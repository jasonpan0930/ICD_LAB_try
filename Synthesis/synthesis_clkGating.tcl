# ==========================================
# 1. Read Design (讀取多個設計檔案)
# ==========================================
# 使用 analyze 讀取 Core 資料夾下的所有必要檔案 (由底層讀到頂層)
set_app_var search_path [list . ./Core ../run/tools $search_path]

remove_design -all

analyze -format verilog { \
    Core/mamba_math.v \
    Core/mamba_linear.v \
    Core/mamba_proj_in_out_shared.v \
    Core/mamba_elementwise.v \
    Core/regfile.v \
    Core/mamba_weight_storage.v \
    Core/mamba_datapath_new.v \
    Core/mamba_core.v \
}

set DESIGN "CHIP_clkGating"

# 使用 elaborate 建立頂層模組 (Top Module) 的架構
elaborate mamba_core

# 設定目前設計為頂層模組
current_design mamba_core
uniquify
link

# ==========================================
# 2. Optimization Constraints (時序與環境約束)
# ==========================================
# ⚠️ 注意：這裡假設你的 Mamba 時鐘腳位叫做 "clk"。如果叫其他名字，請把 "clk" 換掉。
create_clock -period 100 -name "clk" -waveform {0 50} [get_ports clk]
set_dont_touch_network [get_ports clk]
set_fix_hold [get_clocks clk]

set_clock_uncertainty  0.1  [get_clocks clk]
set_clock_latency      0.5  [get_clocks clk]

# 標準做法：設定 Input Delay 時要排除 Clock 腳位，避免 DC 報 Warning
set_input_delay -max 1 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay -min 0.5 -clock clk [all_outputs]

set_drive 1  [all_inputs]
set_load  10 [all_outputs]

set_fix_multiple_port_nets -all -buffer_constants

# 整個 design 設較寬鬆 fanout
set_max_fanout 16 [current_design]
# 所有 input 排除 clock 後設 fanout 6
set non_clk_inputs [remove_from_collection [all_inputs] [get_ports clk]]
set_max_fanout 6 $non_clk_inputs
# set_max_fanout 6 [all_inputs]

# ==========================================
# 3. Operating Conditions & Wire Load Model
# ==========================================
set_operating_conditions -min_library fsa0m_a_generic_core_ff1p98vm40c -min BCCOM -max_library fsa0m_a_generic_core_ss1p62v125c -max WCCOM
set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c

set_max_area 0
set_boundary_optimization {"*"}

# 檢查設計是否有懸空或多重驅動的問題
check_design

# ==========================================
# 4. Map and Optimize the Design
# ==========================================
# compile -map_effort medium
# insert_clock_gating
compile
set_clock_gating_style -minimum_bitwidth 16
set_clock_gating_check -setup 0.1 -hold 0.05 [get_clocks clk]
compile_ultra -gate_clock
# ==========================================
# 5. Output Reports (輸出報表)
# ==========================================
# 檔名改為 mamba 以利區分
report_area         -hierarchy > ./Report/area_mamba.out
report_power > ./Report/power_mamba.out
report_timing -path full -delay max > ./Report/timing_mamba.out

report_area         -hierarchy
report_power
report_timing -path full -delay max

# ==========================================
# 6. Output Files (輸出合成後檔案供 APR 與 Post-sim 使用)
# ==========================================
set verilogout_higher_designs_first true
write   -f ddc      -hierarchy  -output ./Netlist/${DESIGN}_syn.ddc
write   -f verilog  -hierarchy  -output ./Netlist/${DESIGN}_syn.v
write_sdf   -version 2.1                ./Netlist/${DESIGN}_syn.sdf
write_sdc   -version 1.8                ./Netlist/${DESIGN}_syn.sdc


# restore the memory design for further improvement if needed (remember to remove the memory design before writing verilog)
read_ddc ./Netlist/${DESIGN}_syn.ddc
