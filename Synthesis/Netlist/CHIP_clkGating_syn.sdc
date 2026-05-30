###################################################################

# Created by write_sdc on Sat May 30 20:50:43 2026

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max WCCOM -max_library                               \
fsa0m_a_generic_core_ss1p62v125c\
                         -min BCCOM -min_library                               \
fsa0m_a_generic_core_ff1p98vm40c
set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c
set_max_fanout 16 [current_design]
set_max_area 0
set_load -pin_load 10 [get_ports o_ready]
set_load -pin_load 10 [get_ports o_valid]
set_load -pin_load 10 [get_ports {o_class[1]}]
set_load -pin_load 10 [get_ports {o_class[0]}]
set_max_fanout 6 [get_ports rst_n]
set_max_fanout 6 [get_ports rst_weights_n]
set_max_fanout 6 [get_ports i_valid]
set_max_fanout 6 [get_ports {i_data[15]}]
set_max_fanout 6 [get_ports {i_data[14]}]
set_max_fanout 6 [get_ports {i_data[13]}]
set_max_fanout 6 [get_ports {i_data[12]}]
set_max_fanout 6 [get_ports {i_data[11]}]
set_max_fanout 6 [get_ports {i_data[10]}]
set_max_fanout 6 [get_ports {i_data[9]}]
set_max_fanout 6 [get_ports {i_data[8]}]
set_max_fanout 6 [get_ports {i_data[7]}]
set_max_fanout 6 [get_ports {i_data[6]}]
set_max_fanout 6 [get_ports {i_data[5]}]
set_max_fanout 6 [get_ports {i_data[4]}]
set_max_fanout 6 [get_ports {i_data[3]}]
set_max_fanout 6 [get_ports {i_data[2]}]
set_max_fanout 6 [get_ports {i_data[1]}]
set_max_fanout 6 [get_ports {i_data[0]}]
set_max_fanout 6 [get_ports w_we]
set_max_fanout 6 [get_ports {w_addr[8]}]
set_max_fanout 6 [get_ports {w_addr[7]}]
set_max_fanout 6 [get_ports {w_addr[6]}]
set_max_fanout 6 [get_ports {w_addr[5]}]
set_max_fanout 6 [get_ports {w_addr[4]}]
set_max_fanout 6 [get_ports {w_addr[3]}]
set_max_fanout 6 [get_ports {w_addr[2]}]
set_max_fanout 6 [get_ports {w_addr[1]}]
set_max_fanout 6 [get_ports {w_addr[0]}]
set_max_fanout 6 [get_ports {w_data[7]}]
set_max_fanout 6 [get_ports {w_data[6]}]
set_max_fanout 6 [get_ports {w_data[5]}]
set_max_fanout 6 [get_ports {w_data[4]}]
set_max_fanout 6 [get_ports {w_data[3]}]
set_max_fanout 6 [get_ports {w_data[2]}]
set_max_fanout 6 [get_ports {w_data[1]}]
set_max_fanout 6 [get_ports {w_data[0]}]
create_clock [get_ports clk]  -period 100  -waveform {0 50}
set_clock_latency 0.5  [get_clocks clk]
set_clock_uncertainty 0.1  [get_clocks clk]
set_clock_gating_check -rise -setup 0.1 [get_clocks clk]
set_clock_gating_check -fall -setup 0.1 [get_clocks clk]
set_clock_gating_check -rise -hold 0.05 [get_clocks clk]
set_clock_gating_check -fall -hold 0.05 [get_clocks clk]
set_input_delay -clock clk  -max 1  [get_ports rst_n]
set_input_delay -clock clk  -max 1  [get_ports rst_weights_n]
set_input_delay -clock clk  -max 1  [get_ports i_valid]
set_input_delay -clock clk  -max 1  [get_ports {i_data[15]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[14]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[13]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[12]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[11]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[10]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[9]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[8]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[7]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[6]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[5]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[4]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[3]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[2]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[1]}]
set_input_delay -clock clk  -max 1  [get_ports {i_data[0]}]
set_input_delay -clock clk  -max 1  [get_ports w_we]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[8]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[7]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[6]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[5]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[4]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[3]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[2]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[1]}]
set_input_delay -clock clk  -max 1  [get_ports {w_addr[0]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[7]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[6]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[5]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[4]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[3]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[2]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[1]}]
set_input_delay -clock clk  -max 1  [get_ports {w_data[0]}]
set_output_delay -clock clk  -min 0.5  [get_ports o_ready]
set_output_delay -clock clk  -min 0.5  [get_ports o_valid]
set_output_delay -clock clk  -min 0.5  [get_ports {o_class[1]}]
set_output_delay -clock clk  -min 0.5  [get_ports {o_class[0]}]
set_drive 1  [get_ports clk]
set_drive 1  [get_ports rst_n]
set_drive 1  [get_ports rst_weights_n]
set_drive 1  [get_ports i_valid]
set_drive 1  [get_ports {i_data[15]}]
set_drive 1  [get_ports {i_data[14]}]
set_drive 1  [get_ports {i_data[13]}]
set_drive 1  [get_ports {i_data[12]}]
set_drive 1  [get_ports {i_data[11]}]
set_drive 1  [get_ports {i_data[10]}]
set_drive 1  [get_ports {i_data[9]}]
set_drive 1  [get_ports {i_data[8]}]
set_drive 1  [get_ports {i_data[7]}]
set_drive 1  [get_ports {i_data[6]}]
set_drive 1  [get_ports {i_data[5]}]
set_drive 1  [get_ports {i_data[4]}]
set_drive 1  [get_ports {i_data[3]}]
set_drive 1  [get_ports {i_data[2]}]
set_drive 1  [get_ports {i_data[1]}]
set_drive 1  [get_ports {i_data[0]}]
set_drive 1  [get_ports w_we]
set_drive 1  [get_ports {w_addr[8]}]
set_drive 1  [get_ports {w_addr[7]}]
set_drive 1  [get_ports {w_addr[6]}]
set_drive 1  [get_ports {w_addr[5]}]
set_drive 1  [get_ports {w_addr[4]}]
set_drive 1  [get_ports {w_addr[3]}]
set_drive 1  [get_ports {w_addr[2]}]
set_drive 1  [get_ports {w_addr[1]}]
set_drive 1  [get_ports {w_addr[0]}]
set_drive 1  [get_ports {w_data[7]}]
set_drive 1  [get_ports {w_data[6]}]
set_drive 1  [get_ports {w_data[5]}]
set_drive 1  [get_ports {w_data[4]}]
set_drive 1  [get_ports {w_data[3]}]
set_drive 1  [get_ports {w_data[2]}]
set_drive 1  [get_ports {w_data[1]}]
set_drive 1  [get_ports {w_data[0]}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_yt_mac/clk_gate_o_idx_i_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_yt_mac/clk_gate_o_idx_i_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_yt_mac/clk_gate_o_idx_i_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_yt_mac/clk_gate_o_idx_i_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s0_exp_in_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s0_exp_in_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s0_exp_in_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s0_exp_in_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_dt_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_dt_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_dt_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_dt_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_x_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_x_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_x_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_x_proj_serial/clk_gate_idx_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_out_y_flat_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_in_idx_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_in_idx_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_in_idx_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_in_idx_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
