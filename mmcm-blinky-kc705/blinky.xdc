set_property LOC AD12 [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports {clk_p}]

set_property LOC AD11 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports {clk_n}]

set_property LOC AB8 [get_ports led]
set_property IOSTANDARD LVCMOS15 [get_ports {led}]

# user_led:1
set_property LOC AA8 [get_ports {clkout[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {clkout[0]}]

# user_led:2
set_property LOC AC9 [get_ports {clkout[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {clkout[1]}]

# user_led:3
set_property LOC AB9 [get_ports {clkout[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {clkout[2]}]

# user_led:4
set_property LOC AE26 [get_ports {clkout[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {clkout[3]}]

# user_led:5
set_property LOC G19 [get_ports {clkout[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {clkout[4]}]

# user_led:6
set_property LOC E18 [get_ports {clkout[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {clkout[5]}]

# user_led:7
set_property LOC F16 [get_ports {clkout[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {clkout[6]}]
