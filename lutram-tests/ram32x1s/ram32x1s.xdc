# clk_p_i
set_property LOC AD12 [get_ports {clk_p_i}]
set_property IOSTANDARD LVDS [get_ports {clk_p_i}]

# clk_n_i
set_property LOC AD11 [get_ports {clk_n_i}]
set_property IOSTANDARD LVDS [get_ports {clk_n_i}]

# rst_i
set_property LOC G12 [get_ports {rst_i}]
set_property IOSTANDARD LVCMOS25 [get_ports {rst_i}]

# led
set_property LOC AB8 [get_ports {q_o}]
set_property IOSTANDARD LVCMOS15 [get_ports {q_o}]
