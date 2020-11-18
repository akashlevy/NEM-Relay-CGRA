#!/usr/bin/python2

import sys
import re
import os

# Import cgra_info via relative path
mypath = os.path.realpath(__file__)
mydir  = os.path.dirname(mypath)
decoder_path = mydir+"/../decoder"
sys.path.insert(0, decoder_path)
from lib import cgra_info

# cgra_info.read_cgra_info('foo')
# w = "T14_out_s5t1"
# cgra=cgra_info.canon2cgra(w)
# # print w, cgra
# glob = cgra_info.canon2global(w)
# print w, cgra, glob
#
# exit()

# FIXME temprorary backward-compatibility hack
global FOUND_SIXTEEN
FOUND_SIXTEEN = False

# FIXME should be set by set_sign_bit_encoding() or something
# FIXME2 should come from cgra_info.txt I guess

def set_sign_bit_info():
    bitpos = cgra_info.sign_bit_position()
    global SIGN_BIT
    SIGN_BIT = {}
    # SIGN_BIT['u']= (0 << 6)
    # SIGN_BIT['s']= (1 << 6)
    SIGN_BIT['u'] = (0 << bitpos)
    SIGN_BIT['s'] = (1 << bitpos)

# PE_FLAG dictionary set by set_pe_flags(), below
global PE_FLAG
    # egrep 'localparam.*PE_FLAG' $top/genesis_verif/test_pe_unq1.sv 
    # localparam PE_FLAG_EQ = 4'h0;
    # localparam PE_FLAG_NE = 4'h1;
    # localparam PE_FLAG_CS = 4'h2;
    # localparam PE_FLAG_CC = 4'h3;
    # localparam PE_FLAG_MI = 4'h4;
    # localparam PE_FLAG_PL = 4'h5;
    # localparam PE_FLAG_VS = 4'h6;
    # localparam PE_FLAG_VC = 4'h7;
    # localparam PE_FLAG_HI = 4'h8;
    # localparam PE_FLAG_LS = 4'h9;
    # localparam PE_FLAG_GE = 4'hA;
    # localparam PE_FLAG_LT = 4'hB;
    # localparam PE_FLAG_GT = 4'hC;
    # localparam PE_FLAG_LE = 4'hD;
    # localparam PE_FLAG_LUT = 4'hE;
    # localparam PE_FLAG_PE  = 4'hF;


# FIXME I guess these should all come from cgra_info.txt maybe
# FIXME op_data dictionary info should come from design/cgra_info
# FIXME op_data is global, should be upper-case :(
global op_data
op_data = {} # dictionary
    # FIXME where is LUT??
    # % grep localparam $top/genesis_verif/test_pe_comp* | grep _OP
    # localparam PE_ADD_OP     = 6'h0;
    # localparam PE_SUB_OP     = 6'h1;
    # localparam PE_ABS_OP     = 6'h3;
    # localparam PE_GTE_MAX_OP = 6'h4;
    # localparam PE_LTE_MIN_OP = 6'h5;
    # localparam PE_SEL_OP     = 6'h8;
    # localparam PE_MULT_0_OP  = 6'hB;
    # localparam PE_MULT_1_OP  = 6'hC;
    # localparam PE_MULT_2_OP  = 6'hD;
    # localparam PE_RSHFT_OP   = 6'hF;
    # localparam PE_LSHFT_OP   = 6'h11;
    # localparam PE_OR_OP      = 6'h12;
    # localparam PE_AND_OP     = 6'h13;
    # localparam PE_XOR_OP     = 6'h14;

    # NOT ELABORATED: eq, cntr, div
    # % grep localparam $top/../pe_new/pe/rtl/test_pe_comp.svp | grep _OP
    # localparam PE_EQ_OP      = 6'h6; # NOPE it's gone now...?
    # localparam PE_CNTR_OP    = 6'h18;
    # localparam PE_DIV_OP     = 6'h19;

op_data['add']     = 0x00000000
op_data['sub']     = 0x00000001
op_data['abs']     = 0x00000003
op_data['gte_max'] = 0x00000004
op_data['lte_min'] = 0x00000005
#op_data['eq']     = 0x00000006  OOPS no not supported see above/below
op_data['sel']     = 0x00000008
op_data['mult_0']  = 0x0000000B
op_data['mult_1']  = 0x0000000C
op_data['mult_2']  = 0x0000000D
op_data['rshft']   = 0x0000000F
op_data['lshft']   = 0x00000011
op_data['or']      = 0x00000012
op_data['and']     = 0x00000013
op_data['xor']     = 0x00000014

op_data['lut']     = 0x0000000E # ?? right ??


def harris_aliases():
    # NOTE FIXME 180929 this should no longer be necessary (below)
    # Added for Harris 7/2018, probably should NOT work...
    # FIXME Will have to fix this some day SOON maybe
    # signed, unsigned, who cares!!!???  all map to same FIXME
    # Bit 6 decides signed/unsigned
    global op_data
    global SIGN_BIT
    op_data['ashr'] = op_data['rshft']   | SIGN_BIT['s']
    op_data['smax'] = op_data['gte_max'] | SIGN_BIT['s']
    op_data['sle']  = op_data['lte_min'] | SIGN_BIT['s']
    op_data['sge']  = op_data['gte_max'] | SIGN_BIT['s']

#FIXME op_data should only be accessed via this function!!!
def get_op_data(opname): return op_data[get_alias(opname)]


##############################################################################
# Aliases

global ALIAS
ALIAS = {}

ALIAS['eq'] = 'sub.eq'
ALIAS['neq'] = 'sub.ne'

# aliases (gt/lt/ge/min/max...)
# Is this right?  I guess this is right.  Coreir uses ule/uge maybe?
ALIAS['gte']     = 'sub.ge'
ALIAS['ge']      = 'sub.ge'

ALIAS['lte']     = 'sub.le'
ALIAS['le']      = 'sub.le'

ALIAS['gt']      = 'sub.gt'
ALIAS['lt']      = 'sub.lt'

ALIAS['max']     = 'gte_max'
ALIAS['min']     = 'lte_min'

# Aliases (other)
ALIAS['mul']     = 'mult_0'
ALIAS['mux']     = 'sel'

def get_alias(opname,DBG=0):
    global ALIAS
    orig_name = opname
    if DBG>2: print("1 Found op '%s'" % opname)
    while opname in ALIAS:
        if DBG>2: print("2 Found alias '%s'" % ALIAS[opname])
        opname = ALIAS[opname]
        if DBG>2: print("3 Found op '%s'" % opname)
    return opname

def list_aliases():
    global ALIAS
    print("# ALIASES")
    for opname in sorted(ALIAS):
        print("  %-4s => %-s" % (opname, ALIAS[opname]))

def exhaustive_alias_test(DBG=0):
    global ALIAS
    for opname in ALIAS:
        for op1 in ['wire','reg','const12']:
            for op2 in ['wire','reg','const12']:
                op = "%s(%s,%s)" % (opname, op1, op2)
                print("TEST %s" % op)
                bs_op(4, op, DBG); print("")


# A (data0) mode bits are 16,17; REG_CONST=0; REG_DELAY=3; REG_BYPASS=2
op_data['const_a'] = (0 << 16)
op_data['wire_a']  = (2 << 16)
op_data['reg_a']   = (3 << 16)

# B (data1) mode bits are 18,19; REG_CONST=0; REG_DELAY=3; REG_BYPASS=2
op_data['const_b'] = (0 << 18)
op_data['wire_b']  = (2 << 18)
op_data['reg_b']   = (3 << 18)

# C (bit0) mode bits are 24,25; REG_CONST=0; REG_DELAY=3; REG_BYPASS=2
op_data['const_0'] = (0 << 24)
op_data['wire_0']  = (2 << 24)
op_data['reg_0']   = (3 << 24)

# E (bit1) mode bits are 26,27; REG_CONST=0; REG_DELAY=3; REG_BYPASS=2
op_data['const_1'] = (0 << 26)
op_data['wire_1']  = (2 << 26)
op_data['reg_1']   = (3 << 26)

# F (bit2) mode bits are 28,29; REG_CONST=0; REG_DELAY=3; REG_BYPASS=2
op_data['const_2'] = (0 << 28)
op_data['wire_2']  = (2 << 28)
op_data['reg_2']   = (3 << 28)


