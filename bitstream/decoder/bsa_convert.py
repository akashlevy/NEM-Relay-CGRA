#!/usr/bin/python
import sys
import re
DBG=0
TARGET_VERSION='v1'

# NOTE currently cb-translate is wrong I think, see
# - c ; cb_translate.py | tee tmp1 | less
# switchboxes are feature 03 but shouldn't be...


# TODO
# - incorporate cb_translate.py into bsa_convert.py
# - c ; cb_translate.py | tee tmp1 | less

# Goal: get all the benchmarks running under v1 (master)
# - small parrot only
# - use bsview to generate complete list of v0's (pw,c1,c2,c3,bw)
# - use this file to convert them to v1's

# Goal 2: then do the same thing for v2


def usage():
    print "Usage:"
    print "  %s -v1  < bitstream_v0 > bitstream_v1"  % sys.argv[0]
    print "  %s -v1a < bitstream_v0 > bitstream_v1a" % sys.argv[0]
    print ""
    print "Where:"
    print "  v1:  changes features [2356] to [3278] respectively"
    print "  v1a: also shifts alu op bits 8-15 to be 16-23"
    print ""
    print "Example:"
    print "  %% %s -v1 < old.bs > new.bs"  % sys.argv[0]
    print "  % sdiff --side-by-side -W 40 old.bs new.bs --suppress-common-lines"
    print "  00050000 00000C0   |    00070000 00000C0"

    sys.exit(1)

if len(sys.argv) == 1: TARGET_VERSION = 'v1'

elif sys.argv[1] == '--help': usage()
elif sys.argv[1] == '-v1a'  : TARGET_VERSION = 'v1a'
elif sys.argv[1] == '-dbg'  : DBG=1





# v1 changes the rules about how connection boxes work;
# e.g. 


def cb_failure():
    return

    sys.stderr.write("\n")
    sys.stderr.write("ERROR: Ah ha you used a connection box you're screwed.")
    sys.stderr.write("\n")
    sys.exit(1)

def update_switchbox(feature):
    if DBG:
        if feature == "02": print "# UH OHHHHH it's feature 2, should be 3"
        if feature == "03": print "# UH OHHHHH it's feature 3, should be 2"
        if feature == "05": print "# UH OHHHHH it's feature 5, should be 7"
        if feature == "06": print "# UH OHHHHH it's feature 6, should be 8"

    if   feature == "02": cb_failure()
    elif feature == "03": cb_failure()


    if   feature == "02": feature = "03"
    elif feature == "03": feature = "02"
    elif feature == "05": feature = "07"
    elif feature == "06": feature = "08"
    return feature


def update_op(config):
    '''Given 32-bit config data, shift bits 8-15 to become 23-16 instead'''
    DBG=1

    parse = re.search("(....)(..)(..)", config)
    should_be_zero = parse.group(1)
    bits_15_8 = parse.group(2)
    bits_7_0  = parse.group(3)

    config_v1a = "%2s%2s%2s%2s" % ("00", bits_15_8, "00", bits_7_0)

    if DBG:
        print "# BEFORE: %s" % config
        print "# AFTER:  %s" % config_v1a
        print "# "

    return config_v1a

# Uncomment to test update_op
# update_op("0000FFFF")
# sys.exit(1)


def parse_line(line):
    parse = re.search("(..)(..)(....) (........)", line)
    if parse:
        reg = parse.group(1) 
        feature = parse.group(2)
        tile    = parse.group(3)
        data    = parse.group(4)
    else:
        print "ERROR bad line:\n%s"; sys.exit(-1)
    return (reg,feature,tile,data)



def prepass_check0(input_lines):
    tiles_that_use_cb = []
    tiles_that_use_sb = []
    for line in input_lines:
        (reg,feature,tile,data) = parse_line(line)
        if feature == '02': tiles_that_use_cb.append(tile)
        if feature == '03': tiles_that_use_cb.append(tile)
        if feature == '05': tiles_that_use_sb.append(tile)
    print "Tiles that use cb: %s" % tiles_that_use_cb
    print "Tiles that use sb: %s" % tiles_that_use_sb
    sys.exit(0)

