`timescale 1ns / 1ps

module mamba_datapath_new #(
    parameter D_MODEL     = 8,
    parameter D_STATE     = 8,
    parameter DATA_WIDTH  = 16,
    parameter WGHT_WIDTH  = 8,
    parameter Z_WIDTH     = 9,
    parameter BIAS_WIDTH  = 12,
    parameter ADDR_WIDTH  = 9
)(
    input  clk,
    input  rst_n,
    input  rst_weights_n,
    input  i_start,
    input  signed [DATA_WIDTH-1:0] i_data,
    input  [7:0] i_step_cnt,

    input  wire                        w_we,
    input  wire [ADDR_WIDTH-1:0]       w_addr,
    input  wire [7:0]                  w_data,

    input  [(D_MODEL*D_STATE*DATA_WIDTH)-1 : 0] i_h_reg_flat,
    input  [(D_MODEL*DATA_WIDTH)-1 : 0]         i_y_pool_reg_flat,

    output reg [(D_MODEL*DATA_WIDTH)-1 : 0]     o_next_y_pool_flat,
    output reg [(4*DATA_WIDTH)-1 : 0]           o_logits_flat,
    output wire                                 o_h_wr_en,
    output wire [7:0]                           o_h_wr_i,
    output wire [7:0]                           o_h_wr_j,
    output wire signed [DATA_WIDTH-1:0]         o_h_wr_data,
    output reg                                  o_busy,
    output reg                                  o_done
);
    function integer clog2;
        input integer value;
        integer v;
        begin
            v = value - 1;
            clog2 = 0;
            while (v > 0) begin
                v = v >> 1;
                clog2 = clog2 + 1;
            end
            if (clog2 == 0) clog2 = 1;
        end
    endfunction

    function signed [DATA_WIDTH-1:0] round_q88;
        input signed [31:0] val;
        begin
            round_q88 = (val >>> 8) + (val[7] ? 1 : 0);
        end
    endfunction

    localparam integer IDX_W_MODEL = clog2(D_MODEL);
    localparam integer IDX_W_STATE = clog2(D_STATE);
    localparam integer TOTAL_ELEMS = D_MODEL * D_STATE;
    localparam integer FEED_ADDR_W = clog2(TOTAL_ELEMS);

    wire [(D_MODEL*WGHT_WIDTH)-1:0]              bus_W_PROJ_IN;
    wire [Z_WIDTH-1:0]                           bus_Z_PROJ_IN;
    wire [(D_MODEL*BIAS_WIDTH)-1:0]              bus_BIAS_PROJ_IN;
    wire [(D_MODEL*16)-1:0]                      bus_M_PROJ_IN_FLAT;
    wire [(D_MODEL*5)-1:0]                       bus_N_PROJ_IN_FLAT;

    wire [(((2*D_STATE)+1)*WGHT_WIDTH)-1:0]        bus_W_MERGED_X_PROJ;
    wire [Z_WIDTH-1:0]                           bus_Z_MERGED_X_PROJ;
    wire [(((2*D_STATE)+1)*BIAS_WIDTH)-1:0]        bus_BIAS_MERGED_X_PROJ;
    wire [(((2*D_STATE)+1)*16)-1:0]                bus_M_MERGED_X_PROJ_FLAT;
    wire [(((2*D_STATE)+1)*5)-1:0]                 bus_N_MERGED_X_PROJ_FLAT;

    wire [(D_MODEL*WGHT_WIDTH)-1:0]              bus_W_DT_PROJ;
    wire [Z_WIDTH-1:0]                           bus_Z_DT_PROJ;
    wire [(D_MODEL*BIAS_WIDTH)-1:0]              bus_BIAS_DT_PROJ;
    wire [(D_MODEL*16)-1:0]                      bus_M_DT_PROJ_FLAT;
    wire [(D_MODEL*5)-1:0]                       bus_N_DT_PROJ_FLAT;

    wire [(4*D_MODEL*WGHT_WIDTH)-1:0]            bus_W_PROJ_OUT;
    wire [Z_WIDTH-1:0]                           bus_Z_PROJ_OUT;
    wire [(4*BIAS_WIDTH)-1:0]                    bus_BIAS_PROJ_OUT;
    wire [15:0]                                 bus_M_PROJ_OUT;
    wire [4:0]                                  bus_N_PROJ_OUT;

    wire [(D_MODEL*D_STATE*DATA_WIDTH)-1:0]     bus_CONST_A;
    wire [(D_MODEL*DATA_WIDTH)-1:0]             bus_CONST_D;

    mamba_weight_storage #(
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .Z_WIDTH(Z_WIDTH),
        .BIAS_WIDTH(BIAS_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_weight_storage (
        .clk(clk),
        .rst_weights_n(rst_weights_n),
        .w_we(w_we),
        .w_addr(w_addr),
        .w_data(w_data),
        .o_W_PROJ_IN(bus_W_PROJ_IN),
        .o_Z_PROJ_IN(bus_Z_PROJ_IN),
        .o_BIAS_PROJ_IN(bus_BIAS_PROJ_IN),
        .o_M_PROJ_IN_FLAT(bus_M_PROJ_IN_FLAT),
        .o_N_PROJ_IN_FLAT(bus_N_PROJ_IN_FLAT),
        .o_W_MERGED_X_PROJ(bus_W_MERGED_X_PROJ),
        .o_Z_MERGED_X_PROJ(bus_Z_MERGED_X_PROJ),
        .o_BIAS_MERGED_X_PROJ(bus_BIAS_MERGED_X_PROJ),
        .o_M_MERGED_X_PROJ_FLAT(bus_M_MERGED_X_PROJ_FLAT),
        .o_N_MERGED_X_PROJ_FLAT(bus_N_MERGED_X_PROJ_FLAT),
        .o_W_DT_PROJ(bus_W_DT_PROJ),
        .o_Z_DT_PROJ(bus_Z_DT_PROJ),
        .o_BIAS_DT_PROJ(bus_BIAS_DT_PROJ),
        .o_M_DT_PROJ_FLAT(bus_M_DT_PROJ_FLAT),
        .o_N_DT_PROJ_FLAT(bus_N_DT_PROJ_FLAT),
        .o_W_PROJ_OUT(bus_W_PROJ_OUT),
        .o_Z_PROJ_OUT(bus_Z_PROJ_OUT),
        .o_BIAS_PROJ_OUT(bus_BIAS_PROJ_OUT),
        .o_M_PROJ_OUT(bus_M_PROJ_OUT),
        .o_N_PROJ_OUT(bus_N_PROJ_OUT),
        .o_CONST_A(bus_CONST_A),
        .o_CONST_D(bus_CONST_D)
    );

    wire signed [DATA_WIDTH-1:0] i_y_pool_reg [0:D_MODEL-1];

    reg signed [DATA_WIDTH-1:0] o_next_y_pool [0:D_MODEL-1];
    wire signed [DATA_WIDTH-1:0] logits_w      [0:3];

    integer i, j;
    genvar r;
    generate
        for (r = 0; r < D_MODEL; r = r + 1) begin : gen_unpack
            assign i_y_pool_reg[r] = i_y_pool_reg_flat[(D_MODEL-r)*DATA_WIDTH-1 -: DATA_WIDTH];
        end
    endgenerate

    wire signed [DATA_WIDTH-1:0] proj_in_o_y;
    wire                         proj_in_o_valid;
    wire [IDX_W_MODEL-1:0]       proj_in_index;

    wire signed [DATA_WIDTH-1:0] merged_o_y;
    wire                         merged_o_valid;
    wire [clog2(17)-1:0]         merged_index;

    wire signed [DATA_WIDTH-1:0] dt_proj_o_y;
    wire                         dt_proj_o_valid;
    wire [IDX_W_MODEL-1:0]       dt_proj_index;

    wire signed [DATA_WIDTH-1:0] x_proj_mul_a;
    wire signed [DATA_WIDTH-1:0] x_proj_mul_b;
    wire                         x_proj_mul_valid;
    wire signed [DATA_WIDTH-1:0] dt_proj_mul_a;
    wire signed [DATA_WIDTH-1:0] dt_proj_mul_b;
    wire                         dt_proj_mul_valid;
    wire signed [DATA_WIDTH-1:0] elem_mul0_a;
    wire signed [DATA_WIDTH-1:0] elem_mul0_b;
    wire                         elem_mul0_valid;
    wire signed [DATA_WIDTH-1:0] elem_mul1_a;
    wire signed [DATA_WIDTH-1:0] elem_mul1_b;
    wire                         elem_mul1_valid;
    wire signed [DATA_WIDTH-1:0] elem_mul2_a;
    wire signed [DATA_WIDTH-1:0] elem_mul2_b;
    wire                         elem_mul2_valid;
    wire signed [DATA_WIDTH-1:0] elem_mul3_a;
    wire signed [DATA_WIDTH-1:0] elem_mul3_b;
    wire                         elem_mul3_valid;

    wire signed [DATA_WIDTH-1:0] x_scale_hi_a;
    wire signed [DATA_WIDTH-1:0] x_scale_hi_b;
    wire signed [16:0]           x_scale_lo_a;
    wire signed [DATA_WIDTH-1:0] x_scale_lo_b;
    wire                         x_scale_valid;
    wire signed [DATA_WIDTH-1:0] dt_scale_hi_a;
    wire signed [DATA_WIDTH-1:0] dt_scale_hi_b;
    wire signed [16:0]           dt_scale_lo_a;
    wire signed [DATA_WIDTH-1:0] dt_scale_lo_b;
    wire                         dt_scale_valid;

    wire signed [16:0]           M1_a;
    wire signed [DATA_WIDTH-1:0] M1_b;
    wire signed [31:0]           M1_y;
    wire signed [DATA_WIDTH-1:0] M2_a;
    wire signed [DATA_WIDTH-1:0] M2_b;
    wire signed [31:0]           M2_y;
    wire signed [16:0]           M3_a;
    wire signed [DATA_WIDTH-1:0] M3_b;
    wire signed [31:0]           M3_y;
    wire signed [DATA_WIDTH-1:0] M4_a;
    wire signed [DATA_WIDTH-1:0] M4_b;
    wire signed [31:0]           M4_y;

    wire signed [47:0]           x_scaled_acc;
    wire signed [47:0]           dt_scaled_acc;

    wire signed [DATA_WIDTH-1:0] shared_mul0_a;
    wire signed [DATA_WIDTH-1:0] shared_mul0_b;
    wire signed [DATA_WIDTH-1:0] shared_mul1_a;
    wire signed [DATA_WIDTH-1:0] shared_mul1_b;
    wire signed [(2*DATA_WIDTH)-1:0] shared_mul0_y;
    wire signed [(2*DATA_WIDTH)-1:0] shared_mul1_y;

    assign shared_mul0_a = x_proj_mul_valid ? x_proj_mul_a : elem_mul0_a;
    assign shared_mul0_b = x_proj_mul_valid ? x_proj_mul_b : elem_mul0_b;
    assign shared_mul1_a = dt_proj_mul_valid ? dt_proj_mul_a : elem_mul1_a;
    assign shared_mul1_b = dt_proj_mul_valid ? dt_proj_mul_b : elem_mul1_b;

    elementwise_mul #(
        .A_WIDTH(DATA_WIDTH),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_mul0 (
        .i_a(shared_mul0_a),
        .i_b(shared_mul0_b),
        .o_y(shared_mul0_y)
    );

    elementwise_mul #(
        .A_WIDTH(DATA_WIDTH),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_mul1 (
        .i_a(shared_mul1_a),
        .i_b(shared_mul1_b),
        .o_y(shared_mul1_y)
    );

    wire signed [DATA_WIDTH-1:0] softplus_o_y;
    wire                         softplus_o_valid;

    wire [(D_MODEL*DATA_WIDTH)-1:0] xt_flat;
    wire [DATA_WIDTH-1:0]           dt_raw_flat;
    wire [(D_STATE*DATA_WIDTH)-1:0] b_flat;
    wire [(D_STATE*DATA_WIDTH)-1:0] c_flat;
    wire [(D_MODEL*DATA_WIDTH)-1:0] dt_flat;

    reg job_start_d;
    wire job_start_pulse;
    assign job_start_pulse = i_start && !job_start_d;

    reg dt_start_pending;
    reg dt_start;

    reg [4:0] softplus_store_count;
    reg softplus_done;

    wire [(4*DATA_WIDTH)-1:0] w_logits_flat;
    wire                      proj_out_busy;

    mamba_proj_in_out_shared #(
        .IN_DIM(D_MODEL),
        .D_MODEL(D_MODEL),
        .OUT_DIM(4),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .Z_WIDTH(Z_WIDTH),
        .BIAS_WIDTH(BIAS_WIDTH)
    ) u_proj_in_out_shared (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(job_start_pulse),
        .i_proj_in_x0(i_data),
        .i_proj_in_w_flat(bus_W_PROJ_IN),
        .i_proj_in_z(bus_Z_PROJ_IN),
        .i_proj_in_bias_flat(bus_BIAS_PROJ_IN),
        .i_proj_in_scale_m_flat(bus_M_PROJ_IN_FLAT),
        .i_proj_in_scale_n_flat(bus_N_PROJ_IN_FLAT),
        .o_proj_in_y(proj_in_o_y),
        .o_proj_in_valid(proj_in_o_valid),
        .o_proj_in_index(proj_in_index),
        .i_y_pool_flat(i_y_pool_reg_flat),
        .i_proj_out_w_flat(bus_W_PROJ_OUT),
        .i_proj_out_z(bus_Z_PROJ_OUT),
        .i_proj_out_bias_flat(bus_BIAS_PROJ_OUT),
        .i_proj_out_scale_m(bus_M_PROJ_OUT),
        .i_proj_out_scale_n(bus_N_PROJ_OUT),
        .o_proj_out_y_flat(w_logits_flat),
        .o_proj_out_busy(proj_out_busy)
    );

    regfile #(.WIDTH(DATA_WIDTH), .SIZE(D_MODEL)) u_xt_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .input_valid(proj_in_o_valid),
        .data_in(proj_in_o_y),
        .data_out_flat(xt_flat)
    );

    mamba_linear_in1_serial #(
        .OUT_DIM(17),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .Z_WIDTH(Z_WIDTH),
        .BIAS_WIDTH(BIAS_WIDTH)
    ) u_x_proj_serial (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(job_start_pulse),
        .i_x0(i_data),
        .i_w_flat(bus_W_MERGED_X_PROJ),
        .i_z(bus_Z_MERGED_X_PROJ),
        .i_bias_flat(bus_BIAS_MERGED_X_PROJ),
        .i_scale_m_flat(bus_M_MERGED_X_PROJ_FLAT),
        .i_scale_n_flat(bus_N_MERGED_X_PROJ_FLAT),
        .i_mul_result(shared_mul0_y),
        .i_scaled_acc(x_scaled_acc),
        .o_mul_a(x_proj_mul_a),
        .o_mul_b(x_proj_mul_b),
        .o_mul_valid(x_proj_mul_valid),
        .o_scale_hi_a(x_scale_hi_a),
        .o_scale_hi_b(x_scale_hi_b),
        .o_scale_lo_a(x_scale_lo_a),
        .o_scale_lo_b(x_scale_lo_b),
        .o_scale_valid(x_scale_valid),
        .o_y(merged_o_y),
        .o_out_start(),
        .o_valid(merged_o_valid),
        .o_index(merged_index)
    );

    regfile #(.WIDTH(DATA_WIDTH), .SIZE(1)) u_dt_raw_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .input_valid(merged_o_valid && (merged_index == 0)),
        .data_in(merged_o_y),
        .data_out_flat(dt_raw_flat)
    );

    regfile #(.WIDTH(DATA_WIDTH), .SIZE(D_STATE)) u_b_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .input_valid(merged_o_valid && (merged_index >= 1) && (merged_index <= D_STATE)),
        .data_in(merged_o_y),
        .data_out_flat(b_flat)
    );

    regfile #(.WIDTH(DATA_WIDTH), .SIZE(D_STATE)) u_c_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .input_valid(merged_o_valid && (merged_index >= (D_STATE + 1)) && (merged_index <= (2*D_STATE))),
        .data_in(merged_o_y),
        .data_out_flat(c_flat)
    );

    mamba_linear_in1_serial #(
        .OUT_DIM(D_MODEL),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .Z_WIDTH(Z_WIDTH),
        .BIAS_WIDTH(BIAS_WIDTH)
    ) u_dt_proj_serial (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(dt_start),
        .i_x0(dt_raw_flat),
        .i_w_flat(bus_W_DT_PROJ),
        .i_z(bus_Z_DT_PROJ),
        .i_bias_flat(bus_BIAS_DT_PROJ),
        .i_scale_m_flat(bus_M_DT_PROJ_FLAT),
        .i_scale_n_flat(bus_N_DT_PROJ_FLAT),
        .i_mul_result(shared_mul1_y),
        .i_scaled_acc(dt_scaled_acc),
        .o_mul_a(dt_proj_mul_a),
        .o_mul_b(dt_proj_mul_b),
        .o_mul_valid(dt_proj_mul_valid),
        .o_scale_hi_a(dt_scale_hi_a),
        .o_scale_hi_b(dt_scale_hi_b),
        .o_scale_lo_a(dt_scale_lo_a),
        .o_scale_lo_b(dt_scale_lo_b),
        .o_scale_valid(dt_scale_valid),
        .o_y(dt_proj_o_y),
        .o_out_start(),
        .o_valid(dt_proj_o_valid),
        .o_index(dt_proj_index)
    );

    mamba_softplus #(.DATA_WIDTH(DATA_WIDTH)) u_softplus (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(dt_proj_o_valid),
        .i_x(dt_proj_o_y),
        .o_valid(softplus_o_valid),
        .o_y(softplus_o_y)
    );

    regfile #(.WIDTH(DATA_WIDTH), .SIZE(D_MODEL)) u_dt_regfile (
        .clk(clk),
        .rst_n(rst_n),
        .input_valid(softplus_o_valid),
        .data_in(softplus_o_y),
        .data_out_flat(dt_flat)
    );

    wire signed [DATA_WIDTH-1:0] elem_next_h;
    wire                         elem_valid;

    reg [IDX_W_MODEL-1:0] feed_i;
    reg [IDX_W_STATE-1:0] feed_j;
    reg [15:0] feed_count;
    reg c_params_ready;
    wire feed_valid;
    assign feed_valid = o_busy && softplus_done && c_params_ready && (feed_count < TOTAL_ELEMS);

    // Sequential (i,j) feed uses feed_count as a linear index — one part-select each,
    // instead of flatten→2D unpack→64:1 array mux.
    wire signed [DATA_WIDTH-1:0] feed_h_val;
    wire signed [DATA_WIDTH-1:0] feed_const_a_val;
    wire signed [DATA_WIDTH-1:0] feed_dt_val;
    wire signed [DATA_WIDTH-1:0] feed_xt_val;
    wire signed [DATA_WIDTH-1:0] feed_b_val;

    assign feed_h_val      = i_h_reg_flat[(TOTAL_ELEMS - feed_count[FEED_ADDR_W-1:0]) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign feed_const_a_val = bus_CONST_A[(TOTAL_ELEMS - feed_count[FEED_ADDR_W-1:0]) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign feed_dt_val     = dt_flat[(D_MODEL - feed_i) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign feed_xt_val     = xt_flat[(D_MODEL - feed_i) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign feed_b_val      = b_flat[(D_STATE - feed_j) * DATA_WIDTH - 1 -: DATA_WIDTH];

    reg [IDX_W_MODEL-1:0] idx_d0_i, idx_d1_i, idx_d2_i;
    reg [IDX_W_STATE-1:0] idx_d0_j, idx_d1_j, idx_d2_j;
    reg                   idx_d0_v, idx_d1_v, idx_d2_v;

    wire yt_mac_valid;
    wire [7:0] yt_mac_idx_i;
    wire signed [DATA_WIDTH-1:0] yt_mac_final;
    wire signed [DATA_WIDTH-1:0] dx_val_w;
    reg [3:0] y_done_count;

    wire yt_valid;
    assign yt_valid = o_busy && c_params_ready && elem_valid && idx_d2_v;

    // idx_d2_* already tracks elem pipeline delay; do not register again onto
    // o_h_wr_* (idx_d2_j -> o_h_wr_j_reg is FF-to-FF on the same edge -> hold risk).
    assign o_h_wr_en   = o_busy && elem_valid && idx_d2_v;
    assign o_h_wr_i    = {{(8-IDX_W_MODEL){1'b0}}, idx_d2_i};
    assign o_h_wr_j    = {{(8-IDX_W_STATE){1'b0}}, idx_d2_j};
    assign o_h_wr_data = elem_next_h;

    assign M1_a = x_scale_valid
                ? x_scale_lo_a
                : {{elem_mul2_a[15]}, elem_mul2_a};
    assign M1_b = x_scale_valid ? x_scale_lo_b : elem_mul2_b;

    assign M2_a = x_scale_valid ? x_scale_hi_a : c_flat[(D_STATE - idx_d2_j) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign M2_b = x_scale_valid ? x_scale_hi_b : elem_next_h;

    assign M3_a = dt_scale_valid
                ? dt_scale_lo_a
                : {{elem_mul3_a[15]}, elem_mul3_a};
    assign M3_b = dt_scale_valid ? dt_scale_lo_b : elem_mul3_b;

    assign M4_a = dt_scale_valid ? dt_scale_hi_a : bus_CONST_D[(D_MODEL - idx_d2_i) * DATA_WIDTH - 1 -: DATA_WIDTH];
    assign M4_b = dt_scale_valid ? dt_scale_hi_b : xt_flat[(D_MODEL - idx_d2_i) * DATA_WIDTH - 1 -: DATA_WIDTH];

    assign x_scaled_acc =
        ($signed({{16{M2_y[31]}}, M2_y}) <<< 16) + $signed({{16{M1_y[31]}}, M1_y});
    assign dt_scaled_acc =
        ($signed({{16{M4_y[31]}}, M4_y}) <<< 16) + $signed({{16{M3_y[31]}}, M3_y});

    assign dx_val_w = round_q88(M4_y);

    elementwise_mul #(
        .A_WIDTH(17),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_M1 (
        .i_a(M1_a),
        .i_b(M1_b),
        .o_y(M1_y)
    );

    elementwise_mul #(
        .A_WIDTH(DATA_WIDTH),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_M2 (
        .i_a(M2_a),
        .i_b(M2_b),
        .o_y(M2_y)
    );

    elementwise_mul #(
        .A_WIDTH(17),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_M3 (
        .i_a(M3_a),
        .i_b(M3_b),
        .o_y(M3_y)
    );

    elementwise_mul #(
        .A_WIDTH(DATA_WIDTH),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(2*DATA_WIDTH)
    ) u_shared_M4 (
        .i_a(M4_a),
        .i_b(M4_b),
        .o_y(M4_y)
    );

    pipeline_elementwise_multiplier #(.DATA_WIDTH(DATA_WIDTH)) u_elem (
        .i_clk(clk),
        .i_rst_n(rst_n),
        .i_valid(feed_valid),
        .i_dt(feed_dt_val),
        .i_const_a(feed_const_a_val),
        .i_b(feed_b_val),
        .i_h(feed_h_val),
        .i_xt(feed_xt_val),
        .i_mul0_result(shared_mul0_y),
        .i_mul1_result(shared_mul1_y),
        .i_mul2_result(M1_y),
        .i_mul3_result(M3_y),
        .o_mul0_a(elem_mul0_a),
        .o_mul0_b(elem_mul0_b),
        .o_mul0_valid(elem_mul0_valid),
        .o_mul1_a(elem_mul1_a),
        .o_mul1_b(elem_mul1_b),
        .o_mul1_valid(elem_mul1_valid),
        .o_mul2_a(elem_mul2_a),
        .o_mul2_b(elem_mul2_b),
        .o_mul2_valid(elem_mul2_valid),
        .o_mul3_a(elem_mul3_a),
        .o_mul3_b(elem_mul3_b),
        .o_mul3_valid(elem_mul3_valid),
        .o_valid(elem_valid),
        .o_dA(),
        .o_dB(),
        .o_Abar_h(),
        .o_Bxt(),
        .o_next_h(elem_next_h)
    );

    pipeline_yt_mac #(
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .DATA_WIDTH(DATA_WIDTH)
    ) u_yt_mac (
        .i_clk(clk),
        .i_rst_n(rst_n),
        .i_valid(yt_valid),
        .i_idx_i({5'b0, idx_d2_i}),
        .i_idx_j({5'b0, idx_d2_j}),
        .i_h_val(elem_next_h),
        .i_c_val(c_flat[(D_STATE - idx_d2_j) * DATA_WIDTH - 1 -: DATA_WIDTH]),
        .i_dx_val(dx_val_w),
        .i_mul_result(M2_y),
        .o_valid(yt_mac_valid),
        .o_idx_i(yt_mac_idx_i),
        .o_yt_final(yt_mac_final)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            job_start_d <= 1'b0;
            dt_start_pending <= 1'b0;
            dt_start <= 1'b0;
            softplus_store_count <= 5'd0;
            softplus_done <= 1'b0;
            c_params_ready <= 1'b0;
            feed_i <= {IDX_W_MODEL{1'b0}};
            feed_j <= {IDX_W_STATE{1'b0}};
            feed_count <= 16'd0;
            idx_d0_v <= 1'b0;
            idx_d1_v <= 1'b0;
            idx_d2_v <= 1'b0;
            idx_d0_i <= {IDX_W_MODEL{1'b0}};
            idx_d1_i <= {IDX_W_MODEL{1'b0}};
            idx_d2_i <= {IDX_W_MODEL{1'b0}};
            idx_d0_j <= {IDX_W_STATE{1'b0}};
            idx_d1_j <= {IDX_W_STATE{1'b0}};
            idx_d2_j <= {IDX_W_STATE{1'b0}};
            y_done_count <= 4'd0;
            o_busy <= 1'b0;
            o_done <= 1'b0;
            for (i = 0; i < D_MODEL; i = i + 1) begin
                o_next_y_pool[i] <= {DATA_WIDTH{1'b0}};
            end
        end else begin
            job_start_d <= i_start;
            dt_start <= 1'b0;
            o_done <= 1'b0;

            if (job_start_pulse && !o_busy) begin
                o_busy <= 1'b1;
                dt_start_pending <= 1'b0;
                softplus_store_count <= 5'd0;
                softplus_done <= 1'b0;
                c_params_ready <= 1'b0;
                feed_i <= {IDX_W_MODEL{1'b0}};
                feed_j <= {IDX_W_STATE{1'b0}};
                feed_count <= 16'd0;
                idx_d0_v <= 1'b0;
                idx_d1_v <= 1'b0;
                idx_d2_v <= 1'b0;
                y_done_count <= 4'd0;
                for (i = 0; i < D_MODEL; i = i + 1) begin
                    o_next_y_pool[i] <= i_y_pool_reg[i];
                end
            end

            // Do not gate by o_busy here; on the first output beat (index 0),
            // o_busy is still the previous-cycle value in this always block.
            if (merged_o_valid && (merged_index == 0)) begin
                dt_start_pending <= 1'b1;
            end
            if (merged_o_valid && (merged_index == (2*D_STATE))) begin
                c_params_ready <= 1'b1;
            end
            if (dt_start_pending) begin
                dt_start <= 1'b1;
                dt_start_pending <= 1'b0;
            end

            if (o_busy && softplus_o_valid && !softplus_done) begin
                softplus_store_count <= softplus_store_count + 1'b1;
                if (softplus_store_count == (D_MODEL - 1))
                    softplus_done <= 1'b1;
            end

            idx_d2_v <= idx_d1_v;
            idx_d2_i <= idx_d1_i;
            idx_d2_j <= idx_d1_j;
            idx_d1_v <= idx_d0_v;
            idx_d1_i <= idx_d0_i;
            idx_d1_j <= idx_d0_j;
            idx_d0_v <= feed_valid;
            if (feed_valid) begin
                idx_d0_i <= feed_i;
                idx_d0_j <= feed_j;
            end

            if (feed_valid) begin
                feed_count <= feed_count + 16'd1;
                if (feed_j == D_STATE-1) begin
                    feed_j <= {IDX_W_STATE{1'b0}};
                    feed_i <= feed_i + {{(IDX_W_MODEL-1){1'b0}}, 1'b1};
                end else begin
                    feed_j <= feed_j + {{(IDX_W_STATE-1){1'b0}}, 1'b1};
                end
            end

            if (o_busy && yt_mac_valid) begin
                y_done_count <= y_done_count + 1'b1;
                if (i_step_cnt == 0)
                    o_next_y_pool[yt_mac_idx_i] <= yt_mac_final;
                else
                    o_next_y_pool[yt_mac_idx_i] <= (yt_mac_final > i_y_pool_reg[yt_mac_idx_i]) ? yt_mac_final : i_y_pool_reg[yt_mac_idx_i];

                if (y_done_count == (D_MODEL - 1)) begin
                    o_busy <= 1'b0;
                    o_done <= 1'b1;
                end
            end
        end
    end

    always @(*) begin
        for (i = 0; i < D_MODEL; i = i + 1) begin
            o_next_y_pool_flat[(D_MODEL-i)*DATA_WIDTH-1 -: DATA_WIDTH] = o_next_y_pool[i];
        end
        o_logits_flat = w_logits_flat;
    end

endmodule
