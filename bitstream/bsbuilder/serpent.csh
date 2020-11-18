#!/bin/csh -f

# A wrapper for the serpent tool.

goto MAIN
USAGE:
  echo Example:
  echo $0:r pw_mapped.json -cgra_info top/cgra_info.txt -o pw_annotated
  exit

# 	echo BSB/serpent.csh\
# 		$(filter %.json,$?)                   \
# 		$(filter %.txt, $?)                   \
# 		-o build/$*_annotated

MAIN:
  set map_json = $1
  if ("$map_json:e" != 'json') goto USAGE
  if ("$2" != "-cgra_info") goto USAGE
  set cgra = $3
  if ("$4" != '-o') goto USAGE
  set bsa_out = $5

set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h

# Script is maybe in $gen/bitstream/bsbuilder
set gen = `(cd $scriptpath/../..; pwd)`
set bin = $gen/bitstream/bsbuilder
alias json2dot $gen/testdir/graphcompare/json2dot.py

set tmp = `mktemp -d /tmp/serpent-XXX`

# echo "set tmp = $tmp"
# echo 'set gen = CGRAGenerator'
# echo 'cd $gen/bitstream/bsbuilder'
# echo 'alias json2dot $gen/testdir/graphcompare/json2dot.py'
# echo ''

set b = $map_json:t
set b = $b:r
set b = `echo $b | sed 's/_mapped//'`
set map_dot = ${b}_mapped.dot
set bsb      =   ${b}.bsb


  echo "  json2dot < $map_json > $tmp/$map_dot"
  json2dot < $map_json > $tmp/$map_dot || exit -1

  echo "  serpent.py $tmp/$map_dot -o $tmp/$bsb > $tmp/$b.log.serpent"
  $bin/serpent.py $tmp/$map_dot -o $tmp/$bsb > $tmp/$b.log.serpent || exit -1

  unset VERBOSE
  if ($?VERBOSE) then
    echo ''
    echo '========================================================================'
    echo "BSB FILE $bsb"
    echo '========================================================================'
    cat $tmp/$bsb
    echo ''
    echo ''
    echo ''
  endif

  echo "  bsbuilder.py < $tmp/$bsb > $bsa_out"
  #  $bin/bsbuilder.py    < $tmp/$bsb | sed -n '/FINAL PASS/,$p' | sed '1,2d' > $bsa_out
  #  $bin/bsbuilder.py -v < $tmp/$bsb | sed -n '/FINAL PASS/,$p' | sed '1,2d' > $bsa_out || exit -1
  $bin/bsbuilder.py < $tmp/$bsb > $bsa_out || exit -1



  if ($?VERBOSE) then
    echo ''
    echo '========================================================================'
    echo "BSA FILE $bsa_out"
    echo '========================================================================'
    cat $bsa_out
    echo ''
  endif

