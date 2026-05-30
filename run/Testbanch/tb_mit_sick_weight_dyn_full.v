`timescale 1ns / 1ps
//
// Tail sweep: samples SAMPLE_START .. TOTAL_SAMPLES-1.
// $readmemh once; rst_weights_n clears weight regs, then bus-load 285B once.
// Each sample: print OK/NG line, then rst_n (datapath/core FSM) only -> feed (weights kept).
//
`ifndef PATTERN_FEATURES_HEX
`define PATTERN_FEATURES_HEX "Pattern/test_features.hex"
`endif
`ifndef PATTERN_GOLDEN_HEX
`define PATTERN_GOLDEN_HEX "Pattern/test_mit_ground_truth.hex"
`endif
`ifndef PATTERN_WEIGHTS_HEX
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram.hex"
`endif

module tb_mit_sick_weight_dyn_full();

    parameter D_IN           = 1;
    parameter D_MODEL        = 8;
    parameter D_STATE        = 8;
    parameter SEQ_LEN        = 187;
    parameter DATA_WIDTH     = 16;
    parameter WGHT_WIDTH     = 8;
    parameter ADDR_WIDTH     = 9;
    parameter TOTAL_SAMPLES  = 21336;
    parameter integer SAMPLE_START = 18118;

    localparam integer WEIGHT_BYTES = 285;

    reg  clk;
    reg  rst_n;
    reg  rst_weights_n;
    reg  i_valid;
    reg  signed [DATA_WIDTH-1:0] i_data;
    reg  w_we;
    reg  [ADDR_WIDTH-1:0] w_addr;
    reg  [7:0] w_data;

    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    reg [15:0] test_mem   [0:TOTAL_SAMPLES*SEQ_LEN-1];
    reg [1:0]  golden_mem [0:TOTAL_SAMPLES-1];
    reg [7:0]  weight_mem [0:WEIGHT_BYTES-1];

    mamba_core #(
        .D_IN(D_IN),
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .rst_weights_n(rst_weights_n),
        .i_valid(i_valid),
        .i_data(i_data),
        .w_we(w_we),
        .w_addr(w_addr),
        .w_data(w_data),
        .o_ready(o_ready),
        .o_valid(o_valid),
        .o_class(o_class)
    );

    initial begin
        clk = 0;
        forever #3 clk = ~clk;
    end



    integer s, i, k;
    integer c, p;
    integer wait_cycles;
    integer golden_val;
    integer correct_cnt;
    integer run_total;
    integer class_total   [0:3];
    integer class_correct [0:3];
    integer conf_matrix   [0:3][0:3];

    task write_weight_byte;
        input [ADDR_WIDTH-1:0] a;
        input [7:0] d;
        begin
            @(negedge clk);
            #1; // <--- 加上這行
            w_we   = 1'b0;
            w_addr = a;
            w_data = d;
            @(negedge clk);
            #1; // <--- 加上這行
            w_we = 1'b1;
            @(negedge clk);
            #1; // <--- 加上這行
            w_we = 1'b0;
        end
    endtask

    task load_all_weights_from_mem;
        begin
            for (k = 0; k < WEIGHT_BYTES; k = k + 1)
                write_weight_byte(k[ADDR_WIDTH-1:0], weight_mem[k]);
            @(negedge clk);
            w_addr = {ADDR_WIDTH{1'b0}};
            w_data = 8'd0;
        end
    endtask

    task pulse_datapath_reset;
        begin
            @(negedge clk);
            #1; // <--- 加上這行
            rst_n = 1'b0;
            @(negedge clk);
            #1; // <--- 加上這行
            rst_n = 1'b1;
            @(negedge clk);
        end
    endtask

    task feed_sample;
        input integer sid;
        begin
            i = 0;
            while (i < SEQ_LEN) begin
                @(negedge clk);
                #1; // <--- 加上這行，確保在時脈邊緣後才給訊號
                if (o_ready) begin
                    i_valid = 1'b1;
                    i_data  = test_mem[sid*SEQ_LEN + i];
                    i       = i + 1;
                end else
                    i_valid = 1'b0; // 這裡本來在同一個 #1 延遲下，所以不用再加
            end
            @(negedge clk);
            #1; // <--- 加上這行
            i_valid = 1'b0;

            wait_cycles = 0;
            // ... 後面的 wait o_valid 區塊不用改 ...

            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 200000) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("[WEIGHT_TAIL] TIMEOUT waiting o_valid sample %0d", sid);
                $finish(1);
            end
        end
    endtask

    task run_sample_datapath_reset_feed;
        input integer sid;
        begin
            pulse_datapath_reset;
            feed_sample(sid);
        end
    endtask

    initial begin
        `ifdef SDF
        `ifndef SDF_FILE
        `define SDF_FILE "../Netlist/CHIP_syn.sdf"
        `endif
            $display("[TB] SDF annotation enabled: %s", `SDF_FILE);
            $sdf_annotate(`SDF_FILE, uut);
        `endif

        $readmemh(`PATTERN_FEATURES_HEX, test_mem);
        $readmemh(`PATTERN_GOLDEN_HEX, golden_mem);
        $readmemh(`PATTERN_WEIGHTS_HEX, weight_mem);

        if (SAMPLE_START < 0 || SAMPLE_START >= TOTAL_SAMPLES) begin
            $display("[WEIGHT_TAIL] FATAL: SAMPLE_START(%0d) out of range [0,%0d)", SAMPLE_START, TOTAL_SAMPLES);
            $finish(1);
        end

        rst_weights_n = 1'b0;
        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = 16'd0;
        w_we    = 1'b0;
        w_addr  = {ADDR_WIDTH{1'b0}};
        w_data  = 8'd0;

        #25;
        rst_weights_n = 1'b1;
        #10;
        load_all_weights_from_mem;
        rst_n = 1'b1;
        #10;

        run_total = TOTAL_SAMPLES - SAMPLE_START;
        $display("\n[WEIGHT_TAIL] weights bus-loaded once; samples %0d .. %0d (%0d total); per sample rst_n->feed",
                 SAMPLE_START, TOTAL_SAMPLES - 1, run_total);
        correct_cnt = 0;
        for (c = 0; c < 4; c = c + 1) begin
            class_total[c]   = 0;
            class_correct[c] = 0;
            for (p = 0; p < 4; p = p + 1)
                conf_matrix[c][p] = 0;
        end

        for (s = SAMPLE_START; s < TOTAL_SAMPLES; s = s + 1) begin
            run_sample_datapath_reset_feed(s);
            golden_val = golden_mem[s];
            if (o_class !== golden_val)
                $display("[WEIGHT_TAIL] NG sample %0d pred=%0d golden=%0d", s, o_class, golden_val);
            else
                $display("[WEIGHT_TAIL] OK sample %0d pred=%0d golden=%0d", s, o_class, golden_val);
            class_total[golden_val] = class_total[golden_val] + 1;
            conf_matrix[golden_val][o_class] = conf_matrix[golden_val][o_class] + 1;
            if (o_class === golden_val) begin
                correct_cnt = correct_cnt + 1;
                class_correct[golden_val] = class_correct[golden_val] + 1;
            end
        end

        $display("\n=====================================================================");
        $display("[WEIGHT_TAIL] summary: correct %0d / %0d (%.4f %%)",
                 correct_cnt, run_total, (correct_cnt * 100.0) / run_total);
        $display("---------------------------------------------------------------------");
        $display("Normalized confusion matrix (row=true class):");
        $display("                 | Pred 0 | Pred 1 | Pred 2 | Pred 3 |");
        $display("---------------------------------------------------------------------");
        for (c = 0; c < 4; c = c + 1) begin
            if (class_total[c] > 0) begin
                $display(" True Class %0d    | %5.2f%% | %5.2f%% | %5.2f%% | %5.2f%% |",
                         c,
                         (conf_matrix[c][0] * 100.0) / class_total[c],
                         (conf_matrix[c][1] * 100.0) / class_total[c],
                         (conf_matrix[c][2] * 100.0) / class_total[c],
                         (conf_matrix[c][3] * 100.0) / class_total[c]);
            end else
                $display(" True Class %0d    |   --   |   --   |   --   |   --   |", c);
        end
        $display("=====================================================================\n");

        #50;
        $display("[WEIGHT_TAIL] Done.\n");
        $finish(0);
    end
endmodule
