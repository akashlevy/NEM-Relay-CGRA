#!/bin/csh -f

# FIXME need better argswitch processing

if ("$1" == "--help") then
  echo 'test_bitstreams.csh tmpdir'
  echo 'test_bitstreams.csh tmpdir pointwise'
  echo 'test_bitstreams.csh tmpdir pointwise conv_1_2 conv_2_1 conv_3_1 conv_bw onebit_bool'
  echo 'test_bitstreams.csh -trace tmpdir'
  exit
endif

# 1. run_tbg is now the ONLY option
# 2. '-build' is default in run_tbg now or should be anyway
set RUN = run_tbg.csh
set build_switch = ''

if ("$1" == "-tbg") then
  echo "WARNING ignoring -tbg switch (tbg is default)"
  shift
endif

if ("$1" == "-nobuild") then
  echo "WARNING ignoring -nobuild switch (tbg always builds)"
  shift
endif

if ("$1" == "-build") then
  echo "WARNING ignoring -build switch (tbg always builds)"
  shift
endif

unset TRACE
if ("$1" == "-trace") then
  set TRACE
  # echo "WARNING ignoring -build switch (tbg always builds)"
  # set build_switch = '-build'
  shift
endif

if (! -d $1) then
  echo 'Where are the test.bsa input files?'
  echo "Example: $0:t /tmp/build42/"
  exit -1
endif
set tmpdir = $1

# Oops maybe tmpdir must be a full path
set tmpdir = `(cd $tmpdir; pwd)`

# Any remaining arguments constitute the list of benchmarks to run
shift
if ($#argv) then
  set bmarks = ($*)
else 
  # Do them in order
  set bmarks = (pointwise conv_1_2 conv_2_1 conv_3_1 conv_bw onebit_bool)
endif

set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h
cd $scriptpath

# Script is maybe in $gen/bitstream/bsbuilder/testdir
set gen = `(cd ../../..; pwd)`
set v =  $gen/verilator/generator_z_tb
set top = $gen/hardware/generator_z/top

# database for delay values, extracted below
#   - make build/pointwise.correct.txt   DELAY=0,0   
#   - make build/conv_1_2.correct.txt    DELAY=1,0   
#   - make build/conv_2_1.correct.txt    DELAY=10,0  
#   - make build/conv_3_1.correct.txt    DELAY=20,0  
#   - make build/conv_bw.correct.txt     DELAY=130,0 
#   - make build/onebit_bool.correct.txt DELAY=0,0 

if (-e $tmpdir/test_results.log) rm $tmpdir/test_results.log

# Build cgra ONCE
set gen_switch = '-gen'

foreach b ($bmarks)
  echo "------------------------------------------------------------------------"
  echo "TESTING $b"

  set bsa   = $tmpdir/$b.bsa
  set input = $scriptpath/examples/${b}_input.raw
  set delay = `grep ${b}.correct $0:t | sed 's/.*DELAY=\(.*\)/\1/' || echo 0,0`

  # Note this output name is 'magic' and directs run.csh to do things :(
  # Maybe (FIXME)
  set out = $tmpdir/${b}_CGRA_out.raw

  set trace_switch = ''
  if ($?TRACE) then
    echo TRACETRACE
    set trace_switch = "-trace $b.vcd"
  endif

  set out1 = $tmpdir/${b}_CGRA_out1.raw
  set out1sw = ""
  if ($b == onebit_bool) then
    # set out1sw = "-out1 s1t0 $out1"
    set out1sw = "-out1 $out1"
  endif
  
  setenv SERPENT_HACK
  (\
   cd $v; \
   ./$RUN $build_switch $trace_switch $gen_switch $build_switch\
       -nogen \
       -config $bsa -input $input -output $out $out1sw -delay $delay \
  ) || exit 13

  # gen/build ONCE ONLY (except when using tbg :(
  set gen_switch   = '-nogen'
  if ($RUN == "run.csh") set build_switch = '-nobuild'


  echo "FINAL COMPARE FOR SUMMARY"
  if ($b == onebit_bool) set out = $out1
  ./compare_images.csh $b $out examples/${b}_halide_out.raw\
  | tee -a $tmpdir/test_results.log

  grep FAIL $tmpdir/test_results.log && exit 13

end

grep RESULT $tmpdir/test_results.log | sed 's/^/Summary: /'

# Clean up
# No! Not my job!
# /bin/rm -rf $tmpdir
