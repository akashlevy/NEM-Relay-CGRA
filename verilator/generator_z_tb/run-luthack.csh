#!/bin/csh -f

# Remove LUT commands from bitstream 
set decoded = $1
set tmp     = /tmp/lh$$
    echo
    echo '  LUT hack'
    echo '  LUT hack'
    echo '  LUT hack'
    echo '  Temporarily stripping out LUT code...'
    echo ''
    set lut_hack_en = "^FF00.... 00000080"
    set lut_hack_ld = "^0000.... ........"

    cat $decoded \
      | egrep -v "$lut_hack_en" \
      | egrep -v "$lut_hack_ld" \
      > $tmp

    echo diff $decoded $tmp
    diff $decoded $tmp | grep -v d
    echo ""

    mv $tmp $decoded 

    rm $tmp



/bin/rm /tmp/$$