#!/bin/csh -f

# FIXME need better arg processing

if ($#argv == 0) then
  echo 'Where should I put the bsa output files?'
  echo "Example: $0:t /tmp/build42/"
  exit 13
endif

if ("$1" == "--help") then
  echo 'make_bitstreams.csh tmpdir'
  echo 'make_bitstreams.csh tmpdir pointwise'
  echo 'make_bitstreams.csh tmpdir pointwise conv_1_2 conv_2_1 conv_3_1 conv_bw onebit_bool'
  exit
endif

if ("$1" == "--shortmem") then
  shift
endif

if (! -d $1) then
  echo 'Where should I put the bsa output files?'
  echo "Example: $0:t /tmp/build42/"
  exit 13
endif
set tmp = $1

# Any remaining arguments constitute the list of benchmarks to run
shift
if ($#argv) then
  set bmarks = ($*)
else 
  # Do benchmarks in order
  set bmarks = (conv_1_2)
  set bmarks = (pointwise conv_1_2 conv_2_1 conv_3_1 conv_bw onebit_bool)
endif

set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h
cd $scriptpath

# Script is maybe in $gen/bitstream/bsbuilder/testdir
set gen = `(cd ../../..; pwd)`
set v   = $gen/verilator/generator_z_tb
alias json2dot $gen/testdir/graphcompare/json2dot.py


echo "set tmp = $tmp"
echo 'set gen = CGRAGenerator'
echo 'cd $gen/bitstream/bsbuilder'
echo 'alias json2dot $gen/testdir/graphcompare/json2dot.py'
echo ''

unset someone_failed
set t = '$tmp'
foreach b ($bmarks)
  set result = 'PASSED'
  echo "------------------------------------------------------------------------"
  echo "PROCESSING $b"

  set map_json = examples/${b}_mapped.json
  set map_dot  =   ${b}_mapped.dot
  set bsb      =   ${b}.bsb
  set bsa      =   ${b}.bsa

  echo "  json2dot < $map_json > $t/$map_dot"
  json2dot < $map_json > $tmp/$map_dot || exit 13

  echo "cmp $tmp/$map_dot examples/$map_dot"
  cmp $tmp/$map_dot examples/$map_dot || set result = 'FAILED'
  echo ""

  set io_config = $v/io/2in2out.json
  echo "  ../serpent.py -io $io_config \"
  echo "    $t/$map_dot -o $t/$bsb > $t/$b.log.serpent"
  ../serpent.py -io $io_config \
    $tmp/$map_dot -o $tmp/$bsb > $tmp/$b.log.serpent \
    || exit 13

  echo "  cmp $tmp/$bsb examples/$bsb"
  cmp $tmp/$bsb examples/$bsb || set result = 'FAILED'
  echo ""

  if ($?VERBOSE) then
    echo ''
    echo '========================================================================'
    echo "BSB FILE $bsb"
    echo '========================================================================'
    cat $bsb
    echo ''
    echo ''
    echo ''
  endif

  unset BSBFAIL
  echo "  ../bsbuilder.py < $tmp/$bsb > $tmp/$bsa"
  # ../bsbuilder.py -v < $tmp/$bsb | sed -n '/FINAL PASS/,$p' | sed '1,2d' > $tmp/$bsa || exit 13
  ../bsbuilder.py < $tmp/$bsb > $tmp/$bsa || set BSBFAIL
  if ($?BSBFAIL) then
    echo "uh oh looks like bsbuilder FAILED"
    tail -n 40 $tmp/$bsa
    exit 13
  endif


  echo "  diff examples/$bsa $tmp/$bsa | less"
  echo "  cp $tmp/$bsa examples/$bsa"
  ls -l examples/$bsa $tmp/$bsa
  cmp $tmp/$bsa examples/$bsa || set result = 'FAILED'


  if ($?VERBOSE) then
    echo ''
    echo '========================================================================'
    echo "BSA FILE $bsa"
    echo '========================================================================'
    cat $bsa
    echo ''
  endif

  echo "TEST $b $result"
  echo ""

  # if ($result == "FAILED") exit 13
  if ($result == "FAILED") then
    echo "WARNING comparison failed; will attempt to recover"
    set someone_failed
  endif

end

if ($?someone_failed) then
  echo "Hey!  In case you didn't notice..."
  echo "One or more of the above tests FAILED"
  echo ""
else
  echo "Looks like all tests PASSED"
  echo ""
endif

# Clean up
# No! Not my job!
# /bin/rm -rf $tmp
