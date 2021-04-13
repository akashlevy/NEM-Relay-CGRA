#=========================================================================
# designer_interface.tcl
#=========================================================================
# The designer_interface.tcl file is the first script run by PTPX (see the
# top of ptpx.tcl) and sets up ASIC design kit variables and inputs.
#
# Author : Christopher Torng
# Date   : May 20, 2019

set ptpx_design_name        pe_tile_new_unq1
set appname                 $::env(APPNAME)
set designtype              $::env(DESIGNTYPE)
set experiment              $::env(EXPERIMENT)
set appdesname              ${appname}_${designtype}


#-------------------------------------------------------------------------
# Libraries
#-------------------------------------------------------------------------

set adk_dir                       adk

set ptpx_additional_search_path   $adk_dir
set ptpx_target_libraries         stdcells.db

set ptpx_extra_link_libraries     nldm_nems40tt.db

#-------------------------------------------------------------------------
# Inputs
#-------------------------------------------------------------------------

set ptpx_gl_netlist         $designtype/design.vcs.v
set ptpx_sdc                design.pt.sdc
set ptpx_spef               $designtype/design.spef.gz
set ptpx_saif               ../outputs/$appname.saif.gz

# The strip path must be defined!
#
#   export strip_path = th/dut
#
# There must _not_ be any quotes, or read_saif will fail. This fails:
#
#   export strip_path = "th/dut"
#

set ptpx_strip_path         $ptpx_design_name


puts "done"


