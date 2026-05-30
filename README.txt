source /usr/cad/cadence/cshrc
source /usr/cad/synopsys/CIC/vcs.cshrc
source /usr/cad/synopsys/CIC/verdi.cshrc
source /usr/cad/synopsys/CIC/synthesis.cshrc

#在此資料夾路徑下
cd PROJECT_S6

vcs -full64 -sverilog -debug_access+all Testbanch/tb.v Core/mamba_core.v Core/mamba_datapath.v Core/mamba_linear.v Core/mamba_math.v -R


## tb_mit 是正解
## tb_py 是和quant後的結果比
