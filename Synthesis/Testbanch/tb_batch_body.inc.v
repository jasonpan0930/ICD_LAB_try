// Shared by tb_batch_*.v — 32-I/O mode/strobe protocol, per-sample OK/NG, confusion matrix.
`include "tb_define.vh"
`ifndef PATTERN_FEATURES_HEX
`define PATTERN_FEATURES_HEX "Pattern/test_features.hex"
`endif
`ifndef PATTERN_GOLDEN_HEX
`define PATTERN_GOLDEN_HEX "Pattern/test_mit_ground_truth.hex"
`endif
`ifdef SDF
`ifndef SDF_FILE
`define SDF_FILE "Netlist/CHIP_cldGating_syn.sdf"
`endif
`endif

    parameter D_IN           = 1;
    parameter D_MODEL        = 8;
    parameter D_STATE        = 8;
    parameter SEQ_LEN        = 187;
    parameter DATA_WIDTH     = 16;
    parameter WGHT_WIDTH     = 8;
    parameter ADDR_WIDTH     = 9;
    parameter TOTAL_SAMPLES  = 21336;
    parameter integer SAMPLE_START = `BATCH_SAMPLE_START;

    localparam integer WEIGHT_BYTES = 285;

    reg  clk;
    reg  rst_n;
    reg  mode;
    reg  strobe;
    reg  signed [DATA_WIDTH-1:0] i_data;
    reg  [7:0] w_data;

    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    reg [15:0] test_mem   [0:TOTAL_SAMPLES*SEQ_LEN-1];
    reg [1:0]  golden_mem [0:TOTAL_SAMPLES-1];
    reg [7:0]  weight_mem [0:WEIGHT_BYTES-1];

`ifdef GATE_SIM
    mamba_core uut (
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .strobe(strobe),
        .i_data(i_data),
        .w_data(w_data),
        .o_ready(o_ready),
        .o_valid(o_valid),
        .o_class(o_class)
    );
`else
    mamba_core #(
        .D_IN(D_IN),
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .WEIGHT_BYTES(WEIGHT_BYTES)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .strobe(strobe),
        .i_data(i_data),
        .w_data(w_data),
        .o_ready(o_ready),
        .o_valid(o_valid),
        .o_class(o_class)
    );
`endif

`ifndef TB_TOP_MODULE
`define TB_TOP_MODULE tb_batch_uut
`endif
`ifndef FSDB_OUT_FILE
`define FSDB_OUT_FILE "tb_batch.fsdb"
`endif

    string fsdb_path;
    reg fsdb_dump_enabled;
    reg fsdb_window_active;

    task fsdb_setup;
        begin
            fsdb_dump_enabled = 1'b0;
            fsdb_window_active = 1'b0;
`ifdef DUMP_FSDB
            fsdb_dump_enabled = 1'b1;
`else
            if ($test$plusargs("fsdb"))
                fsdb_dump_enabled = 1'b1;
`endif
            if (!fsdb_dump_enabled)
                disable fsdb_setup;

            if (!$value$plusargs("fsdbfile=%s", fsdb_path)) begin
                fsdb_path = `FSDB_OUT_FILE;
            end
            $display("%s FSDB dump enabled: %s", `TB_TAG, fsdb_path);
            $fsdbDumpfile(fsdb_path);
            $fsdbDumpvars(0, `TB_TOP_MODULE);
`ifdef DUMP_FSDB_SAMPLE
            $fsdbDumpoff;
            $display("%s FSDB window: sample %0d only", `TB_TAG, `DUMP_FSDB_SAMPLE);
`endif
        end
    endtask

    task fsdb_on_sample_start;
        input integer sid;
        begin
            if (!fsdb_dump_enabled)
                disable fsdb_on_sample_start;
`ifdef DUMP_FSDB_SAMPLE
            if (sid == `DUMP_FSDB_SAMPLE) begin
                $fsdbDumpon;
                fsdb_window_active = 1'b1;
                $display("%s FSDB recording sample %0d", `TB_TAG, sid);
            end
`endif
        end
    endtask

    task fsdb_on_sample_done;
        input integer sid;
        begin
            if (!fsdb_dump_enabled)
                disable fsdb_on_sample_done;
`ifdef DUMP_FSDB_SAMPLE
            if (fsdb_window_active && sid == `DUMP_FSDB_SAMPLE) begin
                $fsdbDumpoff;
                fsdb_window_active = 1'b0;
                $display("%s FSDB stopped after sample %0d", `TB_TAG, sid);
            end
`endif
        end
    endtask

    initial begin
        clk = 0;
        forever #`TB_CLK_HALF_PERIOD clk = ~clk;
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
    reg [1:0] pred_class;

`ifdef SDF
    initial begin
        $display("%s SDF annotation enabled: %s", `TB_TAG, `SDF_FILE);
        $sdf_annotate(`SDF_FILE, uut);
    end
