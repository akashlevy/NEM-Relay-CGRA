#!/bin/csh -f

set outdir = /tmp/decode_compare
if (-e $outdir) /bin/rm -rf $outdir
mkdir $outdir
echo "Output will go to $outdir"
echo

foreach bsroot (\
  cd387-oldmem \
  cd387-newmem \
  cd387-newmem-8x8 \
)
    foreach nd ("" "-nodefaults")
        set in =      ../examples/$bsroot.bs
        set out =        $outdir/$bsroot$nd.bsd
        set compare = ./examples/$bsroot$nd.bsd
        set sw = `expr "$bsroot" : ".*\(-.*\)"`

        echo ./decode.py $nd $sw $in \> $out
        ./decode.py $nd $sw $in > $out

        echo diff $compare $out
        diff $compare $out || echo cp $out $compare

        # echo cat $out


        echo
    end
end
