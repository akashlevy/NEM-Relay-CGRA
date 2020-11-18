#!/usr/bin/python

# Example:
#   decode.py convbw.bs -cgra examples/cgra_info_8x8.txt

import sys;
import re;
from lib import cgra_info

HACK1 = True
if (0):
    if 1:     print "------------------------------------------------------------------------"
    if 1:     print 'HACK ALERT - search source code for "HACK"'
    if HACK1: print "HACK1 only printing connections with wireno != 0"
    if 1:     print "------------------------------------------------------------------------"

global verbose
verbose = False

# Haha FIXME FIXME oh yeahhhh...this is gonna break big time
# FIXME names should come from cgra_info
OP_IN = {}
# OP_IN['a'] = "op_a_in"
# OP_IN['b'] = "op_b_in"
# OP_IN['c'] = "op_c_in"
# OP_IN['d'] = "op_d_in"
OP_IN['a'] = "data0"
OP_IN['b'] = "data1"
OP_IN['c'] = "data2"
OP_IN['d'] = "bit0" # Right?
OP_IN['e'] = "bit1" # Right?
OP_IN['f'] = "bit2" # Right?

def get_default_cgra_info_filename():
    '''
    Look for default cgra_info file in <decoder-directory>/examples/cgra_info.txt
    '''
    import os
    mydir = os.path.dirname(os.path.realpath(__file__))
    cgra_filename = mydir + "/examples/cgra_info.txt"

    # global verbose #(implied because use before def)
    if verbose: print("I think I am here:\n  %s" % mydir)
    if verbose: print("Default cgra_info file is\n  %s" % cgra_filename)
    return cgra_filename

try:
  sys.path.insert(0, "../../../SMT-PNR/src")
  sys.path.insert(0, "../../../smt-pnr/src")
  from config.annotations import Annotations
  sys.stderr.write("HOORAY decoder loaded 'official' Annotations.py from PNR repository\n\n")
except:
  sys.stderr.write("WARNING decode.py could not load 'official' Annotations.py library\n\n")
  from lib.annotations import Annotations


# print Annotations.op_config('op', 'output')
# sys.exit(-1)

# backends.py:from config import configindex, Annotations
# backends.py: comment[0][(c.sel_w-1, 0)] = Annotations.connect_wire(data[0], c.src_name,
# backends.py: comment[reg][(offset, offset)] = Annotations.latch_wire(c.sel, c.src_name, c.snk_name, row=y, col=x)
# backends.py: comment[reg][(c.sel_w + offset - 1, offset)] = Annotations.connect_wire(c.sel, c.src_name, c.snk_name, row=y, col=x)
# backends.py: comment[_pe_reg[port]][(15,0)] = Annotations.init_reg(port, src.config)
# backends.py: comment[_pe_reg['op']][_read_wire[port]] = Annotations.read_from('reg', port)
# backends.py: comment[_pe_reg['op']][_load_reg[port]] = Annotations.load_reg(port)
# backends.py: comment[_pe_reg['op']][_read_wire[port]] = Annotations.read_from('reg', port)
# backends.py: comment[_pe_reg['op']][_read_wire[port]]  = Annotations.read_from('wire', port)
# backends.py: comment[_pe_reg['op']][(4, 0)] = Annotations.op_config('op', 'input')
# backends.py: comment[_pe_reg['op']][(4, 0)] = Annotations.op_config('op', 'output')
# backends.py: comment[reg][(sel_w + offset - 1, offset)] = Annotations.op_config(opt, value)
# backends.py: suffix =  Annotations.format_comment(comment[reg])


scriptname = sys.argv[0];
args = sys.argv[1:];

scriptname_tail = scriptname
parse = re.search('([/].*$)', scriptname)
parse = re.search('([^/]+$)', scriptname)
if (parse): scriptname_tail = parse.group(1)

usage = '''
Decodes/annotates the indicated bitstream file
Usage:
   %s [ -v ] <bitstream-file> -cgra <cgra_info_file>
   %s --help
''' % (scriptname_tail, scriptname_tail)

# sbdefaults = True;
cgra_filename = get_default_cgra_info_filename()


if (len(args) < 1):       print usage; sys.exit(-1);
if (args[0] == '--help'): print usage; sys.exit(0);
while (len(args) > 0):
    # global verbose # this causes problems/errors
    # if   (args[0] == '-nodefaults'): sbdefaults = False
    if   (args[0] == '-v'):    verbose = True
    elif (args[0] == '-4x4'): print 'WARNING switch "-4x4" not used'
    elif (args[0] == '-8x8'): print 'WARNING switch "-8x8" not used'
    elif (args[0] == '-cgra' or args[0] == '-cgra_info'):
        cgra_filename = args[1]
        args = args[1:];
    else:
        bitstream_filename = args[0];
    args = args[1:]

# read_cgra_info() does this...
# if verbose: print("Using uh cgra_info file %s" % cgra_filename)
# if verbose: print("and verbose is '%s'" % str(verbose))
cgra_info.read_cgra_info(cgra_filename, verbose=verbose)

# # TBD this (below) could be a separate "print_intro()" function like
# if (verbose):
#     print "# ";
#     print "# -----------------------------------------------------------------------------"
#     print "# Assume 4x4 grid of tiles, all with 2-input PEs\n"+\
#           "#                                            \n"+\
#           "#      tileno                   r,c          \n"+\
#           "#   0   1   2   3     (0,0) (0,1) (0,2) (0,3)\n"+\
#           "#   4   5   6   7     (1,0) (1,1) (1,2) (1,3)\n"+\
#           "#   8   9  10  11     (2,0) (2,1) (2,2) (2,3)\n"+\
#           "#  12  13  14  15     (3,0) (3,1) (3,2) (3,3)\n"+\
#           "# ";
#     print "# Note: 's1t3' means 'side 1 track 3' (sides [0123] map to [ESWN] respectively)"
#     print "# -----------------------------------------------------------------------------"

