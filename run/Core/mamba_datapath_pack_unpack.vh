`ifndef MAMBA_DATAPATH_PACK_UNPACK_VH
`define MAMBA_DATAPATH_PACK_UNPACK_VH

// Internal unpacked arrays
wire signed [DATA_WIDTH-1:0] i_h_reg       [0:D_MODEL-1][0:D_STATE-1];
wire signed [DATA_WIDTH-1:0] i_y_pool_reg  [0:D_MODEL-1];

reg  signed [DATA_WIDTH-1:0] o_next_y_pool [0:D_MODEL-1];
reg  signed [DATA_WIDTH-1:0] o_logits      [0:3];

// Unpacked constants
wire signed [DATA_WIDTH-1:0] const_a_2d    [0:D_MODEL-1][0:D_STATE-1];
wire signed [DATA_WIDTH-1:0] const_d_1d    [0:D_MODEL-1];

genvar r, c;
generate
    // Unpack input ports and constants
    for (r = 0; r < D_MODEL; r = r + 1) begin : gen_unpack_y
        assign i_y_pool_reg[r] = i_y_pool_reg_flat[ (D_MODEL - r)*DATA_WIDTH - 1 -: DATA_WIDTH ];
        assign const_d_1d[r]   = CONST_D[ (D_MODEL - r)*DATA_WIDTH - 1 -: DATA_WIDTH ];

        for (c = 0; c < D_STATE; c = c + 1) begin : gen_unpack_h
            assign i_h_reg[r][c]    = i_h_reg_flat[ ((D_MODEL*D_STATE) - (r*D_STATE + c))*DATA_WIDTH - 1 -: DATA_WIDTH ];
            assign const_a_2d[r][c] = CONST_A[ ((D_MODEL*D_STATE) - (r*D_STATE + c))*DATA_WIDTH - 1 -: DATA_WIDTH ];
        end
    end
endgenerate

// Pack output ports
integer orow;
always @(*) begin
    for (orow = 0; orow < D_MODEL; orow = orow + 1) begin
        o_next_y_pool_flat[ (D_MODEL - orow)*DATA_WIDTH - 1 -: DATA_WIDTH ] = o_next_y_pool[orow];
    end
    for (orow = 0; orow < 4; orow = orow + 1) begin
        o_logits_flat[ (4 - orow)*DATA_WIDTH - 1 -: DATA_WIDTH ] = o_logits[orow];
    end
end

// Internal bridging for mamba_linear flat interfaces
wire [(1*DATA_WIDTH)-1:0]       in_arr_flat;
wire [(D_MODEL*DATA_WIDTH)-1:0] xt_flat;
wire [(17*DATA_WIDTH)-1:0]      proj_flat;
wire [(1*DATA_WIDTH)-1:0]       dt_raw_flat;
wire [(D_MODEL*DATA_WIDTH)-1:0] dt_proj_out_flat;
wire [(4*DATA_WIDTH)-1:0]       w_logits_flat;

assign in_arr_flat = in_arr[0];
assign dt_raw_flat = dt_raw[0];

genvar g_flat;
generate
    for (g_flat = 0; g_flat < D_MODEL; g_flat = g_flat + 1) begin : gen_unpack_xt
        assign xt[g_flat]          = xt_flat[ (D_MODEL - g_flat)*DATA_WIDTH - 1 -: DATA_WIDTH ];
        assign dt_proj_out[g_flat] = dt_proj_out_flat[ (D_MODEL - g_flat)*DATA_WIDTH - 1 -: DATA_WIDTH ];
    end
    for (g_flat = 0; g_flat < 17; g_flat = g_flat + 1) begin : gen_unpack_proj
        assign proj[g_flat] = proj_flat[ (17 - g_flat)*DATA_WIDTH - 1 -: DATA_WIDTH ];
    end
endgenerate

always @(*) begin
    o_logits[0] = w_logits_flat[ 4*DATA_WIDTH - 1 -: DATA_WIDTH ];
    o_logits[1] = w_logits_flat[ 3*DATA_WIDTH - 1 -: DATA_WIDTH ];
    o_logits[2] = w_logits_flat[ 2*DATA_WIDTH - 1 -: DATA_WIDTH ];
    o_logits[3] = w_logits_flat[ 1*DATA_WIDTH - 1 -: DATA_WIDTH ];
end

`endif
