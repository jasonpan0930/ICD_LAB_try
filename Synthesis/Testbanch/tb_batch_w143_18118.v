`timescale 1ns / 1ps
// Batch RTL/gate: weights_ram_143.hex, samples 18118 .. end
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram_143.hex"
`define BATCH_SAMPLE_START 18118
`define TB_TAG "[BATCH_W143_18118]"
`define TB_TOP_MODULE tb_batch_w143_18118
`define FSDB_OUT_FILE "tb_batch_w143_18118.fsdb"

module tb_batch_w143_18118;
`include "tb_batch_body.inc.v"
endmodule
