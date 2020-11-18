#!/usr/bin/python

import sys;
import re;

VERBOSE = False
TEST    = False


# Test of pass by reference
# def modify(foo):
#     foo["bar"] = 'baz'
# 
# foo = {}
# modify(foo)
# print foo
# sys.exit(0)

def main():
    if TEST:
        VERBOSE = True
        test_cbfix()
        sys.exit(0)

    # inputstream = sys.stdin; input_lines = inputstream; # for line in inputstream:
    # input_lines = (); input_lines = sys.stdin;

    input_lines = [] # for line in sys.stdin: input_lines.append(line)
    for line in sys.stdin: input_lines.append(line)

    print "################################################################"
    print "# PRE-PASS to build cb, sb dictionaries"
    print "################################################################"

    # cb_config and cb_annote are dictionaries of strings
    # containing cb config and annote strings e.g.
    #   cb_config["00020003"] = "01230456"
    #   cb_annote["00020003"] = "# connect a to foo"

    # sb_config and sb_annote are dictionaries of lists of strings
    # containing sb config and annote strings
    #   sb_config["00050007"] = ("02020000","00001100")
    #   sb_annote["00050007"] = ("# annote1...", "# annote2...")

    cb_config = {}; cb_annote = {}
    sb_config = {}; sb_annote = {}

    for line in input_lines:
        # print 'foo'+line
        fix_cb(line,
           cb_config, cb_annote,
           sb_config, sb_annote,
           DBG=1)

    print "################################################################"
    print "# Now use cb, sb dictionaries to translate v0 => v1"
    print "################################################################"

    for line in input_lines:
        line = line.strip() # YES
        # (reg,feature,tile,data) = parse_bs_line(line)
        (addr, data) = parse_bs_line(line)
        (reg,feature,tile) = parse_bs_addr(addr)
        if addr in cb_config:
            print "# %s" % line
            print "# Found addr '%s' in CB %s" % (addr, cb_config)
            print "%s %s" % (addr, cb_config[addr])
            print "# "
            del cb_config[addr]
        elif addr in sb_config:
            print "# %s" % line
            # print "# Oh boy get to merge addr '%s' into SB %s" % (addr, sb_config)
            print "# Oh boy found existing sb route(s) %s" % sb_config[addr]
            newdata= merge_sbroutes( [data] + sb_config[addr])
            print "%s %s" % (addr, newdata)
            print "# "
            del sb_config[addr]
        else:
            print line

    print ""
    print "# LEFTOVERS"
    # print "CB: %s" % cb_config
    print "# SB: %s" % sb_config
    print "# "
    for addr in sb_config:
        newdata= merge_sbroutes(sb_config[addr])
        print "%s %s" % (addr, newdata)




def merge_sbroutes(sb_list):
    sb_merged = 0
    for rte in sb_list:
        sb_merged = sb_merged | int(rte,16)
    sb_merged = "%08X" % sb_merged
    print "# %s merged to %s" % (sb_list, sb_merged)
    return sb_merged






def fix_cb(line,
           cb_config, cb_annote,
           sb_config, sb_annote,
           DBG=0):

    line = line.strip() # YES
    # (reg,feature,tile,data) = parse_bs_line(line)
    (addr, data) = parse_bs_line(line)
    (reg,feature,tile) = parse_bs_addr(addr)

    # Only interested in a, b connection boxes
    # (Elsewhere, should have checked to make sure this is PE and not mem tile)
    if feature != "02" and feature != "03": return False

    # Translate!
    # (cb_addr, cb_data, sbnew, sbstring) = fix_cba(line,DBG)
    (cb_addr, cb_data, sb_addr, sb_data) = fix_cba(line,DBG)

    cb_config[cb_addr] = cb_data

    try:
        sb_config[sb_addr].append(sb_data)
    except:
        sb_config[sb_addr] = []
        sb_config[sb_addr].append(sb_data)

    print "CB: %s" % cb_config
    print "SB: %s" % sb_config
    print ""