def find_source(row, col, wirename):
    # Given tile number (r,c) in a 4x4 grid as shown...
    #
    #    (0,0) (0,1) (0,2) (0,3)
    #    (1,0) (1,1) (1,2) (1,3)
    #    (2,0) (2,1) (2,2) (2,3)
    #    (3,0) (3,1) (3,2) (3,3)
    #
    # ...and a wire name of indicated side and track e.g. "in_s1t0" or "out_s3t2",
    # return wire source encoded in a string "wire_<r>_<c>_BUS16_S<s>_T<t>",
    # where now r, c and s are the row, column and side of the tile that
    # sources the wire.
    # 
    # "out" wires are sourced in same tile so have same row, col, side and track number.
    # "in" wires come from neighboring tiles e.g. side 1 "in" wire comes
    # from bottom-side neighbor's side 3.  (Note sides [0123] map to [ESWN].)
    # E.g.
    # tile (0,3) out_s1t0 => wire_0_3_BUS16_S1_T0
    # tile (0,1)  in_s1t0 => wire_1_1_BUS16_S3_T0

    # print "FOO " + wirename
    # deconstruct = re.search("(in|out)_s([0-9]+)_t([0-9]+)", wirename)
    deconstruct = re.search("(in|out)_s([0-9]+)t([0-9]+)", wirename)

    if (not deconstruct):
        # Try, try again
        deconstruct = re.search("(in|out)_BUS16_S([0-9]+)_T([0-9]+)", wirename)

    if (not deconstruct):
        print "OOOPS could not deconstruct %s" % wirename
        print "OOOPS"; sys.stdout.flush();

    in_or_out = deconstruct.group(1)
    side      = deconstruct.group(2)
    track     = deconstruct.group(3)

    # print "%s %s" % (wirename, in_or_out)
    if (in_or_out == "in"):
        if   (side=='0'): col = col + 1; side = '2'
        elif (side=='1'): row = row + 1; side = '3'
        elif (side=='2'): col = col - 1; side = '0'
        elif (side=='3'): row = row - 1; side = '1'
        if   (row == -1): row = "m1";
        elif (col == -1): col = "m1";

    sourcewire = "wire_%s_%s_BUS16_S%s_T%s" % \
                 (str(row), str(col), side, track)
    return sourcewire

def find_source_test():
    # test corners: for [row, col] = [0, 0], [3, 0], [0, 3], [3, 3]
    for col in [0,3]:
        for row in [0,3]:
            for wirename in ["in_s0t0", "in_s1t0", "in_s2t0", "in_s3t0"]:
                print "TEST find_source(%d,%d,%s) = %s" % \
                    (row, col, wirename, find_source(row, col, wirename))
            print ""


    for col in [0,3]:
        for row in [0,3]:
            for wirename in ["out_s0t0", "out_s1t0", "out_s2t0", "out_s3t0"]:
                print "TEST find_source(%d,%d,%s) = %s" % \
                    (row, col, wirename, find_source(row, col, wirename))
            print ""

    sys.exit()

# find_source_test();

# for i in range (0,16):
#     print tileno2rc(i)
# sys.exit()

def EE_decode(EE):
    # Given string EE = one of "00", "01", ... "07", return element name
    # "pe", op", etc. as shown below

    #   EE   2-input PE    3-input PE
    #   --   ----------    ----------
    #   00   PE            PE
    #   01   OP            OP
    #   02   CB1           CB1
    #   03   CB2           CB2
    #   04   CB4           CB3
    #   05   SB1           CB4
    #   06   SB2           SB1
    #   07   N/A           SB2

    element = {};
    element["00"] =   "pe";
    element["01"] =   "op";
    element["02"] =   "cb1";
    element["03"] =   "cb2";
    element["04"] =   "cb4";
    element["05"] =   "sb1";
    element["06"] =   "sb2";
    # return element[EE];
    return "sb2"

# Given 8-digit hex string DDDDDDDD = e.g. "00000002", tell what
# switchbox will do with the data, e.g. sb_decode("00000000") = "out <= in_0"
def cb_decode(EE, DDDDDDDD, row, col):
    # Connection box dataword only uses bottom 4 bits interpreted as shown below (see cb.v).
    #   cb1 connects pe input A to a north-south wire track
    #   cb2 connects pe input B to an east-west wire track
    #
    # cb1 (EE = 02):
    #     [01234]: pe_inp_a = in_BUS16_S1_T[01234]
    #     [56789]: pe_inp_a = in_BUS16_S3_T[01234]
    # 
    # cb2 (EE = 03):
    #     [01234]: pe_inp_b = in_BUS16_S0_T[01234]
    #     [56789]: pe_inp_b = in_BUS16_S2_T[01234]

