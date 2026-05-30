source /usr/cad/synopsys/CIC/vcs.cshrc
vcs -full64 +v2k -sverilog +vcs+fsdbon +incdir+Core +incdir+Testbanch \
  Core/mamba_core.v \
  Core/mamba_datapath_new.v \
  Core/mamba_weight_storage.v \
  Core/mamba_linear.v \
  Core/mamba_proj_in_out_shared.v \
  Core/mamba_math.v \
  Core/mamba_elementwise.v \
  Core/regfile.v \
  Testbanch/tb_smoke_18118.v \
  -R
