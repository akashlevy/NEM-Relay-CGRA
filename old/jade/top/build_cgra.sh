#!/bin/bash

function help {
  if [[ "$1" == "--help" ]]; then
    echo ""
    # echo "${0:t}"
    echo "Optional switches:"
    echo "   --design <design_name> (must be first switch on cmd line)"
    echo "   --use_verilator_hacks | --no_verilator_hacks"
    echo "   --help"
    echo ""
    echo "Available designs:"
    echo '    shortmem - memory tile = 1 (same height as PE tile)'
    echo "    tallmem  - memory tile = 2"
    echo "    2groups  - two 16bit IO pad groups per side"
    echo ""
    echo "Example:"
    echo "  ${0:t} --design 2groups"

    exit 13
  fi
}

function do_genesis {

  if [[ $USE_VERILATOR_HACKS == "TRUE" ]]; then
    export TRISTATE_UNAVAILABLE=TRUE
  fi

  Genesis2.pl -parse -generate -top top -hierarchy top.xml \
    -xml ./bin/${design_name}.xml \
    -input top.vp \
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
    ../memory_tile/mem_shift_reg.svp \
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
}

function main {

  # Check for help request
  help $*

  # Backward compatibility: Build cgra_info.txt -> cgra_info.xml link
  cgra_info_link_hack

  # Clean up from previous build(s)
  if [ -d genesis_verif ]; then rm -rf genesis_verif; fi

  # If travis or kiwi, set env var USE_VERILATOR_HACKS
  use_verilator_hacks_if_travis_or_kiwi $*

  # Make sure Genesis2 is available
  find_or_install_genesis2

  design_name=`design_name $* | tail -n 1`
  echo "NOTICE Building design '$design_name'"

  # GENERATE
  do_genesis

  ########################################################################
  # Post-process #########################################################
  ########################################################################

  # If using verilator, replace DW_tap w/verilator stub
  if [[ $USE_VERILATOR_HACKS == "TRUE" ]]; then
    echo
    echo HACKWARNING Using custom stub instead of proprietary DW_tap
    echo HACKWARNING Using custom stub instead of proprietary DW_tap
    echo HACKWARNING Using custom stub instead of proprietary DW_tap
    echo cp  ../jtag/Template/src/digital/DW_tap.v.stub genesis_verif/DW_tap.v
    echo cp  mdll_top.sv genesis_verif/mdll_top.sv
    cp  ../jtag/Template/src/digital/DW_tap.v.stub genesis_verif/DW_tap.v
    cp mdll_top.sv genesis_verif/mdll_top.sv
    ls -l ../jtag/Template/src/digital/DW_tap.v.stub
    ls -l genesis_verif/DW_tap.v
    echo
  fi

  # What are these?  Why are they here?
  source clean_up_cgra_inputs.csh
  source remove_genesis_wires.csh

  # If using verilator, replace SRAM w/verilator stub
  if [[ $USE_VERILATOR_HACKS == "TRUE" ]]; then
    echo '  VERILATOR HACK: SRAM'
    echo '  VERILATOR HACK: SRAM'
    echo '  VERILATOR HACK: SRAM'
    cp ../../../verilator/generator_z_tb/sram_stub.v genesis_verif/sram_512w_16b.v
  fi

  # This won't work on travis until/unless we install xmllint there...
  if [ `hostname` == "kiwi" ]; then
    echo Checking cgra_info for errors...
    echo xmllint --noout cgra_info.xml
    xmllint --noout cgra_info.xml 2>&1 | head -n 20
  fi
}

function cgra_info_link_hack {
  echo ""
  echo "WARNING cgra_info.txt no longer exists; building symlink cgra_info.txt => cgra_info.xml"
  echo "WARNING cgra_info.txt no longer exists; building symlink cgra_info.txt => cgra_info.xml"
  echo "WARNING cgra_info.txt no longer exists; building symlink cgra_info.txt => cgra_info.xml"
  echo ""
  if [ -e cgra_info.txt ]; then /bin/rm cgra_info.txt; fi
  ln -s cgra_info.xml cgra_info.txt
  ls -l  cgra_info.txt
  echo ""
}

function use_verilator_hacks_if_travis_or_kiwi {
  # If it's travis or kiwi then it must mean verilator hacks, yes?
  if [ ! -z ${TRAVIS_BUILD_DIR+x} ]; then
    echo "$0 WARNING I think we are running from travis; setting USE_VERILATOR_HACKS"
    export USE_VERILATOR_HACKS="TRUE"
  fi
  if expr `hostname` : "kiwi" > /dev/null; then
    echo "$0 WARNING I think we are running from kiwi; setting USE_VERILATOR_HACKS"
    export USE_VERILATOR_HACKS="TRUE"
  fi

  # Can override with the appropriate command-line argument(s)
  if [[ "$1" == "--use_verilator_hacks" ]]; then
    echo "$0 WARNING setting USE_VERILATOR_HACKS=TRUE b/c command line arg"
    export USE_VERILATOR_HACKS="TRUE"
  fi
  if [[ "$1" == "--no_verilator_hacks" ]]; then
    echo "$0 WARNING setting USE_VERILATOR_HACKS=FALSE b/c command line arg"
    export USE_VERILATOR_HACKS="FALSE"
  fi
  echo ""
}

function find_or_install_genesis2 {
  if [ ! `command -v Genesis2.pl` ]; then
    echo 'build_cgra.sh: Oops cannot find Genesis2.pl; I will try to fix this for you'
    echo 'build_cgra.sh: source ./setup-genesis2.sh'
    source ./setup-genesis2.sh
    command -v Genesis2.pl || exit 13
    echo ''
  fi
}

function design_name {

  # Default is shortmem
  design_name="shortmem"

  # Backward compatibility why not.
  # Matches e.g. '-tallmem' or '--tallmem'
  if expr "$1" : "tallmem" > /dev/null; then
    echo "WARNING found deprecated switch '--tallmem'"
    echo "WARNING should instead uses '--design tallmem'"
    design_name="tallmem"
  fi  
  if `test "$1" = '--design'`; then
    design_name="$2"
  fi

  # return value
  echo $design_name
}

main $*


# NOTES
# 
# Genesis cleanup: instead of 'rm -rf genesis_verif',
# should probably be doing this:
#   'if (-e ./genesis_clean.cmd) ./genesis_clean.cmd'
