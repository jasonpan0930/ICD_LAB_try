###################################################################

# Created by write_sdc on Sun May 31 11:47:01 2026

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max WCCOM -max_library                               \
fsa0m_a_generic_core_ss1p62v125c\
                         -min BCCOM -min_library                               \
fsa0m_a_generic_core_ff1p98vm40c
set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c
set_max_fanout 32 [current_design]
set_max_area 0
set_load -pin_load 1 [get_ports o_ready]
set_load -pin_load 1 [get_ports o_valid]
set_load -pin_load 1 [get_ports {o_class[1]}]
set_load -pin_load 1 [get_ports {o_class[0]}]
set_max_fanout 32 [get_ports rst_n]
set_max_fanout 32 [get_ports mode]
set_max_fanout 32 [get_ports strobe]
set_max_fanout 32 [get_ports {i_data[15]}]
set_max_fanout 32 [get_ports {i_data[14]}]
set_max_fanout 32 [get_ports {i_data[13]}]
set_max_fanout 32 [get_ports {i_data[12]}]
set_max_fanout 32 [get_ports {i_data[11]}]
set_max_fanout 32 [get_ports {i_data[10]}]
set_max_fanout 32 [get_ports {i_data[9]}]
set_max_fanout 32 [get_ports {i_data[8]}]
set_max_fanout 32 [get_ports {i_data[7]}]
set_max_fanout 32 [get_ports {i_data[6]}]
set_max_fanout 32 [get_ports {i_data[5]}]
set_max_fanout 32 [get_ports {i_data[4]}]
set_max_fanout 32 [get_ports {i_data[3]}]
set_max_fanout 32 [get_ports {i_data[2]}]
set_max_fanout 32 [get_ports {i_data[1]}]
set_max_fanout 32 [get_ports {i_data[0]}]
set_max_fanout 32 [get_ports {w_data[7]}]
set_max_fanout 32 [get_ports {w_data[6]}]
set_max_fanout 32 [get_ports {w_data[5]}]
set_max_fanout 32 [get_ports {w_data[4]}]
set_max_fanout 32 [get_ports {w_data[3]}]
set_max_fanout 32 [get_ports {w_data[2]}]
set_max_fanout 32 [get_ports {w_data[1]}]
set_max_fanout 32 [get_ports {w_data[0]}]
create_clock [get_ports clk]  -period 40  -waveform {0 20}
set_clock_uncertainty 0.05  [get_clocks clk]
set_input_delay -clock clk  -max 5  [get_ports rst_n]
set_input_delay -clock clk  -min 0  [get_ports rst_n]
set_input_delay -clock clk  -max 5  [get_ports mode]
set_input_delay -clock clk  -min 0  [get_ports mode]
set_input_delay -clock clk  -max 5  [get_ports strobe]
set_input_delay -clock clk  -min 0  [get_ports strobe]
set_input_delay -clock clk  -max 5  [get_ports {i_data[15]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[15]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[14]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[14]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[13]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[13]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[12]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[12]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[11]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[11]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[10]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[10]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[9]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[9]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[8]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[8]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[7]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[7]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[6]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[6]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[5]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[5]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[4]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[4]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[3]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[3]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[2]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[2]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[1]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[1]}]
set_input_delay -clock clk  -max 5  [get_ports {i_data[0]}]
set_input_delay -clock clk  -min 0  [get_ports {i_data[0]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[7]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[7]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[6]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[6]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[5]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[5]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[4]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[4]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[3]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[3]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[2]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[2]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[1]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[1]}]
set_input_delay -clock clk  -max 5  [get_ports {w_data[0]}]
set_input_delay -clock clk  -min 0  [get_ports {w_data[0]}]
set_output_delay -clock clk  -max 5  [get_ports o_ready]
set_output_delay -clock clk  -min 0  [get_ports o_ready]
set_output_delay -clock clk  -max 5  [get_ports o_valid]
set_output_delay -clock clk  -min 0  [get_ports o_valid]
set_output_delay -clock clk  -max 5  [get_ports {o_class[1]}]
set_output_delay -clock clk  -min 0  [get_ports {o_class[1]}]
set_output_delay -clock clk  -max 5  [get_ports {o_class[0]}]
set_output_delay -clock clk  -min 0  [get_ports {o_class[0]}]
set_drive 1  [get_ports rst_n]
set_drive 1  [get_ports mode]
set_drive 1  [get_ports strobe]
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
set_drive 1  [get_ports {w_data[7]}]
set_drive 1  [get_ports {w_data[6]}]
set_drive 1  [get_ports {w_data[5]}]
set_drive 1  [get_ports {w_data[4]}]
set_drive 1  [get_ports {w_data[3]}]
set_drive 1  [get_ports {w_data[2]}]
set_drive 1  [get_ports {w_data[1]}]
set_drive 1  [get_ports {w_data[0]}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_y_pool_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[7][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[6][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[5][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[4][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[3][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[2][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[1][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{clk_gate_h_reg_reg[0][0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_data_latched_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_weight_addr_cnt_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_weight_addr_cnt_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_weight_addr_cnt_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_weight_addr_cnt_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/clk_gate_feed_j_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/clk_gate_feed_j_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/clk_gate_feed_j_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/clk_gate_feed_j_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/clk_gate_o_next_y_pool_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_yt_mac/clk_gate_o_yt_final_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_yt_mac/clk_gate_o_yt_final_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_yt_mac/clk_gate_o_yt_final_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_yt_mac/clk_gate_o_yt_final_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_yt_mac/clk_gate_yt_acc_reg_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_o_next_h_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s0_h_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s0_h_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s0_h_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s0_h_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_elem/clk_gate_s1_Abar_h_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_dt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_dt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_dt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_dt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_dt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_softplus/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_dt_proj_serial/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_dt_proj_serial/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_dt_proj_serial/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_dt_proj_serial/clk_gate_o_y_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_c_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_c_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_c_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_c_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_c_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_b_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_b_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_b_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_b_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_b_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_dt_raw_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_dt_raw_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_dt_raw_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_dt_raw_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_dt_raw_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_x_proj_serial/clk_gate_idx_out_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_x_proj_serial/clk_gate_idx_out_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_x_proj_serial/clk_gate_idx_out_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_x_proj_serial/clk_gate_idx_out_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_xt_regfile/clk_gate_regfile_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_xt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_xt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_xt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_xt_regfile/clk_gate_data_negedge_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_out_mac_acc_reg/main_gate]
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
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[7]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[6]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[5]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[4]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[3]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[2]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[1]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -fall -setup 0 [get_cells                               \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -rise -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -fall -hold 0 [get_cells                                \
{u_datapath/u_proj_in_out_shared/clk_gate_x_buf_reg[0]/main_gate}]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_in_y_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_in_y_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_in_y_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_proj_in_out_shared/clk_gate_o_proj_in_y_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_14/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_14/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_14/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_14/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_13/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_13/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_13/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_13/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_12/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_12/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_12/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_12/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_11/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_11/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_11/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_11/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_D_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_126/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_126/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_126/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_126/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_125/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_125/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_125/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_125/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_124/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_124/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_124/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_124/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_123/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_123/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_123/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_123/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_122/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_122/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_122/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_122/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_121/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_121/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_121/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_121/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_120/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_120/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_120/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_120/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_119/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_119/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_119/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_119/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_118/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_118/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_118/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_118/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_117/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_117/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_117/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_117/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_116/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_116/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_116/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_116/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_115/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_115/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_115/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_115/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_114/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_114/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_114/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_114/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_113/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_113/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_113/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_113/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_112/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_112/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_112/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_112/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_111/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_111/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_111/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_111/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_110/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_110/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_110/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_110/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_109/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_109/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_109/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_109/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_108/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_108/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_108/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_108/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_107/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_107/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_107/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_107/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_106/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_106/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_106/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_106/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_105/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_105/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_105/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_105/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_104/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_104/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_104/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_104/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_103/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_103/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_103/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_103/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_102/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_102/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_102/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_102/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_101/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_101/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_101/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_101/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_100/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_100/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_100/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_100/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_99/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_99/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_99/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_99/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_98/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_98/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_98/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_98/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_97/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_97/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_97/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_97/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_96/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_96/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_96/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_96/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_95/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_95/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_95/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_95/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_94/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_94/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_94/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_94/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_93/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_93/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_93/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_93/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_92/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_92/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_92/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_92/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_91/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_91/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_91/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_91/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_90/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_90/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_90/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_90/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_89/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_89/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_89/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_89/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_88/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_88/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_88/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_88/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_87/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_87/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_87/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_87/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_86/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_86/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_86/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_86/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_85/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_85/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_85/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_85/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_84/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_84/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_84/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_84/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_83/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_83/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_83/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_83/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_82/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_82/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_82/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_82/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_81/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_81/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_81/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_81/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_80/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_80/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_80/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_80/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_79/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_79/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_79/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_79/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_78/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_78/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_78/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_78/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_77/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_77/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_77/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_77/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_76/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_76/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_76/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_76/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_75/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_75/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_75/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_75/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_74/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_74/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_74/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_74/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_73/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_73/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_73/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_73/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_72/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_72/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_72/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_72/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_71/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_71/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_71/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_71/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_70/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_70/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_70/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_70/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_69/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_69/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_69/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_69/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_68/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_68/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_68/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_68/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_67/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_67/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_67/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_67/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_66/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_66/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_66/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_66/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_65/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_65/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_65/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_65/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_64/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_64/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_64/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_64/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_63/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_63/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_63/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_63/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_62/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_62/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_62/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_62/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_61/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_61/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_61/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_61/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_60/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_60/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_60/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_60/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_59/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_59/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_59/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_59/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_58/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_58/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_58/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_58/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_57/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_57/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_57/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_57/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_56/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_56/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_56/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_56/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_55/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_55/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_55/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_55/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_54/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_54/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_54/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_54/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_53/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_53/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_53/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_53/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_52/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_52/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_52/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_52/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_51/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_51/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_51/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_51/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_50/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_50/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_50/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_50/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_49/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_49/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_49/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_49/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_48/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_48/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_48/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_48/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_47/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_47/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_47/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_47/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_46/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_46/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_46/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_46/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_45/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_45/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_45/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_45/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_44/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_44/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_44/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_44/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_43/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_43/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_43/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_43/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_42/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_42/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_42/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_42/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_41/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_41/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_41/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_41/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_40/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_40/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_40/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_40/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_39/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_39/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_39/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_39/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_38/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_38/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_38/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_38/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_37/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_37/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_37/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_37/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_36/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_36/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_36/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_36/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_35/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_35/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_35/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_35/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_34/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_34/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_34/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_34/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_33/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_33/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_33/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_33/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_32/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_32/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_32/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_32/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_31/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_31/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_31/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_31/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_30/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_30/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_30/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_30/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_29/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_29/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_29/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_29/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_28/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_28/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_28/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_28/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_27/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_27/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_27/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_27/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_26/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_26/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_26/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_26/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_25/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_25/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_25/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_25/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_24/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_24/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_24/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_24/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_23/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_23/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_23/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_23/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_22/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_22/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_22/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_22/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_21/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_21/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_21/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_21/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_20/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_20/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_20/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_20/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_19/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_19/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_19/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_19/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_18/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_18/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_18/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_18/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_17/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_17/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_17/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_17/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_16/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_16/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_16/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_16/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_15/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_15/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_15/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_15/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_14/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_14/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_14/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_14/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_13/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_13/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_13/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_13/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_12/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_12/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_12/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_12/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_11/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_11/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_11/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_11/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_CONST_A_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_30/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_30/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_30/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_30/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_29/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_29/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_29/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_29/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_28/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_28/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_28/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_28/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_27/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_27/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_27/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_27/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_26/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_26/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_26/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_26/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_25/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_25/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_25/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_25/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_24/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_24/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_24/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_24/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_23/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_23/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_23/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_23/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_22/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_22/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_22/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_22/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_21/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_21/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_21/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_21/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_20/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_20/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_20/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_20/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_19/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_19/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_19/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_19/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_18/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_18/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_18/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_18/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_17/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_17/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_17/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_17/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_16/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_16/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_16/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_16/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_15/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_15/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_15/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_15/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_14/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_14/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_14/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_14/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_13/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_13/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_13/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_13/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_12/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_12/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_12/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_12/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_11/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_11/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_11/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_11/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_OUT_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_DT_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_23/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_23/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_23/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_23/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_22/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_22/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_22/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_22/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_21/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_21/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_21/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_21/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_20/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_20/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_20/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_20/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_19/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_19/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_19/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_19/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_18/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_18/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_18/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_18/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_17/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_17/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_17/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_17/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_16/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_16/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_16/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_16/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_15/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_14/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_13/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_12/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_11/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_MERGED_X_PROJ_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_M_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_10/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_10/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_10/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_10/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_9/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_9/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_9/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_9/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_8/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_8/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_8/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_8/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_7/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_7/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_7/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_7/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_BIAS_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_Z_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_6/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_5/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_4/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_3/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg_0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
u_datapath/u_weight_storage/clk_gate_r_W_PROJ_IN_reg/main_gate]
