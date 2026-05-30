# +notimingcheck: 關閉 lib/SDF 的 $setuphold 等檢查，避免 timing violation 洗版（功能對照用）
# 要做 sign-off 時序模擬時請移除此 flag
vcs ./Testbanch/tb_mit_sick_weight_dyn_full.v ./Netlist/CHIP_syn.v fsa0m_a_generic_core_21.lib.src \
  -full64 -R -debug_access+all +v2k +define+SDF +neg_tchk \
  #+notimingcheck +no_notifier \
  | tee gateSim.log