`endif

    task write_weight_byte;
        input [7:0] d;
        begin
            wait_cycles = 0;
            while (o_ready !== 1'b1 && wait_cycles < 1000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_ready !== 1'b1) begin
                $display("%s TIMEOUT waiting load o_ready", `TB_TAG);
                $finish(1);
            end

            @(negedge clk);
            #1;
            w_data = d;
            strobe = 1'b0;
            @(negedge clk);
            #1;
            strobe = 1'b1;
            @(negedge clk);
            #1;
            strobe = 1'b0;
        end
    endtask

    task load_all_weights_from_mem;
        begin
            @(negedge clk);
            #1;
            mode = 1'b1;
            strobe = 1'b0;
            w_data = 8'd0;

            wait_cycles = 0;
            while (o_ready !== 1'b1 && wait_cycles < 1000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_ready !== 1'b1) begin
                $display("%s TIMEOUT waiting wrapper load mode ready", `TB_TAG);
                $finish(1);
            end

            for (k = 0; k < WEIGHT_BYTES; k = k + 1)
                write_weight_byte(weight_mem[k]);

            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 1000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("%s TIMEOUT waiting wrapper load done", `TB_TAG);
                $finish(1);
            end

            @(negedge clk);
            #1;
            mode = 1'b0;
            strobe = 1'b0;
            w_data = 8'd0;
        end
    endtask

    task pulse_datapath_reset;
        begin
            @(negedge clk);
            #1;
            rst_n = 1'b0;
            @(negedge clk);
            #1;
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
                #1;
                if (o_ready) begin
                    strobe = 1'b1;
                    i_data  = test_mem[sid*SEQ_LEN + i];
                    i       = i + 1;
                end else
                    strobe = 1'b0;
            end
            @(negedge clk);
            #1;
            strobe = 1'b0;

            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 200000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("%s TIMEOUT waiting o_valid sample %0d", `TB_TAG, sid);
                $finish(1);
            end
            pred_class = o_class;
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
        fsdb_setup();
        $readmemh(`PATTERN_FEATURES_HEX, test_mem);
        $readmemh(`PATTERN_GOLDEN_HEX, golden_mem);
        $readmemh(`PATTERN_WEIGHTS_HEX, weight_mem);

        if (SAMPLE_START < 0 || SAMPLE_START >= TOTAL_SAMPLES) begin
            $display("%s FATAL: SAMPLE_START(%0d) out of range [0,%0d)",
                     `TB_TAG, SAMPLE_START, TOTAL_SAMPLES);
            $finish(1);
        end

        rst_n   = 1'b0;
        mode    = 1'b0;
        strobe  = 1'b0;
        i_data  = 16'd0;
        w_data  = 8'd0;

        #25;
        rst_n = 1'b1;
        #10;
        load_all_weights_from_mem;
        #10;

        run_total = TOTAL_SAMPLES - SAMPLE_START;
        $display("\n%s weights=%s; bus-loaded once; samples %0d .. %0d (%0d total)",
                 `TB_TAG, `PATTERN_WEIGHTS_HEX, SAMPLE_START, TOTAL_SAMPLES - 1, run_total);
        correct_cnt = 0;
        for (c = 0; c < 4; c = c + 1) begin
            class_total[c]   = 0;
            class_correct[c] = 0;
            for (p = 0; p < 4; p = p + 1)
                conf_matrix[c][p] = 0;
        end

        for (s = SAMPLE_START; s < TOTAL_SAMPLES; s = s + 1) begin
            fsdb_on_sample_start(s);
            run_sample_datapath_reset_feed(s);
            fsdb_on_sample_done(s);
            golden_val = golden_mem[s];
            if (pred_class !== golden_val)
                $display("%s NG sample %0d pred=%0d golden=%0d", `TB_TAG, s, pred_class, golden_val);
            else
                $display("%s OK sample %0d pred=%0d golden=%0d", `TB_TAG, s, pred_class, golden_val);
            class_total[golden_val] = class_total[golden_val] + 1;
            conf_matrix[golden_val][pred_class] = conf_matrix[golden_val][pred_class] + 1;
            if (pred_class === golden_val) begin
                correct_cnt = correct_cnt + 1;
                class_correct[golden_val] = class_correct[golden_val] + 1;
            end
        end

        $display("\n=====================================================================");
        $display("%s summary: correct %0d / %0d (%.4f %%)",
                 `TB_TAG, correct_cnt, run_total, (correct_cnt * 100.0) / run_total);
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
        $display("%s Done.\n", `TB_TAG);
        $finish(0);
    end