def manpage():
    print('''
Operations should be of the form "T0x<tilenum>_[us]op<.flag>(op1,op2...)" where
  <tilenum> is a 4bit hex number
  [us] is "u" for unsigned or "s" for signed or nothing (also unsigned)
  op and flag choices are listed below (flag is optional)
  op1,op2... are one of "const", "reg", or "wire"

Examples:
    T0x0306_sub.le(wire,const50__148)
    T0x0306_smul(wire,const50__148)
    T0x0705_eq(wire,const50__148)
    T0x1A09_lte_min.lt(wire,reg)
    T0x022F_gte(wire,reg)
    T0x0306_ugt(const16,wire)
''')

    # OPS: Run through the list of 6-bit ops
    global op_data

    # Find max op number
    max = 0
    for i in range(2**6):
        for o in op_data:
            if o[0:3] in ['con','reg','wir']: continue
            if i == op_data[o]:
                if i>max: max=i

    op_list = range(max)
    for i in op_list:
        op_list[i] = '%02x:none' % i
        for o in op_data:
            if o[0:3] in ['con','reg','wir']: continue
            if i == op_data[o]: op_list[i] = '%02x:%s' % (i,o)

    print("# OPS: %s" % op_list)
    print("")

    # ALIASES
    list_aliases()
    print("")

    # PE FLAGS
    list_pe_flags()
    print("")

def bs_addr_sort(addr):
    '''Bitstream address looks like this: RRFFTTTT;
    but want to sort tile first, then feature, then reg, e.g.
    TTTTFFRR'''
    RR =   addr[0:2]
    FF =   addr[2:4]
    TTTT = addr[4:9]
    if (0):
        print ""
        print '%s: RR=%s, FF=%s, TTTT=%s' % (addr, RR,FF,TTTT)
    return TTTT+FF+RR

def bs_comment_sort(comment):
    '''
    Sorted comments should look like this:
      # data[(13, 12)] : @ tile (0, 0) connect ...
      # data[(3, 2)] : @ tile (0, 0) connect ...
      # data[(1, 0)] : @ tile (0, 0) connect ...
    '''
    sortkey = re.search('^\D+(\d+)', comment).group(1)

    # return (0 - int(sortkey))
    # Ugh okay for compatibility have to do it the dumb way.
    return int(sortkey)


# Sort test(s)
def test_bs_addr_sort():
    tmp = {}
    for i in (
        "00020000",
        "F1000000",
        "FF000000",
        "00020001",
        "00050001",
        "F1000001",
        "FF000001",
        "00050002",
        "F0000002",
        "F1000002",
        "FF000002",
        "01050004",
        "00050005",
        "00050006"
        ):
        print i, bs_addr_sort(i)
        tmp[i] = 17
    print tmp

    # for a in sorted(connections.iterkeys())
    for a in sorted(tmp.iterkeys(), key=bs_addr_sort): print a


# Globals
VERBOSE = False
TEST    = False

bitstream = {}
bscomment = {}

curtile = None

# Keep track of what kind of operands each tile needs;
# use an array (dict indexed by integers I guess?)
opa = {}
opb = {}

# Sample input:
#   Tile 7
#   op=mul
#   s3=>a
#   2=>b
#   out=>s0

# Sample input:
#
# Tx0401_mul(wire,const15_15)   # mul_47515_476_PE
# Tx0802_add(wire,wire)         # add_457_476_477_PE
# Tx0103_mul(reg,const13_13$1)  # mul_48313_484_PE
# Tx0201_ule(wire,const50__148) # ule_148_147_149_PE
#
# Tx0505_in_s2t0 -> Tx0505_out_s0t0 (r)
# Tx0506_in_s2t0 -> Tx0506_out_s0t0
# Tx0507_in_s2t0 -> Tx0507_out_s0t0
# Tx0508_in_s2t0 -> Tx0508_mem_in
#
# Tx0202_out_s2t0 -> Tx0202_out_s2t0 (r) (NEW 12/2018)

def main():
    process_args()
    set_sign_bit_info()
    set_pe_flags()
    harris_aliases()
    if (0):
        # Coupla tests
        # New-style register
        bs_connection(0x0202, 'Tx0202_out_s2t0 -> Tx0202_out_s2t0 (r)', DBG=9);
        exit()
        
        # Connect tile 0x0505 (row5,col5) to mem_in of tile 0x0508 (row5,col8)
        bs_connection(0x0505, 'Tx0505_in_s2t0 -> Tx0505_out_s0t0 (r)', DBG=9);
        bs_connection(0x0506, 'Tx0506_in_s2t0 -> Tx0506_out_s0t0',     DBG=9);
        bs_connection(0x0507, 'Tx0507_in_s2t0 -> Tx0507_out_s0t0',     DBG=9);
        bs_connection(0x0508, 'Tx0508_in_s2t0 -> Tx0508_mem_in',       DBG=9);
        
        bs_op(4, 'mux(const0__795,const255__794,wire)', DBG=9); print("")
        bs_op(4, 'mux(wire,reg,wire)', DBG=9); print("")
        
        bs_mux(4, 'mux(const0__795,const255__794,wire)', DBG=9); print("")
        bs_mux(4, 'mux(wire,reg,wire)', DBG=9); print("")
        
        list_aliases()
        bs_op(4, 'sub.le(wire,const50__148)', DBG=9); print("")
        exit()
        
        bs_op(4, 'eq(wire,const50__148)', DBG=9); print("")
        bs_op(4, 'lte_min.lt(wire,reg)' , DBG=9); print("")
        bs_op(4, 'gte(wire,reg)'        , DBG=9); print("")
        bs_op(4, 'gt(wire,reg)'         , DBG=9); print("")
        bs_op(4, 'gt(const16,wire)'     , DBG=9); print("")
        exhaustive_alias_test(DBG=9)
        bs_op(4, 'ugt(const16,wire)'       , DBG=9); print("")
        bs_op(4, 'sgt(const16,wire)'       , DBG=9); print("")
        bs_op(4, 'gte(wire,reg)', DBG=9); print("")
        exit()

    if not VERBOSE: DBG=0
    else:           DBG=1

    io_info = []

    global MEM_CONFIG_HACK
    if MEM_CONFIG_HACK: mem_config_hack()

    tileno = -1
    for line in input_lines:
        orig_line = line     # We can use this later...

        # Skip blank lines
        if re.search("^\s*$", line):
            if DBG: print ""
            continue

        # NOTE in 16x16 grid w/io pads, input can only go to tile 0x15 (T21) in_s2t0

        # self.in -> T0_in_s2t0
        if re.search('self.in', line):
            # Ignore self.in (really?)
            continue

        # T0_out_s0t0 -> self.out
        if re.search('self.out', line):
            io_info.append(process_output(line))
            continue


        # Save I/O info for later
        # INPUT  tile  0 (0,0) / out_BUS16_S1_T4 / wire_0_0_BUS16_S1_T4
        # OUTPUT tile  0 (0,0) / in_BUS16_S1_T1 / wire_1_0_BUS16_S3_T1
        if re.search('^# (IN|OUT)PUT\s+tile', line):
            if DBG: print line
            io_info.append(line)
            if DBG>1: print 'IO_INFO', io_info
            continue

        # Skip comments
        if re.search("^\s*#", line):
            # print "%-40s (comment)" % line
            if DBG: print "#"+line
            continue

        # Remove inline comments e.g.
        # IN:  "T4_mul(wire,const15_15)    # mul_47515_476_PE"
        # OUT: "T4_mul(wire,const15_15)"
        parse = re.search("^(.*\S)\s*#", line)
        if parse: line = parse.group(1)

        if DBG: print "# "+line

        # We'll fix your little red wagon!
        # This turns all old-style Tile designations into standard hex format
        # E.g. "T97_out_s2t1 -> T97_addr" becomes "Tx61_out_s2t1 -> Tx61_addr"
        parse = re.search("(.*)T(\d+)_(.*)", line)
        while (parse):
            if DBG==9: print("\n#A: %s" % line)
            prefix = parse.group(1)
            tileno = parse.group(2)
            suffix = parse.group(3)
            hextile = "Tx%X_" % int(tileno)
            line = prefix + hextile + suffix
            if DBG==9: print("#B: %s" % line)
            parse = re.search("(.*)T(\d+)_(.*)", line)

        ################################################################
        # Shouldn't need this anymore, b/c of what we did just above...
        # # T4_mul(wire,const15_15) or T3_mem_64
        # # Strip off the tile number, leaving e.g. 'mul(wire,const15_15)' or 'mem_64'
        # parse = re.search("^T(\d+)_(.*)", line)
        # if parse:
        #     tileno = int(parse.group(1))
        #     line = parse.group(2)
        #     if DBG>2: print '# tile%02d  %s' % (tileno,line)
        ################################################################

        # Tx4_mul(wire,const15_15) or Tx3_mem_64
        # Strip off the tile number, leaving e.g. 'mul(wire,const15_15)' or 'mem_64'
        # Tx116_pad(out,1) => pad(out,1)
        parse = re.search("^Tx([0-9a-fA-F]+)_(.*)", line)
        if parse:
            tileno = int(parse.group(1),16)
            line = parse.group(2)
            if DBG>2: print '# tile_0x%03x  %s' % (tileno,line)

        if bs_mux(tileno,line, max(0,DBG-1)):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a mux'


        # mul(wire,const15_15)
        # add(wire,wire)
        # mul(reg,const13_13$1)
        # usub.gt(reg,const13_13$1)
        if bs_op(tileno,line, max(0,DBG-1)):
            if DBG: print ''
            continue
        elif DBG: print '# > Not an op'


        # lutF(wire,0,0)
        if bs_lut(tileno,line, max(0,DBG-1)):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a lut'

        # T3_mem_64    # mem_1 fifo_depth=64 => 'mem_64'
        # T17_mem_64   # mem_2 fifo_depth=64 => 'mem_64'
        if bs_mem(tileno,line, DBG-1):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a mem'

        # T97_sram  (sram mode, no fifo depth) (added 1/2019)
        if bs_sram(tileno,line, DBG-1):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a sram'

        # Tx116_pad(out,1)
        if bs_io(tileno, line, DBG-1):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a io'

        if bs_connection(tileno, line, DBG-1):
            if DBG: print ''
            continue
        elif DBG: print '# > Not a connection'


        err_msg = "\n\n# %s\n" % orig_line\
                  + "I don't know what this is: '%s'\n\n" % line
        assert False, err_msg

        continue

