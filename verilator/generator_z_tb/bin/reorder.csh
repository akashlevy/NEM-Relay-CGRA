#!/bin/csh -f

unset HELP
if ("$1" == "--help") set HELP
if ($#argv == 0) set HELP
# if ("$1" == "--help") then
if ($?HELP) then
  echo "Example:"
  echo "  $0 r5_after/onebit_bool.bsa > r5_after/onebit_bool_reordered.bsa"
  exit
endif

set tmpdir = `mktemp -d /tmp/reorder.XXX`
  grep -v '#' $1 | egrep . > $tmpdir/reorder.0
  cat $tmpdir/reorder.0 | egrep -v '^..00' > $tmpdir/reorder.1
  cat $tmpdir/reorder.0 | egrep    '^..00' > $tmpdir/reorder.2
  cat $tmpdir/reorder.1 $tmpdir/reorder.2
/bin/rm -rf $tmpdir

