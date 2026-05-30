source /usr/cad/synopsys/CIC/vcs.cshrc
set CORE_FILES = ( \
    Core/mamba_core.v \
    Core/mamba_datapath_new.v \
    Core/mamba_weight_storage.v \
    Core/mamba_linear.v \
    Core/mamba_proj_in_out_shared.v \
    Core/mamba_math.v \
    Core/mamba_elementwise.v \
    Core/regfile.v \
)
set VCS_OPTS = (-full64 +v2k -sverilog +vcs+fsdbon +incdir+Core +incdir+Testbanch)
vcs $VCS_OPTS $CORE_FILES Testbanch/tb_batch_w143_18118.v -R $argv