#     if (not re.search("0000000[0-9A-Fa-f]", DDDDDDDD)):
#         sys.stdout.flush();
#         sys.stderr.write("\nERROR bad value '%s' for connection box\n" % DDDDDDDD);
#         sys.exit(-1);

    if (not re.search("0000000[0-9A-Fa-f]", DDDDDDDD)):
        print ""
        print "WARNING unexpected value '%s' for connection box" % DDDDDDDD
        print "WARNING I will assume this has to do with memory tiles..."
        print ""
        return "wireB <= in_s9t9"

    cb = {};

    # input A side 0 (S)
    # st["02.00000000"] = "wireA <= in_s1t0"
    cb["02.00000000"] = ("data[(3, 0)]", "in_BUS16_S1_T0", "a")
    cb["02.00000001"] = ("data[(3, 0)]", "in_BUS16_S1_T1", "a")
    cb["02.00000002"] = ("data[(3, 0)]", "in_BUS16_S1_T2", "a")
    cb["02.00000003"] = ("data[(3, 0)]", "in_BUS16_S1_T3", "a")
    cb["02.00000004"] = ("data[(3, 0)]", "in_BUS16_S1_T4", "a")

    # input A side 3 (N)
    cb["02.00000005"] = ("data[(3, 0)]", "in_BUS16_S3_T0", "a")
    cb["02.00000006"] = ("data[(3, 0)]", "in_BUS16_S3_T1", "a")
    cb["02.00000007"] = ("data[(3, 0)]", "in_BUS16_S3_T2", "a")
    cb["02.00000008"] = ("data[(3, 0)]", "in_BUS16_S3_T3", "a")
    cb["02.00000009"] = ("data[(3, 0)]", "in_BUS16_S3_T4", "a")

    # input B side 0 (E)
    cb["03.00000000"] = ("data[(3, 0)]", "in_BUS16_S0_T0", "b")
    cb["03.00000001"] = ("data[(3, 0)]", "in_BUS16_S0_T1", "b")
    cb["03.00000002"] = ("data[(3, 0)]", "in_BUS16_S0_T2", "b")
    cb["03.00000003"] = ("data[(3, 0)]", "in_BUS16_S0_T3", "b")
    cb["03.00000004"] = ("data[(3, 0)]", "in_BUS16_S0_T4", "b")

    # input B side 2 (W)
    cb["03.00000005"] = ("data[(3, 0)]", "in_BUS16_S2_T0", "b")
    cb["03.00000006"] = ("data[(3, 0)]", "in_BUS16_S2_T1", "b")
    cb["03.00000007"] = ("data[(3, 0)]", "in_BUS16_S2_T2", "b")
    cb["03.00000008"] = ("data[(3, 0)]", "in_BUS16_S2_T3", "b")
    cb["03.00000009"] = ("data[(3, 0)]", "in_BUS16_S2_T4", "b")

    # Terrible, terrible.  But should be better soon.
    try:
        (dbits,inwire,outwire) = cb[EE + '.' + DDDDDDDD]
        wireno = int(DDDDDDDD[-1:],16)
        # cb_connection = "\n# %s : @ tile (6, 0) connect wire %d (%s) to %s" \
        #                 % (dbits,wireno,inwire,outwire)

        # "@ tile (6, 0) connect wire 0 (in_BUS16_S1_T0) to a"
        ann = Annotations.connect_wire(wireno,inwire,outwire,col,row)

        # "data[(3, 0)] : @ tile (6, 0) connect wire 0 (in_BUS16_S1_T0) to a"
        cb_connection = "# %s : %s" % (dbits, ann)

        # print Annotations.op_config('op', 'output')
        # backends.py: comment[reg][(c.sel_w + offset - 1, offset)] \
        # = Annotations.connect_wire(c.sel, c.src_name, c.snk_name, row=y, col=x)
        # print "FOOOOO"
        # print Annotations.connect_wire(wireno,inwire,outwire,6,0)

    except:
        cb_connection = "unknown 44"
        
    return cb_connection


#     if (GRIDSIZE == "8x8"):
#         cb_connection = "wireB <= in_s2t4"
#         return cb_connection
#     else:
#         cb_connection = st[EE + '.' + DDDDDDDD]
#         return st[EE + '.' + DDDDDDDD]

yikes_wire = None
def sb_iohack_find_pe_out(connection_list):
    # Find the wire that's connected to pe_out
    # An item in the list should look like this: "out_s1t0 <= pe_out"
    DBG = 0
    list_of_pe_outs = []
    for c in connection_list:
        # print "FOO " + c;
        pe_out = re.search("([A-z_0-9]+).*pe_out$", c);
        if (pe_out):
            iohack_pe_out = pe_out.group(1);
            if (DBG): print "FOUND IT! (%s); " % c,
            if (DBG): print "pe connects to %s" % iohack_pe_out
            list_of_pe_outs.append(iohack_pe_out);
            if (DBG): print "FOO " + str(list_of_pe_outs)

    howmany = len(list_of_pe_outs);
    if (DBG): print "Found %d pe_out's" % howmany
    if (howmany == 0):
        return 0;

    elif (howmany == 1):
        rval = list_of_pe_outs[0];
        if (DBG): print "One pe_out: " + rval
        return rval

    else:
        if (DBG): print "YIKES!  Too many pe_out's (for now)."
        rval = list_of_pe_outs[0];
        global yikes_wire
        yikes_wire = list_of_pe_outs[1];
        return rval;

def sb_print_nonzero(connection_list):
    # Print only sb connections with declared nonzero (nondefault) values

    # connection_list = sb_decode(int(RR), int(DDDDDDDD, 16));
    # Connection list contains a bunch of items
    # ['in_s1t0 -> out_s0t0', 'in_s1t0 -> out_s0t1', 'in_s1t0 -> out_s0t2',
    #  'in_s1t0 -> out_s0t3', 'in_s1t0 -> out_s0t4', 'in_s0t1 -> out_s1t0',
    #  'in_s0t1 -> out_s1t1', 'in_s0t1 -> out_s1t2', 'in_s0t1 -> out_s1t3',
    #  ...

    # Start with list of all connections, then
    # remove default (zero) connections from list.
    # Default (zero) connections look like this:
    #    out_s0.*in_s1
    #    out_s[123].*in_s0
    
    DBG = 0
    if DBG: print ""
    if DBG: print connection_list

    valid = []
    for c in connection_list:
        if (re.search("out_s0.*in_s1", c)):     continue
        if (re.search("out_s[123].*in_s0", c)): continue
        valid.append(c)
        if DBG: print "VALID " + str(valid)

    if (valid == []): print "(defaults only)"

    pad = ""
    for c in valid:
        print "%s%-19s" % (pad,c)
        pad = "%8s %8s %5s " % ("", "", "")

