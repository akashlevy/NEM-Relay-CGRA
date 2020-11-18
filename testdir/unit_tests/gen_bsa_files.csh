#!/bin/csh -f

set VERBOSE
if ($?VERBOSE) echo $0:t':'

set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h

# echo $scriptpath

# Scriptpath should be $gen/testdir/unit_tests...right?
set gen = `cd $scriptpath/../..; pwd`
set v =  $gen/verilator/generator_z_tb

set tmpdir = /tmp/$$
mkdir $tmpdir

foreach test (`ls *.bsb`)
  set b = $test:r

  # echo -n "Found bsb file '$test'..."
  set delay = `cat $test | awk 'BEGIN {d="0,0"} /DELAY/ {d=$NF} END {print d}'`
  # echo "looks like delay should be '$delay'"

  # echo "  Building bitstream using bsbuilder..."
  echo "  "'$'"gen/bitstream/bsbuilder/bsbuilder.py $test > $test:r.bsa"\
  | awk '{printf("  %s %-14s > %s\n", $1, $2, $4)}'
  $gen/bitstream/bsbuilder/bsbuilder.py $test > $test:r.bsa || exit -1

end
