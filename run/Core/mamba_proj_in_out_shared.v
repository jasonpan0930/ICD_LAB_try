`timescale 1ns / 1ps
//
// proj_in (1->D_MODEL) + proj_out (D_MODEL->4) with one 16x10 MAC mult and one 32x17 scale mult.
// Phases run sequentially (proj_in then proj_out) so multipliers never conflict.
// Original mamba_linear_in1_serial / mamba_linear_serial_mac are unchanged.
//

module mamba_linear_shared_mult16x10 #(
    parameter integer DATA_WIDTH   = 16,
    parameter integer W_SHIFTED_W  = 10,
    parameter integer MAC_PROD_W   = 26
)(
    input  wire signed [DATA_WIDTH-1:0]      a,
    input  wire signed [W_SHIFTED_W-1:0]     b,
    output wire signed [MAC_PROD_W-1:0]      p
);
    assign p = a * b;
endmodule

module mamba_linear_shared_mult32x17 #(
    parameter integer ACC_W = 32,
    parameter integer SCALED_W = 48
)(
    input  wire signed [ACC_W-1:0]    a,
    input  wire signed [16:0]         b,
    output wire signed [SCALED_W-1:0] p
);
    assign p = a * $signed(b);
endmodule

module mamba_proj_in_out_shared #(
    parameter IN_DIM     = 8,
    parameter D_MODEL    = 8,
    parameter OUT_DIM    = 4,
    parameter DATA_WIDTH = 16,
    parameter WGHT_WIDTH = 8,
    parameter Z_WIDTH    = 9,
    parameter BIAS_WIDTH = 12,
    parameter integer IDX_W_MODEL = (D_MODEL <= 1) ? 1 : $clog2(D_MODEL)
)(
    input  wire clk,
    input  wire rst_n,
    input  wire i_start,

    // ---- proj_in (mamba_linear_in1_serial compatible) ----
    input  wire signed [DATA_WIDTH-1:0]              i_proj_in_x0,
    input  wire [(D_MODEL*WGHT_WIDTH)-1:0]           i_proj_in_w_flat,
    input  wire [Z_WIDTH-1:0]                        i_proj_in_z,
    input  wire [(D_MODEL*BIAS_WIDTH)-1:0]           i_proj_in_bias_flat,
    input  wire [(D_MODEL*16)-1:0]                   i_proj_in_scale_m_flat,
    input  wire [(D_MODEL*5)-1:0]                    i_proj_in_scale_n_flat,

    output reg  signed [DATA_WIDTH-1:0]              o_proj_in_y,
    output reg                                       o_proj_in_valid,
    output reg  [IDX_W_MODEL-1:0]                    o_proj_in_index,

    // ---- proj_out (mamba_linear_serial_mac compatible) ----
    input  wire [(D_MODEL*DATA_WIDTH)-1:0]             i_y_pool_flat,
    input  wire [(OUT_DIM*IN_DIM*WGHT_WIDTH)-1:0]      i_proj_out_w_flat,
    input  wire [Z_WIDTH-1:0]                        i_proj_out_z,
    input  wire [(OUT_DIM*BIAS_WIDTH)-1:0]            i_proj_out_bias_flat,
    input  wire [15:0]                               i_proj_out_scale_m,
    input  wire [4:0]                                i_proj_out_scale_n,

    output reg  [(OUT_DIM*DATA_WIDTH)-1:0]           o_proj_out_y_flat,
    output wire                                      o_proj_out_busy
);

    localparam integer W_SHIFTED_W    = WGHT_WIDTH + 2;
    localparam integer MAC_PROD_W     = DATA_WIDTH + W_SHIFTED_W;
    localparam [3:0]   SUB_SCALE      = IN_DIM[3:0];

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

    localparam integer ROW_W = clog2_u(OUT_DIM);

    localparam [1:0] PHASE_IDLE = 2'd0;
    localparam [1:0] PHASE_IN   = 2'd1;
    localparam [1:0] PHASE_OUT  = 2'd2;

    function signed [Z_WIDTH-1:0] decode_z9;
        input [Z_WIDTH-1:0] z;
        begin
            decode_z9 = z[Z_WIDTH-1]
                ? -$signed({1'b0, z[Z_WIDTH-2:0]})
                :  $signed({1'b0, z[Z_WIDTH-2:0]});
        end
    endfunction

    function [DATA_WIDTH-1:0] clamp_q16;
        input signed [47:0] in_val;
        begin
            if (in_val > 48'sd32767)
                clamp_q16 = 16'sd32767;
            else if (in_val < -48'sd32768)
                clamp_q16 = -16'sd32768;
            else
                clamp_q16 = in_val[15:0];
        end
    endfunction

    // ---- proj_in state ----
    reg [1:0]                   phase;
    reg [IDX_W_MODEL-1:0]       in_idx;
    reg [IDX_W_MODEL-1:0]       in_idx_out;
    wire [IDX_W_MODEL-1:0]        in_flat_idx;
    wire [WGHT_WIDTH-1:0]         in_w_sel;
    wire signed [BIAS_WIDTH-1:0]  in_bias_sel;
    wire [15:0]                   in_scale_m_sel;
    wire [4:0]                    in_scale_n_sel;
    reg signed [Z_WIDTH-1:0]    in_z_dec;
    reg signed [W_SHIFTED_W-1:0] in_w_shifted;
    reg signed [31:0]           in_mac_acc;
    reg signed [47:0]           in_scaled_acc;
    reg signed [47:0]           in_rounded_acc;
    reg signed [47:0]           in_final_acc;

    // ---- proj_out state ----
    reg [ROW_W-1:0]             out_row;
    reg [3:0]                   out_sub;
    reg signed [31:0]           out_mac_acc;
    reg [3:0]                   y_stream_idx;
    reg signed [DATA_WIDTH-1:0] x_buf [0:IN_DIM-1];

    reg signed [DATA_WIDTH-1:0]   out_x_mac;
    reg        [WGHT_WIDTH-1:0]   out_w_sel;
    reg signed [Z_WIDTH-1:0]      out_z_dec;
    reg signed [W_SHIFTED_W-1:0]  out_w_shifted;
    reg signed [MAC_PROD_W-1:0]   out_prod;
    reg signed [47:0]             out_scaled;
    reg signed [47:0]             out_rounded;
    reg signed [BIAS_WIDTH-1:0]   out_bias_sel;
    reg signed [47:0]             out_final;
    reg signed [DATA_WIDTH-1:0]   out_clamp;

    wire signed [DATA_WIDTH-1:0] y_pool [0:D_MODEL-1];
    genvar gi;
    generate
        for (gi = 0; gi < D_MODEL; gi = gi + 1) begin : gen_y_pool
            assign y_pool[gi] = i_y_pool_flat[(D_MODEL - gi) * DATA_WIDTH - 1 -: DATA_WIDTH];
        end
    endgenerate

    wire out_row_eq_0 = (out_row == {ROW_W{1'b0}});
    wire in_phase     = (phase == PHASE_IN) || (phase == PHASE_IDLE && i_start);
    wire out_phase    = (phase == PHASE_OUT);
    assign in_flat_idx = (phase == PHASE_IDLE) ? {IDX_W_MODEL{1'b0}} : in_idx;
    assign in_w_sel = i_proj_in_w_flat[(D_MODEL - in_flat_idx) * WGHT_WIDTH - 1 -: WGHT_WIDTH];
    assign in_bias_sel = i_proj_in_bias_flat[(D_MODEL - in_flat_idx) * BIAS_WIDTH - 1 -: BIAS_WIDTH];
    assign in_scale_m_sel = i_proj_in_scale_m_flat[(D_MODEL - in_flat_idx) * 16 - 1 -: 16];
    assign in_scale_n_sel = i_proj_in_scale_n_flat[(D_MODEL - in_flat_idx) * 5 - 1 -: 5];
    wire out_mac_step = out_phase && (out_sub != SUB_SCALE);
    wire out_scale_step = out_phase && (out_sub == SUB_SCALE);

    assign o_proj_out_busy = out_phase;

    // ---- shared multipliers (single physical instance each) ----
    wire signed [DATA_WIDTH-1:0]      sh_mac_a;
    wire signed [W_SHIFTED_W-1:0]     sh_mac_b;
    wire signed [MAC_PROD_W-1:0]      sh_mac_prod;
    wire signed [31:0]                sh_scale_a;
    wire signed [16:0]                sh_scale_b;
    wire signed [47:0]                sh_scale_prod;

    assign sh_mac_a   = in_phase ? i_proj_in_x0 : out_x_mac;
    assign sh_mac_b   = in_phase ? in_w_shifted : out_w_shifted;
    assign sh_scale_a = in_phase ? in_mac_acc : out_mac_acc;
    assign sh_scale_b = in_phase ? {1'b0, in_scale_m_sel} : {1'b0, i_proj_out_scale_m};

    mamba_linear_shared_mult16x10 #(
        .DATA_WIDTH(DATA_WIDTH),
        .W_SHIFTED_W(W_SHIFTED_W),
        .MAC_PROD_W(MAC_PROD_W)
    ) u_shared_mac16x10 (
        .a(sh_mac_a),
        .b(sh_mac_b),
        .p(sh_mac_prod)
    );

    mamba_linear_shared_mult32x17 u_shared_scale32x17 (
        .a(sh_scale_a),
        .b(sh_scale_b),
        .p(sh_scale_prod)
    );

    always @(*) begin
        // proj_in combinational datapath
        in_z_dec = decode_z9(i_proj_in_z);
        in_w_shifted = $signed({1'b0, in_w_sel}) - $signed(in_z_dec);
        in_mac_acc = sh_mac_prod;

        if (in_scale_n_sel == 5'd0)
            in_rounded_acc = sh_scale_prod;
        else
            in_rounded_acc = (sh_scale_prod >>> in_scale_n_sel)
                            + ((sh_scale_prod >>> (in_scale_n_sel - 1)) & 48'sd1);

        in_final_acc = in_rounded_acc
                     + $signed({{(48-BIAS_WIDTH){in_bias_sel[BIAS_WIDTH-1]}}, in_bias_sel});

        // proj_out combinational datapath
        out_z_dec = decode_z9(i_proj_out_z);
        out_x_mac = out_row_eq_0 ? y_pool[y_stream_idx[IDX_W_MODEL-1:0]] : x_buf[out_sub];
        out_w_sel = i_proj_out_w_flat[
            ((OUT_DIM * IN_DIM) - (out_row * IN_DIM + out_sub)) * WGHT_WIDTH - 1 -: WGHT_WIDTH
        ];
        out_w_shifted = $signed({1'b0, out_w_sel}) - $signed(out_z_dec);
        out_prod = sh_mac_prod;

        if (i_proj_out_scale_n == 5'd0)
            out_rounded = sh_scale_prod;
        else
            out_rounded = (sh_scale_prod >>> i_proj_out_scale_n)
                        + ((sh_scale_prod >>> (i_proj_out_scale_n - 1)) & 48'sd1);

        out_bias_sel = i_proj_out_bias_flat[(OUT_DIM - out_row) * BIAS_WIDTH - 1 -: BIAS_WIDTH];
        out_final = out_rounded
                  + $signed({{(48-BIAS_WIDTH){out_bias_sel[BIAS_WIDTH-1]}}, out_bias_sel});
        out_clamp = clamp_q16(out_final);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            phase              <= PHASE_IDLE;
            o_proj_in_y        <= {DATA_WIDTH{1'b0}};
            o_proj_in_valid    <= 1'b0;
            o_proj_in_index    <= {IDX_W_MODEL{1'b0}};
            in_idx             <= {IDX_W_MODEL{1'b0}};
            in_idx_out         <= {IDX_W_MODEL{1'b0}};
            out_row            <= {ROW_W{1'b0}};
            out_sub            <= 4'd0;
            out_mac_acc        <= 32'sd0;
            y_stream_idx       <= 4'd0;
            o_proj_out_y_flat  <= {(OUT_DIM*DATA_WIDTH){1'b0}};
        end else begin
            o_proj_in_valid <= 1'b0;

            case (phase)
                PHASE_IDLE: begin
                    if (i_start) begin
                        phase           <= PHASE_IN;
                        in_idx          <= {{(IDX_W_MODEL-1){1'b0}}, 1'b1};
                        o_proj_in_y     <= clamp_q16(in_final_acc);
                        o_proj_in_valid <= 1'b1;
                        o_proj_in_index <= {IDX_W_MODEL{1'b0}};
                        in_idx_out      <= {IDX_W_MODEL{1'b0}};
                    end
                end

                PHASE_IN: begin
                    o_proj_in_y     <= clamp_q16(in_final_acc);
                    o_proj_in_valid <= 1'b1;
                    o_proj_in_index <= in_idx;
                    in_idx_out      <= in_idx;

                    if (in_idx == D_MODEL - 1) begin
                        phase        <= PHASE_OUT;
                        out_row      <= {ROW_W{1'b0}};
                        out_sub      <= 4'd0;
                        out_mac_acc  <= 32'sd0;
                        y_stream_idx <= 4'd0;
                    end else begin
                        in_idx <= in_idx + 1'b1;
                    end
                end

                PHASE_OUT: begin
                    if (out_mac_step) begin
                        if (out_row_eq_0) begin
                            x_buf[out_sub] <= y_pool[y_stream_idx[IDX_W_MODEL-1:0]];
                            y_stream_idx   <= y_stream_idx + 4'd1;
                        end
                        if (out_sub == 4'd0)
                            out_mac_acc <= out_prod;
                        else
                            out_mac_acc <= out_mac_acc + out_prod;
                        out_sub <= out_sub + 4'd1;
                    end else if (out_scale_step) begin
                        o_proj_out_y_flat[(OUT_DIM - out_row) * DATA_WIDTH - 1 -: DATA_WIDTH]
                            <= out_clamp;
                        if (out_row == OUT_DIM - 1) begin
                            phase <= PHASE_IDLE;
                        end else begin
                            out_row     <= out_row + {{(ROW_W-1){1'b0}}, 1'b1};
                            out_sub     <= 4'd0;
                            out_mac_acc <= 32'sd0;
                        end
                    end
                end

                default: phase <= PHASE_IDLE;
            endcase
        end
    end

endmodule
