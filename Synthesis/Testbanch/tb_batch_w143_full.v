`timescale 1ns / 1ps
// Batch RTL/gate: weights_ram_143.hex, samples 0 .. end
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram_143.hex"
`define BATCH_SAMPLE_START 0
`define TB_TAG "[BATCH_W143_FULL]"
`define TB_TOP_MODULE tb_batch_w143_full
`define FSDB_OUT_FILE "tb_batch_w143_full.fsdb"

module tb_batch_w143_full;
`include "tb_batch_body.inc.v"
endmodule
