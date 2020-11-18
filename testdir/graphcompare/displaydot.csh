#!/bin/csh -f

set tmp = /tmp/displaydot$$

if (! -e $1) then
  echo "CAnnot find file '$1'"
  exit -1
endif

set echo
dot $1 -Tpdf > $tmp.pdf
# xpdf $tmp
# pdfjam --scale 0.8 $tmp.pdf -o $tmp.jam
pdfjam --scale 0.8 --landscape $tmp.pdf -o $tmp.jam
echo lp -d gala -h gala $tmp.jam
xpdf $tmp.jam

