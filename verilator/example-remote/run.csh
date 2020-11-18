#!/bin/csh

# Can I run a local test bench using remote v-sources?

# cleanup
if (-e obj_dir)     rm -rf obj_dir
if (-e counter.vcd) rm -f  counter.vcd
if ("$1" == "-clean") exit 0

# setup
# Verilator should already be in path if installed via apt-get
# setenv VERILATOR_ROOT /var/local/verilator-3.900
# set path = (/var/local/verilator-3.900/bin $path)
# which verilator

# set testbench = tb_remote.cpp

set testbench = $1
if (! -e "$testbench") then
  echo ""
  echo "ERROR: Testbench '$testbench' not found."
  echo ""
  echo "Maybe try one of these:"
  foreach f (*tb*.cpp)
    echo "  $0 $f"
  end
  exit -1
endif

set vdir = /nobackup/steveri/github/CGRAGenerator/verilator/example/
set vfiles = (counter.v)
set top = counter  

echo verilator -Wall --cc --exe $testbench -y $vdir $vfiles
verilator -Wall --cc --exe $testbench -y $vdir $vfiles || exit -1

# build C++ project
# make -j -C obj_dir/ -f Vcounter.mk Vcounter
make -j -C obj_dir/ -f V${top}.mk V${top}

echo "now run executable simulation"
# echo "obj_dir/Vcounter"
$ obj_dir/Vcounter
echo "obj_dir/V${top}"
obj_dir/V${top}