def prepass_check(input_lines):
    outwire = {}
    inwirea = {}
    inwireb = {}


    # In translating to v1, a will always connect to out_s2 and
    # b will always connect to out_s1
    #
    # so if pe_out connects to s1 or s2, could be trouble
    # have to make sure track numbers not same


    DBG=1
    for line in input_lines:
        line = line.strip()
        if re.search('^#', line):

            # data[(19, 18)] : @ tile (1, 0) connect wire 3 (pe_out_res) to out_BUS16_S1_T4
            # parse = re.search("tile \((.*)\) connect wire 3 .pe_out_res. to (.*)", line)

            # NOT JUST pe_out!  Must check *all* connected outputs for collisions
            parse = re.search("tile \((.*)\) connect wire .* to (out_BUS16.*)", line)


            if (parse):
                # print line
                t = parse.group(1)
                outwire[t] = parse.group(2)
                # if DBG: print "tile (%s) pe_out connects to '%s'" % (t, outwire[t])
                if DBG: print "tile (%s) something connects to '%s'" % (t, outwire[t])
                

            # data[(3, 0)] : @ tile (1, 0) connect wire 9 (in_BUS16_S3_T4) to a
            parse = re.search("tile \((.*)\) connect .*\((.*)\) to ([ab])", line)
            if (parse):
                # print line
                t = parse.group(1)
                ab = parse.group(3)
                if ab == 'a': inwirea[t] = parse.group(2)
                if ab == 'b': inwireb[t] = parse.group(2)
                if DBG: print "tile (%s) input connects to '%s'" % (t, parse.group(2))
    if DBG: print '---'

    for t in outwire:
        ow = outwire[t]

        # In translating to v1, a will always connect to out_s2 and
        # b will always connect to out_s1

        try:
            a = inwirea[t]
            parse = re.search("in_BUS16_S(.)_T(.)", a)
            a2 = "out_BUS16_S2_T%s" % parse.group(2)
        except: (a,a2) = ("nothing","nothing")

        try:
            b = inwireb[t]
            b2 = "out_BUS16_S1_T%s" % parse.group(2)
        except: (b,b2) = ("nothing","nothing")

        DBG=1
        if DBG:
            # print "tile (%s) pe_out connects to '%s'" % (t, ow)
            print "tile (%s) something connects to '%s'" % (t, ow)
            print "tile (%s) op_a      connects to '%s' => '%s'" % (t, a, a2)
            print "tile (%s) op_b      connects to '%s' => '%s'" % (t, b, b2)
            print ""

        if a2 == ow or b2 == ow:
            print "ERROR collision in tile (%s) wire '%s'" % (t,ow)
            # print "tile (%s) pe_out connects to '%s'" % (t, ow)
            print "tile (%s) something connects to '%s'" % (t, ow)
            print "tile (%s) op_a      connects to '%s' => '%s'" % (t, a, a2)
            print "tile (%s) op_b      connects to '%s' => '%s'" % (t, b, b2)
        
    sys.exit(0)





input_lines = sys.stdin;
prepass_check(input_lines)



for line in input_lines:
    if DBG: print line,

    ########################################################################
    # if feature == 2 or 3, that's a connection box

    # Before: f02/data=[0-9] :: a <= in_s1t[0-4],in_s3t[0-4]
    # Before: f03/data=[0-9] :: b <= in_s0t[0-4],in_s2t[0-4]

    # After:  f02/data=[0-9] :: a <= in_s2t[0-4],out_s2t[0-4]
    # After:  f03/data=[0-9] :: b <= in_s1t[0-4],out_s1t[0-4]

    # So: basically screwed if feature == 2 or 3

    # AND/OR see ~/tmpdir/notes.cb

    ########################################################################


    (reg,feature,tile,data) = parse_line(line)
    tileno = int(tile,16)

    # if DBG: print "r%s f%s t%s d%s" % (reg,feature,tile,data)

    # Change PE tiles only
    # No need to change mem tiles, print them unscathed
    if tileno in [3,7,17,21,31,35,45,49]:
        # print "WHOOP TE DO it's a mem tile"
        print line
        continue

    # Update PE tile feature number
    feature = update_switchbox(feature)

    # If want version 1a, update op_[ab]_in bits also
    if TARGET_VERSION == 'v1a' and reg == 'FF':
        data = update_config(data)

    # Print the modified PE tile
    print "%s%s%s %s" % (reg,feature,tile,data)

    # if DBG: print ""

#endfor


##############################################################################
# v0-to-v1/v2 connection boxes (v1 same as v2 for cb's)
# 
# Given a v0 cb connection, build an equivalent connection for v1/v2
#
# v0: xx030007 00000000 # a <= in_s0t0
# 
# v1: xx030007 00000005 # a <= out_s2t0
#     xx030007 00000000 #      out_s2t0 <= in_s0t0 ([11:10]=0)
#
# Note this mucks up the switchbox, so must do a check elsewhere to fix that
#
# Need two passes:
# - pre-pass to identify and make a list of which switchboxes will be mucked
# - regular pass to do cb, sb fixes on demand

