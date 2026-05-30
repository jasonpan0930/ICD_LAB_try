`timescale 1ns / 1ps
// weights_ram_143.hex, samples 18118 .. TOTAL_SAMPLES-1
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram_143.hex"
`define DYN_SAMPLE_START 18118
`define DYN_TB_TAG "[DYN_W143_18118]"
`define DYN_TB_TOP_MODULE tb_dyn_w143_18118
`define FSDB_OUT_FILE "tb_dyn_w143_18118.fsdb"

module tb_dyn_w143_18118;
`include "tb_mit_dyn_inference_body.inc.v"
endmodule
