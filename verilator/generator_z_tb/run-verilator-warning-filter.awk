#!/bin/awk -f

# Ignore "example path" after sb circularities.

# %Warning-UNOPTFLAT:
#  ../../hardware/generator_z/top/genesis_verif/sb_unq3.v:414: Signal
#  unoptimizable: Feedback to clock or circular logic:
#  v.t0_3_3->sb_wide.out_3_4_i

# %Warning-UNOPTFLAT:
#  ../../hardware/generator_z/top/genesis_verif/sb_unq4.v:359: Signal
#  unoptimizable: Feedback to clock or circular logic:
#  v.t0_3_3->sb_1b.out_2_4_i

BEGIN {
    # print "%Warning Ignoring warnings about unoptimizable switchbox wires (see SR for explainer)."
    ignore = "FALSE";
    nprinted = 0;
}

# These are never useful
/Example path.*ASSIGNW/ { next; }
/Example path.*ALWAYS/ { next; }


/Example path/ {
    if (ignore == "TRUE") next;
}

{ ignore = "FALSE"; }
/Signal unoptimizable.*sb_wide.out/ { ignore = "TRUE"; next; }
/Signal unoptimizable.*sb_1b.out/   { ignore = "TRUE"; next; }

# $0 == "XXX" { # This is turned off (for now)
{
    print
    nprinted++
    if (nprinted > 40) { exit }
}
# { print }
# awk -f ~/bin/awk-examples/verilator-warning-filter.awk /tmp/verilator.out | less
