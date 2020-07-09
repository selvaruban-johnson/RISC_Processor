create_clock -period 10.000 -name clk [get_ports clk]

set_input_delay -clock clk 8.000 [all_inputs]
set_input_delay -clock clk -min 7.000 [all_inputs]
set_output_delay -clock clk 0.300 [all_outputs]
set_output_delay -clock clk -min 0.100 [all_outputs]
