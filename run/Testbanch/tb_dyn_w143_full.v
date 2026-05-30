`timescale 1ns / 1ps
// weights_ram_143.hex, samples 0 .. TOTAL_SAMPLES-1
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram_143.hex"
`define DYN_SAMPLE_START 0
`define DYN_TB_TAG "[DYN_W143_FULL]"
`define DYN_TB_TOP_MODULE tb_dyn_w143_full
`define FSDB_OUT_FILE "tb_dyn_w143_full.fsdb"

module tb_dyn_w143_full;
`include "tb_mit_dyn_inference_body.inc.v"
endmodule
