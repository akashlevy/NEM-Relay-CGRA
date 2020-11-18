#!/bin/csh -f

unset yakky

goto MAIN
USAGE:
  echo ""
  echo "Usage:"
  echo "  $0 <filename>"
  echo ""
  echo "Description:"
  echo "  Tells whether <filename> is of type bsa, dot, json or cgra_info"
  echo ""
  echo "Example:"
  echo "  % $0 conv_bw_annotated"
  echo "  bsa"
  echo ""

MAIN:

# Test for bsa-ness
# bsa file looks like:
#
#    00050008 0000C000
#    # data[(15, 14)] : @ tile (1, 0) connect wire 3 (pe_...
#    00020008 00000001
#    # data[(3, 0)] : @ tile (1, 0) connect wire 1 (in_BU...
#    00030008 00000003
#    # data[(3, 0)] : @ tile (1, 0) connect wire 3 (in_BU...
#    FF000008 0000A000
#    # data[(4, 0)] : op = add
#    # data[(13, 13)] : read from wire `b`

# Look for a bunch of '^# data' comments
set ncomm = `egrep '^# data' $1 | wc -l`

# Non-comments should all be of the form '00050008 0000C000'
set ndata = `egrep -v '^# data' $1 | egrep '^........ ........$' | wc -l`

set ntots = `wc -l $1`

if ($?yakky) then
  echo "Found $ncomm total bsa-style comments"
  echo "Found $ndata total bsa-style data"
  echo "Found $ntots total lines"
endif

if ($ndata > 5 && $ncomm > 5) then
  echo 'bsa'

else

  # Haha this is awful but what if we just say that
  # if it's not bsa it's json :D
  echo 'json'

endif
