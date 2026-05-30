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

set DESIGN "CHIP"

# 使用 elaborate 建立頂層模組 (Top Module) 的架構
elaborate mamba_core

# 設定目前設計為頂層模組
current_design mamba_core
uniquify
link

# ==========================================
# 2. Optimization Constraints - Area Minimum
# ==========================================

create_clock -period 100 -name "clk" -waveform {0 50} [get_ports clk]
set_dont_touch_network [get_ports clk]

# Area mode：不要急著 fix hold，避免插 buffer
# set_fix_hold [get_clocks clk]

# 放鬆 clock margin
set_clock_uncertainty 0.0 [get_clocks clk]
set_clock_latency     0.0 [get_clocks clk]

# I/O delay 放鬆
set non_clk_inputs [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay  -max 0.1 -clock clk $non_clk_inputs
set_output_delay -max 0.1 -clock clk [all_outputs]

# Area mode：input drive / output load 不要設太重
set_drive 1 [all_inputs]
set_drive 0 [get_ports clk]

set_load 0.1 [all_outputs]

# 避免多 port net 問題，但這個可能插 buffer，保留即可
set_fix_multiple_port_nets -all -buffer_constants

# Fanout 不要太嚴，否則 buffer 變多
# set_max_fanout 6 $non_clk_inputs
# set_max_fanout 16 [current_design]
set_max_fanout 32 [current_design]

# 如果真的追求最小 area，可以甚至拿掉 max_fanout：
# remove_attribute [current_design] max_fanout

# ==========================================
# 3. Operating Conditions & Wire Load Model
# ==========================================

set_operating_conditions \
    -min_library fsa0m_a_generic_core_ff1p98vm40c -min BCCOM \
    -max_library fsa0m_a_generic_core_ss1p62v125c -max WCCOM

set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c

# Area 越小越好
set_max_area 0
set_cost_priority area

# 不要自動 flatten，先保 hierarchy，避免面積亂膨脹
set_ungroup [get_designs *] false

# Boundary optimization 可以讓跨 hierarchy 最佳化，有時可省 area
# 如果你要保守，可關掉；若追 area，可打開試一版
set_boundary_optimization [get_designs *] true

check_design
check_timing

# ==========================================
# 4. Map and Optimize the Design - Area Mode
# ==========================================

# 禁用超大 drive cell，避免工具為 timing/load 用太大 cell
# 根據你的 library cell name 調整 X8/X12/X16...
catch { set_dont_use [get_lib_cells */*X12*] true }
catch { set_dont_use [get_lib_cells */*X16*] true }
catch { set_dont_use [get_lib_cells */*X20*] true }
catch { set_dont_use [get_lib_cells */*X24*] true }
catch { set_dont_use [get_lib_cells */*X32*] true }

# 如果 X8 也禁了導致 buffer 變多，不一定比較省
# 建議 X8 先不要禁，之後再 sweep
# catch { set_dont_use [get_lib_cells */*X8*] true }

# 不建議 area-min 模式 insert_clock_gating
# clock gating 省 power，但會加 gate cell，面積通常增加
# insert_clock_gating

# Area-driven compile
compile_ultra -area -no_autoungroup

# 第二輪 incremental 壓 area
compile_ultra -incremental -area -no_autoungroup

# 如果你的 DC 支援 optimize_netlist
catch {
    optimize_netlist -area
}

compile_ultra -incremental -area -no_autoungroup


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
