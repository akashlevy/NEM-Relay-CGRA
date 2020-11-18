#!/bin/csh -f

unset yakky
unset yak9

# When input pixel has to go out to multiple nodes, the PNR guys use
# the following hack:
#
# BEFORE: input -> (node1,node2,node3)
# AFTER:  add(input,0) -> (node1,node2,node3)
#
# In the dot-file the AFTER looks like this:
#
#     "self.in"   -> "T19_ADD";  
#     "T19_const0"-> "T19_ADD";  
#     "T19_ADD"   -> "T20_MUL";  
#     "T19_ADD"   -> "T26_latch_s1t4";
#     "T19_ADD"   -> "T27_regA"; 
#
# This file's goal is to find that and change it to
#
#     # "self.in"   -> "T19_ADD";  
#     # "T19_const0"-> "T19_ADD";  
#     "self.in"   -> "T20_MUL";  
#     "self.in"   -> "T26_latch_s1t4";
#     "self.in"   -> "T27_regA"; 

goto MAIN
USAGE:
  echo ""
  echo "Finds and reverses PNR input hack, see source for deets."
  echo "Example:"
  echo "   $0 conv_bw_annotated.dot"
  exit


MAIN:        
if (! -e "$1") goto USAGE
set f = $1

# First verify that the hack exists;
unset need_hack
egrep 'self.in.*_ADD' $f > /dev/null && set need_hack
if (! $?need_hack) then
  if ($?yakky) echo "No need for hack."
  cat $f
  exit 0
endif

if ($?yak9) echo "Yes indeedy hack is needy"

# Find the ADD to be eliminated, e.g. add="T19_ADD"
set add = `grep self.in $f | sed 's/.*self.in"[^"]*"\([^"]*\).*/\1/'`
if ($?yak9) echo "Found redundant nexus '$add'"

# First a quick paranoia check; add must have operand "const0"
# E.g. "T19_const0"-> "T19_ADD";
unset add0
egrep "const0.*${add}" $f > /dev/null && set add0
if (! $?add0) then
  echo "ABORT add looks wonky maybe hack not needed after all"
  exit 0
endif


# Okay do the transform.  Ping and pong I guess
set ping = /tmp/tmp.fix_input_hack.$$.ping
set pong = /tmp/tmp.fix_input_hack.$$.pong

cp $f $ping

if ($?yak9) echo PHASE 1
egrep -v 'self.in.*_ADD' $ping > $pong
mv $pong $ping; if ($?yak9) diff $f $ping | egrep '^[<>]' | sort

if ($?yak9) echo PHASE 2
egrep -v "const0.*${add}" $ping > $pong
mv $pong $ping; if ($?yak9) diff $f $ping | egrep '^[<>]' | sort

if ($?yak9) echo PHASE 3
sed "/^[^#]*T/s/${add}/self.in/" $ping > $pong
mv $pong $ping; if ($?yak9) diff $f $ping | egrep '^[<>]' | sort -g

if ($?yakky) then
  echo BEFORE:
  diff $f $ping | egrep '^<' | grep self
  diff $f $ping | egrep '^<' | grep const
  diff $f $ping | egrep '^<' | egrep -v 'self|const'
  echo AFTER:
  diff $f $ping | egrep '^>'
endif

cat $ping
