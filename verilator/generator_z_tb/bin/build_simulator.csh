#!/bin/csh -f

# USAGE: $0 <-v|-q> <testbench> <tracefile>

unset VERBOSE
if ("$1" == "-v") then
  set VERBOSE; shift
endif

if ("$1" == "-q") then
  unset VERBOSE; shift
endif

set cmd_line_switches = ()
while ( `expr "$1" : '-'` == 1 )
  # echo "Found switch '$1'"
  set cmd_line_switches = ($cmd_line_switches $1)
  # echo $cmd_line_switches
  shift
end

set testbench = $1
unset tracefile
if ($#argv == 2) set tracefile = $2

  # Build the necessary switches

  # Gather the verilog files for verilator command line
  set vdir = ../../hardware/generator_z/top/genesis_verif
  if (! -e $vdir) then
    echo "ERROR build_simulator.csh: Could not find verilog files in vfile directory $vfile"
    echo "       $vdir"
    exit 13
  endif
  pushd $vdir >& /dev/null
    # set vfiles = (*.v *.sv)
    set vfiles = (*.v)
  popd >& /dev/null

  # So many warnings it wants to DIE!
  set myswitches = '-Wno-fatal'
  set top        = 'top'

  # Add trace switch if trace requested
  if ($?tracefile) set myswitches = "$myswitches --trace"

  # Note default trace_filename in top_tb.cpp is "top_tb.vcd"

  # Run verilator to build the simulator.

  # build C++ project

  set opt = ''

# Hey HEY built a test_pe that maybe has working LUTs for kiwi;
# new LUT code gets swapped in by top/run.csh
#
#   ########################################################################
#   # O0 hack for nbdev3 and beyond: only runs on kiwi if opt OFF
# 
#   set opt = ''
#   set branch = `git rev-parse --abbrev-ref HEAD`
#   set badbranch = nbdev3
#   if (! $?TRAVIS && "$branch" == "$badbranch") then
# 
#     # OMG -O0 is SOO SLOWWW let's just disable luts instead
#     # set opt = '-O0'
#     # echo
#     # echo "WARNING VERILATOR OPT LEVEL 0 (NO OPT)"
#     # echo "WARNING VERILATOR OPT LEVEL 0 (NO OPT)"
#     # echo "WARNING VERILATOR OPT LEVEL 0 (NO OPT)"
# 
#     set hwdir = $vdir/../..
#     echo "WARNING LUTS (and res_p) DISABLED b/c kiwi + $badbranch"
#     echo "WARNING LUTS (and res_p) DISABLED b/c kiwi + $badbranch"
#     echo "WARNING LUTS (and res_p) DISABLED b/c kiwi + $badbranch"
#     echo
#     echo diff $vdir/test_pe_unq1.sv $hwdir/pe_new/pe/rtl/test_pe_unq1.sv.no_lut
#     diff $vdir/test_pe_unq1.sv $hwdir/pe_new/pe/rtl/test_pe_unq1.sv.no_lut
# #     echo
# #     echo cp $hwdir/pe_new/pe/rtl/test_pe_unq1.sv.no_lut $vdir/test_pe_unq1.sv
# #     cp $hwdir/pe_new/pe/rtl/test_pe_unq1.sv.no_lut $vdir/test_pe_unq1.sv || exit 13
# 
#   endif

  set tmpdir = `mktemp -d /tmp/build_verilator.XXX`

  #PUT THE ANALOG BLOCK IN
  cp ../../hardware/generator_z/top/mdll_top.sv $vdir/mdll_top.sv

  echo 'Note (build_simulator.csh): No more IO hacks;'
  echo 'pixels must arrive via pad_S2_T[8:15] aka wire_2_1_BUS16_S0_T0'
  echo 'and           exit via pad_S0_T[7:0] aka wire_2_17_BUS16_S0_T0'

  # (Temporary (I hope)) SRAM hack(s)
  echo
  echo '  SRAM hack'
  echo '  SRAM hack'
  echo '  SRAM hack'
  cp ./sram_stub.v $vdir/sram_512w_16b.v
  ls -l $vdir/sram*

  # Final check of sram hack
  echo
  ls -l ./sram_stub.v $vdir/sram_512w_16b.v

  echo
  echo verilator $cmd_line_switches $opt -Wall $myswitches --cc --exe $testbench \
    -y $vdir $vfiles --top-module $top \
    | fold -s | sed '2,$s/^/  /' | sed 's/$/  \\/'
  echo

#   # if -v then
#   # verilator --version; g++ --version
#   lsb_release -a
#   verilator -V
#   echo


  verilator $cmd_line_switches $opt $myswitches -Wall $myswitches --cc --exe $testbench \
    -y $vdir $vfiles --top-module $top \
    >& $tmpdir/verilator.out

#   # To track down nonconvergence, use this instead
#   set echo
#   verilator $opt $myswitches -Wall $myswitches --cc --exe $testbench \
#     --profile-cfuncs \
#     -y $vdir $vfiles --top-module $top \
#     >& $tmpdir/verilator.out
#   unset echo


  set verilator_exit_status = $status

  if ($?VERBOSE) then
    echo "%Warning1 Ignoring warnings about unoptimizable circularities in switchbox wires (see SR for explainer)."
    echo '%Warning2 To get the flavor of all the warnings, just showing first 40 lines of output.'
    echo "%Warning3 See $tmpdir/verilator.out for full log."
    echo

    # This (head -n 40) can cause broken pipe error (!)
    # awk -f ./run-verilator-warning-filter.awk $tmpdir/verilator.out | head -n 40
    awk -f ./run-verilator-warning-filter.awk $tmpdir/verilator.out

  else
    echo "See $tmpdir/verilator.out for full log of verilator warnings."
  endif

  if ($verilator_exit_status != 0) then
    tail -40 $tmpdir/verilator.out
    echo ""
    echo "VERILATOR FAILED!"
    echo "See $tmpdir/verilator.out for full log of verilator warnings."
    exit 13
  endif

  echo
  echo "build_simulator.csh: Build the testbench..."

  set vtop = 'Vtop'
  if ($?VERBOSE) then
    echo
    echo "make \"
    echo "  -j -C obj_dir/ -f $vtop.mk $vtop"
  endif

  echo
  if (-e obj_dir/Vtop) /bin/rm obj_dir/Vtop

  echo "make $vtop -j -C obj_dir/ -f $vtop.mk $vtop"
  make \
    -j -C obj_dir/ -f $vtop.mk $vtop \
    >& $tmpdir/make_vtop.log \
    || set ERROR
# 
#   # To track down nonconvergence, use this instead
#   set echo
#   make \
#     OPT=-DVL_DEBUG \
#     -j -C obj_dir/ -f $vtop.mk $vtop \
#     >& $tmpdir/make_vtop.log \
#     || set ERROR
#   unset echo


  if ($?ERROR) then
    cat $tmpdir/make_vtop.log; exit 13
  endif

  if ($?VERBOSE) then
    cat $tmpdir/make_vtop.log; echo
  endif


