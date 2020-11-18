#!/bin/csh -f

unset BS
unset BSA

set sfx = $1:e
if ("$sfx" == "bsa") set BSA
if ("$sfx" == "bs")  set BS


# 1. Change fifo_depth from 10 back to 7
#    00080011 00000054
#    # data[(18, 16)] : almost_full_count = 0
#    # data[(1, 0)] : mode = linebuffer
#    # data[(2, 2)] : tile_en = 1
#    # data[(19, 19)] : chain_enable = 0
#    # data[(15, 3)] : fifo_depth = 10

# Usage: $0 old.bsa new.bsa
# Or:    $0 old.bs  new.bs

set oldbsa = $1
set newbsa = /tmp/newbsa.$$

cp $oldbsa $newbsa.1
cp $oldbsa $newbsa.2
cp $oldbsa $newbsa.3
cp $oldbsa $newbsa.4

echo "Looking for fifo_depth 10"
set n10 = `grep 00000054 $oldbsa | wc -l`
if ($n10 > 0) then
  echo "Found $n10 instance(s) of fifo_depth=10"
  echo "Changing fifo_depth from 10 back to 7"
  sed 's/00000054/0000003C/'              $oldbsa > $newbsa.1
  cp $newbsa.1 $newbsa.2
  if ($?BSA) then
    sed 's/fifo_depth = 10/fifo_depth = 7/' $newbsa.1 > $newbsa.2
  endif
endif
echo

# 0008002D 00000034
echo "Looking for fifo_depth 6"
set n6 = `grep 00000034 $oldbsa | wc -l`
if ($n6 > 0) then
  echo "Found $n6 instance(s) of fifo_depth=6"
  echo "Changing fifo_depth from 6 to 7"
  sed 's/00000034/0000003C/'              $oldbsa > $newbsa.1
  cp $newbsa.1 $newbsa.2
  if ($?BSA) then
    sed 's/fifo_depth = 6/fifo_depth = 7/' $newbsa.1 > $newbsa.2
  endif
endif

# echo Found `grep 00000054 $oldbsa | wc -l` instances of fifo_depth=10
# echo


# if ($?BSA) then
#   sed 's/fifo_depth = 10/fifo_depth = 7/' $newbsa.1 > $newbsa.2
# else
#   cat $newbsa.1 > $newbsa.2
# endif

diff $oldbsa $newbsa.2 | grep '<' | awk '{print "    " $0}'
echo
diff $oldbsa $newbsa.2 | grep '>' | awk '{print "    " $0}'
echo

cp $newbsa.2 $newbsa.3
cp $newbsa.3 $newbsa.4


goto NOREG

##############################################################################
echo ""
echo "------------------------------------------------------------------------"
echo "Adding a register to the FIFO output"
echo

# Assume that there is only one functional adder per mem output.
# Assume mem path goes through input B of the adder
# Make input B registered

# 1. Find the adder.  Hint: it's the one reading both its inputs from wires e.g.
#    FF00000C 0000A000
#    # data[15]=1 : 0=>read from reg `a`, 1=>read from wire `a`
#    # data[13]=1 : 0=>read from reg `b`, 1=>read from wire `b`
#    # data[(4, 0)] : op = add

# Print out the adder info found
set lno = `cat -n $newbsa.2 | egrep 'FF00.... 0000A000' | awk '{print $1}'`


if ($?BSA) then
  @ lno_end = $lno + 3
  sed -n "${lno},${lno_end}p" $newbsa.2
  echo
endif

# Change adder to read B input from reg instead of wire
sed 's/0000A000/00009000/' $newbsa.2 > $newbsa.3
cp $newbsa.3 $newbsa.4


if ($?BSA) then
  @ lno = $lno + 2
  sed "${lno}s/read from wire/read from reg/" $newbsa.3 > $newbsa.4
else
  cat $newbsa.3 > $newbsa.4
endif

diff $newbsa.2 $newbsa.4 | grep '<' | awk '{print "    " $0}'
echo
diff $newbsa.2 $newbsa.4 | grep '>' | awk '{print "    " $0}'
echo


NOREG:
##############################################################################
echo ""
echo "------------------------------------------------------------------------"
echo "Writing output to $2"
mv $newbsa.4 $2

echo "Removing intermediate files $newbsa.*"
rm $newbsa.*

if ($?BSA) then
  echo "You'll probably want to do this now:"
  echo
  echo "  grep -v # $2 | grep -v cat > $2:r.bs"
endif





