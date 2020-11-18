#!/bin/csh

# Usage:
#  $0                      - Runs default original testbench w/trace
#  $0 <testbench>          - Run indicated testbench, no "-trace" flag
#  $0 <testbench> --trace  - Run indicated testbench, use "-trace" flag

# cleanup
if (-e obj_dir)     rm -rf obj_dir
if (-e counter.vcd) rm -f  counter.vcd

if ("$1" == "-clean") exit 0

# Verilator should already be in path if installed via apt-get
# setenv VERILATOR_ROOT /var/local/verilator-3.900
# set path = (/var/local/verilator-3.900/bin $path)

# # Here's my first attempt; it's just gonna be, like, "hello world" and stuff.
# set testbench = counter_tb_hello.cpp

if ($#argv == 0) then
  # Original testbench counter_tb produces waveform but no other output :(
  set testbench = "counter_tb.cpp --trace"
  echo "Using default (original) testbench '$testbench'"
else
  set testbench = "$*"
  echo "Using testbench '$testbench'"
endif

set t = ($testbench); set tfile = $t[1]
echo $tfile

if (! -e "$tfile") then
  echo ""
  echo "ERROR: Testbench '$tfile' not found."
  echo ""
  echo "Maybe try one of these:"
  foreach f (*tb*.cpp)
    echo "  $0 $f"
  end
  exit -1
endif

# run Verilator to translate Verilog into C++, include C++ testbench
# verilator -Wall --cc --trace counter.v --exe counter_tb.cpp || exit -1
# verilator -Wall --cc --trace counter.v --exe $testbench || exit -1

# verilator -Wall --cc $trace counter.v --exe $testbench || exit -1
echo verilator -Wall --cc counter.v --exe $testbench
verilator -Wall --cc counter.v --exe $testbench || exit -1

# build C++ project
make -j -C obj_dir/ -f Vcounter.mk Vcounter

echo "now run executable simulation"
echo "obj_dir/Vcounter"
obj_dir/Vcounter


# # view waveforms
# gtkwave counter.vcd counter.sav &
# 
# 
# The script will automatically launch GTKWave and open the waveform.