#         ################################################################
#         # This is the old stuff.
#         # SKIP IT for now anyways
#
#         # "tile=7" (also: "tile7" or "tile=7" or "TILE 7" ...)
#         # (tile) = myparse(line, "\s+tile\s+([0-9]+)")
#         if parse_tile_decl(line):
#             tilestr = "%04X" % int(curtile)
#             continue
#
#         # "op=mul" or "op MUL"
#         if parse_op(line,tilestr): continue
#
#         # "in_s3=>a" or "in_s3 -> a" or "in_s3 => wire a" or "in_s3 => reg a"
#         # or "out_s3 => reg a"
#         if parse_opa(line, tilestr): continue
#
#         # FIXME have to extend above code for operand b (doofus)
#
#         # "in_s3=>out_s0"
#         if parse_connection(line, tilestr): continue
#
#         # Konstants: "2=>b"
#         if parse_const(line, tilestr): continue
#
#         # pe_out=>out_s0
#         # pe_out_res=>out_s0
#         if parse_pe_out(line, tilestr): continue
#
#         else:
#             print "ERROR I can't do that yet."
#             sys.exit(1)
#         ################################################################

    if DBG: print ''
    emit_bitstream()

    # INPUT  tile  0 (0,0) / out_BUS16_S1_T4 / wire_0_0_BUS16_S1_T4
    # OUTPUT tile  0 (0,0) / in_BUS16_S1_T1 / wire_1_0_BUS16_S3_T1
    for i in io_info: print i

    global FOUND_SIXTEEN
    if not FOUND_SIXTEEN:
        configure_output_pads();

    return

def mem_config_hack():
    '''
    01000018 00000000
    0100001C 00000000
    01000020 00000000
    ...
    0100012B 00000000
    0100012F 00000000
    01000133 00000000
    '''
    mlist = cgra_info.find_all_mem_tiles()
    # print(mlist)

    b = "# MEM_CONFIG_HACK\n" + \
        "# Override buggy mem config default: set bits 32-63 in every memtile to all zeroes\n"

    # <tile type='memory_tile' tile_addr='0x0104' row='1' col='4' tracks='BUS1:5 BUS16:5 '>
    # <sb feature_address='0' bus='BUS1' row='0'>
    # Reg 1, feature 0
    # FIXME/TODO: should find feature num viea e.g. cgra_info.find_mem_tile_bus1_sb_featurenum
    reg_feat = 0x01000000

    for t in mlist:
        # print(t)
        id = reg_feat | t
        # print("%08X 00000000 # memtile %d" % (id,t))
        b = b + "%08X 00000000\n" % id
    print b
    return b



def configure_output_pads():
    b = '''
# WARNING You did not designate a 16-bit output bus, so I will build one: 
# Configuring side 0 (right side) io1bit tiles as 16bit output bus
'''
    # NOTE This default only kicks in when bsbuilder detects no output bus designation
    # For now we need it for backward compatibility in CGRAGenerator travis tests...
    # FIXME should fix the tests and remove this hack (also see FOUND_SIXTEEN)
    pad_bus = 'pads_E_0'

    # Little hack to take care of old-style cgra_info files
    if cgra_info.is_oldstyle_pads():
        b = "# WARNING You did not designate a 16-bit output bus and...\n"
        b = b + "# OOPS looks like cgra_info only has old-style IO pads.\n"
        b = b + "# NO DEFAULT OUTPUT-BUS FOR YOU!!!\n"
        print b
        return b

    # Little endian means count backwards 15..0
    for i in range(15, -1, -1):
        # 1/2019 try/except hack to produce bitstreams for tapeout-version w/jtag
        # FIXME need a better way of doing this!!!!  Maybe a cmd-line switch -jtag
        # FIXME but do it back at whoever calls this routine maybe...

        (id, row, col) = cgra_info.find_pad(pad_bus, i)
        b = b + "%08X 00000001\n" % id

    print b
    return b

    # E.g.
    # 00000111 00000001 (bit 15)
    # 00000211 00000001 (bit 14)
    # 00000311 00000001 ( ...  )
    # 00000411 00000001
    # 00000511 00000001
    # 00000611 00000001
    # 00000711 00000001
    # 00000811 00000001
    # 00000911 00000001
    # 00000A11 00000001
    # 00000B11 00000001
    # 00000C11 00000001
    # 00000D11 00000001
    # 00000E11 00000001
    # 00000F11 00000001
    # 00001011 00000001 (bit 0)

def preprocess(input_lines, DBG=0):
    # For lazy programmers:
    # Turn 't0_in_s2t0' into 'T0_in_s2t0'
    # Turn 'self.in -> T0_in_s2t0 -> T0_op1' into
    #   'self.in -> T0_in_s2t0'
    #   'T0_in_s2t0 -> T0_op1'

    output_lines = []
    for line in input_lines:
        line = line.strip()
        if DBG: print "LINE0", line

        # FIXME/HACK Ignore keyi output paths
        if   (line == "T37_in_s2t0 -> T37_in"):      continue
        elif (line == "T20_pe_out -> T20_out_s0t0"): continue

        # Maybe this is a bad road
        # # Turn 't0_in_s2t0' into 'T0_in_s2t0'
        # line1 = re.sub(r't(\d+)_(in|out)', r'T\1_', line)
        # if DBG: print "LINE1", line1
        line1 = line

        # Turn 'a -> b -> c' into 'a -> b', 'b -> c'
        nodes = re.split('\s*->\s*', line1)
        if len(nodes) <= 2:
            output_lines.append(line1)
            continue

        for i in range( len(nodes)-1 ):
            c = '%s -> %s' % (nodes[i], nodes[i+1])
            if DBG: print c
            output_lines.append(c)

        if DBG: print ""

    return output_lines


def process_output(line):
    '''
    line = 'T0_out_s0t0 -> self.out'
    rval = 'OUTPUT tile  0 (0,0) / out_BUS16_S0_T0 / wire_0_0_BUS16_S0_T0'
    '''
    wire = re.search('(\S+)\s*->\s*self.out', line).group(1)
    (tileno, dir, side, track) = cgra_info.parse_canon(wire)
    (r,c) = cgra_info.tileno2rc(tileno)
    g = cgra_info.canon2global(wire)
    return '# OUTPUT tile  %d (%d,%d) / %s_BUS16_S%d_T%d / %s' %\
          (tileno, r, c, dir, side, track, g)


