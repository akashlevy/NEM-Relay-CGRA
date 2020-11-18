#!/bin/csh -f


if ("$1" == "--help") then
cat << eof
  Usage examples:
        $0 log1 -init TEST SUMMARY
        $0 log1 BEGIN \`date\`
        $0 log1 -print
eof
  exit
endif

# This should totally work right?
set f = /tmp/${USER}_$1
shift

if ("$1" == '-init') then
  if (-e $f) rm $f
  shift
endif

if ("$1" == '-print') then
  cat $f
endif

echo $* >> $f
