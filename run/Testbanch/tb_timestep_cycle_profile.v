`timescale 1ns / 1ps
// Single time-step cycle profiler for mamba_core (sequential datapath).
// Reports active cycle ranges (job_cyc) per block and total job latency.
//
// Run (from run/):
//   vcs -full64 +v2k +incdir+Core \
//     Core/mamba_core.v Core/mamba_datapath_new.v Core/mamba_linear.v \
//     Core/mamba_proj_in_out_shared.v \
//     Core/mamba_math.v Core/mamba_elementwise.v Core/regfile.v \
//     Testbanch/tb_timestep_cycle_profile.v -R

module tb_timestep_cycle_profile;

    parameter D_IN       = 1;
    parameter D_MODEL    = 8;
    parameter D_STATE    = 8;
    parameter SEQ_LEN    = 187;
    parameter DATA_WIDTH = 16;
    parameter WGHT_WIDTH = 8;

    reg  clk;
    reg  rst_n;
    reg  i_valid;
    reg  signed [DATA_WIDTH-1:0] i_data;

    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    reg [15:0] test_mem [0:SEQ_LEN-1];

    mamba_core #(
        .D_IN(D_IN),
        .D_MODEL(D_MODEL),
        .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN),
        .DATA_WIDTH(DATA_WIDTH),
        .WGHT_WIDTH(WGHT_WIDTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(i_valid),
        .i_data(i_data),
        .o_ready(o_ready),
        .o_valid(o_valid),
        .o_class(o_class)
    );

    // Shorthand to datapath hierarchy
    wire                         dp_busy       = uut.u_datapath.o_busy;
    wire                         dp_done       = uut.u_datapath.o_done;
    wire                         proj_in_valid = uut.u_datapath.proj_in_o_valid;
    wire                         merged_valid  = uut.u_datapath.merged_o_valid;
    wire [4:0]                   merged_index  = uut.u_datapath.merged_index;
    wire                         dt_proj_valid = uut.u_datapath.dt_proj_o_valid;
    wire                         softplus_valid= uut.u_datapath.softplus_o_valid;
    wire                         c_params_ready= uut.u_datapath.c_params_ready;
    wire                         softplus_done = uut.u_datapath.softplus_done;
    wire                         feed_valid    = uut.u_datapath.feed_valid;
    wire                         elem_valid    = uut.u_datapath.elem_valid;
    wire                         h_wr_en       = uut.u_datapath.o_h_wr_en;
    wire                         yt_mac_valid  = uut.u_datapath.yt_mac_valid;
    wire                         proj_out_busy = uut.u_datapath.proj_out_busy;

    wire merged_dt_raw_valid = merged_valid && (merged_index == 5'd0);

    // -------------------------------------------------------------------------
    // Interval trackers (job_cyc relative to first o_busy cycle = 0)
    // -------------------------------------------------------------------------
    reg        profiling;
    reg        prev_dp_busy;
    reg [15:0] job_cyc;

    reg [15:0] proj_in_min,      proj_in_max;      reg [15:0] proj_in_pulses;
    reg [15:0] merged_min,       merged_max;       reg [15:0] merged_pulses;
    reg [15:0] merged_dt_min,    merged_dt_max;    reg [15:0] merged_dt_pulses;
    reg [15:0] dt_proj_min,      dt_proj_max;      reg [15:0] dt_proj_pulses;
    reg [15:0] softplus_min,     softplus_max;     reg [15:0] softplus_pulses;
    reg [15:0] feed_min,         feed_max;         reg [15:0] feed_pulses;
    reg [15:0] elem_min,         elem_max;         reg [15:0] elem_pulses;
    reg [15:0] h_wr_min,         h_wr_max;         reg [15:0] h_wr_pulses;
    reg [15:0] yt_mac_min,       yt_mac_max;       reg [15:0] yt_mac_pulses;
    reg [15:0] proj_out_min,     proj_out_max;     reg [15:0] proj_out_pulses;

    reg        c_params_seen, softplus_done_seen;
    reg [15:0] c_params_first_cyc, softplus_done_first_cyc;

    reg        ready_low_seen;
    reg [15:0] ready_low_min, ready_low_max;

    reg [15:0] total_job_cycles;
    reg [15:0] done_job_cyc;

    task automatic reset_trackers;
        begin
            profiling            = 1'b0;
            prev_dp_busy         = 1'b0;
            job_cyc              = 16'd0;

            proj_in_min = 16'hFFFF; proj_in_max = 16'd0; proj_in_pulses = 16'd0;
            merged_min  = 16'hFFFF; merged_max  = 16'd0; merged_pulses  = 16'd0;
            merged_dt_min = 16'hFFFF; merged_dt_max = 16'd0; merged_dt_pulses = 16'd0;
            dt_proj_min = 16'hFFFF; dt_proj_max = 16'd0; dt_proj_pulses = 16'd0;
            softplus_min= 16'hFFFF; softplus_max= 16'd0; softplus_pulses= 16'd0;
            feed_min    = 16'hFFFF; feed_max    = 16'd0; feed_pulses    = 16'd0;
            elem_min    = 16'hFFFF; elem_max    = 16'd0; elem_pulses    = 16'd0;
            h_wr_min    = 16'hFFFF; h_wr_max    = 16'd0; h_wr_pulses    = 16'd0;
            yt_mac_min  = 16'hFFFF; yt_mac_max  = 16'd0; yt_mac_pulses  = 16'd0;
            proj_out_min= 16'hFFFF; proj_out_max= 16'd0; proj_out_pulses= 16'd0;

            c_params_seen = 1'b0; softplus_done_seen = 1'b0;
            c_params_first_cyc = 16'd0; softplus_done_first_cyc = 16'd0;

            ready_low_seen = 1'b0;
            ready_low_min  = 16'hFFFF; ready_low_max = 16'd0;

            total_job_cycles = 16'd0;
            done_job_cyc     = 16'd0;
        end
    endtask

    task automatic track_pulse;
        input        active;
        input [15:0] cyc;
        inout [15:0] cyc_min;
        inout [15:0] cyc_max;
        inout [15:0] pulse_cnt;
        begin
            if (active) begin
                if (pulse_cnt == 16'd0)
                    cyc_min = cyc;
                cyc_max = cyc;
                pulse_cnt = pulse_cnt + 16'd1;
            end
        end
    endtask

    task automatic track_level;
        input        active;
        input [15:0] cyc;
        inout [15:0] cyc_min;
        inout [15:0] cyc_max;
        inout [15:0] pulse_cnt; // unused for level; kept for uniform call style
        begin
            if (active) begin
                if (pulse_cnt == 16'd0)
                    cyc_min = cyc;
                cyc_max = cyc;
                pulse_cnt = pulse_cnt + 16'd1; // counts active cycles
            end
        end
    endtask

    function automatic [15:0] span_cycles;
        input [15:0] cyc_min;
        input [15:0] cyc_max;
        input [15:0] pulse_cnt;
        begin
            if (pulse_cnt == 16'd0)
                span_cycles = 16'd0;
            else
                span_cycles = cyc_max - cyc_min + 16'd1;
        end
    endfunction

    task automatic print_range;
        input [255:0] name;
        input [15:0]  cyc_min;
        input [15:0]  cyc_max;
        input [15:0]  pulse_cnt;
        input         is_level;
        begin
            if (pulse_cnt == 16'd0)
                $display("  %-28s : (inactive)", name);
            else if (is_level)
                $display("  %-28s : job_cyc %0d .. %0d  (%0d cycles, level=1)",
                         name, cyc_min, cyc_max, span_cycles(cyc_min, cyc_max, pulse_cnt));
            else
                $display("  %-28s : job_cyc %0d .. %0d  (%0d cycles, pulses=%0d)",
                         name, cyc_min, cyc_max, span_cycles(cyc_min, cyc_max, pulse_cnt), pulse_cnt);
        end
    endtask

    task automatic print_report;
        begin
            $display("");
            $display("================================================================");
            $display(" Single time-step cycle profile  (sample 0, feature[0])");
            $display("================================================================");
            $display("");
            $display("Total job latency : %0d cycles  (job_cyc 0 .. %0d, o_done @ %0d)",
                     total_job_cycles, done_job_cyc, done_job_cyc);
            if (ready_low_seen)
                $display("o_ready low window (ready_low) : job_cyc %0d .. %0d  (%0d cycles)",
                         ready_low_min, ready_low_max,
                         ready_low_max - ready_low_min + 16'd1);
            else
                $display("o_ready low window (ready_low) : (not observed)");
            $display("");
            $display("--- Compute block active ranges (job_cyc, 0 = first busy cycle) ---");
            print_range("proj_in serial",           proj_in_min,      proj_in_max,      proj_in_pulses,      0);
            print_range("merged_x serial",          merged_min,       merged_max,       merged_pulses,       0);
            print_range("merged idx=0 (dt_raw)",    merged_dt_min,    merged_dt_max,    merged_dt_pulses,    0);
            print_range("dt_proj serial",           dt_proj_min,      dt_proj_max,      dt_proj_pulses,      0);
            print_range("softplus",                 softplus_min,     softplus_max,     softplus_pulses,     0);
            if (c_params_seen)
                $display("  %-28s : first asserted @ job_cyc %0d", "c_params_ready", c_params_first_cyc);
            else
                $display("  %-28s : (never)", "c_params_ready");
            if (softplus_done_seen)
                $display("  %-28s : first asserted @ job_cyc %0d", "softplus_done", softplus_done_first_cyc);
            else
                $display("  %-28s : (never)", "softplus_done");
            print_range("elem feed (feed_valid)",   feed_min,         feed_max,         feed_pulses,         0);
            print_range("elem pipeline out",        elem_min,         elem_max,         elem_pulses,         0);
            print_range("h_reg writeback",          h_wr_min,         h_wr_max,         h_wr_pulses,         0);
            print_range("yt_mac (per ch)",          yt_mac_min,       yt_mac_max,       yt_mac_pulses,       0);
            print_range("proj_out serial_mac",      proj_out_min,     proj_out_max,     proj_out_pulses,     1);
            $display("");
            $display("--- Expected (approx, D_MODEL=8, D_STATE=8) ---");
            $display("  proj_in ~8 | merged ~17 | dt_proj ~8 | softplus ~8");
            $display("  feed/elem/h_wr ~64 each | yt_mac pulses ~8");
            $display("  proj_out busy ~36 | total job ~84-87 cycles");
            $display("================================================================");
            $display("");
        end
    endtask

  // Sample all observable signals at the current job_cyc
    always @(posedge clk) begin
        if (!rst_n) begin
            reset_trackers();
            prev_dp_busy = 1'b0;
        end else begin
            // Start profiling on rising edge of datapath busy
            if (dp_busy && !prev_dp_busy) begin
                profiling      = 1'b1;
                job_cyc        = 16'd0;
                ready_low_seen = 1'b0;
                ready_low_min  = 16'hFFFF;
                ready_low_max  = 16'd0;
            end

            if (profiling) begin
                // o_ready low while core cannot accept new input (same job_cyc axis)
                if (!o_ready) begin
                    if (!ready_low_seen) begin
                        ready_low_min  = job_cyc;
                        ready_low_seen = 1'b1;
                    end
                    ready_low_max = job_cyc;
                end
                track_pulse(proj_in_valid,       job_cyc, proj_in_min,      proj_in_max,      proj_in_pulses);
                track_pulse(merged_valid,        job_cyc, merged_min,       merged_max,       merged_pulses);
                track_pulse(merged_dt_raw_valid, job_cyc, merged_dt_min,    merged_dt_max,    merged_dt_pulses);
                track_pulse(dt_proj_valid,       job_cyc, dt_proj_min,      dt_proj_max,      dt_proj_pulses);
                track_pulse(softplus_valid,      job_cyc, softplus_min,     softplus_max,     softplus_pulses);
                track_pulse(feed_valid,          job_cyc, feed_min,         feed_max,         feed_pulses);
                track_pulse(elem_valid,          job_cyc, elem_min,         elem_max,         elem_pulses);
                track_pulse(h_wr_en,             job_cyc, h_wr_min,         h_wr_max,         h_wr_pulses);
                track_pulse(yt_mac_valid,        job_cyc, yt_mac_min,       yt_mac_max,       yt_mac_pulses);
                track_level(proj_out_busy,       job_cyc, proj_out_min,     proj_out_max,     proj_out_pulses);

                if (c_params_ready && !c_params_seen) begin
                    c_params_first_cyc = job_cyc;
                    c_params_seen      = 1'b1;
                end
                if (softplus_done && !softplus_done_seen) begin
                    softplus_done_first_cyc = job_cyc;
                    softplus_done_seen      = 1'b1;
                end

                if (dp_done) begin
                    done_job_cyc     = job_cyc;
                    total_job_cycles = job_cyc + 16'd1;
                    profiling        = 1'b0;
                    print_report();
                end else
                    job_cyc = job_cyc + 16'd1;
            end

            prev_dp_busy = dp_busy;
        end
    end

    // Clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus: one timestep (first sample of test_data.hex)
    initial begin
        reset_trackers();
        $readmemh("Pattern/test_data.hex", test_mem);

        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = {DATA_WIDTH{1'b0}};

        repeat (4) @(negedge clk);
        rst_n = 1'b1;
        repeat (2) @(negedge clk);

        $display("Starting single-timestep cycle profile simulation...");

        // Wait until core is ready, then feed one sample
        wait (o_ready == 1'b1);
        @(negedge clk);
        i_valid <= 1'b1;
        i_data  <= test_mem[0];
        @(negedge clk);
        i_valid <= 1'b0;
        i_data  <= {DATA_WIDTH{1'b0}};

        // Wait for profiler to finish (o_done handled in always block)
        wait (total_job_cycles != 16'd0);

        #50;
        $finish;
    end

endmodule