# Every dest must have exactly ONE source
ALLSOURCES = {}
def bs_connection(tileno, line, DBG=0):
    DBG= max(0,DBG)
    # OLD examples (still supported):
    #  line = 'in_s2t0 -> T0_out_s0t0 (r)'
    #  line = 'T1_in_s2t0 -> T1_out_s0t0/r'
    #  line = 'T25_out_s2t0 -> T25_op1 (r)'
    #  line = 'T192_out_s2t0 -> T192_data0 (r)' (ignores the "(r)")
    #
    # NEW examples:
    #  line = 'Tx0505_in_s2t0  -> Tx0505_out_s0t0 (r)'
    #  line = 'Tx0506_in_s2t0  -> Tx0506_out_s0t0'
    #  line = 'Tx0202_out_s2t0 -> Tx0202_out_s2t0 (r)' // new-style reg 12/2018
    #  line = 'Tx0508_in_s2t0  -> Tx0508_mem_in'

    if DBG==9:
        print("########################################################################")
        print("# bs_connection(0x{tileno:04X}, '{line}')".format(tileno=tileno,line=line))

    parse = re.search('(\w+)\s*->\s*(\w+)[^r]*(r)*', line)
    if not parse: return False

    # print 'Found a connections'

    lhs = parse.group(1)
    rhs = parse.group(2)
    reg = parse.group(3)
    assert reg=='r' or reg==None

    # Verify that tileno in line matches tileno parm
    (t,lhs) = striptile(lhs); assert t == -1 or t == tileno, \
              "'%s': wrong lhs tile '%s' should be -1 or %s\n" % (line, t, tileno)
    (t,rhs) = striptile(rhs); assert t == -1 or t == tileno, \
              "'%s': wrong lhs tile '%s' should be -1 or %s\n" % (line, t, tileno)
    if DBG>1: print "# lhs '%s', rhs '%s', reg '%s'" % (lhs,rhs,reg)

    # New way to specify registers, to make keyi's life easier, e.g.
    # line = 'Tx0202_out_s2t0 -> Tx0202_out_s2t0 (r)' // new-style reg 12/2018
    if (lhs == rhs) and (reg=='r'):
        if DBG==9: print("# Found new-style register syntax")

        # FIXME does this work for bit registers!!!?  I'm guessing no... :(
        # E.g. cgra_info.encode_reg(0x0505, "out_s2t0")
        (raddr,rdata,rcomm) = cgra_info.encode_reg(tileno, rhs)
        addbs(raddr, rdata, rcomm)
        return True

    # FIXME FIXME cgra_info.txt bug regfield crosses 32-bit boundary
    # FIXME FIXME cgra_info.txt bug regfield crosses 32-bit boundary
    # FIXME FIXME cgra_info.txt bug regfield crosses 32-bit boundary
    # Cannot connect e.g. "T24_in_s0t0_b0 -> T24_out_s2t0_b0" b/c requires 2 config regs
    # see reg_field_bug_hack() for deets
    if (lhs == 'in_s0t0_b0') and (rhs == 'out_s2t0_b0'):
        return reg_field_bug_hack(t)

    # Connect lhs to rhs
    Tlhs = "Tx%04X_%s" % (tileno,lhs)
    Trhs = "Tx%04X_%s" % (tileno,rhs)

    # Make sure that no two guys try to write the same guy.
    if (Trhs in ALLSOURCES) and (ALLSOURCES[Trhs] != Tlhs):
        assert False, \
               "ERROR Uh oh looks like more than one guy wants to write '%s'"\
               % Trhs
    ALLSOURCES[Trhs] = Tlhs

    cwt = cgra_info.connect_within_tile(tileno, Tlhs, Trhs, max(0,DBG-1))
    if not cwt:
        # Print useful connection hints
        src_cgra = cgra_info.canon2cgra(Tlhs)
        snk_cgra = cgra_info.canon2cgra(Trhs)
        tile = cgra_info.get_tile(tileno)
        cgra_info.find_mux(tile, src_cgra, snk_cgra, DBG=1)
        sys.exit(-1)

    (laddr,ldata, haddr,hdata, raddr,rdata,   comm, rcomm) = cwt

    # print 'sel %08X %08X' % (addr,data)
    # print '# ', comm, '\n'
    addbs(laddr, ldata, comm)

    if (laddr != haddr):
        if DBG: print("397 ok here we go with the overlapped bitrange")
        addbs(haddr, hdata, comm)

    # process reg if one exists
    # (note registered ops are taken care of elsewheres)
    # E.g. if Trhs = "T192_data0" then rhs = "data0" is an input port
    if reg=='r' and not is_alu_input(rhs):
        # print 'reg %08X %08X' % (ra,rd)
        # print '# ', rcomm, '\n'
        addbs(raddr, rdata, rcomm)

    return True


def is_alu_input(port):
    '''E.g. if Trhs = "T192_data0" then rhs = "data0" is an input port'''
    # E.g. {op1,op2,data0,data1
    return (port[0:2] == "op") or (port[0:4] == "data")


def striptile(r):
    '''
    Given a resource name 'r' e.g. one of
        Tx0101_in_s2t0
        in_s2t0
        Tx0304_add(wire,wire)
    strip off the leading tilenumber "Tx0101" if one exists and return
    (tileno,stripped_name)
    If no leading tilenumber then tileno = -1
    '''
    # Strip off the tile number, if one exists
    parse = re.search("^Tx([^_]+)_(.*)", r)
    if not parse: return(-1, r)

    tileno = int(parse.group(1),16)
    r      = parse.group(2)
    return (tileno,r)


def reg_field_bug_hack(tileno):
    # FIXME FIXME cgra_info.txt bug
    # Cannot connect e.g. "T24_in_s0t0_b0 -> T24_out_s2t0_b0" b/c requires
    # two config regs b/c field crosses regs e.g.
    #
    # found snk out_0_BUS1_2_0
    # found src in_0_BUS1_0_0
    #   tile 24
    #   feature address 0
    #   sel 0
    #   sel_width 3
    #   configh 32
    #   configl 30
    #   configr 70
    #   File "cgra_info.py", line 781, in encode_parms
    #     assert regh==regl, 'select field crossed reg boundary!'
    # AssertionError: select field crossed reg boundary!

    # <sb feature_address='0' bus='BUS1' row='0'>
    #   <mux snk='out_0_BUS1_2_0' reg='1' configh='32' configl='30' configr='70'>
    #     <src sel='0'>in_0_BUS1_0_0</src>

    (configh,configl,sel) = (32,30,0)

    c = cgra_info.gen_comment_conn(
        configh, #parms['configh'],
        configl, #parms['configl'],
        tileno,
        sel, #parms['sel'],
        'in_0_BUS1_0_0', #canon2cgra(src),
        'out_0_BUS1_2_0', #canon2cgra(snk))
        )

    # reg 0, element 0, tile 'tileno' = 0x80000000 (top bit of 0x2)
    (regno,elno) = (0,0)
    addr = (regno << 24) | (elno << 16) | tileno
    data = (sel << configl) & 0xFFFFFFFF
    assert data == 0
    comment = [c + ' (REG 00)'
               , 'da99[(31, 30)] : REG_FIELD_HACK (bsbuilder.py) hand-written code above'
               ]
    addbs(addr, data, comment)

    # reg 1, element 0, tile 'tileno' = 1 (top bit of 0x2)
    (regno,elno) = (1,0)
    addr = (regno << 24) | (elno << 16) | tileno
    data = (sel << configl) >> 32
    assert data == 0
    comment = [c + ' (REG 01)'
               , 'da99[(32, 32)] : REG_FIELD_HACK (bsbuilder.py) hand-written code above'
               ]
    addbs(addr, data, comment)
    return True


def parse_tile_decl(line):
        # "tile=7" (also: "tile7" or "tile=7" or "TILE 7" ...)
        # (tile) = myparse(line, "\s+tile\s+([0-9]+)")
        DBG=0
        (tile) = myparse(line, "\s*tile\D*(\d)")
        if tile:
            # print tile
            tilestr = "%04X" % int(tile)
            if DBG: print "# Found tile '%s' = 0x%s" % (tile, tilestr)
            if DBG: print ""

            # No operands yet
            tileno = int(tile)
            print "# TILE %d (r,c)" % tileno
            global curtile; curtile = tileno
            (opa[tileno],opb[tileno]) = (False,False)

            return True
        else: return False


def parse_opa(line, tilestr):
        # "in_s3=>a" or "in_s3 -> a" or "in_s3 => wire a" or "in_s3 => reg a"
        # or "out_s3 => reg a"
        (io, side, wr) = myparse(line,"(in|out)_s([\d+])\W+(reg|wire)?.*a\s*$")

        if io:
            DBG=0
            tileno = int(tilestr,16)
            # print (io,side,wr)
            # sys.exit(0)
            # First let's take care of wire/reg spec
            if wr == "wire" or wr == 'reg':
                if DBG: print "# Found wire '%s_s%st0' => %s a" % (io, side, wr)
                set_opa(tileno, wr)

            # <cb feature_address='2' bus='BUS16'>
            #     <mux snk='op_a_in'>
            #       <src sel='0'>in_BUS16_S2_T0</src>
            #       <src sel='5'>out_BUS16_S2_T0</src>

            # We're only using track 0 (!), so only two choice is s2
            if side == '2':
                addr = "0002"+tilestr
                if io == "in": data = "00000000"
                else:          data = "00000005"
                addbs(addr, data, line)
                return True

            else:
                print "OOPS 'a' can only connect to side 2, not side %s" % side
                print "Maybe try this:"
                print "  in_s%s -> out_s2" % side
                print "  out_s2 -> a"
                print ""
                return True

        else: return False

def parse_connection(line,tilestr):
        # "in_s3=>out_s0"
        (inside,outside) = myparse(line,".*in_s(\d+).*out_s(\d+)")
        if inside:
            DBG=0
            if DBG: print "# Found in_s%s => out_s%s" % (inside, outside)

            inbus = "in_BUS16_S%s_T0" % inside
            outbus= "out_BUS16_S%s_T0" % outside
            # connectbus('pe_out_res', 'out_BUS16_S2_T0')
            (data,comment) = connectbus(inbus, outbus)
            # I think.  FIXME reg and feature should come from cgra_info, duh.
            addr = "0005"+tilestr
            addbs(addr, data, line+"\n# "+comment)
            return True
        else: return False