# This should be in decode library I guess
# and/or why not a single line
# (reg,feature,tile,data) = myparse(line, "(..)(..)(....) (........)", 4)
def parse_bs_line(line):
    line = line.strip() # Why not
    parse = re.search("(........) (........)", line)
    if parse:
        addr = parse.group(1)
        data = parse.group(2)
        return (addr,data)
    else:
        print "ERROR bad bitstream line:\n%s" % line
        sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
        sys.exit(-1)

def parse_bs_addr(addr):
    parse = re.search("(..)(..)(....)", addr)
    if parse:
        reg = parse.group(1) 
        feature = parse.group(2)
        tile    = parse.group(3)
        return (reg,feature,tile)
    else:
        print "ERROR bad bitstream address:\n%s" % line
        sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
        sys.exit(-1)





def fix_cba(line, DBG=0):
    '''Connection box 'a' input'''

    # (reg,feature,tile,data) = parse_bs_line(line)
    (addr, data) = parse_bs_line(line)
    (reg,feature,tile) = parse_bs_addr(addr)

    ################################################################
    # Feature == "02" => op_a_in
    # OLD (v0):
    # xx02xxxx 0000 000[01234] # a <= in_s1t[01234]
    # xx02xxxx 0000 000[56789] # a <= in_s3t[01234]
    if feature == "02": (inside_lo,inside_hi) = (1,3)

    # NEW (v1):
    # xx02xxxx 0000 000[56789] # a <= out_s2t[01234]
    if feature == "02": out_side = 2

    # xx05xxxx 0010 0000       #      out_s2t0 <= in_s1t0 [21:20]==1
    # xx05xxxx 0040 0000       #      out_s2t1 <= in_s1t1 [23:22]==1
    # xx05xxxx 0100 0000       #      out_s2t2 <= in_s1t2 [25:24]==1
    # xx05xxxx 0400 0000       #      out_s2t3 <= in_s1t3 [27:26]==1
    # xx05xxxx 1000 0000       #      out_s2t4 <= in_s1t4 [29:28]==1

    # xx05xxxx 0020 0000       #      out_s2t0 <= in_s3t0 [21:20]==2
    # xx05xxxx 0080 0000       #      out_s2t1 <= in_s3t1 [23:22]==2
    # xx05xxxx 0200 0000       #      out_s2t2 <= in_s3t2 [25:24]==2
    # xx05xxxx 0800 0000       #      out_s2t3 <= in_s3t3 [27:26]==2
    # xx05xxxx 2000 0000       #      out_s2t4 <= in_s3t4 [29:28]==2


    ################################################################
    # Feature == "03" => op_b_in
    # OLD:
    # xx03xxxx 0000 000[01234] # b <= in_s0t[01234]
    # xx03xxxx 0000 000[56789] # b <= in_s2t[01234]
    if feature == "03": (inside_lo,inside_hi) = (0, 2)


    # NEW:
    # xx03xxxx 0000 000[56789] # b <= out_s1t[01234]
    if feature == "03": out_side = 1

    # xx05xxxx 0000 0000
    # 
    # xx05xxxx 0000 0000       #      out_s1t0 <= in_s0t0 [11:10]==0
    # xx05xxxx 0000 0000       #      out_s1t1 <= in_s0t1 [13:12]==0
    # xx05xxxx 0000 0000       #      out_s1t2 <= in_s0t2 [15:14]==0
    # xx05xxxx 0000 0000       #      out_s1t3 <= in_s0t3 [17:16]==0
    # xx05xxxx 0000 0000       #      out_s1t4 <= in_s0t4 [19:18]==0

    # xx05xxxx 0000 0400       #      out_s1t0 <= in_s2t0 [11:10]==1
    # xx05xxxx 0000 1000       #      out_s1t1 <= in_s2t1 [13:12]==1
    # xx05xxxx 0000 4000       #      out_s1t2 <= in_s2t2 [15:14]==1
    # xx05xxxx 0001 0000       #      out_s1t3 <= in_s2t3 [17:16]==1
    # xx05xxxx 0004 0000       #      out_s1t4 <= in_s2t4 [19:18]==1

    sel = int(data, 16)  # O.k. to use all 32 bits
    track = sel%5

    # v0: 'a' originally came from inwire on side 1 or 3 as indicated by sel bits
    # v0: 'b' originally came from inwire on side 0 or 2 as indicated by sel bits
    # if sel < 5: in_side = 1
    # else:       in_side = 3
    if sel < 5: in_side = inside_lo
    else:       in_side = inside_hi

    # v1 step 1: change cb so 'a' input comes from out_s2 (feature 02)
    #                     and 'b' input comes from out_s1 (feature 03)
    cb_addr = "%s%s%s" % (reg,feature,tile)
    cb_data = "0000000%d" % (track+5)

    # v1 step 2: tell sb to connect orig inwire to out_s2t<track> instead of 'a'
    #                                        or to out_s1t<track> instead of 'b'
    (sel,shiftamt,sbstring) = sbconnect(in_side, out_side, track)
    # sbnew = "%s%s%s %08x" % (reg,"05",tile, sel<<shiftamt)
    sb_addr = "%s%s%s" % (reg,"05",tile)
    sb_data = "%08x" % (sel<<shiftamt)

    VERBOSE = True
    if (VERBOSE):
        # What we did.  E.g.
        # 
        # BEFORE: xx030007 00000008 # b <= in_s2t3
        # AFTER:  xx030007 00000008 # b <= out_s1t3
        #         xx050007 00010000 #      out_s1t3 <= in_s2t3 ([17:16]=1)

        if feature == '02': op='a'
        else:               op='b'
        inwire  = "%s <= in_s%dt%d"  % (op, in_side,  track)
        outwire = "%s <= out_s%dt%d" % (op, out_side, track)

        cbnew = "%s %s" % (cb_addr, cb_data)
        sbnew = "%s %s" % (sb_addr, sb_data)

        print "# BEFORE: %s # %s"      % (line, inwire)
        print "# AFTER:  %s # %s"      % (cbnew, outwire)
        print "#         %s #      %s" % (sbnew, sbstring)
        print ""

    return(cb_addr, cb_data, sb_addr, sb_data)


