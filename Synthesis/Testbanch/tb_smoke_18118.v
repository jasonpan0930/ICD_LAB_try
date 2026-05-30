`timescale 1ns / 1ps
//
// Smoke test: sample 18118 only — load weights, reset, 187 beats, OK/NG, $finish.
// Works for RTL (default) and gate-level (+define+GATE_SIM).
//
// RTL (from run/):
//   source source_run_smoke.sh
//   source source_run_smoke.sh +fsdb +fsdbfile=tb_smoke_18118.fsdb
//
// Gate (from Synthesis/, after synthesis + Pattern/ copied):
//   source gate_sim.sh
//   source gate_sim.sh +fsdb +fsdbfile=gate_smoke_18118.fsdb
//

`include "tb_define.vh"

`ifndef FSDB_OUT_FILE
`define FSDB_OUT_FILE "tb_smoke_18118.fsdb"
`endif

`ifdef SDF
`ifndef SDF_FILE
`define SDF_FILE "Netlist/CHIP_syn.sdf"
`endif
`endif

module tb_smoke_18118;

    localparam integer SAMPLE_ID    = 18118;
    localparam integer SEQ_LEN      = 187;
    localparam integer DATA_WIDTH   = 16;
    localparam integer WEIGHT_BYTES = 285;
    reg clk, rst_n, mode, strobe;
    reg signed [DATA_WIDTH-1:0] i_data;
    reg [7:0] w_data;
    wire o_ready, o_valid;
    wire [1:0] o_class;

    reg [15:0] feat_mem [0:21336*SEQ_LEN-1];
    reg [1:0]  golden_mem [0:21335];
    reg [7:0]  weight_mem [0:WEIGHT_BYTES-1];

    integer i, k, wait_cycles;
    reg [1:0] pred_class;
    string fsdb_path;

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

    initial clk = 0;
    always #`TB_CLK_HALF_PERIOD clk = ~clk;

    task fsdb_setup;
        reg enable;
        begin
            enable = 1'b0;
`ifdef GATE_TB_FSDB
            enable = 1'b1;
`endif
`ifdef DUMP_FSDB
            enable = 1'b1;
`endif
            if ($test$plusargs("fsdb"))
                enable = 1'b1;
            if (!enable)
                ;
            else begin
                if (!$value$plusargs("fsdbfile=%s", fsdb_path))
                    fsdb_path = `FSDB_OUT_FILE;
                $display("[SMOKE18118] FSDB -> %s", fsdb_path);
                $fsdbDumpfile(fsdb_path);
`ifdef GATE_SIM
                $fsdbDumpvars(0, clk);
                $fsdbDumpvars(0, rst_n);
                $fsdbDumpvars(0, mode);
                $fsdbDumpvars(0, strobe);
                $fsdbDumpvars(0, o_ready);
                $fsdbDumpvars(0, o_valid);
                $fsdbDumpvars(0, o_class);
                $fsdbDumpvars(0, w_data);
                $fsdbDumpvars(0, i_data);
                $fsdbDumpvars(0, pred_class);
`else
                $fsdbDumpvars(0, tb_smoke_18118, "+mda");
                $fsdbDumpvars;
                $fsdbDumpon;
`endif
            end
        end
    endtask

    task write_weight_byte;
        input [7:0] d;
        begin
            wait_cycles = 0;
            while (o_ready !== 1'b1 && wait_cycles < 2000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_ready !== 1'b1) begin
                $display("[SMOKE18118] TIMEOUT load o_ready");
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

    task load_weights;
        begin
            @(negedge clk);
            #1;
            mode = 1'b1;
            strobe = 1'b0;
            w_data = 8'd0;
            wait_cycles = 0;
            while (o_ready !== 1'b1 && wait_cycles < 2000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_ready !== 1'b1) begin
                $display("[SMOKE18118] TIMEOUT wrapper load ready");
                $finish(1);
            end
            for (k = 0; k < WEIGHT_BYTES; k = k + 1)
                write_weight_byte(weight_mem[k]);
            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 2000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("[SMOKE18118] TIMEOUT load done o_valid");
                $finish(1);
            end
            @(negedge clk);
            #1;
            mode = 1'b0;
            strobe = 1'b0;
            w_data = 8'd0;
        end
    endtask

    task pulse_rst;
        begin
            @(negedge clk);
            #1;
            rst_n = 1'b0;
            @(negedge clk);
            #1;
            rst_n = 1'b1;
            @(negedge clk);
            #1;
        end
    endtask

    task feed_sample_18118;
        begin
            i = 0;
            while (i < SEQ_LEN) begin
                @(negedge clk);
                #1;
                if (o_ready) begin
                    strobe = 1'b1;
                    i_data = feat_mem[SAMPLE_ID*SEQ_LEN + i];
                    i = i + 1;
                end else
                    strobe = 1'b0;
            end
            @(negedge clk);
            #1;
            strobe = 1'b0;
            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 500000) begin
                @(negedge clk);
                #1;
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("[SMOKE18118] TIMEOUT inference o_valid");
                $finish(1);
            end
            #5;
            pred_class = o_class;
        end
    endtask

    initial begin
        fsdb_setup();

`ifdef SDF
        $display("[SMOKE18118] SDF -> %s", `SDF_FILE);
        $sdf_annotate(`SDF_FILE, uut);
`endif

        $readmemh("Pattern/test_features.hex", feat_mem);
        $readmemh("Pattern/test_mit_ground_truth.hex", golden_mem);
        $readmemh("Pattern/weights_ram.hex", weight_mem);

        rst_n = 1'b0;
        mode = 1'b0;
        strobe = 1'b0;
        i_data = 16'd0;
        w_data = 8'd0;
        #100;
        rst_n = 1'b1;
        #50;
        load_weights;
        #50;
        pulse_rst;
        feed_sample_18118;

        if (pred_class === golden_mem[SAMPLE_ID])
            $display("[SMOKE18118] OK pred=%0d golden=%0d", pred_class, golden_mem[SAMPLE_ID]);
        else
            $display("[SMOKE18118] NG pred=%0d golden=%0d", pred_class, golden_mem[SAMPLE_ID]);

        $fsdbDumpflush;
        #100;
        $finish(0);
    end

endmodule
