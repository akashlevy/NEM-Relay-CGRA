#!/bin/csh -f

goto MAIN
USAGE:
  echo ""
  echo "Usage:"
  echo "  1. Cut the desired bsa section out of the travis log"
  echo "  2. Paste it into a file e.g. '/tmp/tmp909.raw'"
  echo "  3. $0 -i /tmp/tmp909.raw -o pw909"
  echo "  4. Creates 'pw909{bs,bsa}' which must not already exist"
  exit

MAIN:

# Command line should look like this:
#  $0 -i /tmp/tmp909.raw -o pw909

if ("$#argv" != 4) goto USAGE


if ("$1" != "-i") goto USAGE
if ("$3" != "-o") goto USAGE

set raw = $2
if (! -e $raw) then
  echo "Cannot find input file '$raw'"; goto USAGE
endif

set bs  = $4.bs
set bsa = $4.bsa
set found = ()
if (-e $bs)  set found = ($bs)
if (-e $bsa) set found = ($found $bsa)
if ("$found" != "") then
  echo ""
  echo "ERROR Do not want to overwrite existing file(s) '$found'"
  goto USAGE
endif

# When you paste from the travis log it looks like this:
# 
#    cat build/conv_2_1_annotated
#    
#    00070000 00000000
#    
#    # data[(21, 20)] : @ tile (0, 0) connect wire 0 (in_BUS16_S0_T0) to out_BUS16_S2_T0
#    
#    00020000 00000005
# 
#    # data[(3, 0)] : @ tile (0, 0) connect wire 5 (out_BUS16_S2_T0) to op_a_in
#    ...

cat $raw | grep . | egrep -v '^cat' > $bsa
grep -v \# $bsa > $bs

echo "Extracted files '$bs', '$bsa'"
echo ""
head -3 $bs $bsa


##############################################################################
# # Temporary I hope:
# # Sometimes the bsa file has erroneous wire names e.g.
# # 'out_0_BUS1_2_0' instead of 'out_0_BUS1_S2_T0'
# 
# unset busted
# egrep '(in|out)_[01]_BUS(1|16)_[0-9]_[0-9]' $raw > /dev/null && set busted
# if ($?busted) echo "yep its busted"
# 
# 
# set tmp = /tmp/extract$$
# sed -r 's/(in|out)_([01])_(BUS1|BUS16)_([0-9])_([0-9])/\1_\2_\3_S\4_T\5/g' $raw \
#   > $tmp
# 
# unset VERBOSE
# if ($?VERBOSE) diff $raw $tmp
# 
# cat $tmp | grep . | egrep -v '^cat' > $bsa



