#!/bin/csh -f

set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h
cd $scriptpath

# This test script is maybe in $gen/bitstream/bsbuilder/testdir
cd ..
set gen = `(cd ../..; pwd)`
set cgra = $gen/hardware/generator_z/top/cgra_info.txt

# Do benchmarks in order
set bmarks = (pointwise conv_1_2 conv_2_1 conv_3_1 conv_bw)

set test_suite = PASSED

foreach b ($bmarks)
  set result = 'PASSED'
  echo "PROCESSING $b"

  set map_json = testdir/examples/${b}_mapped.json
  echo "  ./serpent.csh $map_json -cgra_info $cgra -o /tmp/$b-$$.bsa"
  ./serpent.csh $map_json -cgra_info $cgra -o /tmp/$b-$$.bsa

  echo "  diff testdir/examples/$b.bsa /tmp/$b-$$.bsa"
  diff testdir/examples/$b.bsa /tmp/$b-$$.bsa || set result = 'FAILED'

  if ("$result" == "FAILED") set test_suite = 'FAILED'

  echo "TEST $b $result"
  echo ""
end

echo "------------------------------------------------------------------------"
echo "TEST SUITE $test_suite"

