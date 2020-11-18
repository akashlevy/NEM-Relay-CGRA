#!/bin/csh -f

# Example: $0 conv_bw /tmp/gentest-Dfe/conv_bw_CGRA_out.raw examples/conv_bw_CGRA_out.raw

# Given two bmarks e.g. 
#   test=tmpdir/pointwise_CGRA_out.raw and
#   gold=examples/pointwise_halide_out.raw
# compare and verify that they match exactly

set b = $1
set test = $2
set gold = $3

echo "$test looks like this:"
set cmd = "od -t u1 $test"
echo $cmd; $cmd | head; echo ...; $cmd | tail -n 3
echo ''

echo "$gold looks like this:"
set cmd = "od -t u1 $gold"
echo $cmd; $cmd | head; echo ...; $cmd | tail -n 3
echo ''
cmp $test $gold\
  && echo "TEST RESULT $b PASSED"\
  || echo "TEST RESULT $b FAILED"\

echo '------------------------------------------------------------------------'
