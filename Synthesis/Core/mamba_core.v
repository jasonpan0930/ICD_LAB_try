`timescale 1ns / 1ps

//
// 32-signal top-level interface.
//
// External protocol:
//   mode = 1'b1: weight-load mode
//     - strobe writes w_data[7:0] to the internal auto-increment address.
//     - entering mode=1 automatically pulses rst_weights_n low for one cycle
//       and resets the internal address counter to 0.
//     - o_ready indicates the top can accept the next weight byte.
//     - o_valid asserts after byte address 284 has been written.
//
//   mode = 1'b0: inference mode
//     - strobe is forwarded as i_valid.
//     - i_data[15:0] is forwarded as the ECG feature sample.
//     - o_ready/o_valid/o_class are forwarded from the internal core logic.
//
// Top-level signal count, including clk:
//   clk + rst_n + mode + strobe + i_data[15:0] + w_data[7:0]
//   + o_ready + o_valid + o_class[1:0] = 32
//
module mamba_core #(
    parameter D_IN         = 1,
    parameter D_MODEL      = 8,
    parameter D_STATE      = 8,
    parameter SEQ_LEN      = 187,
    parameter DATA_WIDTH   = 16,
    parameter WGHT_WIDTH   = 8,
    parameter ADDR_WIDTH   = 9,
    parameter WEIGHT_BYTES = 285
)(
    input  wire                         clk,
    input  wire                         rst_n,
    input  wire                         mode,
    input  wire                         strobe,
    input  wire signed [DATA_WIDTH-1:0] i_data,
    input  wire [7:0]                   w_data,

    output wire                         o_ready,
    output wire                         o_valid,
    output wire [1:0]                   o_class
);
    // Weight-load wrapper
    reg [ADDR_WIDTH-1:0] weight_addr_cnt;
    reg                  mode_d;
    reg                  rst_weights_n_r;
    reg                  load_ready;
    reg                  load_done;

    wire mode_rise = mode && !mode_d;
    wire core_w_we = mode && load_ready && !load_done && strobe;

    wire core_i_valid = (!mode) && strobe;
    wire core_o_ready;
    reg  core_o_valid;
    reg  [1:0] core_o_class;

    assign o_ready = mode ? (load_ready && !load_done) : core_o_ready;
    assign o_valid = mode ? load_done : core_o_valid;
    assign o_class = mode ? 2'd0 : core_o_class;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            weight_addr_cnt <= {ADDR_WIDTH{1'b0}};
            mode_d          <= 1'b0;
            rst_weights_n_r <= 1'b1;
            load_ready      <= 1'b0;
            load_done       <= 1'b0;
        end else begin
            mode_d <= mode;

            if (mode_rise) begin
                weight_addr_cnt <= {ADDR_WIDTH{1'b0}};
                rst_weights_n_r <= 1'b0;
                load_ready      <= 1'b0;
                load_done       <= 1'b0;
            end else if (mode) begin
                if (!rst_weights_n_r) begin
                    rst_weights_n_r <= 1'b1;
                    load_ready      <= 1'b1;
                end else if (core_w_we) begin
                    if (weight_addr_cnt == (WEIGHT_BYTES - 1)) begin
                        weight_addr_cnt <= {ADDR_WIDTH{1'b0}};
                        load_ready      <= 1'b0;
                        load_done       <= 1'b1;
                    end else begin
                        weight_addr_cnt <= weight_addr_cnt + 1'b1;
                    end
                end
            end else begin
                rst_weights_n_r <= 1'b1;
                load_ready      <= 1'b0;
                load_done       <= 1'b0;
            end
        end
    end

    // ctrl signals
    reg  [7:0] step_cnt;
    wire       is_last_step;

    // State Registers
    reg  signed [DATA_WIDTH-1:0] h_reg      [0:D_MODEL-1][0:D_STATE-1];
    reg  signed [DATA_WIDTH-1:0] y_pool_reg [0:D_MODEL-1];

    // Datapath 的計算結果
    wire signed [DATA_WIDTH-1:0] next_y_pool [0:D_MODEL-1];
    wire signed [DATA_WIDTH-1:0] logits      [0:3];

    integer i, j;

    // ======================================================
    // 轉接層：將 2D/3D 陣列打平 (Flatten) 與解開 (Unpack)
    // ======================================================
    wire [(D_MODEL*D_STATE*DATA_WIDTH)-1:0] flat_h_reg;
    wire [(D_MODEL*DATA_WIDTH)-1:0]         flat_y_pool_reg;
    wire [(D_MODEL*DATA_WIDTH)-1:0]         flat_next_y_pool;
    wire [(4*DATA_WIDTH)-1:0]               flat_logits;
    wire                                    datapath_busy;
    wire                                    datapath_done;
    wire                                    h_wr_en;
    wire [7:0]                              h_wr_i;
    wire [7:0]                              h_wr_j;
    wire signed [DATA_WIDTH-1:0]            h_wr_data;

    reg                                     datapath_start;
    reg signed [DATA_WIDTH-1:0]             data_latched;

    genvar r, c;
    generate
        for (r = 0; r < D_MODEL; r = r + 1) begin : gen_y
            assign flat_y_pool_reg[(D_MODEL - r)*DATA_WIDTH - 1 -: DATA_WIDTH] = y_pool_reg[r];
            assign next_y_pool[r] = flat_next_y_pool[(D_MODEL - r)*DATA_WIDTH - 1 -: DATA_WIDTH];

            for (c = 0; c < D_STATE; c = c + 1) begin : gen_h
                assign flat_h_reg[((D_MODEL*D_STATE) - (r*D_STATE + c))*DATA_WIDTH - 1 -: DATA_WIDTH] = h_reg[r][c];
            end
        end

        for (r = 0; r < 4; r = r + 1) begin : gen_logits
            assign logits[r] = flat_logits[(4 - r)*DATA_WIDTH - 1 -: DATA_WIDTH];
        end
    endgenerate

    // ======================================================
    // 實例化資料路徑 (Datapath Instantiation)
    // ======================================================
    mamba_datapath_new #(
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_datapath (
        .clk(clk),
        .rst_n(rst_n),
        .rst_weights_n(rst_weights_n_r),
        .i_start(datapath_start),
        .i_data(data_latched),
        .i_step_cnt(step_cnt),
        .w_we(core_w_we),
        .w_addr(weight_addr_cnt),
        .w_data(w_data),
        .i_h_reg_flat(flat_h_reg),
        .i_y_pool_reg_flat(flat_y_pool_reg),
        .o_next_y_pool_flat(flat_next_y_pool),
        .o_logits_flat(flat_logits),
        .o_h_wr_en(h_wr_en),
        .o_h_wr_i(h_wr_i),
        .o_h_wr_j(h_wr_j),
        .o_h_wr_data(h_wr_data),
        .o_busy(datapath_busy),
        .o_done(datapath_done)
    );

    // ======================================================
    // FSM & Sequential Circuit
    // ======================================================
    assign core_o_ready = !(datapath_busy || datapath_start);
    assign is_last_step = (step_cnt == (SEQ_LEN - 1));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            step_cnt <= 8'd0;
            core_o_valid <= 1'b0;
            core_o_class <= 2'b00;
            datapath_start <= 1'b0;
            data_latched <= {DATA_WIDTH{1'b0}};

            for (i = 0; i < D_MODEL; i = i + 1) begin
                y_pool_reg[i] <= 16'd0;
                for (j = 0; j < D_STATE; j = j + 1) begin
                    h_reg[i][j] <= 16'd0;
                end
            end
        end else begin
            datapath_start <= 1'b0;
            core_o_valid <= 1'b0;

            if (h_wr_en && (h_wr_i < D_MODEL) && (h_wr_j < D_STATE)) begin
                h_reg[h_wr_i][h_wr_j] <= h_wr_data;
            end

            if (!datapath_busy && !datapath_start && core_i_valid) begin
                datapath_start <= 1'b1;
                data_latched <= i_data;
            end

            if (datapath_done) begin
                if (is_last_step) step_cnt <= 8'd0;
                else              step_cnt <= step_cnt + 1'b1;

                for (i = 0; i < D_MODEL; i = i + 1) begin
                    y_pool_reg[i] <= next_y_pool[i];
                end

                if (is_last_step) begin
                    core_o_valid <= 1'b1;
                    if ((logits[0] >= logits[1]) && (logits[0] >= logits[2]) && (logits[0] >= logits[3])) begin
                        core_o_class <= 2'd0;
                    end else if ((logits[1] >= logits[2]) && (logits[1] >= logits[3])) begin
                        core_o_class <= 2'd1;
                    end else if (logits[2] >= logits[3]) begin
                        core_o_class <= 2'd2;
                    end else begin
                        core_o_class <= 2'd3;
                    end
                end
            end
        end
    end

endmodule