# def parse_const(line, tilestr):
#         # Konstants: "2=>b"
#         (k,operand) = myparse(line,"(\d+)[^ab]+([ab])")
#         if (k):
#             DBG=0
#             if DBG: print "# Found constant '%s' assigned to operand '%s'" % (k, operand)
#
#             # A
#             # F0000008 00000002 # data[(15, 0)]=2 : init `a` reg with const `2`
#             # FF000008 0000000B # data[(15,15)]=0 : read from reg `a`
#             #
#             # or B
#             # F1000008 00000002 # data[(15, 0)]=2 : init `b` reg with const `2`
#             # FF000008 0000000B # data[(13,13)]=0 : read from reg `b`
#
#             comment = line
#             tileno = int(tilestr,16)
#             if (operand=='a'):
#                 addr = "F000"+tilestr; opa[tileno] = 'reg'
#                 # print "# Remember opa[%04X] = %s" % (tileno, opa[tileno])
#                 comment = "# Remember opa[%04X] = %s" % (tileno, opa[tileno])
#             else:
#                 addr = "F100"+tilestr; opb[tileno] = 'reg'
#                 # print "# Remember opb[%04X] = %s" % (tileno, opb[tileno])
#                 comment = "# Remember opb[%04X] = %s" % (tileno, opb[tileno])
#
#             data = "%08X" % int(k)
#             addbs(addr, data, line+"\n"+comment)
#             return True
#
#         else: return False

def parse_pe_out(line,tilestr):
        # Given a line that looks like that below, build bitstream info
        # pe_out=>out_s0
        # pe_out_res=>out_s0
        outside = myparse(line,"pe_out[^o]+out_s(\d+)")
        if outside:
            DBG=0
            if DBG: print "# Found pe_out_res => out_s%s" % outside
            # print "# use cgra_info library to look up mux for out_s%st0" % outside

            # inbus = "in_BUS16_S%s_T0" % inside
            inbus = "pe_out_res"
            outbus= "out_BUS16_S%s_T0" % outside
            # connectbus('pe_out_res', 'out_BUS16_S2_T0')
            (data,comment) = connectbus(inbus, outbus)

            # I think.  FIXME reg and feature should come from cgra_info, duh.
            addr = "0005"+tilestr
            addbs(addr, data, line+"\n# "+comment)
            return True
        else:
            return False




def emit_bitstream():
    DBG=0
    if VERBOSE: print "# FINAL PASS: EMIT BITSTREAM"
    if VERBOSE: print "#----------------------------------------------------------------"
    for addr in sorted(bitstream.iterkeys(), key=bs_addr_sort):
        if DBG:
            print "# " + addr, bscomment[addr]
            print "# " + addr, bitstream[addr]
            print ""

        # We don't do this no more (i think)
        # # If addr indicates an op, then merge in operands a, b
        # insert_operands(addr)

        data = merge_data(addr)
        if (data == "ERROR"): sys.exit(1)

        # print data, type(data)
        print "%s %08X" % (addr,data)

        for c in sorted(bscomment[addr], key=bs_comment_sort): print "# " + c
        print ""


def set_opa(tileno, wr):
    DBG=0
    # print "# Setting a input to default 'wire'"
    opa[tileno] = wr;
    if DBG: print "# opa[%04X] = %s" % (tileno, opa[tileno])

def set_opb(tileno, wr):
    DBG=0
    # print "# Setting a input to default 'wire'"
    opb[tileno] = wr;
    if DBG: print "# opb[%04X] = %s" % (tileno, opb[tileno])


def bs_mem(tileno, line, DBG=0):
    # IN:
    # mem_64

    # OUT (see e.g. ../examples/bw1000.bsa)
    # 00040003 00000204
    # data[(1, 0)] : mode = 0 (linebuffer)
    # data[(2, 2)] : tile_en = 1
    # data[(15, 3)] : fifo_depth = 64
    # data[(18, 16)] : almost_full_count = 0
    # data[(19, 19)] : chain_enable = 0

    parse = re.search('mem_(\d+)', line)
    if not parse: return False

    fd = int(parse.group(1))
    # print '666foo found mem w/fd=%s' % fd

    if cgra_info.MEMTILE_HEIGHT == 1:
        addr = 0x00020000 | tileno
    else:
        addr = 0x00040000 | tileno

    data = 0x00000004 | (fd<<3)
    comment = [
        "data[(1, 0)] : mode = 0 (linebuffer)",
        "data[(2, 2)] : tile_en = 1",
        "data[(15, 3)] : fifo_depth = %d" % fd,
        "data[(18, 16)] : almost_full_count = 0",
        "data[(19, 19)] : chain_enable = 0",
        ]
    addbs(addr, data, comment)
    return True


#  (sram mode, no fifo depth) (added 1/2019)
def bs_sram(tileno, line, DBG=0):
    # IN:
    #     Tx61_sram
    # OR (old-style):
    #     T97_sram  #sram_input$mem$cgramem
    #
    # OUT:
    #     00020061 00000006
    #     # data[(1, 0)] : mode = 2 (sram)
    #     # data[(2, 2)] : tile_en = 1
    #     # data[(15, 3)] : fifo_depth = 0
    #     # data[(18, 16)] : almost_full_count = 0
    #     # data[(19, 19)] : chain_enable = 0

    parse = re.search('sram', line)
    if not parse: return False

#     # FIXME ho HO this is bad; feature address should come from cgra_info
#     if cgra_info.MEMTILE_HEIGHT == 1:
#         addr = 0x00020000 | tileno
#     else:
#         addr = 0x00040000 | tileno
    addr = cgra_info.get_mem_config_feature_address()
    addr = (addr << 16) | tileno

    data = 0x00000006
    comment = [
        "data[(1, 0)] : mode = 2 (sram)",
        "data[(2, 2)] : tile_en = 1",
        "data[(15, 3)] : fifo_depth = 0",
        "data[(18, 16)] : almost_full_count = 0",
        "data[(19, 19)] : chain_enable = 0",
        ]
    addbs(addr, data, comment)
    return True



def bs_io(tileno, line, DBG=0):
    '''
    E.g. tileno = 0x116, line = "pad(out,1)" or just "(out,1)" =>
      00000116 00000003
      # io1_116
      # data[(0, 0)] : output  # 0x1
      # data[(1, 1)] : one-bit # 0x1
    '''
    if DBG>1: print "# > It's a IO!"
    parse = re.search('[(](in|out),(1|16)[)]', line)
    if not parse: return False
    dir = parse.group(1)
    wid = parse.group(2)

    if (dir == 'in'):
        b0 = 0; c0 = 'input ';
    else:
        b0 = 1; c0 = 'output';

    if (wid == '16'):
        b1 = 0; c1 = '16-bit';
        global FOUND_SIXTEEN
        FOUND_SIXTEEN = True
    else:
        b1 = 1; c1 = 'one-bit';

    addr = tileno;      # E.g. '00000116' (after addbs() formatting)
    data = (2*b1 + b0); # E.g. '00000003' (after addbs() formatting)
    if DBG>1: print "addr=%04X" % addr

    comment = [
        "data[(0, 0)] : %s # 0x%d" % (c0, b0),
        "data[(1, 1)] : %s # 0x%d" % (c1, b1)
        ]
    addbs(addr, data, comment)
    return True


def bs_mux(tileno, line, DBG=0):
    # IN:
    # "mux(const0__795,const255__794,wire) # mux_793_794_795$mux"
    # "sel(const0__795,const255__794,wire) # mux_793_794_795$mux"
    # OUT: ?
    #     FF00008B 0200F008
    #     # data[(5, 0)] : alu_op = mux
    #     # data[(6, 6)] : unsigned=0x0
    #     # data[(15, 12] : flag_sel: PE_FLAG_PE=0xF
    #     # data[(17, 16)]: data0: REG_CONST= 0x0
    #     # data[(19, 18)]: data1: REG_CONST= 0x0
    #     # data[(25, 24)]:  bit0: REG_BYPASS=0x2

    # Want signed mux e.g. "umux" or "smux"?  Too bad!!  Why would you want that anyway.

    parse = re.search('(mux|sel)\s*\(\s*(\S+)\s*,\s*(\S+)\s*,\s*(\S+)\s*\)', line)
    if not parse:
        if DBG>1: print '# > Not mux or sel (line 836)'
        return False

    # Note op1==data0, op2==data1
    opname = parse.group(1)
    op1    = parse.group(2)+"_a"  # 'reg_a' or 'wire_a' or 'const0__795_a'
    op2    = parse.group(3)+"_b"
    bit0   = parse.group(4)+"_0"  # 'reg_0' or 'wire_0' or 'const0__795_0'

    # If op is a const, returns 'const_a' or 'const_b' etc
    # else returns op unchanged (e.g. ('reg_a')
    # Also: builds the constant e.g.
    # F1000008 00000002 # data[(15, 0)]=2 : init `b` reg with const `2`
    # FF000008 0000000B # data[(13,13)]=0 : read from reg `b`
    op1 = bs_const(tileno,  op1, 'op1')
    op2 = bs_const(tileno,  op2, 'op2')
    bit0= bs_const(tileno, bit0, 'bit0')

    # FIXME/TODO should use d0 and d1 instead of a and b maybe
    assert op1 =='reg_a' or op1 =='wire_a' or op1== 'const_a',op1
    assert op2 =='reg_b' or op2 =='wire_b' or op2== 'const_b',op2
    assert bit0=='reg_0' or bit0=='wire_0' or bit0=='const_0',op2

    assert (opname == 'mux') or (opname == 'sel')

    # FIXME PE_FLAG shift amount should come from config file e.g. cgra_i
    # data = op_data[opname] | (PE_FLAG['pe'] << 12)
    data = get_op_data(opname) | (PE_FLAG['pe'] << 12) \
           | op_data[op1] | op_data[op2] | op_data[bit0]

    # Address for a PE is reg 'FF' + elem '00' + tileno e.g. '0001'
    addr = "FF00%04X" % tileno

    # COMMENT
    # data[(5, 0)] : alu_op = mux (sel)
    # data[(15, 12] : flag_sel: PE_FLAG_PE=0xF
    # data[(17, 16)] : data0: REG_DELAY
    # data[(19, 18)] : data1: REG_CONST
    # data[(25, 24)] : bit0: REG_CONST

