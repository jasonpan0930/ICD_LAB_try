`timescale 1ns / 1ps


module mamba_linear_in1_serial #(
    parameter OUT_DIM    = 8,
    parameter DATA_WIDTH = 16,
    parameter WGHT_WIDTH = 8,
    parameter Z_WIDTH    = 9,
    parameter BIAS_WIDTH = 12,
    parameter integer IDX_WIDTH = (OUT_DIM <= 1) ? 1 : $clog2(OUT_DIM)
)(
    input  wire                               clk,
    input  wire                               rst_n,
    input  wire                               i_start,
    input  wire signed [DATA_WIDTH-1:0]       i_x0,
    input  wire [(OUT_DIM*WGHT_WIDTH)-1:0]    i_w_flat,
    input  wire [Z_WIDTH-1:0]                 i_z,
    input  wire [(OUT_DIM*BIAS_WIDTH)-1:0]    i_bias_flat,
    input  wire [(OUT_DIM*16)-1:0]            i_scale_m_flat,
    input  wire [(OUT_DIM*5)-1:0]             i_scale_n_flat,
    input  wire signed [2*DATA_WIDTH-1:0]     i_mul_result,
    input  wire signed [47:0]                 i_scaled_acc,

    output wire signed [DATA_WIDTH-1:0]       o_mul_a,
    output wire signed [DATA_WIDTH-1:0]       o_mul_b,
    output wire                               o_mul_valid,
    output wire signed [DATA_WIDTH-1:0]       o_scale_hi_a,
    output wire signed [DATA_WIDTH-1:0]       o_scale_hi_b,
    output wire signed [16:0]                 o_scale_lo_a,
    output wire signed [DATA_WIDTH-1:0]       o_scale_lo_b,
    output wire                               o_scale_valid,
    output reg  signed [DATA_WIDTH-1:0]       o_y,
    output reg                                o_out_start,
    output reg                                o_valid,
    output wire [IDX_WIDTH-1:0]               o_index
);

    // z: sign + 8b magnitude in [Z_WIDTH-1:0]; w-z fits in WGHT_WIDTH+2 signed bits
    localparam integer W_SHIFTED_W = WGHT_WIDTH + 2;

    reg [IDX_WIDTH-1:0] idx;
    reg [IDX_WIDTH-1:0] idx_out;
    reg                 busy;

    reg signed [Z_WIDTH-1:0]     z_dec;
    reg signed [W_SHIFTED_W-1:0] w_shifted;
    reg signed [31:0]            mac_acc;
    reg signed [47:0]           scaled_acc;
    reg signed [47:0]           rounded_acc;
    reg signed [47:0]           final_acc;
    reg [WGHT_WIDTH-1:0]        w_sel;
    reg signed [BIAS_WIDTH-1:0] bias_sel;
    reg [15:0]                  scale_m_sel;
    reg [4:0]                   scale_n_sel;
    integer                     flat_idx;

    function [DATA_WIDTH-1:0] clamp_data_width;
        input signed [47:0] in_val;
        begin
            if (in_val > 48'sd32767)
                clamp_data_width = 16'sd32767;
            else if (in_val < -48'sd32768)
                clamp_data_width = -16'sd32768;
            else
                clamp_data_width = in_val[15:0];
        end
    endfunction
    
    assign o_index = idx_out;

    wire [IDX_WIDTH-1:0]           flat_idx_c;
    wire [WGHT_WIDTH-1:0]          w_sel_c;
    wire signed [Z_WIDTH-1:0]      z_dec_c;
    wire signed [W_SHIFTED_W-1:0]  w_shifted_c;

    assign flat_idx_c = i_start ? {IDX_WIDTH{1'b0}} : idx;
    assign w_sel_c = i_w_flat[(OUT_DIM - flat_idx_c) * WGHT_WIDTH - 1 -: WGHT_WIDTH];
    assign z_dec_c = i_z[Z_WIDTH-1]
        ? -$signed({1'b0, i_z[Z_WIDTH-2:0]})
        :  $signed({1'b0, i_z[Z_WIDTH-2:0]});
    assign w_shifted_c = $signed({1'b0, w_sel_c}) - $signed(z_dec_c);

    wire [15:0]                  scale_m_sel_c;
    wire signed [DATA_WIDTH-1:0] scale_m_s_c;
    wire signed [31:0]           mac_acc_c;

    assign scale_m_sel_c = i_scale_m_flat[(OUT_DIM - flat_idx_c) * 16 - 1 -: 16];
    assign scale_m_s_c   = $signed({1'b0, scale_m_sel_c[14:0]});
    assign mac_acc_c     = i_mul_result[31:0];

    assign o_mul_a        = i_x0;
    assign o_mul_b        = {{(DATA_WIDTH-W_SHIFTED_W){w_shifted_c[W_SHIFTED_W-1]}}, w_shifted_c};
    assign o_mul_valid    = i_start || busy;
    assign o_scale_hi_a   = mac_acc_c[31:16];
    assign o_scale_hi_b   = scale_m_s_c;
    assign o_scale_lo_a   = {1'b0, mac_acc_c[15:0]};
    assign o_scale_lo_b   = scale_m_s_c;
    assign o_scale_valid  = o_mul_valid;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_y           <= {DATA_WIDTH{1'b0}};
            o_out_start   <= 1'b0;
            o_valid       <= 1'b0;
            idx           <= {IDX_WIDTH{1'b0}};
            idx_out       <= {IDX_WIDTH{1'b0}};
            busy          <= 1'b0;
        end else begin
            o_out_start <= i_start;
            o_valid     <= 1'b0;

            if (i_start || busy) begin
                if (i_start)
                    busy <= 1'b1;

                flat_idx = i_start ? 0 : idx;
                w_sel = i_w_flat[(OUT_DIM - flat_idx) * WGHT_WIDTH - 1 -: WGHT_WIDTH];
                bias_sel = i_bias_flat[(OUT_DIM - flat_idx) * BIAS_WIDTH - 1 -: BIAS_WIDTH];
                scale_m_sel = i_scale_m_flat[(OUT_DIM - flat_idx) * 16 - 1 -: 16];
                scale_n_sel = i_scale_n_flat[(OUT_DIM - flat_idx) * 5 - 1 -: 5];

                z_dec = i_z[Z_WIDTH-1]
                    ? -$signed({1'b0, i_z[Z_WIDTH-2:0]})
                    :  $signed({1'b0, i_z[Z_WIDTH-2:0]});
                w_shifted = w_shifted_c;
                mac_acc    = mac_acc_c;
                scaled_acc = i_scaled_acc;

                if (scale_n_sel == 5'd0)
                    rounded_acc = scaled_acc;
                else
                    rounded_acc = (scaled_acc >>> scale_n_sel) + ((scaled_acc >>> (scale_n_sel - 1)) & 48'sd1);

                final_acc = rounded_acc
                          + $signed({{(48-BIAS_WIDTH){bias_sel[BIAS_WIDTH-1]}}, bias_sel});

                o_y <= clamp_data_width(final_acc);
                o_valid <= 1'b1;
                idx_out <= (i_start ? {IDX_WIDTH{1'b0}} : idx);

                if ((i_start ? {IDX_WIDTH{1'b0}} : idx) == OUT_DIM - 1)
                    busy <= 1'b0;
                else
                    idx <= (i_start ? {IDX_WIDTH{1'b0}} : idx) + 1'b1;
            end
        end
    end

endmodule

// Serial MAC linear (proj_out): row 0 consumes streamed i_x/i_x_valid (sub != 8 => MAC step);
// sub == 8 => scale+bias for that row. x_buf holds samples for rows 1..OUT_DIM-1.
// Rows 1..OUT_DIM-1: 8 MAC cycles (sub != 8) + 1 scale (sub == 8), no external valids.
module mamba_linear_serial_mac #(
    parameter IN_DIM     = 8,
    parameter OUT_DIM    = 4,
    parameter DATA_WIDTH = 16,
    parameter WGHT_WIDTH = 8,
    parameter Z_WIDTH    = 9,
    parameter BIAS_WIDTH = 12
)(
    input  wire clk,
    input  wire rst_n,
    input  wire i_start,
    input  wire signed [DATA_WIDTH-1:0]           i_x,
    input  wire                                   i_x_valid,
    input  wire [(OUT_DIM*IN_DIM*WGHT_WIDTH)-1:0] i_w_flat,
    input  wire [Z_WIDTH-1:0]                     i_z,
    input  wire [(OUT_DIM*BIAS_WIDTH)-1:0]         i_bias_flat,
    input  wire [15:0]                            i_scale_m,
    input  wire [4:0]                             i_scale_n,
    output reg  [(OUT_DIM*DATA_WIDTH)-1:0]        o_y_flat
);

    function integer clog2_u;
        input integer value;
        integer v;
        begin
            v = value - 1;
            clog2_u = 0;
            while (v > 0) begin
                v = v >> 1;
                clog2_u = clog2_u + 1;
            end
            if (clog2_u == 0) clog2_u = 1;
        end
    endfunction

    localparam [3:0] SUB_SCALE = IN_DIM[3:0];
    localparam integer ROW_W       = clog2_u(OUT_DIM);
    localparam integer W_SHIFTED_W = WGHT_WIDTH + 2;
    localparam integer MAC_PROD_W  = DATA_WIDTH + W_SHIFTED_W;

    reg                         busy;
    reg [ROW_W-1:0]             row;
    reg [3:0]                   sub;
    reg signed [31:0]           mac_acc;
    reg signed [DATA_WIDTH-1:0] x_buf [0:IN_DIM-1];

    function signed [DATA_WIDTH-1:0] clamp_acc_to_q16;
        input signed [47:0] final_acc;
        begin
            if (final_acc > 48'sd32767)
                clamp_acc_to_q16 = 16'sd32767;
            else if (final_acc < -48'sd32768)
                clamp_acc_to_q16 = -16'sd32768;
            else
                clamp_acc_to_q16 = final_acc[15:0];
        end
    endfunction

    wire row_eq_0 = (row == {ROW_W{1'b0}});

    reg signed [DATA_WIDTH-1:0]   x_mac_c;
    reg        [WGHT_WIDTH-1:0]   w_sel_c;
    reg signed [Z_WIDTH-1:0]      z_dec_c;
    reg signed [W_SHIFTED_W-1:0]  w_shifted_c;
    reg signed [MAC_PROD_W-1:0]   prod_c;
    reg signed [47:0]           scaled_c;
    reg signed [47:0]           rounded_c;
    reg signed [BIAS_WIDTH-1:0] bias_sel_c;
    reg signed [47:0]           final_c;
    reg signed [DATA_WIDTH-1:0] clamp_c;

    always @(*) begin
        z_dec_c = i_z[Z_WIDTH-1]
            ? -$signed({1'b0, i_z[Z_WIDTH-2:0]})
            :  $signed({1'b0, i_z[Z_WIDTH-2:0]});
        x_mac_c = row_eq_0 ? i_x : x_buf[sub];
        w_sel_c = i_w_flat[((OUT_DIM * IN_DIM) - (row * IN_DIM + sub)) * WGHT_WIDTH - 1 -: WGHT_WIDTH];
        w_shifted_c = $signed({1'b0, w_sel_c}) - $signed(z_dec_c);
        prod_c      = x_mac_c * w_shifted_c;

        scaled_c = mac_acc * $signed({1'b0, i_scale_m});
        if (i_scale_n == 5'd0)
            rounded_c = scaled_c;
        else
            rounded_c = (scaled_c >>> i_scale_n)
                      + ((scaled_c >>> (i_scale_n - 1)) & 48'sd1);
        bias_sel_c = i_bias_flat[(OUT_DIM - row) * BIAS_WIDTH - 1 -: BIAS_WIDTH];
        final_c    = rounded_c
                   + $signed({{(48-BIAS_WIDTH){bias_sel_c[BIAS_WIDTH-1]}}, bias_sel_c});
        clamp_c    = clamp_acc_to_q16(final_c);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            busy    <= 1'b0;
            row     <= {ROW_W{1'b0}};
            sub     <= 4'd0;
            mac_acc <= 32'sd0;
            o_y_flat <= {(OUT_DIM*DATA_WIDTH){1'b0}};
        end else if (i_start) begin
            busy    <= 1'b1;
            row     <= {ROW_W{1'b0}};
            sub     <= 4'd0;
            mac_acc <= 32'sd0;
        end else if (busy) begin
            if (row_eq_0) begin
                if (sub != SUB_SCALE) begin
                    if (i_x_valid) begin
                        x_buf[sub] <= i_x;
                        if (sub == 4'd0)
                            mac_acc <= prod_c;
                        else
                            mac_acc <= mac_acc + prod_c;
                        sub <= sub + 4'd1;
                    end
                end else begin
                    o_y_flat[(OUT_DIM - row) * DATA_WIDTH - 1 -: DATA_WIDTH]
                          <= clamp_c;
                    row <= row + {{(ROW_W-1){1'b0}}, 1'b1};
                    sub <= 4'd0;
                    mac_acc <= 32'sd0;
                end
            end else begin
                if (sub != SUB_SCALE) begin
                    if (sub == 4'd0)
                        mac_acc <= prod_c;
                    else
                        mac_acc <= mac_acc + prod_c;
                    sub <= sub + 4'd1;
                end else begin
                    o_y_flat[(OUT_DIM - row) * DATA_WIDTH - 1 -: DATA_WIDTH]
                          <= clamp_c;
                    if (row == OUT_DIM - 1) begin
                        busy <= 1'b0;
                    end else begin
                        row <= row + {{(ROW_W-1){1'b0}}, 1'b1};
                        sub <= 4'd0;
                        mac_acc <= 32'sd0;
                    end
                end
            end
        end
    end

endmodule


