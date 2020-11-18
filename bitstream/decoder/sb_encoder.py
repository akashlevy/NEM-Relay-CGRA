#!/usr/bin/python
import sys;
import os;
# import re;


# Automatic switchbox encoder.

##############################################################################
# Use "--help" flag for more info
# 
# Given ntracks = n_buses_per_side, generate a switchbox decoder.
# (ntracks defaults to 5)
#
# -full for full decode
# -abbrev for abbreviated decode (default)
#
# Assumes four sides per tile, and four possible inputs for each mux
# (in1, in2, in3, and pe_out)

# FIXME update examples
##############################################################################
# Example (-full)
# ---------------------
# % sb_encoder.py -full
# 
# Using ntracks = 5
# 
# // SIDE 0
# case(sb[1:0]) // TRACK 0
#     0: out_0_0 <= in_0_0         // (r0 & 00000003) == 00000000
#     1: out_0_0 <= in_1_0         // (r0 & 00000003) == 00000001
#     2: out_0_0 <= in_3_0         // (r0 & 00000003) == 00000002
#     3: out_0_0 <= pe_output_0    // (r0 & 00000003) == 00000003
# 
# case(sb[3:2]) // TRACK 1
#     0: out_0_1 <= in_0_0         // (r0 & 0000000C) == 00000000
#     1: out_0_1 <= in_1_0         // (r0 & 0000000C) == 00000004
#     2: out_0_1 <= in_3_0         // (r0 & 0000000C) == 00000008
#     3: out_0_1 <= pe_output_0    // (r0 & 0000000C) == 0000000C
# ...
# // SIDE 2 pipelining
#   sb[50]: enable pipereg for out_2_0   // (r1 & 00040000) == 00040000
#   sb[51]: enable pipereg for out_2_1   // (r1 & 00080000) == 00080000
#   sb[52]: enable pipereg for out_2_2   // (r1 & 00100000) == 00100000
#   sb[53]: enable pipereg for out_2_3   // (r1 & 00200000) == 00200000
#   sb[54]: enable pipereg for out_2_4   // (r1 & 00400000) == 00400000


##############################################################################
# Example (-abbrev)
# -----------------------
# % sb_encoder.py -abbrev
#
# Using ntracks = 5
# 
# // SIDE 0
# ...
# // SIDE 1
# ...
# // SIDE 2
# ...
# // SIDE 3
#   sb[31:30]:  out_3_0 <= {in_0_3, in_1_3, in_3_3, pe_output_0}
#   sb[33:32]:  out_3_1 <= {in_0_3, in_1_3, in_3_3, pe_output_0}
#   sb[35:34]:  out_3_2 <= {in_0_3, in_1_3, in_3_3, pe_output_0}
#   sb[37:36]:  out_3_3 <= {in_0_3, in_1_3, in_3_3, pe_output_0}
#   sb[39:38]:  out_3_4 <= {in_0_3, in_1_3, in_3_3, pe_output_0}
# 
# 
# // REGISTERS
# // SIDE 0:  sb[44,43,42,41,40]: enable pipereg for out_0_[01234]
# // SIDE 1:  sb[49,48,47,46,45]: enable pipereg for out_1_[01234]
# // SIDE 2:  sb[54,53,52,51,50]: enable pipereg for out_2_[01234]
# // SIDE 3:  sb[59,58,57,56,55]: enable pipereg for out_3_[01234]

def build_c_compare(hibit, lobit, val):
    # Build a comparison to tell whether the bitfield defined by [hibit:lobit] is equal to "val"
    # 
    # Bits 0-31 live in "r0" and bits 32-63 live in "r1"
    # Examples:
    #    build_c_compare(  1,0,   3 ) = "(r0 & 00000003) == 00000003"
    #    build_c_compare( 39,38,  2 ) = "(r1 & 000000C0) == 00000080"

    # Unflagged error if lobit and hibit are not in the same reg
    # Unflagged error if bitno > 63 or < 0

    reg  = "r0"  if (lobit < 32) else "r1";
    rbit = lobit if (lobit < 32) else (lobit - 32);
    mask = (2 ** (hibit - lobit + 1)) - 1;

    rval = "(%s & %08X) == %08X" % (reg, (mask << rbit), (val << rbit));

    return rval;

# Test build_c_compare
# print build_c_compare(  1,0,   3 ); # = "(r0 & 00000003) == 00000003"
# print build_c_compare( 39,38,  2 ); # = "(r1 & 000000C0) == 00000080"
# sys.exit(0);

