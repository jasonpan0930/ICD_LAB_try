`ifndef TB_DEFINE_VH
`define TB_DEFINE_VH

// Clock control for RTL and gate-level simulations.
// `timescale is 1ns/1ps in the testbenches, so 25 means a 50 ns period.
`ifndef TB_CLK_HALF_PERIOD
`define TB_CLK_HALF_PERIOD 10
`endif

// Optional FSDB (Verdi/nWave) controls — set in each tb_dyn_*.v wrapper:
//   `define DYN_TB_TOP_MODULE   top module name for $fsdbDumpvars
//   `define FSDB_OUT_FILE       default dump file when +fsdb has no +fsdbfile=
//
// Run-time (after VCS compile with +vcs+fsdbon):
//   ./simv +fsdb
//   ./simv +fsdb +fsdbfile=tb_18118.fsdb
//
// RTL smoke test (from run/):
//   source source_run_smoke.sh +fsdb +fsdbfile=tb_smoke_18118.fsdb
//
// Gate sim single-sample window (compile-time, keeps fsdb small):
//   bash:  FSDB_SAMPLE=18118 bash gate_sim.sh +fsdb +fsdbfile=gate.fsdb
//   tcsh:  setenv FSDB_SAMPLE 18118; bash gate_sim.sh +fsdb +fsdbfile=gate.fsdb
//
// Or always dump from time 0 (compile-time):
//   vcs ... +define+DUMP_FSDB

`endif // TB_DEFINE_VH
