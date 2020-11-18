#!/bin/csh -f

# ./bin/build_simulator_tbg.csh $VSWITCH $config $input $output [$tracefile]

set VSWITCH   = $1; shift
set config    = $1; shift
set io_config = $1; shift
set input     = $1; shift
set output    = $1; shift
set input_size = $1; shift
set output_size = $1; shift

# Note tracefile is optional
unset tracefile
set trace_switch     = ''
set tracefile_switch = ''
if ($#argv) then
  set trace_switch = '--trace'

  # tracefile path will be relative to build directory :(
  # so use absolute path (readlink -f)
  set tracefile = $1
  set tracefile = `readlink -f $tracefile`
  set tracefile_switch = "--trace-file-name $tracefile"
endif


# E.g. testname = "bw" or "pw2_16x16"
set testname = $config:t; set testname = $testname:r

if (! -e build) mkdir build
# set tmpdir = `mktemp -d /tmp/tbg.XXX`; set build = $tmpdir

if ("$VSWITCH" != '-q') then
  echo ""
  echo "${0:t}: Generating the harness"
endif

# set python = python3.6


echo ""
echo "Python must be 3.6 or above"
python  --version |& awk '{print "  python  version " $2}'
python3 --version |& awk '{print "  python3 version " $2}'
echo ""

set TBG_DIR=`pwd`/../../../TestBenchGenerator
if (! -d $TBG_DIR) then
  echo ""
  echo "ERROR I expected to find TestBenchGenerator here:"
  echo "  $TBG_DIR"
  echo ""
  echo "Maybe you started ${0:t} from the wrong directory?"
  echo "Or you may need to do something like this:"
  echo "  % git clone https://github.com/StanfordAHA/TestBenchGenerator.git $TBG_DIR"
  echo ""
  echo "Or if you are on kiwi you can probably get away with:"
  set d = `cd ../../..; pwd`
  echo "  % cd $d"
  echo "  % ln -s /nobackup/steveri/github/TestBenchGenerator"
  echo ""
  exit 13
endif

set TestBenchGenerator = `cd $TBG_DIR; pwd`
set echo
python3 $TestBenchGenerator/generate_harness.py \
	--pnr-io-collateral $io_config \
	--bitstream $config \
	--max-clock-cycles 5000000                \
	--output-file-name build/harness.cpp \
    --input-chunk-size $input_size \
    --output-chunk-size $output_size \
    $trace_switch $tracefile_switch
unset echo

ls -l build/harness.cpp

########################################################################
# CGRAGenerator
set gen        = ../..
set VERILATOR_TOP = $gen/verilator/generator_z_tb
set RTL_DIR       = $gen/hardware/generator_z/top/genesis_verif/
cp $VERILATOR_TOP/sram_stub.v $RTL_DIR/sram_512w_16b.v  # SRAM hack


# oh no oh no oh no don't do this
# # Note TBG will not build simulator if one already exists
# # Note TBG detects simulator by presence/absence of mk files (?)
# (ls build/*.mk >& /dev/null) || goto NEXT
# foreach f (build/*.mk)
#   mv $f $f.old
# end
# NEXT:


# Verilator wrapper that only builds if the output object is not present
# (override with --force-rebuild)
echo "  2. Building simulator source files..."
echo "     verilate.py \"
echo "        --harness harness.cpp          \"
echo "        --verilog-directory $RTL_DIR   \"
echo "        --output-directory build       \"
echo "        --top-module-name top          \"
echo "        $trace_switch"
echo ""
python3 $TestBenchGenerator/verilate.py \
        --harness harness.cpp        \
        --verilog-directory $RTL_DIR \
        --output-directory build     \
        --top-module-name top        \
        $trace_switch

echo ''
echo make -C build -j -f Vtop.mk Vtop
echo ''
# make --silent -C build -j -f Vtop.mk Vtop
make -C build -j -f Vtop.mk Vtop

