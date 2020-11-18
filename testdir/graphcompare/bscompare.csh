#!/bin/csh -f

unset yakky

# Usage: $0 gold.bsa prog.bsa cgra_info.txt

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



set tmpdir = /tmp/tmp.bscompare.$$
mkdir $tmpdir

# Script is here maybe: CGRAGenerator/testdir/graphcompare/bscompare.csh
# bsview is here maybe: CGRAGenerator/bitstream/visualizer

set scripthome = $0:h
if ("$scripthome" == "$0") set scripthome = .
set bs = $scripthome/../../bitstream
set viz = $bs/visualizer

set cgra_info = $3
if ("$cgra_info" == "") then
  # set cgra_info = $bs/examples/cgra_configs/cgra_info_8x8.txt
  set cgra_info = $scripthome/examples/cgra_info.txt
  echo ""
  echo "WARNING No cgra_info file specified; "
  echo "WARNING will use default $cgra_info"
  echo ""
endif

set r1 = $f1:t; set r1 = $r1:r
set r2 = $f2:t; set r2 = $r2:r

########################################################################

# (For now?) ignore this warning(s):
# /usr/lib/python2.7/dist-packages/gtk-2.0/gtk/__init__.py:57: GtkWarning: could not open display
# warnings.warn(str(e), _gtk.Warning)
# Using config file 'CGRAGenerator/testdir/graphcompare/examples/cgra_info.txt'

if ($?yakky) echo Building $tmpdir/$r1.dot...
$viz/bsview.py -cgra_info $cgra_info $f1 -dot $tmpdir/$r1.dot\
  |& grep . | grep -v GtkWarning | grep -v gtk.Warning\
  | grep -v 'Using config'

if ($?yakky) echo Building $tmpdir/$r2.dot...
$viz/bsview.py -cgra_info $cgra_info $f2 -dot $tmpdir/$r2.dot\
  |& grep . | grep -v GtkWarning | grep -v gtk.Warning\
  | grep -v 'Using config'

########################################################################
if ($?yakky) echo Building $tmpdir/$r1.nodelist...
$scripthome/dotsummary.py $tmpdir/$r1.dot > $tmpdir/$r1.nodelist

if ($?yakky) echo Building $tmpdir/$r2.nodelist...
$scripthome/dotsummary.py $tmpdir/$r2.dot > $tmpdir/$r2.nodelist

########################################################################
if ($?yakky) echo
if ($?yakky) echo 'DIFF (should be null)'
if ($?yakky) echo

unset FAIL
diff $tmpdir/{$r1,$r2}.nodelist || set FAIL

if ($?FAIL) then
  echo "ERROR $f1:t and $f2:t differ: FAIL"
  exit -1
else
  if ($?yakky) echo "SUCCESS $f1 and $f2 are equal"
endif