def sb_print_all(connection_list):
    # Print all sb connections, including defaults

    # connection_list = sb_decode(int(RR), int(DDDDDDDD, 16));
    # Connection list should contain sixteen items
    # ['in_s1t0 -> out_s0t0', 'in_s1t0 -> out_s0t1', 'in_s1t0 -> out_s0t2',
    #  'in_s1t0 -> out_s0t3', 'in_s1t0 -> out_s0t4', 'in_s0t1 -> out_s1t0',
    #  'in_s0t1 -> out_s1t1', 'in_s0t1 -> out_s1t2', 'in_s0t1 -> out_s1t3',
    #  'in_s0t1 -> out_s1t4', 'in_s0t2 -> out_s2t0', 'in_s0t2 -> out_s2t1',
    #  'in_s0t2 -> out_s2t2', 'in_s0t2 -> out_s2t3', 'in_s0t2 -> out_s2t4',
    #  'in_s0t3 -> out_s3t0']

    # This sorts them into three columns of five rows each:
    #     in_s1t0 -> out_s0t0    in_s0t1 -> out_s1t0    in_s0t2 -> out_s2t0
    #     in_s1t0 -> out_s0t1    in_s0t1 -> out_s1t1    in_s0t2 -> out_s2t1
    #     in_s1t0 -> out_s0t2    in_s0t1 -> out_s1t2    in_s0t2 -> out_s2t2
    #     in_s1t0 -> out_s0t3    in_s0t1 -> out_s1t3    in_s0t2 -> out_s2t3
    #     in_s1t0 -> out_s0t4    in_s0t1 -> out_s1t4    in_s0t2 -> out_s2t4

    # TBD/FIXME list should actually have sixteen items (in the case of RR=00)
    # plus four more for RR==01, for a total of 4x5=20, plus pipe connections for RR=01
    # !!!!!

    # print connection_list
    # print "\n".join(connection_list)

    # Behavior will change depending on whether we're decoding reg 1 or reg 2
    sbreg = 0;
    first_out = connection_list[0][0:8]
    if (first_out[0:8] == "out_s3t1"): sbreg = 1

#     first_out = connection_list[0][0:8]
#     if (first_out[0:8] == "out_s3t1"):
    if (sbreg==1):
        # Things are different if the switchbox reg is R1 instead of R0.
        # The connection list will have exactly FOUR "out" connections,
        # followed by an indeterminate number of "reg" directives:
        # 
        # ['out_s3t1 <= in_s0t1', 'out_s3t2 <= in_s0t2', 'out_s3t3 <= in_s0t3',
        #  'out_s3t4 <= in_s0t4', 'reg out_s0t0', 'reg out_s1t0']

        # Is this terrible code?  I think it might be.  Can't really tell anymore... :)

        col1 = connection_list[0:4];  # Four output connections
        col2 = connection_list[4:];   # Reg directives, presumably few.
        # print col1; print col2
        nlines = max( len(col1), len(col2) )
        for i in range (0,nlines):
            f1 = ""; f2 = "";
            if (i < len(col1)): f1 = col1[i]
            if (i < len(col2)): f2 = col2[i]
            if (i): print "%8s %8s %5s" % ("", "", ""),
            print "%-19s    %-19s" % (f1, f2);
        return;


    col1 = connection_list[0:5];   # print col1;
    col2 = connection_list[5:10];  # print col2;
    col3 = connection_list[10:15]; # print col3;

    # for i in range(0,5):
    for i in range(0, 5):
        # print "%8s %8s" % ("", ""),
        # if (i): print "%8s %8s %19s" % ("", "", ""),
        if (i): print "%8s %8s %5s" % ("", "", ""),
        print "%-19s    %-19s    %-19s" % (col1[i], col2[i], col3[i]);
    # One more
    print "%8s %8s %5s" % ("", "", ""),
    print "%-19s    %-19s    %-19s" % ("","",connection_list[15]);

def pe_decode(RR, DDDDDDDD):

    global asrc, bsrc, csrc, dsrc
    global areg, breg, creg, dreg

    # F000xxxx xxxxDDDD => load reg a w/ DDDD (once)
    # F100xxxx xxxxDDDD => load reg b w/ DDDD (once)
    # F300xxxx xxxxDDDD => load reg d w/ DDDD (once)

    # Load constants
    k = 0;
    DDDD = DDDDDDDD[4:8]   # last four hex digits
    dstring = "0x" + DDDD  # Same, with a "0x" in front
    # Note: C input unused/invalid for 2-input PEs!

    # Haha FIXME FIXME oh yeahhhh...this is gonna break big time
    # FIXME names should come from cgra_info
    # if (RR == "F0"): areg = dstring; k="op_a_in"
    # if (RR == "F1"): breg = dstring; k="op_b_in"
    # if (RR == "F2"): creg = dstring; k="op_c_in"
    # if (RR == "F3"): dreg = dstring; k="op_d_in"; print "\n\nFOOOOOOOOOOOOOOO\n\n"
    if (RR == "F0"): areg = dstring; k=OP_IN['a']
    if (RR == "F1"): breg = dstring; k=OP_IN['b']
    if (RR == "F2"): creg = dstring; k=OP_IN['c']
    if (RR == "F3"): dreg = dstring; k=OP_IN['d']; print "\n\nFOOOOOOOOOOOOOOO\n\n"

    if (k):
        if verbose:
            iohack = "";
            if (DDDDDDDD == "FFFFFFFF"): iohack = "IO HACK: "
            print "%sreg%s <= %s" % (iohack, k, dstring);
        if (DDDDDDDD == "FFFFFFFF"): return
        print "# data[(15, 0)] : init `%s` reg with const `%d`" % (k,int(dstring,16))
        return;

    if (RR == "00"):
        # print "# data[(15, 0)] : init `%s` reg with const `%d`" % (k,int(dstring,16))
        print "# data[(8, 0)] : lut_value = %d" % int(DDDDDDDD,16)
        return

    # Only other valid option is "FF" (load opcode)
    if (RR != "FF"):
        err = "ERROR decode.py: Unknown PE register code '%s'" % RR
        print err
        sys.stdout.flush()
        sys.stderr.write("\n\n%s" % err);
        sys.exit(-1);

    # (Note default value for all tiles is opcode = 16'h0000 (ADD)

    ########################################################################
    # Figure out sources for A, B inputs

    # FF00xxxx xxxxDDDD =>
    # case DDDD[15:8]: program behavior of operands A, B, D

    # 0xxx,xxxx => (always) read A from reg_a
    # 1xxx,xxxx => (always) read A from wire op_a_in
    # x1xx,xxxx => (always) load reg a from wire op_a_in
    # 
    # xx0x,xxxx => (always) read B from reg_b
    # xx1x,xxxx => (always) read B from wire op_b_in
    # xxx1,xxxx => (always) load reg b from wire op_b_in
    # 
    # xxxx,xx0x => (always) read D from reg_d
    # xxxx,xx1x => (always) read D from wire op_d_in
    # xxxx,xxx1 => (always) load reg a from wire op_d_in

    # (Note default value for all tiles is opcode = 16'h0000 (ADD, src=reg, reg=wire)

    dddd = int(DDDD,16) >> 8;
    if (dddd & 0x80): asrc = "wire `op_a_in`";
    if (dddd & 0x20): bsrc = "wire `op_b_in`";
    if (dddd & 0x02): dsrc = "wire `op_d_in`";


    ########################################################################
    ########################################################################
    ########################################################################
    # Consider:
    # leave asrc as is for now
    # calculate new/separate acomment,bcomment for decoder

    # FIXME these bits should come from cgra_info, yes?
    # 
    #    old   new
    # a 15,14  17,16 data0
    # b 13,12  19,18 data1
    # c 11,10  21,20 data2
    # d  9, 8  ????

    # FIXME this could be better. also missing c, d,e,f
    
    rmode = range(4)
    rmode[0] = "REG_CONST"  #  Output is constant 
    rmode[1] = "REG_VALID"  #  Pipeline delay with clock_en = 'clk_en'
    rmode[2] = "REG_BYPASS" # FF is bypassed
    rmode[3] = "REG_DELAY"  #  Assumes data is always valid, adds 1 cycle delay

    d0 = ((int(DDDDDDDD,16)>>16)&0x3); d0_comment = "# data[(17, 16)] : data0: %s" % rmode[d0]
    d1 = ((int(DDDDDDDD,16)>>18)&0x3); d1_comment = "# data[(19, 18)] : data1: %s" % rmode[d1]
    # print "d0 = %d" % d0
    # print "d1 = %d" % d1