#     comment = [
#         "data[( 5,  0)]: alu_op = %s (0x%02X)" % (opname, op_data[opname]),
#         "data[( 6,  6)]: unsigned=0x0",
#         "data[(15, 12] : flag_sel: PE_FLAG_PE=0xF",
#         "data[17, 16] = %2d :: data0 = %s"    % (data >> 16 & 0x03, regtranslate(op1)),
#         "data[19, 18] = %2d :: data1 = %s"    % (data >> 18 & 0x03, regtranslate(op2)),
#         "data[25, 24] = %2d ::  bit0 = %s"    % (data >> 25 & 0x03, regtranslate(bit0)),
#         ]

    # Want signed mux e.g. "umux" or "smux"?  Too bad!!  Why would you want that anyway.
    sign = 'u'
    comment = build_comment(data, opname, sign, op1, op2, bit0)
    addbs(addr, data, comment)
    if DBG>1:
        print '# T0x%04X %s %s ( %s %s %s )' % (tileno,opname,'eq',op1,op2,bit0)
        print("%s %08X" % (addr, data))
        for L in comment: print(L)
    return True


def build_comment(data, opname, sign, op1, op2, bit0=''):
    # data[(5, 0)] : alu_op = mul
    # data[(15, 12] : flag_sel: PE_FLAG_PE=0xF
    # data[(17, 16)] : data0: REG_DELAY
    # data[(19, 18)] : data1: REG_CONST

    global PE_FLAG
    f = data >> 12 & 0x0F
    for flag_name in PE_FLAG:
        if PE_FLAG[flag_name] == f: break

    comment = [
        "data[ 5,  0] = %2d :: alu_op '%s'" % (data >>  0 & 0x1F, opname),
        "data[ 6,  6] = %2d :: sign   '%s'" % (data >>  6 & 0x01, sign),
        "data[15, 12] = %2d :: flag   '%s'" % (data >> 12 & 0x0F, flag_name),
        "data[17, 16] = %2d :: data0  %s"   % (data >> 16 & 0x03, regtranslate(op1)),
        "data[19, 18] = %2d :: data1  %s"   % (data >> 18 & 0x03, regtranslate(op2)),
        ]
    if bit0 != '': comment.append(
        "data[25, 24] = %2d :: bit0   %s"    % (data >> 25 & 0x03, regtranslate(bit0))
        )
    return comment



def bs_op(tileno, line, DBG=0):
    # IN:
    # mul(wire,const15_15)
    # add(wire,wire)
    # mul(reg,const13_13$1)
    # ule(wire,const50__148)
    # sub_le(wire,const50__148)

    # OUT (../examples/bw1000.bsa):
    # FF000001 0003 000B
    # data[(4, 0)] : alu_op = mul
    # data[(17, 16)] : data0: REG_DELAY
    # data[(19, 18)] : data1: REG_CONST

    if DBG>1: print(line)

    parse = re.search('(\S+)\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)', line)
    if not parse: return False

    opname = parse.group(1)       # 'mul'
    op1    = parse.group(2)+"_a"  # 'reg_a' or 'wire_a' or 'const19_19$1_a'
    op2    = parse.group(3)+"_b"

    # LUTs and PADs get processed elsewhere e.g.
    # Tx0301_lut66(wire,wire,const0_0)
    # Tx0201_uge(wire,const20__150)
    if opname[0:3] == 'lut': return False
    if opname[0:3] == 'pad': return False

    # Also muxes and sels
    if opname[0:3] == 'mux': return False
    if opname[0:3] == 'sel': return False

    # E.g. ALIAS['eq'] = 'usub.eq'
    opname = get_alias(opname)
    if DBG>2: print("Found op '%s'" % opname)

    # OOPS no FIXME below opname can be e.g. 'mult_0' or 'lte_max' :(
    # Unpack flag if one exists, e.g. if opname = "usub.lt" flag is 'lt'
    # For backward compatibility, default flag is 'eq'
    # although should probably be 'pe', no?
    flag = 'pe'
    parse = re.search(r'([^.]+)[.](.*)', opname)
    if parse:
        opname = get_alias(parse.group(1))
        flag   = parse.group(2)

    if DBG>1: print '# T0x%04X %s %s ( %s %s )' % (tileno,opname,flag,op1,op2)

    global SIGN_BIT
    sign = 'u'    # Default is unsigned, why not
    if opname not in op_data:
        # Check for sign maybe
        # E.g. "usub" means "unsigned sub"
        parse = re.search(r'^([us])(.*)', opname)
        if parse:
            sign = parse.group(1); opname = get_alias(parse.group(2))

            # Depending on how alias worked out, may need to redo flag thingy
            # E.g. 'ugt' => (u)'sub.gt'
            parse = re.search(r'([^.]+)[.](.*)', opname)
            if parse:
                opname = get_alias(parse.group(1))
                flag   = parse.group(2)

            if opname not in op_data:
                if DBG>1: print('# > "%s" does not seem to be a valid op (line 1084)' % opname)
                return False

    if DBG>1: print '# T0x%04X    %s %s %s ( %s %s )' % (tileno,sign,opname,flag,op1,op2)

    # If op is a const, returns 'const_a' or 'const_b'
    op1 = bs_const(tileno, op1, 'op1')
    op2 = bs_const(tileno, op2, 'op2')

    assert op1=='reg_a' or op1=='wire_a' or op1=='const_a',op1
    assert op2=='reg_b' or op2=='wire_b' or op2=='const_b',op2

# Don't think we need this anymore...
#     # FIXME does this belong here?  Looks like a hack to me!
#     if opname == 'eq': flag = 'eq'

    if DBG>1: print(sign, opname, flag, op1, op2)
    # FIXME PE_FLAG shift amount should come from config file e.g. cgra_i
    data = get_op_data(opname) | SIGN_BIT[sign] | (PE_FLAG[flag] << 12) | op_data[op1] | op_data[op2]

    # Address for a PE is reg 'FF' + elem '00' + tileno e.g. '0001'
    addr = "FF00%04X" % tileno

    # data[(5, 0)] : alu_op = mul
    # data[(15, 12] : flag_sel: PE_FLAG_PE=0xF
    # data[(17, 16)] : data0: REG_DELAY
    # data[(19, 18)] : data1: REG_CONST
    comment = build_comment(data, opname, sign, op1, op2)
    addbs(addr, data, comment)
    return True

