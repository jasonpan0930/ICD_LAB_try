# ==========================================
# 1. Read Design
# ==========================================
set_app_var search_path [list . ./Core ../run/tools $search_path]
analyze -format verilog { \
    Core/mamba_math.v \
    Core/mamba_linear.v \
    Core/mamba_elementwise.v \
    Core/mamba_datapath.v \
    Core/mamba_core.v \
}

set DESIGN "CHIP_QUICK"

elaborate mamba_core
current_design mamba_core
uniquify
link

# ==========================================
# 2. Constraints (Quick Validation)
# ==========================================
create_clock -period 100 -name "clk" -waveform {0 50} [get_ports clk]
set_dont_touch_network [get_ports clk]

set_clock_uncertainty 0.1 [get_clocks clk]
set_clock_latency 0.5 [get_clocks clk]

set_input_delay -max 1 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay -min 0.5 -clock clk [all_outputs]

set_drive 1 [all_inputs]
set_load 10 [all_outputs]
set_fix_multiple_port_nets -all -buffer_constants

# ==========================================
# 3. Operating Conditions / Wire Load
# ==========================================
set_operating_conditions -min_library fsa0m_a_generic_core_ff1p98vm40c -min BCCOM -max_library fsa0m_a_generic_core_ss1p62v125c -max WCCOM
set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c

# Quick mode: relax expensive global optimization knobs.
set_max_area 100000000
# Disable boundary optimization globally with valid object list syntax.
set_boundary_optimization [current_design] false

check_design

# ==========================================
# 4. Compile (Quick)
# ==========================================
compile -map_effort medium

# ==========================================
# 5. Reports
# ==========================================
report_area -hierarchy > ./Report/area_mamba_quick.out
report_power > ./Report/power_mamba_quick.out
report_timing -path full -delay max > ./Report/timing_mamba_quick.out

# ==========================================
# 6. Netlist Outputs
# ==========================================
set verilogout_higher_designs_first true
write -f ddc -hierarchy -output ./Netlist/${DESIGN}_syn.ddc
write -f verilog -hierarchy -output ./Netlist/${DESIGN}_syn.v
write_sdf -version 2.1 ./Netlist/${DESIGN}_syn.sdf
write_sdc -version 1.8 ./Netlist/${DESIGN}_syn.sdc
