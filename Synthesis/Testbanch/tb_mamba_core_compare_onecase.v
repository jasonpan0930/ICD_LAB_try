`timescale 1ns / 1ps

module tb_mamba_core_compare_onecase;
    parameter D_IN       = 1;
    parameter D_MODEL    = 8;
    parameter D_STATE    = 8;
    parameter SEQ_LEN    = 187;
    parameter DATA_WIDTH = 16;
    parameter WGHT_WIDTH = 8;
    parameter TOTAL_SAMPLES = 21336;
    parameter SAMPLE_ID = 0;

    reg clk;
    reg rst_n;
    wire rst_weights_n;
    assign rst_weights_n = rst_n;

    reg i_valid_comb;
    reg signed [DATA_WIDTH-1:0] i_data_comb;
    wire o_ready_comb;
    wire o_valid_comb;
    wire [1:0] o_class_comb;

    reg i_valid_seq;
    reg signed [DATA_WIDTH-1:0] i_data_seq;
    wire o_ready_seq;
    wire o_valid_seq;
    wire [1:0] o_class_seq;

    reg [15:0] test_mem [0:TOTAL_SAMPLES*SEQ_LEN-1];

    integer i, j;
    integer mism_h;
    integer mism_y_pool;
    integer wait_cycles;
    integer feed_wait_cycles;
    reg signed [DATA_WIDTH-1:0] comb_h_snap [0:D_MODEL-1][0:D_STATE-1];
    reg signed [DATA_WIDTH-1:0] comb_y_pool_snap [0:D_MODEL-1];
    reg [1:0] comb_class_snap;

    task apply_reset;
        begin
            rst_n = 1'b0;
            i_valid_comb = 1'b0;
            i_valid_seq  = 1'b0;
            i_data_comb  = {DATA_WIDTH{1'b0}};
            i_data_seq   = {DATA_WIDTH{1'b0}};
            repeat (4) @(negedge clk);
            rst_n = 1'b1;
            repeat (2) @(negedge clk);
        end
    endtask

    // Original combinational datapath version
    mamba_core #(
        .D_IN(D_IN),
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH)
    ) uut_comb (
        .clk(clk),
        .rst_n(rst_n),
        .rst_weights_n(rst_weights_n),
        .i_valid(i_valid_comb),
        .i_data(i_data_comb),
        .w_we(1'b0),
        .w_addr(9'd0),
        .w_data(8'd0),
        .o_ready(o_ready_comb),
        .o_valid(o_valid_comb),
        .o_class(o_class_comb)
    );

    // Sequential datapath version
    mamba_core #(
        .D_IN(D_IN),
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH)
    ) uut_seq (
        .clk(clk),
        .rst_n(rst_n),
        .rst_weights_n(rst_weights_n),
        .i_valid(i_valid_seq),
        .i_data(i_data_seq),
        .w_we(1'b0),
        .w_addr(9'd0),
        .w_data(8'd0),
        .o_ready(o_ready_seq),
        .o_valid(o_valid_seq),
        .o_class(o_class_seq)
    );

    initial begin
        clk = 1'b0;
        forever #3 clk = ~clk;
    end

    task run_one_sample_comb;
        integer k;
        begin
            k = 0;
            feed_wait_cycles = 0;
            while (k < SEQ_LEN) begin
                @(negedge clk);
                if (o_ready_comb) begin
                    i_valid_comb = 1'b1;
                    i_data_comb  = test_mem[SAMPLE_ID*SEQ_LEN + k];
                    k = k + 1;
                    feed_wait_cycles = 0;
                end else begin
                    i_valid_comb = 1'b0;
                    feed_wait_cycles = feed_wait_cycles + 1;
                    if (feed_wait_cycles > 300000) begin
                        $display("TIMEOUT: comb feed stuck. k=%0d o_ready=%b busy=%b start=%b",
                                 k, o_ready_comb, uut_comb.datapath_busy, uut_comb.datapath_start);
                        $finish;
                    end
                end
            end
            @(negedge clk);
            i_valid_comb = 1'b0;

            wait_cycles = 0;
            while ((o_valid_comb !== 1'b1) && (wait_cycles < 300000)) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid_comb !== 1'b1) begin
                $display("TIMEOUT: comb core did not assert o_valid.");
                $finish;
            end
            // Wait one extra cycle so state regs are fully committed
            // before snapshot/compare.
            @(posedge clk);
        end
    endtask

    task run_one_sample_seq;
        integer k;
        begin
            k = 0;
            feed_wait_cycles = 0;
            while (k < SEQ_LEN) begin
                @(negedge clk);
                if (o_ready_seq) begin
                    i_valid_seq = 1'b1;
                    i_data_seq  = test_mem[SAMPLE_ID*SEQ_LEN + k];
                    k = k + 1;
                    feed_wait_cycles = 0;
                end else begin
                    i_valid_seq = 1'b0;
                    feed_wait_cycles = feed_wait_cycles + 1;
                    if (feed_wait_cycles > 300000) begin
                        $display("TIMEOUT: seq feed stuck. k=%0d o_ready=%b busy=%b start=%b",
                                 k, o_ready_seq, uut_seq.datapath_busy, uut_seq.datapath_start);
                        $finish;
                    end
                end
            end
            @(negedge clk);
            i_valid_seq = 1'b0;

            wait_cycles = 0;
            while ((o_valid_seq !== 1'b1) && (wait_cycles < 300000)) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid_seq !== 1'b1) begin
                $display("TIMEOUT: seq core did not assert o_valid.");
                $finish;
            end
            // Wait one extra cycle so state regs are fully committed
            // before snapshot/compare.
            @(posedge clk);
        end
    endtask

    initial begin
        $fsdbDumpfile("tb_mamba_core_compare_onecase.fsdb");
        $fsdbDumpvars(0, tb_mamba_core_compare_onecase);
        $fsdbDumpMDA();

        $readmemh("Pattern/test_features.hex", test_mem);

        rst_n = 1'b1;
        i_valid_comb = 1'b0;
        i_valid_seq  = 1'b0;
        i_data_comb  = {DATA_WIDTH{1'b0}};
        i_data_seq   = {DATA_WIDTH{1'b0}};
        apply_reset();

        $display("============================================================");
        $display("Run one testcase compare: SAMPLE_ID = %0d", SAMPLE_ID);
        $display("============================================================");

        run_one_sample_comb();
        comb_class_snap = o_class_comb;
        for (i = 0; i < D_MODEL; i = i + 1) begin
            comb_y_pool_snap[i] = uut_comb.y_pool_reg[i];
            for (j = 0; j < D_STATE; j = j + 1) begin
                comb_h_snap[i][j] = uut_comb.h_reg[i][j];
            end
        end

        // Reset before running seq core to ensure clean state start.
        apply_reset();
        run_one_sample_seq();

        $display("\n--- Output class compare ---");
        $display("comb o_class = %0d", comb_class_snap);
        $display("seq  o_class = %0d", o_class_seq);
        if (comb_class_snap === o_class_seq)
            $display("class compare: PASS");
        else
            $display("class compare: FAIL");

        mism_y_pool = 0;
        mism_h = 0;

        $display("\n--- y_pool_reg matrix compare (8x1) ---");
        for (i = 0; i < D_MODEL; i = i + 1) begin
            if (comb_y_pool_snap[i] !== uut_seq.y_pool_reg[i]) begin
                mism_y_pool = mism_y_pool + 1;
                $display("y_pool mismatch @i=%0d comb=%0d seq=%0d",
                         i, comb_y_pool_snap[i], uut_seq.y_pool_reg[i]);
            end
        end
        if (mism_y_pool == 0) $display("y_pool compare: PASS");
        else                  $display("y_pool compare: FAIL, mismatch count = %0d", mism_y_pool);

        $display("\n--- h_reg matrix compare (8x8) ---");
        for (i = 0; i < D_MODEL; i = i + 1) begin
            for (j = 0; j < D_STATE; j = j + 1) begin
                if (comb_h_snap[i][j] !== uut_seq.h_reg[i][j]) begin
                    mism_h = mism_h + 1;
                    $display("h mismatch @i=%0d j=%0d comb=%0d seq=%0d",
                             i, j, comb_h_snap[i][j], uut_seq.h_reg[i][j]);
                end
            end
        end
        if (mism_h == 0) $display("h_reg compare: PASS");
        else             $display("h_reg compare: FAIL, mismatch count = %0d", mism_h);

        $display("\n============================================================");
        if ((comb_class_snap === o_class_seq) && (mism_y_pool == 0) && (mism_h == 0))
            $display("FINAL RESULT: PASS (comb == seq for this testcase)");
        else
            $display("FINAL RESULT: FAIL (comb != seq for this testcase)");
        $display("============================================================");

        #30;
        $finish;
    end

endmodule
