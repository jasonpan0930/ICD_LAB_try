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
set VCS_OPTS = (-full64 +v2k +incdir+Core +incdir+Testbanch)
foreach arg ($argv)
    if ("$arg" == "+fsdb") then
        set VCS_OPTS = ($VCS_OPTS +vcs+fsdbon)
    endif
end
vcs $VCS_OPTS $CORE_FILES Testbanch/tb_gate_sdf_18118.v -R $argv