#     if     (asrc == "wireA"): print "# data[15] : read from wire `op_a_in`"
#     else:                     print "# data[15] : read from reg `op_a_in`"
# 
#     if     (bsrc == "wireB"): print "# data[13] : read from wire `op_b_in`"
#     else:                     print "# data[13] : read from reg `op_b_in`"
# 
#     if     (dsrc == "wireD"): print "# data[2] : read from wire `op_d_in`"
#     else:                     print "# data[2] : read from reg `op_d_in`"

    if (dddd & 0x40): areg = "wireA";
    if (dddd & 0x10): breg = "wireB";
    if (dddd & 0x01): dreg = "wireD";

    ########################################################################
    # Set the PE operation

    # case DDDD[4:0]: program PE op type (default out1 = carry from adder)
    #   00: out16 = ADD(a,b)           out1 = carry
    #   01: out16 = SUB(a,b)           out1 = carry
    #   04: out16 = MAX(A,B)           out1 = GE(a,b)
    #   05: out16 = MIN(A,B)           out1 = LT(a,b)
    #   06: out16 = B                  out1 = XNOR reduction ~|(a^b) (?)
    #   07: out16 = A                  out1 = XOR  reduction  |(a^b) (?)
    #   08: out16 = MUX d ? a : b      out1 = carry
    #   0B: out16 = MUL(a,b)[15: 0]    out1 = carry
    #   0C: out16 = MUL(a,b)[23: 8]    out1 = carry
    #   0D: out16 = MUL(a,b)[31:16]    out1 = carry
    #   0F: LSHR out16 = a  >> b[3:0]  ...
    #   10: ASHR out16 = a >>> b[3:0]
    #   11: SHL  out16 = a <<< b[3:0]
    #   12: OR   out16 = a | b
    #   13: AND  out16 = a & b
    #   14: XOR  out16 = a ^ b
    #   15: NOT  out16 = ~a

#     op = DDDDDDDD[6:8] # last two hex digits
# 
#     if   (op == "00"): opstr = "pe_out <= ADD(A,B)"
#     elif (op == "01"): opstr = "pe_out <= SUB(A,B)"
# 
#     elif (op == "04"): opstr = "pe_out <= MAX(A,B), pe_out_p <= GE(A,B)"
#     elif (op == "05"): opstr = "pe_out <= MIN(A,B), pe_out_p <= LT(A,B)"
# 
#     elif (op == "06"): opstr = "pe_out <= B, pe_out_p <= XNOR reduction ~|(a^b) (?)"
#     elif (op == "07"): opstr = "pe_out <= A, pe_out_p <= XOR  reduction  |(a^b) (?)"
# 
#     elif (op == "08"): opstr = "pe_out <= MUX d ? a : b"
# 
#     elif (op == "0B"): opstr = "pe_out <= MUL(A,B)"
#     elif (op == "0C"): opstr = "pe_out <= MUL(A,B) [23:8]"
#     elif (op == "0D"): opstr = "pe_out <= MUL(A,B) [31:16]"
# 
#     elif (op == "0F"): opstr = "pe_out <= LSHR(A,B[3:0])"
#     elif (op == "10"): opstr = "pe_out <= ASHR(A,B[3:0])"
#     elif (op == "11"): opstr = "pe_out <=  SHL(A,B[3:0])"
# 
#     elif (op == "12"): opstr = "pe_out <=  OR(A,B)"
#     elif (op == "13"): opstr = "pe_out <= AND(A,B)"
#     elif (op == "14"): opstr = "pe_out <= XOR(A,B)"
#     elif (op == "15"): opstr = "pe_out <= NOT(A,B)"
# 
#     else:
#         sys.stdout.flush()
#         sys.stderr.write("\n\nERROR Unknown/invalid opcode for PE");
#         sys.exit(-1);
# 
#     print opstr;

    iohack = 0;

    op = DDDDDDDD[6:8] # last two hex digits
    A = "A"; B = "B";
    A = asrc; B = bsrc;

    # areg can be one of "wireA", "0x[0-9]+", "unset"
    if ((asrc == "reg `op_a_in`") and re.search("0x", areg)): A = areg;
    if ((bsrc == "reg `op_b_in`") and re.search("0x", breg)): B = breg;
    if ((asrc == "reg `op_c_in`") and re.search("0x", creg)): A = creg;
    if ((asrc == "reg `op_d_in`") and re.search("0x", dreg)): A = dreg;