def sbconnect(in_side, out_side, track):
    '''
    Build a switchbox that connects in_s<in_side>t<track> to out_s<out_side>t<track>
    '''

    # (input b)
    # For now only needs to work for output sides 1 and 2
    if out_side == 1:
        shiftamt = 10 + 2*track # output to side 1 (out_s1)
        # For now only needs to work for input sides 0 and 2
        if in_side == 0: sel = 0
        elif in_side == 2: sel = 1
        else: print "ERROR in_side=%d when out_side=1" % in_side


    # (input a)
    # For now only needs to work for output sides 1 and 2
    elif out_side == 2:
        shiftamt = 20 + 2*track # output to side 2 (out_s2)
        # For now only needs to work for input sides 1 and 3
        if in_side == 1: sel = 1
        elif in_side == 3: sel = 2
        else: print "ERROR in_side=%d when out_side=2" % in_side


    else: print "ERROR out_side=%d" % in_side

    # For debug purposes, make a text string e.g.
    # "out_s2t3 <= in_s2t3 ([17:16]=1)"
    #
    connection = "out_s%dt%d <= in_s%dt%d ([%d:%d]=%d)" \
                 % (out_side, track, in_side, track, shiftamt+1, shiftamt, sel)

    return (sel, shiftamt, connection)

# NOTE MUST ADD 0005<TTTT> to a watchlist now!!!
# Keep a list of all switchboxes used;
# keep a list of all switchboxes modified;
# make sure the two lists have NO COMMON TILES.


def test_cbfix():
    x = {} # dummy dict

    fix_cb("xx020007 00000000", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000001", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000002", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000003", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000004", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000005", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000006", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000007", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000008", x, x, x, x, DBG=1)
    fix_cb("xx020007 00000009", x, x, x, x, DBG=1)

    print "##########################################################################"

    fix_cb("xx030007 00000000", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000001", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000002", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000003", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000004", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000005", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000006", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000007", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000008", x, x, x, x, DBG=1)
    fix_cb("xx030007 00000009", x, x, x, x, DBG=1)


main()
