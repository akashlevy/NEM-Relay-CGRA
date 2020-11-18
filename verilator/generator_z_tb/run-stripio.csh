#!/bin/csh -f

#------------------------------------------------------------------------
if ($1 == '--help') then
cat << eof
Input:  Bitstream 'foo.bs' w/ bitstream-embedded I/O
Output: Bitstream 'foo.bsio' w/ comment-formatted I/O ONLY

Example:
  $0:t -v foo.bs -o foo.bsio

eof
exit
endif

#------------------------------------------------------------------------
if ($1 == '-v') set VERBOSE
if ($1 == '-v') shift

if ($1 == '-q') unset VERBOSE
if ($1 == '-q') shift

#------------------------------------------------------------------------
set bs  = $1
set out = $3
if (-e $out) rm $out

# set tmpdir = /tmp/tmp$$; mkdir $tmpdir
set tmpdir = `mktemp -d /tmp/run-stripio.XXX`

# Clean bitstream (strip out comments and hacked-in IO info)
cat $bs \
  | egrep -v '^F000.... FFFFFFFF' \
  | egrep -v '^F100.... FFFFFFFF' \
  | egrep -v '^FF00.... 000000F0' \
  | egrep -v '^FF00.... 000000FF' \
  > $tmpdir/stripped_bs


# Show/verify diff between stripped and original
# This is small and SHOULD NOT BE OPTIONAL!
# Meh.  Now it's optional.
if ($?VERBOSE) then
    echo diff $bs $tmpdir/stripped_bs
    diff $bs $tmpdir/stripped_bs | grep -v d
endif


# Verify that exactly five lines got stripped
set ndiff = `diff $bs $tmpdir/stripped_bs | grep -v d | wc -l`
if ("$ndiff" == "5") then
    if ($?VERBOSE) echo "run.csh: Five lines of diff.  That's good!"
else
    echo "ERROR run-stripio: Looks like we messed up the IO"
    exit -1
endif


# Strip out comments from decoded bitstream
cat $tmpdir/stripped_bs\
    | awk \
      '/^[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]/{print $1 " " $2}'\
      > $out


# Add back in just the I/O comments
egrep '^# INPUT  tile' $bs >> $out
egrep '^# OUTPUT tile' $bs >> $out


# Show/verify diff between final and original
if ($?VERBOSE) then
    echo diff $bs $out
    diff $bs $out | grep -v d
endif


# Clean up
/bin/rm -rf $tmpdir
