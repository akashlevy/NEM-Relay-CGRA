# Set up technology libs
suppress_message [list AUTOREAD-107 ELAB-311 MWLIBP-311 TFCHK-012 TFCHK-049 TFCHK-050 TFCHK-084 TFCHK-092 TIM-052 TIM-128 UISN-40 VO-4]
source -echo -verbose ../../scripts/tsmc40r_setup.tcl

set design_name $::env(DESIGN)
set report_dir ./reports

sh mkdir -p $report_dir

define_design_lib WORK -path ./WORK

# Read in the RTL
read_verilog -netlist ../$design_name.sv
current_design $design_name

# Look at link libs to resolve any cell references in the RTL
link

### PLACE YOUR DESIGN CONSTRAINTS HERE
# If you want to use this script to synthesize multiple designs
# with different constraints, you can create a contraints script
# for each of the designs and use the commentd line below
source -verbose "../../scripts/constraints.tcl"
### END DESIGN CONSTRAINTS

compile_ultra -only_design_rule -incremental

#uniquify -force -dont_skip_empty_designs

#check_design > $report_dir/$design_name.chk2

report_timing -in -net -transition_time  -capacitance  -significant_digits  4 -attributes  -nosplit -path full_clock -delay max -nworst 1 -max_paths 10 > $report_dir/$design_name.time

# Write synthesized verilog
write -format verilog -hierarchy -output ./$design_name.sv
# write_milkyway -overwrite -output $design_name
# write design reports (timing, area, power)
report_qor > $report_dir/$design_name.qor.rpt
report_power > $report_dir/$design_name.power.top.rpt
report_area -hierarchy > $report_dir/$design_name.area.rpt
report_power -hierarchy -levels 3 >  $report_dir/$design_name.power.rpt
#export design database
write -format ddc -hier -out ./$design_name.ddc;

quit

