#!/bin/csh -f

unset yakky

goto MAIN
USAGE:
  echo ""
  echo "Usage:"
  echo "  $0 <-v> file1 file2 <cgra_info_file>"
  echo ""
  echo "Where:"
  echo "  (file1, file2) can be json, dot or bsa"
  echo "  <-v> optional verbose mode, else silent"
  echo "  <cgra_info_file> recommended for comparing bsa/annotated bitstream file(s)"
  echo ""
  echo "Examples:"
  echo "  $0 bw_annotated gold/bw_annotated ../cgra_info.txt"
  echo "  $0 bw_design_top.json bw_annotated ../cgra_info.txt"
  echo "  $0 bw_design_top.json gold/bw_design_top.json"
  echo ""
  exit


MAIN:
# -v => 'verbose'
if ("$1" == "-v") then
  set yakky
  shift
endif

set f1 = $1
set f2 = $2

if (! -e $f1) then
  echo; echo "ERROR No such file '$f1'"; goto USAGE
endif

if (! -e $f2) then
  echo; echo "ERROR No such file '$f2'"; goto USAGE
endif

# Script is here maybe: CGRAGenerator/testdir/graphcompare/bscompare.csh
# bsview is here maybe: CGRAGenerator/bitstream/visualizer

set scripthome = $0:h
if ("$scripthome" == "$0") set scripthome = .

set cgra_info = $3

# I think "dotsummary" is responsible for this now...
# if ("$cgra_info" == "") then
#   set cgra_info = $scripthome/examples/cgra_info.txt
#   echo ""
#   echo "WARNING No cgra_info file specified; "
#   echo "WARNING will use default $cgra_info"
#   echo ""
# endif

# set r1 = $f1:t; set r1 = $r1
# set r2 = $f2:t; set r2 = $r2

set r1 = `echo $f1 | sed 's|/|_|g'`
set r2 = `echo $f2 | sed 's|/|_|g'`

echo $r1
echo $r2

set tmpdir = /tmp/tmp.bscompare.$$
mkdir $tmpdir

if ($?yakky) echo Building $tmpdir/$r1.dot...
$scripthome/convert2dot.csh $f1 $tmpdir/$r1.dot $cgra_info

if ($?yakky) echo Building $tmpdir/$r2.dot...
$scripthome/convert2dot.csh $f2 $tmpdir/$r2.dot $cgra_info

if ($?yakky) wc -l $tmpdir/{$r1,$r2}.dot


########################################################################
if ($?yakky) echo Building $tmpdir/$r1.nodelist...
$scripthome/dotsummary.py < $tmpdir/$r1.dot > $tmpdir/$r1.nodelist

if ($?yakky) echo Building $tmpdir/$r2.nodelist...
$scripthome/dotsummary.py < $tmpdir/$r2.dot > $tmpdir/$r2.nodelist

########################################################################
if ($?yakky) echo
if ($?yakky) echo 'DIFF (should be null)'
if ($?yakky) echo

unset FAIL
if ($?yakky) then
  wc -l $tmpdir/{$r1,$r2}.nodelist
  echo "diff $tmpdir/{$r1,$r2}.nodelist"
endif
diff $tmpdir/{$r1,$r2}.nodelist || set FAIL

if ($?FAIL) then
  echo "ERROR $f1:t and $f2:t differ: FAIL"
  exit -1
else
  if ($?yakky) echo "SUCCESS $f1 and $f2 are equal"
endif



