#!/bin/csh -f

# Find out where we live
# set scriptpath = "$0" # No good if symlinks exist maybe
set scriptpath = `readlink -f $0`
set scriptpath = $scriptpath:h

# Script lives in $CGROOT/bin/$0
# Therefore scriptpath is "$CGROOT/bin"
# Therefore CGROOT is $scriptpath:h
set gen = $scriptpath:h
set top = $gen/hardware/generator_z/top
set xml = $top/top.xml

cat $xml \
  | sed 's/ /./g' \
  | sed 's/[<>]/ /g' \
  | egrep 'InstanceName|eterItem|Doc|Name|Val'\
  | awk -f $gen/bin/parse_xml.awk \
  | sort | uniq \
  | sed 's/[.]/ /g'\
  | awk -F / '\
BEGIN { prev = $1 } \
{\
  if ($1 != prev) { print "" } \
  print\
} \
{prev = $1}'
