#!/bin/csh -f

# Not everyone has access to readlink -f
unset no_readlink
readlink -f >& /dev/null || set no_readlink
if ($?no_readlink) then
  set scriptpath = "$0"
  set scriptpath = $scriptpath:h
  if ("$scriptpath" == "$0") then
    set scriptpath = `pwd`
    set CGROOT = `cd $scriptpath:h; pwd`
  else
    set CGROOT = `cd $scriptpath/..; pwd`
  endif
else
  # set scriptpath = "$0" # No good if symlinks exist maybe
  set scriptpath = `readlink -f $0`
  set scriptpath = $scriptpath:h
endif

# I think I live in $topdir/bin/
set topdir = $scriptpath/..
set topdir = `cd $topdir; pwd`
set top       = $topdir/genesis_verif/top.v
set cgra_core = $topdir/genesis_verif/cgra_core.v
if (! -e $top) then
  echo "Cannot find TOP '$top'"
  exit -1
endif

# set topdir = $top:h
# set work = $topdir/../genesis_work

echo "${0:t}: built $top"
echo "--------------------------------------------------------------------"
echo "Here is what I built (it's supposed to look like an array of tiles)."

# memtile height, e.g.
#   // Parameter mem_tile_height    = 1
#   // mem_tile_height (_GENESIS2_EXTERNAL_XML_PRIORITY_) = 1
grep mem_tile_height $cgra_core

# Grid e.g.
# //CGRA      00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11
# //CGRA   00 .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..
# //CGRA   01 .. p  p  p  m  p  p  p  m  p  p  p  m  p  p  p  m  ..
# //CGRA   02 .. p  p  p  m  p  p  p  m  p  p  p  m  p  p  p  m  ..
# //CGRA   03 .. p  p  p  m  p  p  p  m  p  p  p  m  p  p  p  m  ..
# ...
echo ""
egrep '^//CGRA' $cgra_core
echo ""

echo "--------------------------------------------------------------------"