##############################################################################
# Given ntracks = n_buses_per_side, generate a switchbox decoder.
#
# -full for full decode
# -abbrev for abbreviated decode
#
# Assumes four sides per tile, and four possible inputs for each mux
# (in1, in2, in3, and pe_out)

# Switchbox data word is spread across two 32-bit registers to
# accomodate twenty two-bit fields (twenty because five tracks per
# side times four sides):
# 
#   reg1:    XX        [pipe3]  [pipe2]     [pipe1]       [pipe0] [34][33] [32][31]
#   reg0: [30][24] [23][22] [21][20] [14][13]   [12][11] [10][04] [03][02] [01][00]
# 
# where each five-bit field "pipe<S>" maps to an output out_<S>_[43210] telling
# whether or not to insert a pipeline register in front of the output i.e.
#
#   assign out_0_0 = config_sb[40] ? out_0_0_id1 : out_0_0_i; 
#   assign out_0_1 = config_sb[41] ? out_0_1_id1 : out_0_1_i; 
#   assign out_0_2 = config_sb[42] ? out_0_2_id1 : out_0_2_i; 
#   assign out_0_3 = config_sb[43] ? out_0_3_id1 : out_0_3_i; 
#   assign out_0_4 = config_sb[44] ? out_0_4_id1 : out_0_4_i; 
# 
#   assign out_1_0 = config_sb[45] ? out_1_0_id1 : out_1_0_i; 
#   assign out_1_1 = config_sb[46] ? out_1_1_id1 : out_1_1_i; 
#   assign out_1_2 = config_sb[47] ? out_1_2_id1 : out_1_2_i; 
#   assign out_1_3 = config_sb[48] ? out_1_3_id1 : out_1_3_i; 
#   assign out_1_4 = config_sb[49] ? out_1_4_id1 : out_1_4_i; 
# 
#   assign out_2_0 = config_sb[50] ? out_2_0_id1 : out_2_0_i; 
#   assign out_2_1 = config_sb[51] ? out_2_1_id1 : out_2_1_i; 
#   assign out_2_2 = config_sb[52] ? out_2_2_id1 : out_2_2_i; 
#   assign out_2_3 = config_sb[53] ? out_2_3_id1 : out_2_3_i; 
#   assign out_2_4 = config_sb[54] ? out_2_4_id1 : out_2_4_i; 
# 
#   assign out_3_0 = config_sb[55] ? out_3_0_id1 : out_3_0_i; 
#   assign out_3_1 = config_sb[56] ? out_3_1_id1 : out_3_1_i; 
#   assign out_3_2 = config_sb[57] ? out_3_2_id1 : out_3_2_i; 
#   assign out_3_3 = config_sb[58] ? out_3_3_id1 : out_3_3_i; 
#   assign out_3_4 = config_sb[59] ? out_3_4_id1 : out_3_4_i; 
#
# and where each two-bit field ST={34,33,32,...00} has a value {0,1,2,3}
# denoting the connection for output bus out_S_T_i to input wires
# {in_{a,b,c}_T, pe_output_0} respectively, and where
#    out_S_T_i => "unregistered output bus on side S track T"
#    sides S {0,1,2,3} map to {E,S,W,N} sides respectively
#    in_{1,2,3}_T => "input bus on track T of side {S+1,S+2,S+3} respectively
#    abc = {123,023,013,012} for sides S = {0,1,2,3} respectively
# 
# Examples: least two bits ST=00 (sb[1:0]) are interpreted as follows:
#     sb[1:0]
#     0: out_0_0_i = in_1_0;
#     1: out_0_0_i = in_2_0;
#     2: out_0_0_i = in_3_0;
#     3: out_0_0_i = pe_output_0;
# 
# ...and e.g. middle bits [23] would be interpreted
#     sb[27:26]
#     0: out_2_3_i = in_0_3;
#     1: out_2_3_i = in_1_3;
#     2: out_2_3_i = in_3_3;
#     3: out_2_3_i = pe_output_0;

# Count how many command-line arguments.
nargs = len(sys.argv)
# print "found", len(sys.argv), "args"

# Process the command-line arguments
scriptname = sys.argv[0];
args = sys.argv[1:];

usage = "\n"\
  + "Builds a switchbox encoder for indicated number of tracks (default=5).\n"\
  + "Usage:\n"\
  + "   %s <-ntracks %%d> <-full | -abbrev>\n" % scriptname\
  + "   %s --help\n" % scriptname\
  + ""


# usage = "\n%s\nUsage:\n\n    %s\n    %s" % (usage0,usage1,usage2);


