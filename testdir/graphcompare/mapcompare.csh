#!/bin/csh -f

unset yakky

# Usage: $0 gold_mapped.json prog_mapped.json

set f1 = $1
set f2 = $2

if (! -e $f1) then
  echo "No such file '$f1'"
  exit
endif

if (! -e $f2) then
  echo "No such file '$f2'"
  exit
endif

set tmpdir = /tmp/tmp.mapcompare.$$
mkdir $tmpdir

# Script is here maybe:   CGRAGenerator/testdir/graphcompare/mapcompare.csh
# json2dot is here maybe: CGRAGenerator/testdir/graphcompare/json2dot.py

set scripthome = $0:h
if ("$scripthome" == "$0") set scripthome = .

# set bs = $scripthome/../../bitstream
# set viz = $bs/visualizer

set j2d = $scripthome/json2dot.py

set r1 = $f1:t; set r1 = $r1:r
set r2 = $f2:t; set r2 = $r2:r

########################################################################

if ($?yakky) echo Building $tmpdir/$r1.dot...
$j2d < $f1 > $tmpdir/$r1.dot

if ($?yakky) echo Building $tmpdir/$r2.dot...
$j2d < $f2 > $tmpdir/$r2.dot


########################################################################
if ($?yakky) echo Building $tmpdir/$r1.dotsummary...
$scripthome/dotsummary.py $tmpdir/$r1.dot > $tmpdir/$r1.dotsummary

if ($?yakky) echo Building $tmpdir/$r2.dotsummary...
$scripthome/dotsummary.py $tmpdir/$r2.dot > $tmpdir/$r2.dotsummary

########################################################################
if ($?yakky) echo
if ($?yakky) echo 'DIFF (should be null)'
if ($?yakky) echo

unset FAIL
diff $tmpdir/{$r1,$r2}.dotsummary || set FAIL

if ($?FAIL) then
  echo "ERROR $f1:t and $f2:t differ: FAIL"
  exit -1
else
  if ($?yakky) echo "SUCCESS $f1 and $f2 are (topologically) equal"
endif



