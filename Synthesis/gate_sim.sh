#!/bin/csh
# Gate-level simulation. Run from Synthesis/ after synthesis.tcl.
#
# Usage:
#   source gate_sim.sh                              # smoke (sample 18118)
#   source gate_sim.sh tb_batch_w0_18118.v          # batch from 18118
#   source gate_sim.sh tb_batch_w0_full.v           # full batch
#   source gate_sim.sh tb_batch_w143_18118.v
#   source gate_sim.sh tb_batch_w143_full.v
#   source gate_sim.sh tb_smoke_18118.v +fsdb +fsdbfile=gate.fsdb
#
# Or use convenience wrappers:
#   source gate_sim_smoke.sh
#   source gate_sim_batch_18118.sh
#
# With SDF timing:
#   setenv GATE_SDF 1
#   source gate_sim.sh
#
source /usr/cad/synopsys/CIC/vcs.cshrc

if ($#argv >= 1 && "$argv[1]" !~ +*) then
    set TB = Testbanch/$argv[1]
    set SIM_ARGS = ($argv[2-$#argv])
else
    set TB = Testbanch/tb_smoke_18118.v
    set SIM_ARGS = ($argv)
endif

set NETLIST = ./Netlist/CHIP_syn.v
if ($?GATE_SDF) then
    set SDF_DEF = (+define+SDF)
    set TIMING_OPTS = (+neg_tchk +notimingcheck +no_notifier)
else
    set SDF_DEF = ()
    set TIMING_OPTS = ()
endif

set TB_BASE = `basename $TB .v`
vcs $TB $NETLIST fsa0m_a_generic_core_21.lib.src \
    -full64 -debug_access+all +v2k -sverilog \
    +incdir+Testbanch \
    +define+GATE_SIM \
    +vcs+fsdbon \
    $SDF_DEF $TIMING_OPTS \
    -o simv_${TB_BASE} \
    | tee gate_sim_${TB_BASE}_compile.log

./simv_${TB_BASE} $SIM_ARGS | tee gate_sim_${TB_BASE}.log
