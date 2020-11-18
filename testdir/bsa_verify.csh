#!/bin/csh -f

if ($#argv < 2) goto USAGE
goto MAIN

USAGE:
  echo ""
  echo "Usage:"
  echo "  $0:t <pnr_annotated_bitstream> [-cgra cgra_info.txt]"
  echo ""
  echo "Description:"
  echo "  Extracts bitstream tmp.bs from <pnr_annotated_bitstream> 'bsa'"
  echo "  Independently decodes tmp.bs to make tmp.bsd"
  echo "  Checks tmp.bsd for equivalence against orig file 'bsa'"
  echo ""
  echo "Example:"
  echo "  $0:t pointwise_annotated"
  exit

MAIN:

# # mydir myscript scriptdir
# set scriptpath = `readlink -f $0`
# set scriptpath = $scriptpath:h
# 
# set CGROOT = `cd $scriptpath/..; pwd`
# # echo "I think CGRAGenerator is here: $CGROOT"; exit

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


unset VERBOSE;

while ($#argv)
  if ($?VERBOSE) echo "  Found switch '$1'"
  switch ("$1")
    case '-q':
      unset VERBOSE; breaksw
    case '-v':
      set VERBOSE; breaksw
    case '-cgra':
      set cgra = "$2"; shift; breaksw
    default:
      unset found_daesh
      expr "$1" : '-' > /dev/null && set found_daesh
      set bsa="$1"
      if ($?found_daesh) then
        echo ""
        echo "ERROR Bad command-line arg '$1'"
        goto USAGE
      endif
  endsw
  shift;
end

set vswitch = '-q'
if ($?VERBOSE) set vswitch = '-v'

# Use default cgra file is none specified
if (! $?cgra) then
  set cgra = $CGROOT/hardware/generator_z/top/cgra_info.txt
  if ($?VERBOSE) then
    echo "WARNING $0:t - No cgra_info specified"
    echo "WARNING $0:t - Using default '$cgra'"
    echo ""
  endif
endif

# Use backup default if cannot find default
if (! -f $cgra) then
  set t = $cgra
  set cgra = $CGROOT/bitstream/examples/940/cgra_info.txt
  if ($?VERBOSE) then
    echo "WARNING $0:t - cgra_info file '$t' not found"
    echo "WARNING $0:t - Using backup default '$cgra'"
    echo ""
  endif
endif



foreach f ($bsa $cgra)
  test -f $f || echo ""
  test -f $f || echo "ERROR Cannot find file '$f'"
  test -f $f || goto USAGE
end

# Extract pure bitstream from bsa file
set bs = /tmp/tmp$$.bs
cat $bsa\
  | grep . \
  | egrep -v '^#'\
  > $bs

if ($?VERBOSE) echo "Built bs file '$bs'"

# 1. Cannot divine from pure bitstream which '0' selects are valid, so...
# From bsa must remove wire-0-connect lines of the form
#   ... connect wire 0 (in_0_BUS16_0_4) to sb_wire_in_1_BUS16_3_4
#   ... connect wire 0 (in_1_BUS16_1_3) to sb_wire_out_1_BUS16_3_3
#   ... connect wire 0 (sb_wire_in_1_BUS16_3_4) to out_1_BUS16_2_4
# 
# but not
#   ... connect wire 0 (in_BUS16_S0_T0) to b
#
# 2. bsa now has these 'nodenet' annotations e.g.
#   < # data[(15, 0)] : init `data1` reg with const `2` ; 4
#   > # data[(15, 0)] : init `data1` reg with const `2`

cat $bsa\
  | egrep -v 'connect wire 0 .*to [soi]'\
  | sed 's/ ; [0-9]*//'\
  > /tmp/tmp$$.bsa




# Decode the pure bitstream
if ($?VERBOSE) echo decode.py $vswitch $bs -cgra $cgra

# $CGROOT/bitstream/decoder/decode.py $vswitch $bs -cgra $cgra \
$CGROOT/bitstream/decoder/decode.py -q $bs -cgra $cgra \
  | sed '/Summary/,$d' \
  > /tmp/tmp$$.bsd \
  || exit 13

if ($?VERBOSE) set echo
diff /tmp/tmp$$.{bsa,bsd}

exit

# CLEAN UP!!!
/bin/rm /tmp/tmp$$.{bsa,bsd}