#     if (op == "8B"):
#         print "okay here we go"
#         # Oh yes this will break things.
#         print ""
#         print "op = %s" % op
#         print "opi = %d" % opi
            
    # There are better ways to do this I'm sure... FIXME maybe
    if not (op == "F0" or op == "FF"):
        opi = int(op,16)
        op = "%02X" % (opi & 0x7F)
        if (opi & 0x80): print "# data[(7, 7)] : Enable Lut"





    if   (op == "00"): opp="add"; opstr = "ADD(%s,%s)" % (A,B)
    elif (op == "01"): opp="sub"; opstr = "SUB(%s,%s)" % (A,B)

    elif (op == "04"): opp="max/ge"; opstr = "MAX(%s,%s), pe_out_p <= GE(%s,%s)" % (A,B,A,B)
    elif (op == "05"): opp="min/lt"; opstr = "MIN(%s,%s), pe_out_p <= LT(%s,%s)" % (A,B,A,B)

    elif (op == "06"): opp="xnor"; opstr = "%s, pe_out_p <= XNOR reduction ~|(a^b) (?)" % (B)
    elif (op == "07"): opp="xor";  opstr = "%s, pe_out_p <= XOR  reduction  |(a^b) (?)" % (A)

    elif (op == "08"): opp="mux"; opstr = "MUX d ? a : b"

    elif (op == "0B"): opp="mul";       opstr = "MUL(%s,%s)"         % (A,B)
    elif (op == "0C"): opp="mul_23_8";  opstr = "MUL(%s,%s) [23:8]"  % (A,B)
    elif (op == "0D"): opp="mul_31_16"; opstr = "MUL(%s,%s) [31:16]" % (A,B)

    elif (op == "0F"): opp="lshr"; opstr = "LSHR(%s,%s[3:0])" % (A,B)
    elif (op == "10"): opp="ashr"; opstr = "ASHR(%s,%s[3:0])" % (A,B)
    elif (op == "11"): opp="shl";  opstr = " SHL(%s,%s[3:0])" % (A,B)

    elif (op == "12"): opp="or";  opstr = " OR(%s,%s)" % (A,B)
    elif (op == "13"): opp="and"; opstr = "AND(%s,%s)" % (A,B)
    elif (op == "14"): opp="xor"; opstr = "XOR(%s,%s)" % (A,B)
    elif (op == "15"): opp="not"; opstr = "NOT(%s,%s)" % (A,B)

    elif (op == "80"):
        print "# data[(9, 9)] : Enable Lut"
        return

    elif (op == "F0"):
        # IO hack/inputs
        #   FF00xxxx 000000F0    # (op==F0): pe_out is input to CGRA
        #   F000xxxx FFFFFFFF   # IO input pad: ignore pe_in_a
        #   F100xxxx FFFFFFFF   # IO input pad: ignore pe_in_b

        # opstr = "# data[(4, 0)] : op = input"
        # if verbose: opstr = "IO HACK: pe_out is CGRA INPUT" + opstr;

        opp = "input"
        opstr = "IO HACK: pe_out is CGRA INPUT"

        iohack = 1;
        # opstr = opstr + "\n                        " + \
        #         "(IN  wire_0_3_BUS16_S1_T0) (out_s1t0)"

    elif (op == "FF"):
        # IO hack/outputs
        #   FF00xxxx 000000FF    # (op==FF): pe_in_a (wireA) is CGRA output
        #   F1000004 00000000    # IO output pad: ignore pe_in_b

        # opstr = "# data[(4, 0)] : op = output"
        # if verbose: opstr = "IO HACK: pe_in_a (wireA) is CGRA OUTPUT" + opstr;

        opp = "output"
        opstr = "IO HACK: pe_in_a (wireA) is CGRA OUTPUT"

        iohack = 1;

        # opstr = opstr + "\n                        " + \
        #         "(OUT wire_1_1_BUS16_S3_T0) (in_s1t0)"

    else:
        print "ERROR decode.py: Unknown/invalid opcode for PE '%s'" % op
        sys.stdout.flush()
        sys.stderr.write("\n\nERROR Unknown/invalid opcode for PE");
        sys.exit(-1);

    # PRINT:
    # "pe_out <= MUL(wireA,wireB) ; regA <= wireA (always) ; regB <= wireB (always)"

    # Oops FIXME bits should come from cgra_info
    print "# data[(4, 0)] : alu_op = %s" % opp
    # print "# data[(5, 0)] : alu_op = %s" % opp

    if (not iohack):
        # FIXME when/if have an op that uses d, will want to activate this...
        # print "# data[2] : read from "  + dsrc

        # Got to get the order correct!  Now don't we.
        # if breg == "wireB": print "# data[(12, 12)] : load `op_b_in` reg with wire"
        # if (1):             print "# data[(13, 13)] : read from " + bsrc
        # if areg == "wireA": print "# data[(14, 14)] : load `op_a_in` reg with wire"
        # if (1):             print "# data[(15, 15)] : read from " + asrc

        # if dreg == "wireD": print "BOOOOOOOOOOOOOOOOO " + DDDD + "  " + str(dddd);
        print d0_comment
        print d1_comment




    if verbose:
        reg = ""
        indent = " ; "
        opstr = "pe_out <= " + opstr
        if (areg == "wireA"): reg = indent + "regA <= wireA (always)"
        if (breg == "wireB"): reg = indent + "regB <= wireB (always)"
        if (creg == "wireC"): reg = indent + "regC <= wireC (always)"
        if (dreg == "wireD"): reg = indent + "regD <= wireD (always)"
        print opstr + reg