def bs_lut(tileno, line, DBG=0):

    # IN: lutF(const0,const0,const0)
    # OUT:
    # 0000TTTT 0000000F reg=0x00 => set LUT for 0xF (right?)
    # data[(7, 0)] : lut_value = 15
    #
    # F300TTTT 00000000 reg=0xF3 => set bit0 for const 1'b0
    # data[(0, 0)] : init `bit0` reg with const `0`
    #
    # F400TTTT 00000000 reg=0xF4 => set bit1 for const 1'b0
    # data[(0, 0)] : init `bit1` reg with const `0`
    #
    # F500TTTT 00000000 reg=0xF5 => set bit2 for const 1'b0
    # data[(0, 0)] : init `bit2` reg with const `0`
    #
    # FF00TTTT 0000000E
    # data[(5, 0)] : alu_op = lut ; 0xE
    # data[(25, 24)] : bit0: REG_CONST ; 0x0
    # data[(27, 26)] : bit1: REG_CONST ; 0x0
    # data[(29, 28)] : bit2: REG_CONST ; 0x0

    # T56_lut55(wire,const0_0,const0_0) # ult_152_147_153_not_lut_bitPE

    parse = re.search('lut([0-9a-fA-F][0-9a-fA-F])\s*\(\s*(\S+)\s*,\s*(\S+)\s*,\s*(\S+)\s*\)', line)
    if not parse:
        if DBG>1: print '# > Not a lut (line 831)'
        return False

    # print 'hey found a lut'

    lutval = parse.group(1)       # 'FF' or '55'
    bit0   = parse.group(2)       # 'wire'   (e.g.)
    bit1   = parse.group(3)       # 'const0' (e.g.)
    bit2   = parse.group(4)       # 'const0' (e.g.)

    # !!!!!
    # FIXME this needs more explainos
    # assert bit0 != 'wire', "Weird bug: bit0 cannot be wire/REG_BYPASS"
    # !!!!!

    # load lut reg with lut value
    lutval = int(lutval,16)
    addr = "0000%04X" % tileno; data = lutval
    comment = "data[(7, 0)] : lut_value = 0x%X" % lutval
    addbs(addr, data, comment)

    # operands
    op0 = bit0[0:5] + '_0' # E.g. 'wire_0', 'reg_0', or 'const_0'
    op1 = bit1[0:5] + '_1' # E.g. 'wire_1', 'reg_1', or 'const_1'
    op2 = bit2[0:5] + '_2' # E.g. 'wire_2', 'reg_2', or 'const_2'

    if DBG:
        print("# %s", line)
        print("# Found operands %s => %s", [bit0,bit1,bit2], [op0,op1,op2])

    # If const, build the constant load sequences e.g.
    # F3000099 00000013
    # data[(0, 0)] : init `bit0` reg with const `19`"
    if bit0[0:5] == 'const': lut_const(0, bit0, tileno)
    if bit1[0:5] == 'const': lut_const(1, bit1, tileno)
    if bit2[0:5] == 'const': lut_const(2, bit2, tileno)

    assert op0=='reg_0' or op0=='wire_0' or op0=='const_0', op0
    assert op1=='reg_1' or op1=='wire_1' or op1=='const_1', op1
    assert op2=='reg_2' or op2=='wire_2' or op2=='const_2', op2

    opname = 'lut'
    # FIXME PE_FLAG shift amount should come from config file e.g. cgra_i
    data = get_op_data(opname) | (PE_FLAG['lut'] << 12) | op_data[op2] | op_data[op1] | op_data[op0]
    # TODO check opname is correct above and op_data etc.

    # Address for a PE is reg 'FF' + elem '00' + tileno e.g. '0001'
    addr = "FF00%04X" % tileno

    assert opname == 'lut'

    # FF00TTTT 0000000E
    # data[(5, 0)] : alu_op = lut ; 0xE
    # data[(15, 12] : flag_sel: PE_FLAG_LUT=0xE
    # data[(25, 24)] : bit0: REG_CONST ; 0x0
    # data[(27, 26)] : bit1: REG_CONST ; 0x0
    # data[(29, 28)] : bit2: REG_CONST ; 0x0

    comment = [
        "data[(5, 0)] : alu_op = lut ; 0xE",
        "data[(6, 6)] : unsigned=0x0",
        "data[(15, 12] : flag_sel: PE_FLAG_LUT=0xE",
        "data[(25, 24)]: bit0: %s" % regtranslate(op0),
        "data[(27, 26)]: bit1: %s" % regtranslate(op1),
        "data[(29, 28)]: bit2: %s" % regtranslate(op2),
        ]

    if DBG:
        print("# %s %X" % (addr,data))
        for c in comment: print '#', c
        print('\n\n')

    addbs(addr, data, comment)

    return True


def lut_const(bitno, kstring, tileno):
    # E.g. to load bit0=0x13 in tile 0x99 want: 'F3000099 00000013'

    parse = re.search('const(\d+)', kstring)
    if not parse:
        assert False, 'Huh, %s does not look like a valid constant string' % kstring
    k = int(parse.group(1))

    # (bit0,bit1,bit2) = regs (F3,F4,F5) respectively
    regno = 0xF3 + bitno

    # addr = "F300%04X" % tileno; data = 0
    # addr = (regno<<24) | tileno; data = 0
    # data = 0!!?  WTF dude!
    addr = (regno<<24) | tileno; data = k
    assert data==1 or data==0

    comment = "data[(0, 0)] : init `bit%d` reg with const `%d`" % (bitno, k)
    addbs(addr, data, comment)


# def regtranslate_old(op):
#     if   op[0:3]=='reg': return 'REG_DELAY= 0x3'
#     elif op[0:3]=='wir': return 'REG_BYPASS=0x2'
#     elif op[0:3]=='con': return 'REG_CONST= 0x0'
#     else: assert False, 'what izzit'

def regtranslate(op):
    # E.g. regtranslate('data0', 'wire') =>
    if   op[0:3]=='reg': return "'%s' (REG_DELAY)"  % (op)
    elif op[0:3]=='wir': return "'%s' (REG_BYPASS)" % (op)
    elif op[0:3]=='con': return "'%s' (REG_CONST)"  % (op)
    else: assert False, 'what izzit'



def bs_const(tileno,op,operand):
    '''
    Where const = e.g. "const13_13$1" and operand= "op1"
    If 'op' not a const, return 'op' unchanged.
    If 'op' is a const, process it and return
    'const_a' or 'const_b' as appropriate.
    '''

    if op[0:5] != 'const': return op

    const = op

    DBG=0
    if DBG: print "# Found constant '%s' assigned to operand '%s'" \
              % (const, operand)

    # OP1
    # F0000008 00000002 # data[(15, 0)]=2 : init `a` reg with const `2`
    # FF000008 0000000B # data[(15,15)]=0 : read from reg `a`
    #
    # or OP2
    # F1000008 00000002 # data[(15, 0)]=2 : init `b` reg with const `2`
    # FF000008 0000000B # data[(13,13)]=0 : read from reg `b`

    # Parse the constant e.g. 'const13_13$1' == 13
    k = int(re.search('const(\d+)', const).group(1))
    #data = "%08X" % k
    data = k

    # Address for a const is reg 'F0' + elem '00' + tileno e.g. '0008'
    # (op2 constant is 'F1' instead of 'F0')
    if operand=='op1':
        const = 'const_a'
        addr = "F000%04X" % tileno
        comment = "data[(15, 0)] : init `data0` reg with const `%d`" % k
    elif operand=='op2':
        const = 'const_b'
        addr = "F100%04X" % tileno
        comment = "data[(15, 0)] : init `data1` reg with const `%d`" % k

    elif operand=='bit0':
        const = 'const_0'
        addr = "F300%04X" % tileno
        comment = "data[(15, 0)] : init `bit0` reg with const `%d`" % k
    elif operand=='bit1':
        const = 'const_1'
        addr = "F400%04X" % tileno
        comment = "data[(15, 0)] : init `bit1` reg with const `%d`" % k
    elif operand=='bit2':
        const = 'const_2'
        addr = "F500%04X" % tileno
        comment = "data[(15, 0)] : init `bit2` reg with const `%d`" % k

    else:
        assert False, "unknown operand '%s'" % operand

    addbs(addr, data, comment)
    return const
    # return "%s %s %s" % (addr, data, comment)

#     comment = line
#     tileno = int(tilestr,16)
#     if (operand=='a'):
#         addr = "F000"+tilestr; opa[tileno] = 'reg'
#         # print "# Remember opa[%04X] = %s" % (tileno, opa[tileno])
#         comment = "# Remember opa[%04X] = %s" % (tileno, opa[tileno])
#     else:
#         addr = "F100"+tilestr; opb[tileno] = 'reg'
#         # print "# Remember opb[%04X] = %s" % (tileno, opb[tileno])
#         comment = "# Remember opb[%04X] = %s" % (tileno, opb[tileno])
#
#     data = "%08X" % int(k)
#     addbs(addr, data, line+"\n"+comment)
#     return True
#
#








# sb_config and sb_annote are dictionaries of lists of strings
# containing sb config and annote strings
#   sb_config["00050007"] = ("02020000","00001100")
#   sb_annote["00050007"] = ("# annote1...", "# annote2...")

# cb_config = {}; cb_annote = {}
# sb_config = {}; sb_annote = {}
def addbs(addr,data, comment=''):
    if type(addr) == int: addr = "%08X" % addr
    data = '%08X' % data

    try: bitstream[addr]
    except:
        bitstream[addr] = []
        bscomment[addr] = []

    # Watch for redundant info
    for d in bitstream[addr]:
        if d == data:
            if VERBOSE:
                print '# '
                print "# WARNING redundant instruction, this was already done (and/or it's the default)"
                print "# %s %s" % (addr,data),
                print ":: bs['%s'] = %s" % (addr, bitstream[addr])

            # BUT!  Still want a comment :(
            if data != '00000000': return


    bitstream[addr].append(data)

    if type(comment)==str: comment = [comment]
    bscomment[addr] = bscomment[addr] + comment

    if VERBOSE:
        print '# '
        print "# %s %s" % (addr,data),
        print ":: bs['%s'] = %s" % (addr, bitstream[addr])

        # if comment != '': print "# " + comment
        for c in comment: print "# " + c

    # Howzabout a quick error check on cb, sb elements
    feature = int(addr[2:4],16)

    # FIXME this should really be a cgra_info function!!!
    # hack (2,3,5) are cba, cbb and sb16 in PE tiles FIXME
    if feature in (2,3,5,7):
        valid = merge_data(addr) # Just for the error check
        if valid == "ERROR":
            print "ERROR This connection collides with a previous one"


