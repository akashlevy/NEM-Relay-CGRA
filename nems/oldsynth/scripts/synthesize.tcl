# Set up technology libs
suppress_message [list AUTOREAD-107 ELAB-311 MWLIBP-311 TFCHK-012 TFCHK-049 TFCHK-050 TFCHK-084 TFCHK-092 TIM-052 TIM-128 UISN-40 VO-4]
source -echo -verbose ../../scripts/tsmc40r_setup.tcl

set design_name $::env(DESIGN)
set report_dir ./reports

sh mkdir -p $report_dir

define_design_lib WORK -path ./WORK



# Read in the RTL
# Currently expects rtl to be at EE272_flow/rtl (feel free to change this)
# read_file automatically performs both analyze and elaborate
read_file -top $design_name -autoread [glob -directory ../../gen -type f *.v *.sv]
current_design $design_name

# Look at link libs to resolve any cell references in the RTL
link

### PLACE YOUR DESIGN CONSTRAINTS HERE
# If you want to use this script to synthesize multiple designs
# with different constraints, you can create a contraints script
# for each of the designs and use the commentd line below
source -echo -verbose "../../scripts/constraints.tcl"
### END DESIGN CONSTRAINTS

### DON'T TOUCH OR USE CUSTOM CELLS
#set_dont_touch [get_lib_cells tcbn40lpbwptc/BUFTD*]
#set_dont_touch [get_cells "out_buf*" -hierarchical]
set_dont_touch [get_cells "sbmux*" -hierarchical]
set_dont_touch [get_cells "cbmux*" -hierarchical]
set_dont_touch [get_lib_cells hybrid40tt/*]
set compile_enable_register_merging false
set_attribute [get_lib_cells hybrid40tt/*] dont_use true
### END DONT TOUCH OR USE CUSTOM CELLS

# Settings for XG mode compatibility issues
set uniquify_keep_original_design true
set ungroup_keep_original_design true

# Compile optimization settings
set compile_seqmap_identify_shift_registers false
set compile_seqmap_propagate_constants true
set compile_retime_exception_registers true
set compile_enable_constant_propagation_with_no_boundary_opt true
set case_analysis_with_logic_constants true
set timing_use_enhanced_capacitance_modeling

# Reset related optimization settings
set compile_seqmap_sync_clr_preset_more_opt true
set hdlin_ff_always_sync_set_reset true

### POWER ESTIMATION
saif_map -start

### Create merged SAIF file if it does not exist
### NOTE: DELETE THE FILE IF YOU ARE TRYING TO SYNTHESIZE A DIFFERENT MODULE
### OTHERWISE THE SWITCHING ACTIVITY WILL NOT BE ANNOTATED
if {![file exists ../../saif/merged.saif.gz]} {
    merge_saif -input_list { \
        -input ../../saif/active_renamed/cascade_pe_0x0F07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x020F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A0E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A01.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x010B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0907.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0102.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0903.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x050D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B0E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0206.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0809.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0703.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x030E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0407.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0609.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x080D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0305.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0707.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C0F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0509.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x030D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0702.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0406.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x080A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0805.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x080E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x040F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0706.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x070B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0601.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0906.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x090B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0505.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x050A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x050E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0103.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x090F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0902.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0207.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x060A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0807.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x030F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0E09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C0E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0909.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0306.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0803.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x040D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x010A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0507.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A02.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0709.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0603.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x020E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0205.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0607.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B0F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0409.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x090D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0101.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x050B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0506.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x090A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0905.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x020D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0602.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x060B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0901.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x090E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0E0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x050F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0806.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x080B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0405.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0701.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0307.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0109.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x070A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x040E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x080F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0802.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0302.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x070D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0807.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0F09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0803.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C01.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0909.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x030B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0201.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0105.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0709.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A02.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A0F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0503.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x010E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x090D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x020A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0409.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0607.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B02.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x060F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x050B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x090A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0905.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x010D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0901.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x090E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0502.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0606.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x060B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x070E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0303.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0209.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0806.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x080B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D02.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x040A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0401.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0802.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x070A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0705.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A0E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0907.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0106.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0202.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x060D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B01.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B0E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x020B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0809.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0903.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0E07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x010F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0609.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0703.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C06.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C0B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0301.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x030A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0509.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0707.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C02.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0403.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x080D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x040B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D01.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x080A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0805.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0A09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0C07.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x070F.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0C03.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0706.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x070B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0D05.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0D0A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0801.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0B09.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0402.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0906.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x090B.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0309.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0107.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0A0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x050A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x060E.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0203.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0B0D.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x060A.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0605.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0501.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/harris_pe_0x0902.saif.gz -weight 0.444444444444 \
        -input ../../saif/active_renamed/cascade_pe_0x0E06.saif.gz -weight 0.444444444444 \
    } -instance TOP/v/core/pe_tile_new_unq1 -output ../../saif/merged.saif.gz
}

# Read saif and report mapping
read_saif -auto_map_names -input ../../saif/merged.saif.gz -instance_name TOP/v/core/pe_tile_new_unq1
#read_saif -auto_map_names -input ../../saifnew/output_config-cascade_keyi.*.vcd.saif.gz -instance_name TOP/v/core
#read_saif -auto_map_names -input ../../saifnew/output_config-harris_keyi.*.vcd.saif.gz -instance_name TOP/v/core
report_saif

# Set toggle rate of constant registers to 0 and report mapping
#set_switching_activity [get_pins "config_*/Q" -hierarchical] -toggle_rate 0
#report_saif

### END POWER ESTIMATION

check_design > $report_dir/$design_name.chk1

report_compile_options

compile_ultra -gate_clock              -scan -no_seq_output_inversion -no_autoungroup 
compile_ultra -gate_clock -incremental -scan -no_seq_output_inversion -no_autoungroup 

uniquify -force -dont_skip_empty_designs

check_design > $report_dir/$design_name.chk2

report_timing -in -net -transition_time  -capacitance  -significant_digits  4 -attributes  -nosplit -path full_clock -delay max -nworst 1 -max_paths 10 > $report_dir/$design_name.time

# Write synthesized verilog
write -format verilog -hierarchy -output ./$design_name.sv
# write_milkyway -overwrite -output $design_name
# write design reports (timing, area, power)
report_qor > $report_dir/$design_name.qor.rpt
report_power > $report_dir/$design_name.power.top.rpt
report_area -hierarchy > $report_dir/$design_name.area.rpt
report_power -hierarchy -levels 10 > $report_dir/$design_name.power.rpt
#export design database
write -format ddc -hier -out ./$design_name.ddc;

quit

