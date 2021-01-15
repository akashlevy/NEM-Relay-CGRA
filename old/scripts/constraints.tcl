# Targets on metrics
get_ports clk*
create_clock -name clk -period 2 [get_ports clk*]
set_max_area 0

# Clock delays
set_input_delay -max 0.2 -clock clk [all_inputs]
set_output_delay -max 0.2 -clock clk [all_outputs]
set_input_delay -min 0 -clock clk [all_inputs]
set_output_delay -min 0 -clock clk [all_outputs]

# Loads and transitions
set_load 0.1 [all_outputs]
set_input_transition 0.2 [all_inputs]

# False paths
set constant_regs [get_cells "config_*" -hierarchical -filter "is_sequential==true"]
set_false_path -through $constant_regs
set_false_path -through [get_pins sb*/* -hierarchical -filter "direction==out"] -through [get_pins cb_*/* -hierarchical -filter "direction==in"]
set_false_path -from [get_ports -hierarchical {config* tile_id* reset}] -to [all_outputs]