def merge_data(addr, DBG=0):
    mdata = 0
    for data in bitstream[addr]:
        d = int(data,16)
        # print "%08x %08x" % (d, mdata)
        if (d & mdata):
            print "ERROR Collision in data for address '%s'" % addr
            return "ERROR"
        else: mdata = mdata | d
    return mdata



def myparse(line, regexp):
    #     print line
    #     print regexp
    ngroups = re.compile(regexp).groups

    match = re.search(regexp, line)
    #     match = re.search(".*tile", "tile")
    #     print re.search("\s*.*tile\s*(\d)", "tile 7").group(1)
    #     sys.exit(0)
    #     print match
    #     print match.group(1)
    if match:
        g = match.groups()
        if ngroups == 1: return g[0]
        else:           return match.groups()
    else:
        if ngroups == 1: return False
        else:            return [False] * ngroups


# def num_groups(regex):
#     return re.compile(regex).groups





# see cgra_info.get_default_cgra_info_filename() instead
# def get_default_cgra_info_filename():
#     '''
#     Look for default cgra_info file in <decoder-directory>/examples/cgra_info.txt
#     '''
#     import os
#     mydir = os.path.dirname(os.path.realpath(__file__))
#     cgra_filename = mydir + "../decoder/examples/cgra_info.txt"
#
#     # global verbose #(implied because use before def)
#     if VERBOSE: print("I think I am here:\n  %s" % mydir)
#     if VERBOSE: print("Default cgra_info file is\n  %s" % cgra_filename)
#     return cgra_filename

input_lines = []
def process_args():
    DBG=0
    bitstream_filename = False

    # Get name of this script
    scriptname = sys.argv[0]
    scriptname_tail = scriptname
    parse = re.search('([/].*$)', scriptname)
    parse = re.search('([^/]+$)', scriptname)
    if (parse): scriptname_tail = parse.group(1)
    args = sys.argv[1:] # shift

    cmd = scriptname_tail
    usage = '''\
Decodes/annotates the indicated bitstream file, output to stdout

Usage:
   %s [OPTION]... [bsb-file]
   %s [OPTION]... < [bsb-file]

Options:
   -v
       verbose/debug info to stdout

   --cgra [cgra_info_file]
       use the indicated cgra_info file

   --mem_config_hack
       include memtile switchbox-default bug fix sequence in output

   --manpage
       extended info about bsb syntax etc.

   --help
       this help message\
''' % (cmd,cmd)

    # Load cgra_info
    cgra_filename = cgra_info.get_default_cgra_info_filename()

    # if (len(args) < 1): print usage; sys.exit(-1);

    global VERBOSE
    global MEM_CONFIG_HACK
    MEM_CONFIG_HACK = False
    # cgra_filename = get_default_cgra_info_filename()
    while (len(args) > 0):
        if (args[0] == '--help'):
            print(usage);
            sys.exit(0);
        elif (args[0] == '--manpage'):
            print(usage);
            manpage();
            sys.exit(0);
        elif (args[0] == '--mem_config_hack'): MEM_CONFIG_HACK = True   
        elif (args[0] == '-v'):    VERBOSE = True
        elif (args[0] == '-q'):    VERBOSE = False

        # elif (args[0] == '-cgra' or args[0] == '-cgra_info' or args[0] == '--cgra_info'):
        elif (re.match(r'^[-].*cgra.*', args[0]) != None):
            cgra_filename = args[1]
            args = args[1:];
        else:
            bitstream_filename = args[0];
        args = args[1:]

    cgra_info.read_cgra_info(cgra_filename, verbose=VERBOSE)

    global input_lines
    if bitstream_filename:
        input_stream = open(bitstream_filename)
        for line in input_stream: input_lines.append(line)
        input_stream.close()
    else:
        for line in sys.stdin: input_lines.append(line)

    # Read the input, store to 'input_lines' tuple
    input_lines = preprocess(input_lines)
    if DBG>1:
        for i in input_lines: print i


def find_outreg16(outwire):
    mux = find_outmux16(outwire)
    r = mux.attrib['configr']
    print "# To enable register just do 1 << r"


def connectbus(inbus, outbus):
    DBG = 0
    mux = find_outmux16(outbus)
    h = int(mux.attrib['configh'])
    l = int(mux.attrib['configl'])
    if h>31 or l>31: print "ERROR ERROR ERROR "

    for src in mux:
        sel = int(src.attrib['sel'])
        if src.text == inbus:
            comment = "bits[%s:%s]=%s for %s => %s" % (h, l, sel, src.text, outbus)

            # print "#     bits[%s:%s]=%s to select source %s" % (h, l, sel, src.text)
            if DBG: print "# "+comment
            data = "%08X" % (sel << l)
            # print "# %s" % data
            # return (sel, h, l, r)
            return (data, comment)



    # FIXME TROUBLE if configl or configr > 31...




def find_outmux16(outwire):
    DBG = 0
    sb = find_sb16()
    for item in sb:
        if item.tag == 'mux':
            # print 'found a mux'
            snk = item.attrib['snk']
            if snk == outwire:
                if DBG: print "#    Found the mux for outwire '%s'" % snk
                return item



def find_sb16():
    DBG = 0
    # if DBG: print "Looking up tile %d element %d" % (tileno, elemno)
    if DBG: print "# use cgra_info library to look up mux connections"
    if DBG: print "# Find first tile that's a PE"
    for tile in cgra_info.CGRA.findall('tile'):
        type = tile.attrib['type']
        if DBG: print "#  Found tile type '%s'" % type
        if type == 'pe_tile_new':
            for feature in tile:
                # if DBG: print "# Found feature '%s'" % feature.tag
                if feature.tag == "sb" and feature.attrib['bus'] == 'BUS16':
                    if DBG: print "#   Found the sb for 16-bit track"
                    return feature


def set_pe_flags(DBG=0):
    global PE_FLAG
    PE_FLAG = {}
    ##############################################################################
    # PE FLAGS
    # Note could/should set these automatically based on verilog in genesis_verif!
    # 
    # FIXME/TODO autogenerate this string with something like:
    # egrep 'localparam.*PE_FLAG' $top/genesis_verif/test_pe_unq1.sv 
    pe_flags_raw_string = """
    localparam PE_FLAG_EQ = 4'h0;
    localparam PE_FLAG_NE = 4'h1;
    localparam PE_FLAG_CS = 4'h2;
    localparam PE_FLAG_CC = 4'h3;
    localparam PE_FLAG_MI = 4'h4;
    localparam PE_FLAG_PL = 4'h5;
    localparam PE_FLAG_VS = 4'h6;
    localparam PE_FLAG_VC = 4'h7;
    localparam PE_FLAG_HI = 4'h8;
    localparam PE_FLAG_LS = 4'h9;
    localparam PE_FLAG_GE = 4'hA;
    localparam PE_FLAG_LT = 4'hB;
    localparam PE_FLAG_GT = 4'hC;
    localparam PE_FLAG_LE = 4'hD;
    localparam PE_FLAG_LUT = 4'hE;
    localparam PE_FLAG_PE  = 4'hF;
"""

    pe_flags_raw_array = pe_flags_raw_string.split('\n')

    if DBG>2:
        print("# Found raw pe flags: %s" % pe_flags_raw_string)
        print("Turned it into an array:"),
        for line in pe_flags_raw_array: print(line)

    pe_flag = {}
    for line in pe_flags_raw_array:
        parse = re.search("PE_FLAG_(\S*).*'h([0-9a-fA-F]+)", line)
        if parse:
            if DBG>2: print(parse.group(1), parse.group(2)),
            flag_name = parse.group(1).lower()
            flag_num  = int(parse.group(2),16)
            if DBG>2: print(flag_name, flag_num)
            PE_FLAG[flag_name] = flag_num

    if DBG:
        list_pe_flags()

def list_pe_flags_alt():
    # Sixteen flags, deal with it.
    flag_list = range(16)
    print PE_FLAG
    for i in range(16):
        print i
        flag_list[i] = '%1x:none' % i
        for f in PE_FLAG:
            if i == PE_FLAG[f]:
                flag_list[i] = '%1x:%s' % (i,f)
    print("# FLAGS: %s" % flag_list)



   
def list_pe_flags():
    global PE_FLAG
    set_pe_flags()
    print("# PE FLAGS:")
    for i in range(256):
        for j in PE_FLAG:
            if PE_FLAG[j] == i:
                # print("    PE_FLAG[0x%1X] = '%s'" % (i, PE_FLAG[i]))
                s = "PE_FLAG['%s'" % j
                print("#    %-13s] = 0x%1X" % (s, PE_FLAG[j]))
                break;

main()
