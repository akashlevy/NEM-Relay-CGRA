#!/bin/bash

# @Caleb: For providing registers on all outputs of all SBs, do-
# setenv CGRA_GEN_ALL_REG 1 (csh syntax)
export CGRA_GEN_ALL_REG=1


if [ -d genesis_verif ]; then
  rm -rf genesis_verif
fi

# Let's do this in run.csh instead...
# branch=`git rev-parse --abbrev-ref HEAD`
# if [[ `hostname` == "kiwi" && "$branch" == "nbdev3" ]]; then
#   echo kiwi branch nbdev3 means must use no-opt or disable luts
# fi



Genesis2.pl -parse -generate -top test_top -hierarchy top.xml -input\
  ncsim_verif/test_top.svp \
  ncsim_verif/test.svp \
  ncsim_verif/JTAGDriver.svp \
  ncsim_verif/clocker.svp \
  top.vp \
  cgra_core.vp \
  \
  ../pad_ring/pad_ring.svp \
  ../pad_ring/io_group.svp \
  ../pad_ring/fixed_io.vp \
  \
  ../sb/sb.vp \
  ../cb/cb.vp \
  \
  ../pe_new/pe/rtl/test_pe_red.svp \
  ../pe_new/pe/rtl/test_pe_dual.vpf \
  ../pe_new/pe/rtl/test_pe_comp.svp \
  ../pe_new/pe/rtl/test_pe_comp_dual.svp \
  ../pe_new/pe/rtl/test_cmpr.svp \
  ../pe_new/pe/rtl/test_pe.svp \
  ../pe_new/pe/rtl/test_mult_add.svp \
  ../pe_new/pe/rtl/test_full_add.svp \
  ../pe_new/pe/rtl/test_lut.svp      \
  ../pe_new/pe/rtl/test_opt_reg.svp  \
  ../pe_new/pe/rtl/test_simple_shift.svp \
  ../pe_new/pe/rtl/test_shifter.svp  \
  ../pe_new/pe/rtl/test_debug_reg.svp  \
  ../pe_new/pe/rtl/test_opt_reg_file.svp  \
  \
  ../pe_tile_new/pe_tile_new.svp \
  \
  ../empty/empty.vp \
  ../io1bit/io1bit.vp \
  ../io16bit/io16bit.vp \
  ../global_signal_tile/global_signal_tile.vp \
  \
  ../memory_tile/memory_tile.vp \
  ../memory_core/input_sr.vp \
  ../memory_core/output_sr.vp \
  ../memory_core/linebuffer_control.vp \
  ../memory_core/fifo_control.vp \
  ../memory_core/mem.vp \
  ../memory_core/memory_core.vp \
  \
  ../global_controller/global_controller.svp \
  \
  ../jtag/jtag.svp \
  ../jtag/Template/src/digital/template_ifc.svp \
  ../jtag/Template/src/digital/cfg_ifc.svp \
  ../jtag/Template/src/digital/flop.svp \
  ../jtag/Template/src/digital/tap.svp \
  ../jtag/Template/src/digital/reg_file.svp \
  ../jtag/Template/src/digital/cfg_and_dbg.svp \
  || exit 13



# echo
# echo HACKWARNING Restoring original LUT code
# echo HACKWARNING Restoring original LUT code
# echo HACKWARNING Restoring original LUT code
# echo git checkout ../pe_new/pe/rtl/test_pe.svp
# git checkout ../pe_new/pe/rtl/test_pe.svp
# echo

#echo
#echo HACKWARNING Swapping stub in place of DW_tap
#echo HACKWARNING Swapping stub in place of DW_tap
#echo HACKWARNING Swapping stub in place of DW_tap
#echo cp  ../jtag/Template/src/digital/DW_tap.v.stub genesis_verif/DW_tap.v
#ls ../jtag/Template/src/digital/DW_tap.v.stub genesis_verif/DW_tap.v
#cp  ../jtag/Template/src/digital/DW_tap.v.stub genesis_verif/DW_tap.v
#echo

source clean_up_cgra_inputs.csh
source remove_genesis_wires.csh
cp ../../../verilator/generator_z_tb/sram_stub.v genesis_verif/sram_512w_16b.v

# Fixed now maybe
# # Must fix e.g.  <depth bith='15' bitl='3'>0</depth>
# # should be <fifo_depth bith='15' bitl='3'>0</fifo_depth>
# # Second run below should say 'no errors found'
# ./find_and_fix_depth_problems.csh
# ./find_and_fix_depth_problems.csh


# Must fix e.g.
#       <src sel='0'>in_1_BUS16_0_3</src>
# should be
#       <src sel='0'>in_1_BUS16_S0_T3</src>
# 
./find_and_fix_ST_deficient_memwires.csh
./find_and_fix_ST_deficient_memwires.csh


if [ `hostname` == "kiwi" ]; then
  echo Checking cgra_info for errors...
  echo xmllint --noout cgra_info.txt
  xmllint --noout cgra_info.txt 2>&1 | head -n 20
fi