def found_new_tile(prevtile, thistile):
        # Sources for PE inputs (defaults from verilog test_pe.v and test_opt_reg.v)

        # print "# TILE %d %s" % (thistile, rc)
        # print "####################### TILE %d %s" % (thistile, rc)
        if (verbose):
            [r,c] = cgra_info.tileno2rc(thistile); rc = "(%d,%d)" % (r,c)
            print ""
            print "                        TILE %d %s" % (thistile, rc)

        # valid values for e.g. asrc: "wire `op_a_in`" or "reg `op_a_in`" or (deprecated) "0x[0-9]+"
        global asrc, bsrc, csrc, dsrc
        (asrc, bsrc, csrc, dsrc) = ("reg `op_a_in`", "reg `op_b_in`", "reg `op_c_in`", "reg `op_d_in`")

        # Contents of PE input regs
        # valid values for e.g. areg: "0x[0-9]+" or 'wireA' or 'unset'
        global areg, breg, creg, dreg
        (areg, breg, creg, dreg) = ("unset", "unset", "unset", "unset")

##############################################################################
# MAIN
prevtile = -1
# inputstream = sys.stdin;
inputstream = open(bitstream_filename);
# print inputstream.next();
iohack_cb_out = {};
iohack_pe_out = {};
iohack_io_tiles = {};
for line in inputstream:
    line = line.strip(); # Ugh "strip is the worst...ugly but necessary.

    # Address RREETTTT
    f = re.search("(..)(..)(....) (........)", line);
    if (not f): continue

    RR = f.group(1);       # register
    EE = f.group(2);       # element
    TTTT = f.group(3);     # tile
    DDDDDDDD = f.group(4); # data

    # tmpaddr = RR+EE+TTTT; if (tmpaddr == "00050009"): print "\nFOO %s" % line

    thistile = int(TTTT,16)
    if (thistile != prevtile):

        # found_new_tile() initializes globals asrc, areg, [bcd]{src,reg}
        found_new_tile(prevtile, thistile)
        prevtile = thistile

    # print line,
    # # print "[ r%02X e%02X %-5s ]  " % \
    # #     (int(RR,16) ,int(EE,16) ,"(" + EE_decode(EE) + ")" \
    # #  ),
    # # print "%-5s  " % ("(" + EE_decode(EE) + ")"),
    # print "[%-3s]" % (EE_decode(EE)),

    if verbose: print "%s [%-3s]" % (line, (EE_decode(EE))),
    else:       print line

    # Switchbox (new)
    e = cgra_info.get_element(EE, TTTT)
    if (e == False):
        print "ERROR Cannot find element '%s' in tile '%s' (%d)" \
              % (EE,TTTT, thistile)
        sys.exit(-1)

    if (e.tag == "mem"):
        # print "OOP found memory"
        cgra_info.mem_decode(e, DDDDDDDD)
        continue


    elif (e.tag == "cb"):
        # 00040011 00000005
        # # data[(3, 0)] : @ tile (3, 2) connect wire 5 (in_0_BUS16_2_0) to din
        inwire = cgra_info.cb_decode(e,thistile,DDDDDDDD)
        iohack_cb_out[thistile] = inwire
        continue

    # Switchbox (new)
    elif (e.tag == "sb"):
        DBG=0
        # if (tmpaddr == "00050009"): DBG = 1

        (regs,connections) = cgra_info.sb_decode(e,RR,DDDDDDDD)
        if DBG:
            print "----------------------------------------"
            print connections
            print regs
            print "----------------------------------------"

        # Hm.  They have to be printed in a certain order according to bit number
        comments = [None]*32

        # Want:
        # "data[(1, 0)] : @ tile (0, 1) connect wire 3 (pe_out_res) to out_BUS16_S0_T0"
        t = thistile
        [r,c] = cgra_info.tileno2rc(t); rc = "(%d, %d)" % (r,c);
        for outwire in sorted(connections.iterkeys()):
            # print outwire + " " + str(connections[outwire])
            (inwire,configh,configl,wireno) = connections[outwire]

            # HACK HACK FIXME
            # if HACK1 => only list connections where wireno != 0

            printwire = True
            if HACK1:
                # FIXME print "HACK1 only printing connections with wireno != 0"
                printwire = (wireno != 0)

            if (printwire):
                # Adjust bits so they fit in their 32-bit register!
                (configh,configl) = (configh%32,configl%32)

                # If the wires being connected are in lower half of a mem tile,
                # must increment row by 1
                # 
                # WRONG: @ tile (0, 3) connect wire 1 (in_1_BUS16_1_3) to sb_wire_out_1_BUS16_3_3
                # RIGHT: @ tile (1, 3) connect wire 1 (in_1_BUS16_1_3) to sb_wire_out_1_BUS16_3_3
                #
                # Here's a table that should help
                # 
                # wire     side  half     example
                # -------- ----  -------  -------
                # in0/out0  023  top      in_0_BUS16_2_2
                # in0/out0    1  ?        in_0_BUS16_1_2
                #
                # in1/out1  012  bottom   out_1_BUS16_2_2
                # in1/out1    3  ?        sb_wire_in_1_BUS16_3_4

                r2 = r
                if re.search('(in|out)_1_BUS16_[012]', inwire+outwire):
                    r2 = r + 1

                # OOPS want this special case to be in bottom half:
                # data[(1, 0)] : @ tile (2, 3) connect wire 3 (mem_out) to sb_wire_out_1_BUS16_3_1
                # if (inwire == "mem_out") and re.search('sb_wire_out_1_BUS16_3', outwire):
                if re.search('mem_out.*sb_wire_out_1_BUS16_3', inwire+outwire):
                    r2 = r + 1

                # print "# data[(%d, %d)] : @ tile (%d, %d) connect wire %d (%s) to %s"\
                #       % (configh,configl,r2,c,wireno,inwire,outwire)
                comments[configh] = "# data[(%d, %d)] : @ tile (%d, %d) connect wire %d (%s) to %s"\
                      % (configh,configl,r2,c,wireno,inwire,outwire)

            if (inwire == "pe_out_res"):
                DBG=0
                if (DBG): print "FOUND IT!",
                if (DBG): print "pe connects to %s in tile %d" % (outwire,thistile)
                iohack_pe_out[thistile] = outwire;

        # LIST REGISTERS like so
        # data[(13, 13)] : @ tile (0, 2) latch wire 0 (in_BUS16_S0_T0)
        # before connecting to out_BUS16_S1_T0

        # for outwire in sorted(connections.iterkeys()):
        for reg in regs:
            if DBG: print "OOP found reg %s" % str(reg)
            (outwire,bitno) = reg

            # Some wires are in the lower half of a memtile
            # FIXME Elsewhere we used side 3 as part of criteria e.g.
            # if re.search('sb_wire_out_1_BUS16_3', wire): r = r+1
            if re.search('sb_wire_out_1_', outwire): r = r + 1

            comments[bitno] = "# data[(%d, %d)] : @ tile (%d, %d) latch output wire %s"\
                  % (bitno,bitno,r,c,outwire)

        if verbose: print "" # This is CRUCIAL, mon.
        for c in comments:
            if c: print c

        continue

    else:
        if 0: print "Could not find tag %s" %  e.tag

    # Processing element
    if (EE == "00"):
        pe_decode(RR, DDDDDDDD);

        # IO hack
        op = DDDDDDDD[6:8] # last two hex digits

        # print "RR=%s and op=%s" % (RR,op)


        if ( (RR=="FF") and (op=="FF") ): iohack_io_tiles[thistile] = "output";
        if ( (RR=="FF") and (op=="F0") ):
            iohack_io_tiles[thistile] = "input";
            # print "iohack_io_tiles[%s] = %s" % (thistile, iohack_io_tiles[thistile])
            # print "\n\nFOO input\n\n"
            # print "\n\nFOO output\n\n"
            


    # Connection box
    elif (EE == "02" or EE == "03"):
        print "FOOOO NEVER USED, RIGHT?"
        # print "%s   # %s" % (line, cb_decode(EE,DDDDDDDD));

        t = int(TTTT,16)
        [r,c] = cgra_info.tileno2rc(t); rc = "(%d, %d)" % (r,c);
        cb_connection = cb_decode(EE,DDDDDDDD,r,c);  # E.g. "wireA <= in_s1t0"
        print "%s" % (cb_connection);

        # cb_connection = '...connect wire 3 (in_BUS16_S1_T1) to a'
        parse = re.search("((in|out)_BUS16_.*)\)", cb_connection)

        # IOHACK/new
        if (parse):
            # Support for io hack (new)
            # print "\n\nGOOOO '%s'" % parse.group(1)
            iohack_cb_out[thistile] = parse.group(1)

        # IOHACK/old
        else:
            # Support for io hack (old)
            # Last 7 chars of string I guess e.g. iohack_cb_out[4] = "in_s1t0"
            # global iohack_cb_out[];
            iohack_cb_out[thistile] = cb_connection[-7:]

    # Switchbox (old)
    # elif (EE == "05"):
    #     connection_list = sb_decode(int(RR), int(DDDDDDDD, 16));
    #     if (verbose): sb_print_all(connection_list);
    #     else:            sb_print_nonzero(connection_list);
    #     pe_out = sb_iohack_find_pe_out(connection_list);
    #     if (pe_out):
    #         # print "FOUND IT! pe connects to %s" % pe_out
    #         iohack_pe_out[thistile] = pe_out;

    else:
        if verbose: print "";