# Check for "-full" flag
abbrev = 1;
ntracks = 5;
while len(args) > 0:
    if   (args[0] == '--help')  : print usage; sys.exit(0);
    elif (args[0] == '-full')   : abbrev = 0;
    elif (args[0] == '-abbrev') : abbrev = 1;
    elif (args[0] == '-ntracks'): ntracks = int(args[1]); args = args[1:];
    else: sys.stderr.write("WARNING Unknown arg '%s'\n" % args[0]);
    args = args[1:];  # shift!
print;

print "Using ntracks = %d," % ntracks,
print "abbrev = %d" % abbrev;
print ""

bitno = 0;
for s_out in {0,1,2,3}:
  print "// SIDE %d" % s_out;
  for track in range(0, ntracks):
    outbus = "out_s%dt%d" % (s_out, track);

    # abbrev = 1;
    # if (abbrev == 0):

    # Build a set of four input wires {in_{a,b,c}_T, pe_output_0}
    # where abc = {123,023,013,012} for sides S = {0,1,2,3} respectively
    input_set = [];
    for i in {0,1,2,3}:
        # input_set.append("in_s%dt%d" % (i, s_out));
        input_set.append("in_s%dt%d" % (i, track));
    del input_set[s_out];
    input_set.append(" pe_out");

    if (abbrev):
     # sb[ 1: 0]:  out_s0t0 <= {in_s1t0, in_s2t0, in_s3t0,  pe_out}

        print "  sb[%2d:%2d]: " % (bitno+1, bitno),
        print "%s <= {%s, %s, %s, %s}" % (outbus, input_set[0], input_set[1], input_set[2], input_set[3]);

    else:
        # case(sb[1:0]) // TRACK 0
        #     0: out_s0t0 <= in_s1t0    // (r0 & 00000003) == 00000000
        #     1: out_s0t0 <= in_s2t0    // (r0 & 00000003) == 00000001
        #     2: out_s0t0 <= in_s3t0    // (r0 & 00000003) == 00000002
        #     3: out_s0t0 <=  pe_out    // (r0 & 00000003) == 00000003

        print "case(sb[%d:%d]) // TRACK %d" % (bitno+1, bitno, track);
        for i in [0,1,2,3]:

            # vlog = "0: out_s0t0 <= in_s1t0"
            vlog = "%d: %s <= %-7s" % (i, outbus, input_set[i]);

            # clang = "(r0 & 00000003) == 00000000"
            clang = build_c_compare(bitno+1, bitno,   i);

            # "0: out_s0t0 <= in_s1t0    // (r0 & 00000003) == 00000000"
            print "    %s    // %s" % (vlog, clang);

        print ""

    bitno = bitno + 2;
  print

# Not done!  Now do pipeline registers.

if (abbrev):
    # ABBREV
    print
    print "// REGISTERS"
    for s_out in {0,1,2,3}:
      # print "// SIDE %d pipelining" % s_out;
      print "// SIDE %d: " % s_out,
      bits = range(bitno+4,bitno-1,-1)
      # bitstring = ",".join(bits);
      bitstring = ','.join(str(x) for x in range(bitno+4,bitno-1,-1))
      tstring = ''.join(str(x) for x in range(0,5))
      # print bits
      print "sb[%s]: enable pipereg for out_%d_[%s]" % (bitstring, s_out, tstring);
      bitno = bitno + 5

else:
    # FULL
    # // SIDE 0 pipelining
    #   sb[40]: enable pipereg for out_0_0   // (sb2 & 00000100) == 00000100
    #   sb[41]: enable pipereg for out_0_1   // (sb2 & 00000200) == 00000200
    #   sb[42]: enable pipereg for out_0_2   // (sb2 & 00000400) == 00000400
    #   sb[43]: enable pipereg for out_0_3   // (sb2 & 00000800) == 00000800
    #   sb[44]: enable pipereg for out_0_4   // (sb2 & 00001000) == 00001000

    for s_out in {0,1,2,3}:
      print "// SIDE %d pipelining" % s_out;
      for t in range(0, ntracks):

        # "(r1 & 00008000) == 00008000"
        comp = build_c_compare(bitno, bitno,    1);

        print "  sb[%d]: enable pipereg for out_%d_%d   // %s" % (bitno, s_out, t, comp);
        bitno = bitno + 1;

##############################################################################
# OLD
#         #     0: out_0_0 <= in_0_0      // xxxx xxxx xxxx xxxx xxxx xxxx xxxx xx00
#             b = bit_encode(32, bitno+1,bitno, i);
#             # now b = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx00"
# 
#             b = list(b)
#             for s in range(4,36,5): b.insert(s,' ');
#             b = ''.join(b);
#             # now b = list("xxxx xxxx xxxx xxxx xxxx xxxx xxxx xx00")

