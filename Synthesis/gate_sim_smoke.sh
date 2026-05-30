source /usr/cad/synopsys/CIC/vcs.cshrc
vcs -full64 -debug_access+all +v2k -sverilog +vcs+fsdbon +incdir+Testbanch +define+GATE_SIM \
  Testbanch/tb_smoke_18118.v \
  ./Netlist/CHIP_clkGating_syn.v \
  fsa0m_a_generic_core_21.lib.src \
  -R
