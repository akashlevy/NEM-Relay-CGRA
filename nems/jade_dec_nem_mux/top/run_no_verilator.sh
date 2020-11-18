#!/bin/bash

# run script with NO VERILATOR HACKS

echo ERROR this script should fail unless/until sram and tap stubs are fixed
echo ERROR and maybe some other things too
echo ERROR If/when you fix these, you can comment out this error block
exit 13


# @Caleb: For providing registers on all outputs of all SBs, do-
# setenv CGRA_GEN_ALL_REG 1 (csh syntax)
# export CGRA_GEN_ALL_REG=1  (sh syntax)
export CGRA_GEN_ALL_REG=1


if [ -d genesis_verif ]; then
  rm -rf genesis_verif
fi

Genesis2.pl -parse -generate -top top -hierarchy top.xml -input\
  top.vp \
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
  $io1bit \
  ../io16bit/io16bit.vp \
  ../global_signal_tile/global_signal_tile.vp \
  \
  ../memory_tile/memory_tile.vp \
  ../memory_tile/mem_shift_reg.svp \
  ../memory_core/input_sr.vp \
  ../memory_core/output_sr.vp \
  ../memory_core/linebuffer_control.vp \
  ../memory_core/fifo_control.vp \
  ../memory_core/mem.vp \
  ../memory_core/memory_core.vp \
  \
  ../global_controller/global_controller.svp \
  ../global_controller/analog_regfile.vp \
  \
  ../jtag/jtag.svp \
  ../jtag/Template/src/digital/template_ifc.svp \
  ../jtag/Template/src/digital/cfg_ifc.svp \
  ../jtag/Template/src/digital/flop.svp \
  ../jtag/Template/src/digital/tap.svp \
  ../jtag/Template/src/digital/reg_file.svp \
  ../jtag/Template/src/digital/cfg_and_dbg.svp \
  || exit 13


# What are these?  Why are they here?
source clean_up_cgra_inputs.csh
source remove_genesis_wires.csh
