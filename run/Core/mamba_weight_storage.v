`timescale 1ns / 1ps
//
// Byte-wide loadable weight / constant storage.
// rst_weights_n (async low): clear all weight registers to zero.
// rst_n does not affect this block. After release, load 285B via w_we before use.
// Address map (byte index, MSB byte first within each field):
//   W, Z (9b), BIAS (12b Q8.8 packed), M, N per layer; CONST_A/D stay 16b
//   merged x proj block, dt proj block, proj_out block, CONST_A, CONST_D
//

module mamba_weight_storage #(
    parameter D_MODEL     = 8,
    parameter D_STATE     = 8,
    parameter DATA_WIDTH  = 16,
    parameter WGHT_WIDTH  = 8,
    parameter Z_WIDTH     = 9,
    parameter BIAS_WIDTH  = 12,
    parameter ADDR_WIDTH  = 9
)(
    input  wire                        clk,
    input  wire                        rst_weights_n,
    input  wire                        w_we,
    input  wire [ADDR_WIDTH-1:0]       w_addr,
    input  wire [7:0]                  w_data,

    output wire [(D_MODEL*WGHT_WIDTH)-1:0]              o_W_PROJ_IN,
    output wire [Z_WIDTH-1:0]                           o_Z_PROJ_IN,
    output wire [(D_MODEL*BIAS_WIDTH)-1:0]              o_BIAS_PROJ_IN,
    output wire [(D_MODEL*16)-1:0]                      o_M_PROJ_IN_FLAT,
    output wire [(D_MODEL*5)-1:0]                       o_N_PROJ_IN_FLAT,

    output wire [(((2*D_STATE)+1)*WGHT_WIDTH)-1:0]        o_W_MERGED_X_PROJ,
    output wire [Z_WIDTH-1:0]                           o_Z_MERGED_X_PROJ,
    output wire [(((2*D_STATE)+1)*BIAS_WIDTH)-1:0]       o_BIAS_MERGED_X_PROJ,
    output wire [(((2*D_STATE)+1)*16)-1:0]               o_M_MERGED_X_PROJ_FLAT,
    output wire [(((2*D_STATE)+1)*5)-1:0]                o_N_MERGED_X_PROJ_FLAT,

    output wire [(D_MODEL*WGHT_WIDTH)-1:0]              o_W_DT_PROJ,
    output wire [Z_WIDTH-1:0]                           o_Z_DT_PROJ,
    output wire [(D_MODEL*BIAS_WIDTH)-1:0]              o_BIAS_DT_PROJ,
    output wire [(D_MODEL*16)-1:0]                      o_M_DT_PROJ_FLAT,
    output wire [(D_MODEL*5)-1:0]                       o_N_DT_PROJ_FLAT,

    output wire [(4*D_MODEL*WGHT_WIDTH)-1:0]            o_W_PROJ_OUT,
    output wire [Z_WIDTH-1:0]                           o_Z_PROJ_OUT,
    output wire [(4*BIAS_WIDTH)-1:0]                    o_BIAS_PROJ_OUT,
    output wire [15:0]                                  o_M_PROJ_OUT,
    output wire [4:0]                                   o_N_PROJ_OUT,

    output wire [(D_MODEL*D_STATE*DATA_WIDTH)-1:0]     o_CONST_A,
    output wire [(D_MODEL*DATA_WIDTH)-1:0]             o_CONST_D
);

    localparam integer OUT_MERGED = (2 * D_STATE) + 1;

    localparam integer LN_W_PI   = (D_MODEL * WGHT_WIDTH) / 8;
    localparam integer LN_Z_PI   = 2;
    localparam integer LN_BIAS_PI = (D_MODEL * BIAS_WIDTH + 7) / 8;
    localparam integer LN_M      = (DATA_WIDTH + 7) / 8;
    localparam integer LN_N      = 1;

    localparam integer LN_W_MX   = (OUT_MERGED * WGHT_WIDTH) / 8;
    localparam integer LN_Z_MX   = 2;
    localparam integer LN_BIAS_MX = (OUT_MERGED * BIAS_WIDTH + 7) / 8;

    localparam integer LN_W_DT   = LN_W_PI;
    localparam integer LN_Z_DT   = LN_Z_PI;
    localparam integer LN_BIAS_DT = LN_BIAS_PI;

    localparam integer LN_W_PO   = (4 * D_MODEL * WGHT_WIDTH) / 8;
    localparam integer LN_Z_PO   = 2;
    localparam integer LN_BIAS_PO = (4 * BIAS_WIDTH + 7) / 8;

    localparam integer LN_CA     = (D_MODEL * D_STATE * DATA_WIDTH) / 8;
    localparam integer LN_CD     = (D_MODEL * DATA_WIDTH) / 8;

    localparam integer OS_W_PI   = 0;
    localparam integer OS_Z_PI   = OS_W_PI   + LN_W_PI;
    localparam integer OS_BIAS_PI = OS_Z_PI  + LN_Z_PI;
    localparam integer OS_M_PI   = OS_BIAS_PI + LN_BIAS_PI;
    localparam integer OS_N_PI   = OS_M_PI    + LN_M;

    localparam integer OS_W_MX   = OS_N_PI   + LN_N;
    localparam integer OS_Z_MX   = OS_W_MX   + LN_W_MX;
    localparam integer OS_BIAS_MX = OS_Z_MX + LN_Z_MX;
    localparam integer OS_M_MX   = OS_BIAS_MX + LN_BIAS_MX;
    localparam integer OS_N_MX   = OS_M_MX   + LN_M;

    localparam integer OS_W_DT   = OS_N_MX   + LN_N;
    localparam integer OS_Z_DT   = OS_W_DT   + LN_W_DT;
    localparam integer OS_BIAS_DT = OS_Z_DT  + LN_Z_DT;
    localparam integer OS_M_DT   = OS_BIAS_DT + LN_BIAS_DT;
    localparam integer OS_N_DT   = OS_M_DT   + LN_M;

    localparam integer OS_W_PO   = OS_N_DT   + LN_N;
    localparam integer OS_Z_PO   = OS_W_PO   + LN_W_PO;
    localparam integer OS_BIAS_PO = OS_Z_PO + LN_Z_PO;
    localparam integer OS_M_PO   = OS_BIAS_PO + LN_BIAS_PO;
    localparam integer OS_N_PO   = OS_M_PO   + LN_M;

    localparam integer OS_CA     = OS_N_PO   + LN_N;
    localparam integer OS_CD     = OS_CA     + LN_CA;

    reg [(D_MODEL*WGHT_WIDTH)-1:0]              r_W_PROJ_IN;
    reg [Z_WIDTH-1:0]                         r_Z_PROJ_IN;
    reg [(D_MODEL*BIAS_WIDTH)-1:0]            r_BIAS_PROJ_IN;
    reg [DATA_WIDTH-1:0]                       r_M_PROJ_IN;
    reg [4:0]                                  r_N_PROJ_IN;

    reg [(OUT_MERGED*WGHT_WIDTH)-1:0]           r_W_MERGED_X_PROJ;
    reg [Z_WIDTH-1:0]                          r_Z_MERGED_X_PROJ;
    reg [(OUT_MERGED*BIAS_WIDTH)-1:0]           r_BIAS_MERGED_X_PROJ;
    reg [15:0]                                 r_M_MERGED_X_PROJ;
    reg [4:0]                                  r_N_MERGED_X_PROJ;

    reg [(D_MODEL*WGHT_WIDTH)-1:0]              r_W_DT_PROJ;
    reg [Z_WIDTH-1:0]                          r_Z_DT_PROJ;
    reg [(D_MODEL*BIAS_WIDTH)-1:0]              r_BIAS_DT_PROJ;
    reg [DATA_WIDTH-1:0]                       r_M_DT_PROJ;
    reg [4:0]                                  r_N_DT_PROJ;

    reg [(4*D_MODEL*WGHT_WIDTH)-1:0]            r_W_PROJ_OUT;
    reg [Z_WIDTH-1:0]                          r_Z_PROJ_OUT;
    reg [(4*BIAS_WIDTH)-1:0]                    r_BIAS_PROJ_OUT;
    reg [15:0]                                 r_M_PROJ_OUT;
    reg [4:0]                                  r_N_PROJ_OUT;

    reg [(D_MODEL*D_STATE*DATA_WIDTH)-1:0]      r_CONST_A;
    reg [(D_MODEL*DATA_WIDTH)-1:0]             r_CONST_D;

    integer idx;

    assign o_W_PROJ_IN   = r_W_PROJ_IN;
    assign o_Z_PROJ_IN   = r_Z_PROJ_IN;
    assign o_BIAS_PROJ_IN = r_BIAS_PROJ_IN;

    assign o_W_MERGED_X_PROJ   = r_W_MERGED_X_PROJ;
    assign o_Z_MERGED_X_PROJ   = r_Z_MERGED_X_PROJ;
    assign o_BIAS_MERGED_X_PROJ = r_BIAS_MERGED_X_PROJ;

    assign o_W_DT_PROJ   = r_W_DT_PROJ;
    assign o_Z_DT_PROJ   = r_Z_DT_PROJ;
    assign o_BIAS_DT_PROJ = r_BIAS_DT_PROJ;

    assign o_W_PROJ_OUT   = r_W_PROJ_OUT;
    assign o_Z_PROJ_OUT   = r_Z_PROJ_OUT;
    assign o_BIAS_PROJ_OUT = r_BIAS_PROJ_OUT;
    assign o_M_PROJ_OUT    = r_M_PROJ_OUT;
    assign o_N_PROJ_OUT    = r_N_PROJ_OUT;

    assign o_CONST_A = r_CONST_A;
    assign o_CONST_D = r_CONST_D;

    assign o_M_PROJ_IN_FLAT = {D_MODEL{r_M_PROJ_IN}};
    assign o_N_PROJ_IN_FLAT = {D_MODEL{r_N_PROJ_IN}};
    assign o_M_MERGED_X_PROJ_FLAT = {OUT_MERGED{r_M_MERGED_X_PROJ}};
    assign o_N_MERGED_X_PROJ_FLAT = {OUT_MERGED{r_N_MERGED_X_PROJ}};
    assign o_M_DT_PROJ_FLAT = {D_MODEL{r_M_DT_PROJ}};
    assign o_N_DT_PROJ_FLAT = {D_MODEL{r_N_DT_PROJ}};

    always @(posedge clk or negedge rst_weights_n) begin
        if (!rst_weights_n) begin
            r_W_PROJ_IN          <= {(D_MODEL*WGHT_WIDTH){1'b0}};
            r_Z_PROJ_IN          <= {Z_WIDTH{1'b0}};
            r_BIAS_PROJ_IN       <= {(D_MODEL*BIAS_WIDTH){1'b0}};
            r_M_PROJ_IN          <= {DATA_WIDTH{1'b0}};
            r_N_PROJ_IN          <= 5'd0;

            r_W_MERGED_X_PROJ    <= {(OUT_MERGED*WGHT_WIDTH){1'b0}};
            r_Z_MERGED_X_PROJ    <= {Z_WIDTH{1'b0}};
            r_BIAS_MERGED_X_PROJ <= {(OUT_MERGED*BIAS_WIDTH){1'b0}};
            r_M_MERGED_X_PROJ    <= 16'd0;
            r_N_MERGED_X_PROJ    <= 5'd0;

            r_W_DT_PROJ          <= {(D_MODEL*WGHT_WIDTH){1'b0}};
            r_Z_DT_PROJ          <= {Z_WIDTH{1'b0}};
            r_BIAS_DT_PROJ       <= {(D_MODEL*BIAS_WIDTH){1'b0}};
            r_M_DT_PROJ          <= {DATA_WIDTH{1'b0}};
            r_N_DT_PROJ          <= 5'd0;

            r_W_PROJ_OUT         <= {(4*D_MODEL*WGHT_WIDTH){1'b0}};
            r_Z_PROJ_OUT         <= {Z_WIDTH{1'b0}};
            r_BIAS_PROJ_OUT      <= {(4*BIAS_WIDTH){1'b0}};
            r_M_PROJ_OUT         <= 16'd0;
            r_N_PROJ_OUT         <= 5'd0;

            r_CONST_A            <= {(D_MODEL*D_STATE*DATA_WIDTH){1'b0}};
            r_CONST_D            <= {(D_MODEL*DATA_WIDTH){1'b0}};
        end else if (w_we) begin
            if (w_addr >= OS_W_PI && w_addr < OS_W_PI + LN_W_PI) begin
                idx = w_addr - OS_W_PI;
                r_W_PROJ_IN[(LN_W_PI * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_Z_PI && w_addr < OS_Z_PI + LN_Z_PI) begin
                idx = w_addr - OS_Z_PI;
                if (idx == 0)
                    r_Z_PROJ_IN[8] <= w_data[0];
                else
                    r_Z_PROJ_IN[7:0] <= w_data[7:0];
            end else if (w_addr >= OS_BIAS_PI && w_addr < OS_BIAS_PI + LN_BIAS_PI) begin
                idx = w_addr - OS_BIAS_PI;
                r_BIAS_PROJ_IN[(D_MODEL * BIAS_WIDTH) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_M_PI && w_addr < OS_M_PI + LN_M) begin
                idx = w_addr - OS_M_PI;
                r_M_PROJ_IN[(LN_M * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr == OS_N_PI) begin
                r_N_PROJ_IN <= w_data[4:0];
            end else if (w_addr >= OS_W_MX && w_addr < OS_W_MX + LN_W_MX) begin
                idx = w_addr - OS_W_MX;
                r_W_MERGED_X_PROJ[(LN_W_MX * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_Z_MX && w_addr < OS_Z_MX + LN_Z_MX) begin
                idx = w_addr - OS_Z_MX;
                if (idx == 0)
                    r_Z_MERGED_X_PROJ[8] <= w_data[0];
                else
                    r_Z_MERGED_X_PROJ[7:0] <= w_data[7:0];
            end else if (w_addr >= OS_BIAS_MX && w_addr < OS_BIAS_MX + LN_BIAS_MX) begin
                idx = w_addr - OS_BIAS_MX;
                r_BIAS_MERGED_X_PROJ[(OUT_MERGED * BIAS_WIDTH) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_M_MX && w_addr < OS_M_MX + LN_M) begin
                idx = w_addr - OS_M_MX;
                r_M_MERGED_X_PROJ[(LN_M * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr == OS_N_MX) begin
                r_N_MERGED_X_PROJ <= w_data[4:0];
            end else if (w_addr >= OS_W_DT && w_addr < OS_W_DT + LN_W_DT) begin
                idx = w_addr - OS_W_DT;
                r_W_DT_PROJ[(LN_W_DT * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_Z_DT && w_addr < OS_Z_DT + LN_Z_DT) begin
                idx = w_addr - OS_Z_DT;
                if (idx == 0)
                    r_Z_DT_PROJ[8] <= w_data[0];
                else
                    r_Z_DT_PROJ[7:0] <= w_data[7:0];
            end else if (w_addr >= OS_BIAS_DT && w_addr < OS_BIAS_DT + LN_BIAS_DT) begin
                idx = w_addr - OS_BIAS_DT;
                r_BIAS_DT_PROJ[(D_MODEL * BIAS_WIDTH) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_M_DT && w_addr < OS_M_DT + LN_M) begin
                idx = w_addr - OS_M_DT;
                r_M_DT_PROJ[(LN_M * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr == OS_N_DT) begin
                r_N_DT_PROJ <= w_data[4:0];
            end else if (w_addr >= OS_W_PO && w_addr < OS_W_PO + LN_W_PO) begin
                idx = w_addr - OS_W_PO;
                r_W_PROJ_OUT[(LN_W_PO * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_Z_PO && w_addr < OS_Z_PO + LN_Z_PO) begin
                idx = w_addr - OS_Z_PO;
                if (idx == 0)
                    r_Z_PROJ_OUT[8] <= w_data[0];
                else
                    r_Z_PROJ_OUT[7:0] <= w_data[7:0];
            end else if (w_addr >= OS_BIAS_PO && w_addr < OS_BIAS_PO + LN_BIAS_PO) begin
                idx = w_addr - OS_BIAS_PO;
                r_BIAS_PROJ_OUT[(4 * BIAS_WIDTH) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_M_PO && w_addr < OS_M_PO + LN_M) begin
                idx = w_addr - OS_M_PO;
                r_M_PROJ_OUT[(LN_M * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr == OS_N_PO) begin
                r_N_PROJ_OUT <= w_data[4:0];
            end else if (w_addr >= OS_CA && w_addr < OS_CA + LN_CA) begin
                idx = w_addr - OS_CA;
                r_CONST_A[(LN_CA * 8) - 1 - 8 * idx -: 8] <= w_data;
            end else if (w_addr >= OS_CD && w_addr < OS_CD + LN_CD) begin
                idx = w_addr - OS_CD;
                r_CONST_D[(LN_CD * 8) - 1 - 8 * idx -: 8] <= w_data;
            end
        end
    end

endmodule
