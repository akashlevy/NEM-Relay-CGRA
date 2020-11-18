#!/bin/csh -f

set config = $1

# Quick check of goodness in config file
unset bad_config
set c = '[0-9a-fA-F]'
set goodline = "$c$c$c$c$c$c$c$c $c$c$c$c$c$c$c$c"

set tmp = /tmp/verify_bitstream_goodness.$$
egrep -v "$goodline" $config > $tmp && set bad_config
if ($?bad_config) then
  echo
  echo "ERROR Config file '$config' looks bad, man. Bad line(s) include:"
  cat $tmp | sed 's/^/> /'
  /bin/rm $tmp
  exit 13
endif

/bin/rm $tmp

