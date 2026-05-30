`timescale 1ns / 1ps
`ifndef PATTERN_FEATURES_HEX
`define PATTERN_FEATURES_HEX "Pattern/test_features.hex"
`endif
`ifndef PATTERN_GOLDEN_HEX
`define PATTERN_GOLDEN_HEX "Pattern/test_mit_ground_truth.hex"
`endif
`ifndef PATTERN_WEIGHTS_HEX
`define PATTERN_WEIGHTS_HEX "Pattern/weights_ram.hex"
`endif
//
// Dynamic weight RAM load test (template: tb_mit_sick.v).
// Phase 1-2: load weights once (rst_weights_n), then per sample: rst_n only -> feed.
// Phase 3-4: corrupt TB mem, bus-reload once, same per-sample datapath reset + feed.
// Phase 5: readmemh + bus reload + one sample (datapath reset).
//

module tb_mit_sick_weight_dyn();

    parameter D_IN          = 1;
    parameter D_MODEL       = 8;
    parameter D_STATE       = 8;
    parameter SEQ_LEN       = 187;
    parameter DATA_WIDTH    = 16;
    parameter WGHT_WIDTH    = 8;
    parameter ADDR_WIDTH    = 9;
    parameter TOTAL_SAMPLES = 21336;
    parameter integer SAMPLE_START = 18118;
    parameter integer SAMPLE_COUNT = 100;
    // Strong perturbation on TB weight_mem before Phase 4 reload (indices match weights_ram.hex).
    parameter [ADDR_WIDTH-1:0] CORRUPT_BYTE_ADDR   = 9'd0;
    parameter [7:0]            CORRUPT_XOR_MASK   = 8'hff;
    parameter integer          CORRUPT_SPAN_BYTES = 285;

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

    reg [1:0] pred_baseline [0:SAMPLE_COUNT-1];
    integer   si;
    integer   correct_cnt_p2;
    integer   pred_changed_cnt;
    integer   corrupt_nbytes;

    task write_weight_byte;
        input [ADDR_WIDTH-1:0] a;
        input [7:0] d;
        begin
            @(negedge clk);
            w_we   = 1'b0;
            w_addr = a;
            w_data = d;
            @(negedge clk);
            w_we = 1'b1;
            @(negedge clk);
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
            rst_n = 1'b0;
            @(negedge clk);
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
                if (o_ready) begin
                    i_valid = 1'b1;
                    i_data  = test_mem[sid*SEQ_LEN + i];
                    i       = i + 1;
                end else
                    i_valid = 1'b0;
            end
            @(negedge clk);
            i_valid = 1'b0;

            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 200000) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("[WEIGHT_DYN] TIMEOUT waiting o_valid sample %0d", sid);
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
        $readmemh(`PATTERN_FEATURES_HEX, test_mem);
        $readmemh(`PATTERN_GOLDEN_HEX, golden_mem);
        $readmemh(`PATTERN_WEIGHTS_HEX, weight_mem);

        if (SAMPLE_START + SAMPLE_COUNT > TOTAL_SAMPLES) begin
            $display("[WEIGHT_DYN] FATAL: SAMPLE_START(%0d)+SAMPLE_COUNT(%0d) > TOTAL_SAMPLES(%0d)",
                     SAMPLE_START, SAMPLE_COUNT, TOTAL_SAMPLES);
            $finish(1);
        end
        if (CORRUPT_BYTE_ADDR >= WEIGHT_BYTES) begin
            $display("[WEIGHT_DYN] FATAL: CORRUPT_BYTE_ADDR(%0d) >= WEIGHT_BYTES(%0d)",
                     CORRUPT_BYTE_ADDR, WEIGHT_BYTES);
            $finish(1);
        end
        corrupt_nbytes = WEIGHT_BYTES - CORRUPT_BYTE_ADDR;
        if (CORRUPT_SPAN_BYTES < corrupt_nbytes)
            corrupt_nbytes = CORRUPT_SPAN_BYTES;
        if (corrupt_nbytes < 1) begin
            $display("[WEIGHT_DYN] FATAL: CORRUPT_SPAN_BYTES / addr yields no bytes");
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

        $display("\n[WEIGHT_DYN] Phase 1-2: %0d samples from %0d .. %0d (weights loaded once; per sample rst_n->feed)",
                 SAMPLE_COUNT, SAMPLE_START, SAMPLE_START + SAMPLE_COUNT - 1);
        correct_cnt = 0;
        run_total   = 0;
        for (c = 0; c < 4; c = c + 1) begin
            class_total[c]   = 0;
            class_correct[c] = 0;
            for (p = 0; p < 4; p = p + 1)
                conf_matrix[c][p] = 0;
        end

        for (s = SAMPLE_START; s < SAMPLE_START + SAMPLE_COUNT; s = s + 1) begin
            run_sample_datapath_reset_feed(s);
            golden_val = golden_mem[s];
            si = s - SAMPLE_START;
            pred_baseline[si] = o_class;
            run_total  = run_total + 1;
            class_total[golden_val] = class_total[golden_val] + 1;
            conf_matrix[golden_val][o_class] = conf_matrix[golden_val][o_class] + 1;
            if (o_class !== golden_val)
                $display("[WEIGHT_DYN] NG sample %0d pred=%0d golden=%0d", s, o_class, golden_val);
            else begin
                correct_cnt = correct_cnt + 1;
                class_correct[golden_val] = class_correct[golden_val] + 1;
                $display("[WEIGHT_DYN] OK sample %0d pred=%0d golden=%0d", s, o_class, golden_val);
            end
        end
        $display("[WEIGHT_DYN] Phase 1-2 summary: correct %0d / %0d (%.4f %%)",
                 correct_cnt, run_total, (correct_cnt * 100.0) / run_total);

        $display("\n=====================================================================");
        $display("[WEIGHT_DYN] Phase 1-2 完成 (動態載入權重後 vs golden)");
        $display("---------------------------------------------------------------------");
        $display("總體正確數: %0d / %0d", correct_cnt, run_total);
        $display("總體正確率: %0f %%", (correct_cnt * 100.0) / run_total);
        $display("---------------------------------------------------------------------");
        $display("📊 Normalized Confusion Matrix (混淆矩陣比例):");
        $display("                 | Pred 0 (N) | Pred 1 (V) | Pred 2 (F) | Pred 3 (Q) |");
        $display("---------------------------------------------------------------------");
        for (c = 0; c < 4; c = c + 1) begin
            if (class_total[c] > 0) begin
                $display(" True Class %0d    |   %5.2f%%   |   %5.2f%%   |   %5.2f%%   |   %5.2f%%   |",
                         c,
                         (conf_matrix[c][0] * 100.0) / class_total[c],
                         (conf_matrix[c][1] * 100.0) / class_total[c],
                         (conf_matrix[c][2] * 100.0) / class_total[c],
                         (conf_matrix[c][3] * 100.0) / class_total[c]);
            end else begin
                $display(" True Class %0d    |    --      |    --      |    --      |    --      |", c);
            end
        end
        $display("=====================================================================\n");

        $display("\n[WEIGHT_DYN] Phase 3: XOR weight_mem[%0d : %0d] (%0d bytes) ^= 8'h%02x",
                 CORRUPT_BYTE_ADDR,
                 CORRUPT_BYTE_ADDR + corrupt_nbytes - 1,
                 corrupt_nbytes,
                 CORRUPT_XOR_MASK);
        for (k = 0; k < corrupt_nbytes; k = k + 1)
            weight_mem[CORRUPT_BYTE_ADDR + k] = weight_mem[CORRUPT_BYTE_ADDR + k] ^ CORRUPT_XOR_MASK;
        load_all_weights_from_mem;

        $display("\n[WEIGHT_DYN] Phase 4: same %0d samples with perturbed mem (pred vs Phase 1-2 baseline)",
                 SAMPLE_COUNT);
        pred_changed_cnt = 0;
        correct_cnt_p2   = 0;
        for (s = SAMPLE_START; s < SAMPLE_START + SAMPLE_COUNT; s = s + 1) begin
            run_sample_datapath_reset_feed(s);
            golden_val = golden_mem[s];
            si = s - SAMPLE_START;
            if (o_class !== pred_baseline[si]) begin
                pred_changed_cnt = pred_changed_cnt + 1;
                $display("[WEIGHT_DYN] PERTURB sample %0d pred %0d -> %0d (golden %0d)",
                         s, pred_baseline[si], o_class, golden_val);
            end
            if (o_class === golden_val)
                correct_cnt_p2 = correct_cnt_p2 + 1;
        end
        $display("[WEIGHT_DYN] Phase 4 summary: pred changed vs baseline %0d / %0d; vs golden correct %0d / %0d",
                 pred_changed_cnt, SAMPLE_COUNT, correct_cnt_p2, SAMPLE_COUNT);
        if (pred_changed_cnt == 0)
            $display("[WEIGHT_DYN] NOTE: zero pred changes; widen CORRUPT_SPAN_BYTES or raise |CORRUPT_XOR_MASK|.");

        $display("\n[WEIGHT_DYN] Phase 5: $readmemh -> weight_mem; bus reload; rst_n + feed sample %0d",
                 SAMPLE_START);
        $readmemh(`PATTERN_WEIGHTS_HEX, weight_mem);
        load_all_weights_from_mem;
        run_sample_datapath_reset_feed(SAMPLE_START);
        golden_val = golden_mem[SAMPLE_START];
        if (o_class === pred_baseline[0] && o_class === golden_val)
            $display("[WEIGHT_DYN] OK restore: pred=%0d matches baseline & golden=%0d", o_class, golden_val);
        else if (o_class === pred_baseline[0])
            $display("[WEIGHT_DYN] OK restore pred matches baseline=%0d (golden=%0d)", o_class, golden_val);
        else
            $display("[WEIGHT_DYN] NG restore: pred=%0d baseline[0]=%0d golden=%0d",
                     o_class, pred_baseline[0], golden_val);

        #50;
        $display("[WEIGHT_DYN] Done.\n");
        $finish(0);
    end
endmodule
