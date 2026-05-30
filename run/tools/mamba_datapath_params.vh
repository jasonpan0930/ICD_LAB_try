`ifndef MAMBA_DATAPATH_PARAMS_VH
`define MAMBA_DATAPATH_PARAMS_VH
//
// Reference constants (weights / biases / A / D). Used by tools and optional legacy `include.
// Simulation RTL: mamba_weight_storage reset clears to zero; load 369 bytes via w_we before infer.
// D_MODEL / D_STATE must match the including module when this file is `included.
//

// ==========================================
// Auto-generated Mamba Datapath parameters
// ==========================================

// (1) proj_in (1 -> 8)
localparam [(8*1*8)-1:0] W_PROJ_IN = {8'd59, 8'd235, 8'd0, 8'd68, 8'd199, 8'd255, 8'd202, 8'd132};
localparam [(8*16)-1:0] Z_PROJ_IN = {16'sd151, 16'sd151, 16'sd151, 16'sd151, 16'sd151, 16'sd151, 16'sd151, 16'sd151};
localparam [(8*16)-1:0] BIAS_PROJ_IN = {16'sd244, -16'sd154, -16'sd99, -16'sd84, -16'sd265, 16'sd13, 16'sd110, 16'sd269};
localparam [15:0] M_PROJ_IN = 16'd1221;
localparam [4:0]  N_PROJ_IN = 5'd16;

// (2) merged_x_proj (1 -> 17)
localparam [(17*1*8)-1:0] W_MERGED_X_PROJ = {
    8'd112, 8'd220, 8'd77, 8'd237, 8'd28, 8'd231, 8'd132, 8'd0,
    8'd255, 8'd94, 8'd137, 8'd246, 8'd218, 8'd222, 8'd82, 8'd237,
    8'd216
};
localparam [(17*16)-1:0] Z_MERGED_X_PROJ = {
    16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164, 16'sd164,
    16'sd164
};
localparam [(17*16)-1:0] BIAS_MERGED_X_PROJ = {
    16'sd278, 16'sd43, 16'sd445, -16'sd809, 16'sd7, 16'sd190, -16'sd1018, 16'sd770, 16'sd75, 16'sd117, -16'sd903, -16'sd236, 16'sd1220, -16'sd835, 16'sd931, -16'sd1706,
    16'sd384
};
localparam [15:0] M_MERGED_X_PROJ = 16'd5950;
localparam [4:0]  N_MERGED_X_PROJ = 5'd16;

// (3) dt_proj (1 -> 8)
localparam [(8*1*8)-1:0] W_DT_PROJ = {8'd35, 8'd68, 8'd121, 8'd255, 8'd0, 8'd117, 8'd141, 8'd67};
localparam [(8*16)-1:0] Z_DT_PROJ = {16'sd64, 16'sd64, 16'sd64, 16'sd64, 16'sd64, 16'sd64, 16'sd64, 16'sd64};
localparam [(8*16)-1:0] BIAS_DT_PROJ = {-16'sd751, -16'sd557, -16'sd486, -16'sd981, -16'sd1084, -16'sd570, -16'sd524, -16'sd568};
localparam [15:0] M_DT_PROJ = 16'd915;
localparam [4:0]  N_DT_PROJ = 5'd16;

// (4) proj_out (8 -> 4)
localparam [(4*8*8)-1:0] W_PROJ_OUT = {
    8'd255, 8'd238, 8'd192, 8'd114, 8'd189, 8'd250, 8'd211, 8'd109,
    8'd207, 8'd152, 8'd75, 8'd225, 8'd197, 8'd85, 8'd131, 8'd236,
    8'd200, 8'd146, 8'd237, 8'd191, 8'd75, 8'd203, 8'd191, 8'd173,
    8'd0, 8'd148, 8'd218, 8'd173, 8'd230, 8'd199, 8'd67, 8'd151
};
localparam [(4*16)-1:0] Z_PROJ_OUT = {16'sd168, 16'sd168, 16'sd168, 16'sd168};
localparam [(4*16)-1:0] BIAS_PROJ_OUT = {-16'sd419, 16'sd106, 16'sd49, 16'sd522};
localparam [15:0] M_PROJ_OUT = 16'd747;
localparam [4:0]  N_PROJ_OUT = 5'd16;

// Constant parameter A (Q8.8)
localparam [(D_MODEL*D_STATE*16)-1:0] CONST_A = {
    -16'sd122, -16'sd137, -16'sd1189, -16'sd808, -16'sd1020, -16'sd1231, -16'sd1640, -16'sd1311,
    -16'sd87, -16'sd1126, -16'sd224, -16'sd4207, -16'sd1603, -16'sd603, -16'sd1363, -16'sd952,
    -16'sd446, -16'sd423, -16'sd1174, -16'sd1053, -16'sd937, -16'sd846, -16'sd1819, -16'sd1522,
    -16'sd61, -16'sd146, -16'sd574, -16'sd466, -16'sd508, -16'sd447, -16'sd1369, -16'sd2098,
    -16'sd103, -16'sd393, -16'sd281, -16'sd1532, -16'sd516, -16'sd815, -16'sd32768, -16'sd4595,
    -16'sd97, -16'sd832, -16'sd147, -16'sd4480, -16'sd4572, -16'sd4052, -16'sd32768, -16'sd4326,
    -16'sd3, -16'sd692, -16'sd64, -16'sd2001, -16'sd2411, -16'sd832, -16'sd926, -16'sd690,
    -16'sd159, -16'sd677, -16'sd680, -16'sd11982, -16'sd10911, -16'sd527, -16'sd1119, -16'sd637
};

// Constant parameter D (Q8.8)
localparam [(D_MODEL*16)-1:0] CONST_D = {16'sd1457, -16'sd263, 16'sd635, 16'sd158, 16'sd240, 16'sd566, 16'sd284, 16'sd452};

`endif