# OUTPUT tiles go to wire indicated by iohack_cb_out
# INPUT tiles take input from wire idicated by sb[pe_out]

# for i in iohack_cb_out:
#     print "FOO iohack_cb_out[%d] = %s" % (i, iohack_cb_out[i])
    
# for i in iohack_io_tiles:
#     print "FOO iohack_io_tiles[%d] = %s" % (i, iohack_io_tiles[i])
#     io = iohack_io_tiles[i]
#     if (io == "input" ): print "  input from ?%s?" % (iohack_pe_out[i])
#     if (io == "output"): print "  output to ?%s?"  % (iohack_cb_out[i])
# 
# print "HEYYY"

if (iohack_io_tiles == {}):
    inputstream.close();
    sys.exit(0);

print "# I/O Summary:"
for t in iohack_io_tiles:
    io = iohack_io_tiles[t];
    [r,c] = cgra_info.tileno2rc(t); rc = "(%d,%d)" % (r,c);
    tile = "tile %2d (%d,%d)" % (t, r, c);
    if (io == "input" ):

#         print "About to fail.  t = %s, io='%s'" % (t, io)
#         print "iohack_io_tiles = "; print iohack_io_tiles
#         print "iohack_pe_out = "; print iohack_pe_out

        if (iohack_pe_out == {}):
            print ""
            print "ERROR Did not find output wire"
            print ""
            # sys.exit(-1) # (let it fail on its own, so to dump trace)"

        inwire = iohack_pe_out[t]
        input_wirename  = "%8s / %s" % ( inwire, find_source(r,c, inwire))
        print "# INPUT  %s / %s" % (tile, input_wirename)

        if (not yikes_wire == None):
            yikes_wirename  = "%8s / %s" % ( inwire, find_source(r,c, yikes_wire))
            print "# YIKES  %s / %s" % (tile, yikes_wirename)

        # else: print "FOO no yikes wire"

    if (io == "output"):
        outwire = iohack_cb_out[t];
        output_wirename = "%8s / %s" % (outwire, find_source(r,c,outwire));
        print "# OUTPUT %s / %8s" % (tile, output_wirename)

########################################################################
# In io.xml format:
#   <io name='ioin' type='source'>
#     <wire_name>wire_0_0_BUS16_S1_T0</wire_name>
#   <io name='ioout' type='sink'>
#     <wire_name>wire_1_0_BUS16_S1_T5</wire_name>

print "  <io name='ioin' type='source'>"
for t in iohack_io_tiles:
    io = iohack_io_tiles[t];
    [r,c] = cgra_info.tileno2rc(t);
    if (io == "input" ):
        inwire = iohack_pe_out[t]
        input_wirename  = find_source(r,c, inwire)
        print "    <wire_name>%s</wire_name>" % (input_wirename)


print "  <io name='ioout' type='sink'>"
for t in iohack_io_tiles:
    io = iohack_io_tiles[t];
    [r,c] = cgra_info.tileno2rc(t);
    if (io == "output" ):
        outwire = iohack_cb_out[t];
        output_wirename = find_source(r,c,outwire)
        print "    <wire_name>%s</wire_name>" % (output_wirename)

inputstream.close();
