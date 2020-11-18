#!/usr/bin/python2
import sys
import re
import os
import traceback # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

def pstack(): traceback.print_stack(file=sys.stdout)

# Import cgra_info via relative path
mypath = os.path.realpath(__file__)
mydir  = os.path.dirname(mypath)
decoder_path = mydir+"/../decoder"
sys.path.insert(0, decoder_path)
from lib import cgra_info
from lib import connect_tiles as CT


def show_trace(nlines=100):
    sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

from inspect import currentframe, getframeinfo
def where(lno=0):
    # E.g. 'serpent.py/42'
    # frameinfo = getframeinfo(currentframe())
    frameinfo = getframeinfo(currentframe().f_back)
    if not lno: lno = frameinfo.lineno
    return '%s/%s' % (frameinfo.filename, lno)

def pwhere(lno=0, txt=''):
    frameinfo = getframeinfo(currentframe().f_back)
    if not lno: lno = frameinfo.lineno
    info = '%s/%s' % (frameinfo.filename, lno)
    if txt=='':
        # E.g. "serpent.py/42"
        print info
    else:
        # E.g. "serpent.py/42: hello world"
        print '%s: %s' % (info, txt)

def test_where():
    print where()
    pwhere('hello')
    print where()
    exit()
# test_where()

import packer

# CAREFUL! get_nearest_tile() may have tried to put sname and dname in same tile!
# If it fails it may erroneaousl deallocate sname!
# FIXME ORIG_ORDER is a very hacky way to address that...
ORIG_ORDER = False

# well this is awful isn't it
WEN_LUT_LIST = []

# FIXME/TODO globals wrapper and initializer thingy, see packer.py maybe
# FIXME/TODO pretty sure this is WRONG and never gets RESET!!
GRID_WIDTH  = 8
GRID_HEIGHT = GRID_WIDTH

# These all get rewritten by find_input_tile, below.
INPUT_TILENO =      0x0101           # Top left
INPUT_WIRE   =      'in_s3t0'        # From the *north*
INPUT_WIRE_T =      'Tx%04X_in_s3t0' % INPUT_TILENO
INPUT_TILE_PE_OUT = "Tx%04X_pe_out"  % INPUT_TILENO
INPUT_TILE   =      INPUT_TILENO     # An alias - is this a good idea?

# Find the input tile
def find_input_tile():
    # Assumes first pe tile found is the input tile (how terrible is that!?
    # FIXME this is not a good way to do this...
    for i in range(1000):
        t = cgra_info.tiletype(i)
        if t[0:2] == "pe":

            # FIXME what we *should* do is...
            # - Find input signal name in json file
            # - Look up signal name (io16bit tile) in cgra_info.xml
            # - Set input, output globals


            global INPUT_TILENO
            global INPUT_TILE
            global INPUT_WIRE
            global INPUT_WIRE_T
            global INPUT_TILE_PE_OUT

            INPUT_TILENO = i
            INPUT_TILE   = INPUT_TILENO
            INPUT_WIRE   = 'in_s3t0' # From the *north*
            INPUT_WIRE_T = 'Tx%04X_%s' % (INPUT_TILENO, INPUT_WIRE)
            INPUT_TILE_PE_OUT = "Tx%04X_pe_out" % INPUT_TILENO
            
            print "I think  input tile is Tx%04X" % INPUT_TILENO
            print "I think  input wire is %s" % INPUT_WIRE_T
            print "I think output wire is %s" % INPUT_TILE_PE_OUT
            return i

##############################################################################
# global output info
# 
# Where is the 1-bit output tile?
global OUTPUT01_TILENO        # E.g. 0x1101
#
# Which tile feeds the 1-bit output tile, and on what side?
global OUTPUT01_FEEDER_TILENO # E.g. 0x1001
global OUTPUT01_FEEDER_SIDE   # 0,1,2,3 = E,S,W,N
#
# Which tile feeds the 16-bit output tile?
global OUTPUT16_FEEDER_TILENO


def find_output_tile():
    # FIXME this should come from board_info.json etc
    # Note OUTPUT01 globals are set by staging_area_onebit(), below

    global OUTPUT16_FEEDER_TILENO
    # This is the PE (or MEM) tile that feeds into the io16 output tile...
    # We use the first (PE or?) mem tile in NW corner
    # E.g. for tallmem OUTPUT16_FEEDER_TILENO = 0x24
    # FIXME better would be to calculate it from pad name, like OUTPUT01_FEEDER_TILENO below

    # FIXME Terrible assumption(s):
    # - output tile is last pe or mem tile in row 1
    # - that tile number is less than 1000
    for i in range(1000):
        if is_pe_tile(i) or is_mem_tile(i):
            (r,c) = cgra_info.tileno2rc(i)
            if r == 1:
                OUTPUT16_FEEDER_TILENO = i
            elif r > 1:
                print "I think output tile is Tx%04X (early out)" % OUTPUT16_FEEDER_TILENO
                # Early out
                break
    print "I think output tile is Tx%04X (late)" % OUTPUT16_FEEDER_TILENO
    return

def staging_area_onebit():
    # FIXME clean up this function!!!

    # Find staging area for onebit-output tile
    # If io1bit output tile is on side 1 and its location is (r,c),
    # then staging area is tile (r-2,c).  Right?
    # E.g. if output pad is 'pad_S1_T0' at (19,2) then staging tile is at (17,2)
    # Currently default json sets pads_S_0[0] as 1-bit output, which
    # in the current 16x16 1-high-mem design translates to tile 0x1101 (r17c1);
    # this is Use first bit on side 1 (bottom, SW corner).

    # Info comes from json file now I guess

    # global OUTPUT01_PADNAME = 'pads_S_0[0]'  # Bottom / SW corner
    global OUTPUT01_TILENO
    global OUTPUT01_FEEDER_TILENO
    global OUTPUT01_FEEDER_SIDE

    global io_filename
    assert io_filename

    print("\n# Found io json info file '%s'" % io_filename)
    import json
    # Looking for this:
    #   "io1_out_0_0": {
    #       "pad_bus" : "pads_S_0",
    #       "bits": { "0": { "pad_bit":"0" }},
    #       "mode": "out",
    #       "width": 1
    #
    io1_out = "io1_out_0_0"
    with open(io_filename) as json_data:
        io_info = json.load(json_data)
        # print(io_info)
        if io1_out in io_info:
            # print(666, io_info[io1_out])
            # print(667, io_info[io1_out]["pad_bus"])
            padname = io_info[io1_out]["pad_bus"]
            padbit  = io_info[io1_out]["bits"]["0"]["pad_bit"]
            (padno, padrow, padcol) = cgra_info.find_pad(padname, int(padbit))
            print "# ::found onebit output pad %d = 0x%x" % (padno,padno)

            # Name should be of the form "pads_S_0"
            padside = re.search('^pads_([NSEW])', padname).group(1)

            OUTPUT01_TILENO = padno

            if   (padside == 'N'): OUTPUT01_FEEDER_TILENO = padno+0x0100 # One row down
            elif (padside == 'S'): OUTPUT01_FEEDER_TILENO = padno-0x0100 # One row up
            elif (padside == 'E'): OUTPUT01_FEEDER_TILENO = padno-0x0001 # One col left
            elif (padside == 'W'): OUTPUT01_FEEDER_TILENO = padno+0x0001 # One col right
            else: assert False

            if   (padside == 'N'): OUTPUT01_FEEDER_SIDE = 3
            elif (padside == 'S'): OUTPUT01_FEEDER_SIDE = 1
            elif (padside == 'E'): OUTPUT01_FEEDER_SIDE = 0
            elif (padside == 'W'): OUTPUT01_FEEDER_SIDE = 2

    print "# Found onebit output staging tile %d = 0x%x" % (padno,padno)
    return OUTPUT01_FEEDER_TILENO


# Set this to True if a PE has been placed in the INPUT tile
# FIXME is this the best way to do this!!?
INPUT_OCCUPIED = False

VERBOSE = False
dot_filename = False
bsb_filename = False
def process_args():
    # Get name of this script
    scriptname = sys.argv[0]
    scriptname_tail = scriptname
    parse = re.search('([/].*$)', scriptname)
    parse = re.search('([^/]+$)', scriptname)
    if (parse): scriptname_tail = parse.group(1)
    args = sys.argv[1:] # shift

    usage = '''
Place and route indicated "dot" file.  Output is in "bsb" format.
Examples:
   %s pointwise_mapped.dot
   %s -v pointwise_mapped.dot
   %s pointwise_mapped.dot -o pointwise.bsb
   %s pointwise_mapped.dot -o pointwise.bsb -cgra cgra_info.txt -io $v/io/2in2out.json
   %s --help
''' % (scriptname_tail, scriptname_tail, scriptname_tail, scriptname_tail, scriptname_tail)

    # Will need cgra_info
    global cgra_filename
    cgra_filename = get_default_cgra_info_filename()

    # if (len(args) < 1): print usage; sys.exit(-1);

    global io_filename
    io_filename = None

    global VERBOSE
    global bsb_filename
    global dot_filename
    while (len(args) > 0):
        if   (args[0] == '--help'): print usage; sys.exit(0);
        elif (args[0] == '-v'):    VERBOSE = True
        elif (args[0] == '-cgra' or args[0] == '-cgra_info'):
            cgra_filename = args[1]
            args = args[1:];
        elif (args[0] == '-io'):
            io_filename = args[1]
            args = args[1:];
        elif (args[0] == '-o'):
            bsb_filename = args[1]
            args = args[1:];

        else:
            dot_filename = args[0];
        args = args[1:]

    assert dot_filename, '\n\nERROR Oops you forgot to specify a dotfile input\n'


def nearest_mem_tile(node='INPUT', exclude = [], DBG=1):
    '''
    Find mem tile nearest to indicated node,
    excluding tiles in exclude list
    '''

    mytileno = getnode(node).tileno
    (myrow,mycol) = rc2tileno(mytileno)
    if DBG: print \
       "# Looking for memtile nearest to node '%s' in tile %d (r%d,c%d)" \
       % (node, mytileno, myrow, mycol)

    for i in range( max(GRID_WIDTH, GRID_HEIGHT)):
        if DBG: print "# Searching distance %d" % i
        

def manhattan_distance_rc(src=[0,0], dst=[5,1], DBG=0):

    # use connect_tiles.connect_tiles_same_{row,col} to connect;
    # count ntiles in path

    # (begin,path,end) = CT.connect_tiles(src=0,dst=17,track=0,dir='hv',DBG=DBG-1)
    p = CT.connect_tiles(src=0,dst=17,track=0,dir='hv',DBG=DBG-1)
    (begin,path,end) = CT.unpack_path(p)

    dist = len(path)
    
    # E.g. extract_tile('T1_in_s2t0 -> T1_out_s0t0') = 'T1'
    def extract_tile(s): return re.search('^(T\d+)', s).group(1)

    if DBG:
        print "# Distance from %s to %s is %d:" % (src, dst, dist)
        # T0-> (T1 -> T2 -> T3) ->T17
        a = extract_tile(begin)

        tiles = []
        for i in path: tiles.append(extract_tile(i))
        b = tiles

        c = extract_tile(end)
        print '# %s-> %s ->%s' % (a,b,c)
            
def test_manhattan_distance_rc():
    cgra_info.read_cgra_info(verbose=True)
    manhattan_distance_rc(DBG=1)
    print ''

def test_fan_out():
    # S0 only connects to four sides
    cgra_info.fan_out('in_BUS16_S0_T0', 0, DBG=1)
    
    # S2 can also connect to op1
    cgra_info.fan_out('in_BUS16_S2_T0', 0, DBG=1)
    
    cgra_info.fan_out('mem_out', 3, DBG=1)
    cgra_info.fan_out('pe_out_res', 0, DBG=1)

# # FIXME combine with other manhattan thing above maybe
# def manhattan_distance(src=[0,0], dst=[5,1]):
#     '''
#     Return manhattan distance (number of intervening tiles) from src
#     tile to each side (e,s,w,n) of dst tile.
#     E.g. path from (0,0) to (5,1) should be (7,8,5,5)
#     '''
# 
#     dist = {}
#     # Eight cases: dest is (n, ne, e, se, s, sw, w, nw) of src
#     d2s = direction(dst,src)
#     delta_row = abs( src[0] - dst[0] )
#     delta_col = abs( src[1] - dst[1] )
# 
#     short_straight_path = min(delta_row-2,delta_col-2)
# 
#     if d2s == 'n':
#         
#         dist['n'] = (delta_row-2) + 0
#         dist['w'] = (delta_row-1) + (delta_col-1)
#         dist['e'] = (delta_row-1) + (delta_col+1)
#         dist['s'] = (delta_row-0) + (delta_col-0)
#     if d2s == 's':
#         dist['s'] = (delta_row-2) + 0
#         dist['w'] = (delta_row-1) + (delta_col-1)
#         dist['e'] = (delta_row-1) + (delta_col+1)
#         dist['n'] = (delta_row-0) + (delta_col-0)
#     if d2s == 'e':
#         dist['e'] = (delta_col-2) + 0
#         dist['w'] = (delta_col-1) + (delta_row-1)
#         dist['n'] = (delta_col-0) + (delta_row-0)
#         dist['e'] = (delta_col-1) + (delta_row+1)
# 
# 
# 
# 
# def search_pattern_old(n,DBG=1):
#     '''
#     Produce a searchpattern list of (r,c) coords for all tiles at
#     distance n away from center tile (0,0).  The idea is to pack as
#     closely as possible to the NW corner of the grid and to prefer-
#     entially find tiles in a straight line form the center tile.
# 
#                     1--------> 3
#                     2          |
#                     |   +--+   |
#                     |   |  |   |
#                     |   +--+   |
#                     |          v
#                     v 4-------->
# 
#     '''
#     (top,left,right,bottom) = ([],[],[],[])
# 
#     # Top side, NW corner to NE neighbor
#     top.append([-n,0]) # Opt: straight-line tile goes first
#     for c in range(-n, n): top.append([-n,c])
#     if DBG: print top
# 
#     # Left side, NW neighbor to SW corner
#     left.append([0,-n]) # Opt: straight-line tile goes first
#     for r in range(1-n, n+1): left.append([r,-n])
#     if DBG: print left
# 
#     # Right side, NE corner to SE neighbor
#     right.append([0,n]) # Opt: straight-line tile goes first
#     for r in range(-n, n): right.append([r,n])
#     if DBG: print right
# 
#     # Bottom side, SW neighbor to SE corner
#     bottom.append([n,0]) # Opt: straight-line tile goes first
#     for c in range(1-n, n+1): bottom.append([n,c])
#     if DBG: print bottom
# 
# 
# def test_search_pattern():
#     search_pattern(1,DBG=1)
#     # [[-1, 0], [-1, -1], [-1, 0]]
#     # [[0, -1], [0, -1], [1, -1]]
#     # [[0, 1], [-1, 1], [0, 1]]
#     # [[1, 0], [1, 0], [1, 1]]
# 
#     print "----"
#     search_pattern(2,DBG=1)
#     # [[-2, 0], [-2, -2], [-2, -1], [-2, 0], [-2, 1]]
#     # [[0, -2], [-1, -2], [0, -2], [1, -2], [2, -2]]
#     # [[0, 2], [-2, 2], [-1, 2], [0, 2], [1, 2]]
#     # [[2, 0], [2, -1], [2, 0], [2, 1], [2, 2]]



# It's here when we need it I guess
PREPLACED = {}
PREPLACED['lb_grad_yy_2_stencil_update_stream$lb1d_0$reg_1'] = (12,2)
PREPLACED['lb_padded_2_stencil_update_stream$lb1d_1$reg_2']  = (13,3)
PREPLACED['lb_padded_2_stencil_update_stream$lb1d_1$reg_1'] =  (14,4)
# PREPLACED['add_644_646_647$binop'] = (10,2) # r10c2, bout halfway down

def preplaced(nodename, DBG=0):
    '''# Hand placement! ho HO!  how terrible is this?'''
    # Sanity check for preplacement dictionary
    for k in PREPLACED: assert k == base_nodename(k)

    d = base_nodename(nodename)
    if d not in PREPLACED: return -1

    (r,c) = PREPLACED[d]
    t = cgra_info.rc2tileno(r,c)
    return t


def main(DBG=1):
    # test_connect_tiles()
    # sys.exit(0)
    # notes()

    global cgra_filename
    process_args()

    # oops FIXME swizzlers
    global SWIZZLE_TRACKS
    SWIZZLE_TRACKS = True
    if dot_filename == 'harris.dot':
        print "ONE TIME ONLY!  SWIZZLE_TRACKS == TRUE!!!"
        SWIZZLE_TRACKS = True

    print '######################################################'
    print '# serpent.py: Read cgra info'
    cgra_info.read_cgra_info(cgra_filename, verbose=True)

    global MEMHEIGHT
    MEMHEIGHT = cgra_info.mem_tile_height()
    print "######################################################"
    print "# Found mem_tile height = %d" % MEMHEIGHT
    print ""

    # Find INPUT and OUTPUT tiles heuristically
    find_input_tile()
    find_output_tile()

    print '######################################################'
    print '# serpent.py: Initialize the packer'
    packer.USE_CGRA_INFO = True
    packer.init_globals() # this is crucial out there
    print "# here's the grid!"
    print '# '
    packer.FMT.grid()
    print ''

    print '######################################################'
    print '# serpent.py: Read input, initialize node and tile data structures'
    init_tile_resources(DBG=1)
    build_nodes(DBG=1)
    assert not getnode('INPUT').placed
    initialize_routes()
    initialize_node_INPUT()
    initialize_node_OUTPUT()
    initialize_node_OUTPUT_1bit()

    # FIXME should be part of initialize_node_INPUT somehow right?
    # Allocate tile 0 for input node
    # packer.allocate(0)  ARRGGGGH you such a idioot
    packer.allocate(INPUT_TILE)
    if DBG>2:
        print "# order so far"
        print '# '
        packer.FMT.order()
        print ''

    print ''
    print '########################################'
    print '# serpent.py: register folding'
    register_folding(DBG=1)

    # Happens automatically as long as we process non-regop regs LAST (right?)
    # print '######################################################'
    # print '# serpent.py: Process and optimize INPUT node'
    # process_input()

    print ''
    print '######################################################'
    print '# serpent.py: Process remaining nodes, starting with INPUT'
    process_nodes('INPUT')
    # process_nodes_new('INPUT')

    print '########################################'
    print '# serpent.py: constant folding - do this LAST'
    constant_folding(DBG=1)
    print "# consts should be gone now"

    # TODO/FIXME Special treatment for OUTPUT?
    # note OUTPUT wire is always wire_m1_1_BUS16_S1_T0

    if bsb_filename: note = 'see file "%s"' % bsb_filename
    else:            note = ''

    print "########################################################"
    print "# FINAL OUTPUT", note
    final_check()
    final_output()

    sys.exit(0)
    

def want_onebit_output():
    '''Return True if onebit outputs is wanted'''
    if 'OUTPUT_1bit' in nodes: return True
    else: return False


def final_check(DBG=0):
    '''Make sure everyone has been allocated to a tile'''
    for sname in sorted(nodes):
        if getnode(sname).tileno == -1:
            errmsg = "\nERROR? Node '%s' unassigned (tileno = -1)?" % sname
            print errmsg;
            assert False, errmsg


def final_output(DBG=0):

    # Redirect stdout to bsb_filename if such exists
    if bsb_filename:
        save_stdout = sys.stdout
        sys.stdout = open(bsb_filename, 'w')

    if DBG:
        print '# REGISTERS', REGISTERS
        for n in sorted(nodes):
            # print "  %-20s %s" % (n, getnode(n).dests)
            getnode(n).show()

        for nodename in sorted(nodes):
            node = getnode(nodename)
            print nodename
            prettyprint_dict("  route ", node.route)

    # First the constants
    print ''
    print '# CONSTANTS'
    for sname in sorted(nodes):
        if is_const(sname):
            dname = getnode(sname).dests[0]
            # getnode(sname).show()
            # getnode(dname).show()

            # The new stuff
            o = getnode(sname).output
            # E.g. 'T41_in.1' => 'T41_op2'
            parse = re.search('^(.*)_(in)\.([012])', o)
            if parse:
                o = '%s_op%d' % (parse.group(1), int(parse.group(3))+1)

            print '# %s::%s %s' % (sname, dname, o)
    print ''

    # Registers and ops
    print '# REGISTERS', REGISTERS
    print ''

    print '# PE tiles'
    print_oplist()

    print '# MEM tiles'
    print_memlist()

    # IO
    if want_onebit_output():
        '''E.g. print("Tx116_pad(out,1)")'''
        # Currently 0x116 for 16x16 tallmem, 0x136 for shortmem maybe
        print '# IO'
        print("Tx%X_pad(out,1)\n" % OUTPUT01_TILENO);

    # Routing
    print '# ROUTING'
    print ''
    for sname in sorted(nodes):

        # Don't route constants haha they get folded into ALU op
        if is_const(sname): continue

        src = getnode(sname)
        for dname in src.dests:
            dst = getnode(dname)
            print '# %s::%s' % (sname,dname)

            if is_regop(sname):
                r = src.route[dname][0]
                print '#', mark_regs(r), '\n'
                break

            for c in src.route[dname]:
                print mark_regs(c)

            print ''

            if is_mem(dname) and getnode(dname).wen_lut:
                print "# wen_lut::%s" % dname
                route_wen(dname)

    # INPUT  tile  0 (0,0) / out_BUS16_S1_T4 / wire_0_0_BUS16_S1_T4
    # OUTPUT tile  0 (0,0) / in_BUS16_S1_T1 / wire_1_0_BUS16_S3_T1
    print_io_info(DBG=1)


def print_io_info(DBG=0):
    # INPUT  tile  0 (0,0) / out_BUS16_S1_T4 / wire_0_0_BUS16_S1_T4
    # OUTPUT tile  0 (0,0) / in_BUS16_S1_T1 / wire_1_0_BUS16_S3_T1
    inode = getnode('INPUT');  

    # onebit_bool DAG uses 'OUTPUT_1bit' instead of OUTPUT
    try: onode = getnode('OUTPUT');
    except:
        if DBG: print("# WARNING Using 'OUTPUT_1bit' as OUTPUT node")
        if DBG>1: getnode('OUTPUT_1bit').show()
        onode = getnode('OUTPUT_1bit')

    if DBG>1:
        inode.show()
        onode.show()

    # cgra_info.test_canon2global()

    iwire = inode.input0
    owire = onode.output

    if DBG>1:
        print "# local name for input  wire is '%s'" % iwire
        print "# local name for output wire is '%s'" % owire

    ig = cgra_info.canon2global(iwire)
    og = cgra_info.canon2global(owire)

    if DBG>1: print '# ', iwire, ig
    if DBG>1: print '# ', owire, og

    # Func to print IO comments
    def p(io, t, w, wg):
        # INPUT  tile  0 (0,0) / out_BUS16_S1_T4 / wire_0_0_BUS16_S1_T4
        # OUTPUT tile  0 (0,0) / in_BUS16_S1_T1 / wire_1_0_BUS16_S3_T1
        (r,c) = cgra_info.tileno2rc(t)
        wc    = cgra_info.canon2cgra(w)
        print '# %-6s tile %3d (%2d,%2d) / %s / %s' % (io, t, r,c, wc, wg)

    p('INPUT',  inode.tileno, iwire, ig)
    p('OUTPUT', onode.tileno, owire, og)
    # assert False
    exit()


# If input is unconnected, assume it's a "don't care" and set to zero
def connect_dont_cares(operand, opno, DBG=0):
    if operand == False:
        if DBG:
            print("Found unconnected operand bit%d" % opno)
            print("Connecting to constant ZERO")
        return (True, 'const0_0')
    else: return (False, operand)


def get_opname(sname, DBG=0):
    # E.g. sname = 'slt_790_775_791$comp$compop.data.in.1' => opname = 'slt'

    # OLD: opname = sname[0:3] # 'add' or 'mul'
    # add_514_518_519_PE

    # NEW
    #   add_721_722_723$binop
    #   mul_649_649_650$binop

    # NEW for harris 7/2018
    # ashr_761_763_765$binop
    # sle100_775_792$compop
    # "slt_790_775_791$comp$compop.data.in.1"
    # "mux_793_794_795$mux"

    # assert sname[-5:] == binop
    parse = re.search(r'^([^_]+)_', sname)
    if parse: opname = parse.group(1)
    else: assert False
    return opname


def print_oplist(DBG=0):

    oplist = {}
    for sname in sorted(nodes):
        if is_const(sname): continue
        src = getnode(sname)

        if DBG>2: print ('ist einen lutten das noden "%s"?' % sname)
        if is_lut(sname):
            # FIXME this could be a func someday
            if DBG>2: print('oho so its a lut ye are after')
            # Make sure dont-cares are connected to something (zero)
            (dc,src.bit0) = connect_dont_cares(src.bit0, 0)
            (dc,src.bit1) = connect_dont_cares(src.bit1, 1)
            (dc,src.bit2) = connect_dont_cares(src.bit2, 2)
            if dc and DBG:
                print("# Fixed dont-care(s) maybe")
                src.show()

            bit0 = optype(src.bit0, 'bit0', DBG)
            bit1 = optype(src.bit1, 'bit1', DBG)
            bit2 = optype(src.bit2, 'bit2', DBG)

            opline = 'Tx%04X_lut%X(%s,%s,%s)' % (src.tileno, src.lut_value, bit0, bit1, bit2)
            opcomm = '# %s' % sname
            oplist[src.tileno] = '%-26s %s' % (opline,opcomm)

            if DBG: pwhere(556, 'what to load lut with??  instead of LUTX??')
            if DBG: pwhere(557, 'duh...how about 0x%x?' % src.lut_value)
            lv = src.lut_value
            assert (lv > 0) and (lv < 0x100),\
                   "That there LUT value 0x%x don't look so good" % lv

        elif is_pe(sname):
            # E.g. sname = 'slt_790_775_791$comp$compop.data.in.1' => opname = 'slt'
            opname = get_opname(sname)

            # Rewrites for harris
            
            # "sle100_775_792$compop" -> "bitand_791_792_793$lut$lut.bit.in.1"; # lut_value 0x00
            if re.search(r'^sle[0-9]', sname): opname = 'sle'
            if re.search(r'^ule[0-9]', sname): opname = 'ule' # why not



            # "slt_790_775_791$not$c01" -> "slt_790_775_791$not$lut$lut.bit.in.1";
            # POSTPONED for now, these bit constants are ignored by serpent :(

            # "slt_790_775_791$not$lut$lut" -> "..."; # lut_value 0x55
            # already does the right thing elsewhere i guess

            # "slt_790_775_791$comp$compop" -> "foo.bit.in.0"; # lut_value 0x00
            # "slt_790_775_791$comp$compop":{
            #     "modargs":{"alu_op":[["BitVector",6],"6'h04"], (6'h04 == GTE!)
            # reused same not-lut trick as before, see below



            # # OLD
            # # TRICKY! Node 'ult_152_147_153_uge_PE' is NOT a ult; it's a uge :o
            # if re.search(r'^ult.*_uge_PE$', sname): opname = 'uge'


            # NEW
            # TRICKY! Node 'ult_324_327_328$comp$compop' is NOT a ult; it's a uge :o
            # (Note this is a superset of prev hack, above)
            if re.search(r'^ult.*$', sname): opname = 'uge'



            # OY!  Mapper turns slt into an slt$compop with code 0x4 (GTE)
            # followed by slt$not$lut$lut to make SLT
            # 
            # NEW tricky.  Mapper uses same trick but w/o the extra clues
            # It is assumed that the slt will be followed by a NOT-LUT
            # FIXME could/should use asserts to verify...
            # 
            # "slt_790_775_791$comp$compop" -> "slt_790_775_791$not$lut$lut.bit.in.0"; # lut_value 0x00
            # "slt_790_775_791$not$lut$lut" -> "bitand_791_792_793$lut$lut.bit.in.0"; # lut_value 0x55
            if re.search(r'^slt.*', sname): opname = 'sge'

            # ...I assume the converse will also be true...?
            if re.search(r'^ugt.*_ule_PE$', sname): opname = 'ule'

            op1 = optype(src.input0, 'op1', DBG=1)
            op2 = optype(src.input1, 'op2', DBG=1)

            # MUX
            # node='mux_793_794_795$mux'
            #   input0='False'
            #   input1='False'
            #   bit0='T139_bit0'
            #   bit1='False'
            #   bit2='False'
            if opname == 'mux':
                bit0 = optype(src.bit0, 'bit0', DBG)
                opline = 'Tx%04X_%s(%s,%s,%s)' % (src.tileno, opname, op1, op2, bit0)
            else:
                opline = 'Tx%04X_%s(%s,%s)' % (src.tileno, opname, op1, op2)

            opcomm = '# %s' % sname
            oplist[src.tileno] = '%-26s %s' % (opline,opcomm)

    for i in oplist: print oplist[i]
    print ''

    # FIXME should be separate print_wenlist()
    print "# LUT tiles for wen_lut's", WEN_LUT_LIST
    for i in WEN_LUT_LIST: print "Tx%04X_lutFF(const0,const0,const0)" % i
    print ''


def print_memlist():
    # E.g. prints
    #     'T3_mem_64    # mem_1 fifo_depth=64'
    #     'T17_mem_64   # mem_2 fifo_depth=64'
    memlist = {}

    for sname in sorted(nodes):
        # FIXME Why is this here?  Can we be both const and mem?
        if is_const(sname): continue
        src = getnode(sname)

        if is_mem_node(sname):
            # print("# Adding mem node", sname)
            opline = 'Tx%04X_mem_%d' % (src.tileno, src.fifo_depth)
            opcomm = '# %s fifo_depth=%d' % (sname, src.fifo_depth)
            memlist[src.tileno] = '%-12s %s' % (opline,opcomm)

    # Print in tile order, 0 to 'ntiles'
    for i in sorted(memlist):
        print memlist[i]
    print ''


# E.g.  bit0 = optype(src.bit0, 'bit0')
# returns e.g. 'wire' or 'const0_0' or 'reg'
def optype(input, opname, DBG=0):
    '''
    Where input is one of e.g. 'T32_op1', 'const32_32'
    and where 'T32_op1' may or may not be in REGISTERS list.
    Return 'reg', 'wire' or name of const e.g. 'const0_0'
    '''

    if input == False:
        if DBG: print(''); getnode(sname).show(); print('');
        assert input != False, "LUT/PE '%s' has no %s operand; why?" % (sname, opname)

    if is_const(input):                return input
    elif re.search('op.\(r\)', input): return 'reg'
    elif input in REGISTERS:           return 'reg'
    else:                              return 'wire'

def mark_regs(c):
    '''
    if e.g. c=="T0_in_s2t0 -> T0_out_s0t0" and "T0_out_s0t0" is a register,
    mark it with an r e.g. return "T0_in_s2t0 -> T0_out_s0t0 (r)"
    '''
    rhs = re.search('(\S+)$', c).group(1)
    # print c,rhs
    # if rhs in REGISTERS: c = c+ '_R'
    if rhs in REGISTERS: c = c+ ' (r)'
    return c



def notes():
    print "Read the dotfile input make make a list of dests for each node"
    print "Process all the constants"
    print "Process all the reg->pe pairs"
    print "Process all node->regall groups"
    print "  -> out[node] = (list of regs), combined[reg] = node"
    print "Start with INPUT node"
    print "  if pe in dests: combine pe into input tile, mark it processed"
    print "    -> pe (and optional input reg) will get assigned a tile,"
    print "       indicating that they have been processed."
    print "  elif reg-pe combo in dests:"
    print "    combine pe into input tile, mark it processed"
    print "  else no combinings"
    print "  foreach remaining dest d:"
    print "    if pe: assign a nearby tile; recurse on dests (RD)"
    print "    elif mem: assign a nearby tile; recurse on dests (RD)"
    print "    elif unprocessed reg: "
    print "      # all combinings have been done, yes? maybe not quite..."
    print "      assign a nearby tile"
    print "      if all dests are unassigned regs, assign a double reg"
    print "      recurse on dests"
    print "    elif processed reg: "
    print "      recurse on dests"


def test_connect_tiles():
    cgra_filename = get_default_cgra_info_filename()
    cgra_info.read_cgra_info(cgra_filename)
    connect_tiles.test_ctsr()
    connect_tiles.test_ctsc()



# Maybe this should be part of cgra library, yes?
def get_default_cgra_info_filename():
    return cgra_info.get_default_cgra_info_filename()

def addnode(nodename, DBG=0):
    global nodes
    nodename = base_nodename(nodename)
    if nodename in nodes:
        if DBG>1: print("Node '%s' already exists" % nodename)
    else:
        nodes[nodename] = Node(nodename)
        if DBG>1: print("Build node '%s'" % nodename)

    # print '\n\n'; print 'added', nodename; for n in nodes: print n; print '\n\n'

        
def getnode(nodename):
    bn = base_nodename(nodename)
    return nodes[bn]

def base_nodename(nodename):
    # Strip off in/out info e.g.
    #   "reg_0_1.in" => "reg_0_1"
    #   "mul_347_348_349_PE.data.in.1" => "mul_347_348_349_PE"
    #   "mul_347_348_349_PE.data.out"  => "mul_347_348_349_PE"
    newname = nodename
    newname = re.sub(r'\.(data|bit)\.in\.[0-9]$', '', newname)
    newname = re.sub(r'\.in',                     '', newname)

    # Optional: output rewrites should have been done by json2bit maybe
    newname = re.sub(r'\.(data|bit)\.out$', '', newname)
    newname = re.sub(r'\.out$',             '', newname)

    # mam_1.wen => mem_1
    newname = re.sub(r'\.wen$', '', newname)

    return newname


def nodetile(tileno):
    '''Given tileno, find associated node, else return False'''

    # Shortcut/special case if tileno is INPUT tile
    # Could contain TWO nodes; must use 'INPUT' or things break I think
    if tileno == INPUT_TILE: return nodes["INPUT"]

    for nodename in nodes:
        node = nodes[nodename]
        if node.tileno == int(tileno): return node

    return False

class Node:
    def __init__(self, nodename):
        self.name       = nodename
        self.tileno     = -1 # Because 0 is a valid tile number, see?
        self.fifo_depth = -1
        self.lut_value  = -1
        self.wen_lut    = False
        self.reg_op     = False

        # input/output EXAMPLES (FIXME needs update)
        #            input0/1         output
        # regpe      op1             'alu_3_2' (unplaced)
        # regpe      T0_op1          'alu_3_2' (placed)

        # regreg     T0_out_s0t0     'reg_2_4'
        # mem        T3_mem_in       T3_mem_out
        # pe         T0_op[12]       T0_pe_out
        # regsolo    T0_out_s0t0     T1_in_s2t0
        self.input0 = False  # E.g. T0_out_s0t0 or 'add_x_y'
        self.input1 = False
        
        # one-bit inputs (lut)
        self.bit0   = False
        self.bit1   = False
        self.bit2   = False

        self.output = False

        self.dests = []
        self.placed = False
        self.route  = {}   # E.g. route['INPUT'] = [T0_in_s0t0, 'T0_op1']

        # self.routed = {}   # E.g. routed['INPUT'] = True
        # Use self.is_routed() instead (see below)

        self.net = []
        # self.processed = False

    def tiletype(self):
        if is_mem_node(self.name): return 'mem'
        else:                      return 'pe'

    def addop(self, operand, which_op = 'either'):
        assert type(operand) == str

        # Can ask for in.0, in.1 or "either" (default)
        if (which_op == 'in.0'):
            self.input0 = operand; return "in.0"
        elif (which_op == 'in.1'):
            self.input1 = operand; return "in.1"

        # Defaults to "either op, you pick"
        elif not self.input0:
            self.input0 = operand; return "in.0"
        elif not self.input1:
            self.input1 = operand; return "in.1"
        else:
            print "ERROR my dance card she is full"
            return False

    def show(self):
        print "node='%s'" % self.name        

        type = 'idunno'
        if is_regsolo(self.name): type='regsolo'
        elif is_regop(self.name): type = 'regop'
        elif is_regreg(self.name): type = 'regreg'
        # also: is_{const,mem,reg,pe,io}
        # FIXME add the other types, make it a separate func
        print "  type='%s'" % type
        print "  reg_op='%s'" % self.reg_op
        print "  ----"
        print "  tileno= 0x%04X" % int(self.tileno)
        print "  input0='%s'" % self.input0
        print "  input1='%s'" % self.input1

        # one-bit inputs (lut)
        print "  bit0='%s'"   % self.bit0
        print "  bit1='%s'"   % self.bit1
        print "  bit2='%s'"   % self.bit2

        print "  output='%s'" % self.output
        print "  ----"
        if self.wen_lut: print "  wen_lut=%s" % str(self.wen_lut)
        print "  placed= %s" % self.placed # FIXME needed/used?
        print "  dests=%s" % self.dests
        # print "  route=%s" % self.route
        prettyprint_dict("  route ", self.route)
        print "  net= %s" % self.net

        if self.fifo_depth != -1: print "  fifo_depth= %d" % self.fifo_depth
        if self.lut_value  != -1: print "  lut_value= 0x%x" % self.lut_value

        print ''

    def is_placed(self): return self.tileno != -1
    def is_routed(self,dest_name):
        return self.route[dest_name] != []

    def is_avail(self, rname, DBG=0):
        '''
        Resource rname in tile T is avail
        if it is free and/or if it is already in mynet.
        rname should be of the form 'Tx%04X_something'
        '''
        # DBG=9
        # rname must have embedded tileno, e.g. 'Tx0101_in_s3t2' or 'Tx0805_mem_out'
        (tileno,r) = parse_resource(rname)
        if DBG>2: pwhere(386)

        ########################################################################
        # FIXME re-examine / remove this hack!!!
        # harris hack to get us to the next level
        # To maintain prior success, restrict tile 111 usage to indicated nodes...
        # FIXME FIXME
        # NOTE this hack may have been solved by can_skip_resource_check(), below
        if 'lb_grad_yy_2_stencil_update_stream$lb1d_0$reg_1' in nodes:
            # restrict hack to harris only:
            # assumes "lb_grad_xy..." nodename is unique to harris
            if (tileno == 111):
                if self.name == 'lb_grad_xy_2_stencil_update_stream$lb1d_1$reg_1':
                    print "AWFUL HARRIS HACK.  HEY REG1 YOU'RE ALL RIGHT!"

                elif self.name == 'add_adj003$binop':
                    print "AWFUL HARRIS HACK.  HEY ADD_ADJ YOU'RE ALL RIGHT!"

                else:
                    print "AWFUL HARRIS HACK.  DENIED!"
                    return False
        ########################################################################


        # E.g. resources[T] = ['in_s0t0', 'in_s0t1', ...
        # Can't use a register unless we're specifically looking for a register
        if rname in REGISTERS:
            if DBG>2: print('')
            if DBG>2: print "Looking for '%s' in tile Tx%04X (0x%x)" % (r, tileno, tileno)
            assert rname not in resources[tileno],\
                   "'%s' is a register: should not be in resources list!" % rname
            # But it CAN be in the net list maybe...?
            print "OOPS looks like '%s' (0x%x) is a register...?" % (r, tileno)
            print "Did not want a register in this path!"
            # print "'%s' not avail to '%s' b/c its a register" % (r, self.name)
            return False
            # assert r not in self.net, "'%s' is a register: should not be part of net list!"

        if DBG>2: print('')
        if DBG>2: pwhere(874, "Looking for '%s' in Tx%04X (0x%x)" % (r, tileno, tileno))

        # First check to see if resource already assigned to output net of orig node (?)
        # 'is_avail: looking for 'T121_in_s2t0' in 'mux_793_794_795$mux' nodenet'
        if DBG>2: print "is_avail: looking for '%s' in '%s' nodenet" % (rname, self.name)
        if rname in self.net:
            if DBG>2: print "  YES %-11s available in '%s' nodenet" % (rname, self.name)
            return True

        # Then check to see if resource is free/unassigned
        # "is_avail: still looking for 'T121_in_s2t0' in tile 121 resources ['T121_in_s0t0', 'T121_in_s0t1'..."
        if DBG>2: print "is_avail: Looking for '%s' in tile %d resources %s" \
              % (rname, tileno, resources[tileno])
        if rname in resources[tileno]:
            if DBG>2: print "  YES %-11s available to tile Tx%04X (0x%x)" % (rname, tileno, tileno)
            return True

        else:
            print "  %-11s is not available to node '%s'" % (rname, self.name)
            return False

    def place(self,tileno,input,output,DBG=0):
        '''
        Place node "name" in tile "tileno"
        with input 'input' and output 'output'
        where e.g. 'input'  = 'Tx0302_op1'    or 'Tx0507_out_s0t1'
        where e.g. 'output' = 'Tx0101_pe_out' or 'Tx0101_in_s2t1' or? 'mul_307_308_309$binop.data.in.0'
        '''
        name = self.name

        # Originally, input=False was a sign that wire can connect to
        # any available input.  But we don't do that no more.
        # assert input != False, 'we dont do that no more'

        # Maybe need it for unrouted 16- or 1-bit OUTPUT nodes e.g.
        if name[0:6] != "OUTPUT":
            assert input != False, 'we dont do that no more'

        if   is_pe(name):
            assert re.search('(op[12])|(bit[012])',     input),\
                   '\n\n\ninput should be "op1/2 or bit0/1/2", is actually '+input
            assert re.search('pe_out$',  output)

        elif is_mem(name):
            assert re.search('mem_in$',  input)
            assert re.search('mem_out$', output)

        if self.placed:
            # assert False, "ERROR %s already placed in tile T%s" % (name, self.tileno)
            pwhere(934)
            print "#   WARNING %s already placed at %s" % (name, self.tileno)
            print "#   It's okay, probably an alu with two inputs"
            if DBG: self.show()
            if self.tileno == -1: # Hey, it happened once
                self.show(); assert False

        self.tileno = tileno

        # self.input0  = input
        # FIXME this is maybe not great...
        if input:
            if DBG: print('placing input "%s" in tile %d' % (input, int(tileno)))

            if   re.search('op1', input): self.input0 = input
            elif re.search('op2', input): self.input1 = input

            elif re.search('bit0', input): self.bit0 = input
            elif re.search('bit1', input): self.bit1 = input
            elif re.search('bit2', input): self.bit2 = input

            else:
                # Face it dude some tiles (INPUT, io1_out) have wires for inputs
                assert not is_pe(self.name), input
                self.input0 = input

        # If dest exists and says 'bitPE.in' then it has buswidth 1 instead of default 16
        # dests=['bitmux_157_157_149_lut_bitPE.in0', 'bitxor_149_151_155_lut_bitPE.in0']
        if (len(self.dests) > 0) and is_bit_node(self.dests[0]): buswidth = 1
        else: buswidth = 16

        # One-bit output should have 'b' suffix
        # if (self.buswidth == 1) and (output[-3:] == "out"):
        if (buswidth == 1) and (output[-3:] == "out"):
            if DBG>1: print("output was '%s'" % output)
            output = output + 'b'
            if DBG>1: print("output now '%s'" % output)
            # assert False

        self.output = output
        self.placed = True

        # output is in our net, but input is not.  right?
        self.net.append(output) # right?  RIGHT???

        if DBG:
            print "# 818 Placed '%s' in tile %d at location '%s'" % (name, tileno, input)

        # FIXME there should be a better way to do this...!
        # Oh...maybe that's this.
        # Ub...better make sure that any reg_op that has this node as its output is also placed!
        rname = self.reg_op
        if rname:
            self.show()
            if DBG: pwhere(1080, "hey look I have an associated reg_op '%s'" % rname)
            rnode = getnode(rname)
            if DBG: rnode.show()
            if rnode.tileno != tileno:
                if DBG: print "hey look reg_op is not placed yet and/or is in the wrong place!"
                rnode.tileno = self.tileno
                rnode.placed = True
                if DBG: rnode.show()

        if re.search(r'in[0-9]$', name): assert False, 'oops'

        return

    # Placing the node does not remove its resources from the tile;
    # that's a job for the router, yes?

#     (itile,dummy) = parse_resource( input)
#     (otile,dummy) = parse_resource(output)
#     assert itile == tileno
#     if DBG and (otile != itile): print \
#        "# node's output is in a different tile; must be a register."
# 
#     print otile,tileno,output,input
# 
#     # Placing the node does not remove its resources from the tile;
#     # that's a job for the router, yes?
#     print itile, resources[itile].bus
#     assert input in resources[itile],\
#            "ERROR tile %d has no available resource '%s'" % (tileno,input)
#     resources[itile].remove(input)
# 
# 
#     assert output in resources[otile],\
#            "ERROR tile %d has no available resource '%s'" % (tileno,output)
# 
#     print otile,tileno,output
# 
#     # note input==output for INPUT node only (bug?  feature?)
#     if input == output:
#         assert tileno == INPUT_TILENO, 'input should not equal outpu!?'
#     else:
#         resources[otile].remove(output)

    def connect(self,a,b,T=-1,DBG=1):
        '''
        In tile T, connect a to b if possible.
        a and b may or may not have embedded tile info.
        Both must be resources available to self.
        If can connect, return connection(s) necessary.
        Else return FALSE i guess.
        '''
        return serpent_connect_within_tile(self, a, b, T, DBG)


def can_skip_resource_check(node, op, DBG=0):
    # If node (e.g. 'INPUT') has a reg_op (e.g. 'Tx0101_data0'), 
    # then okay to skip availability check
    # FIXME this could be clearer, no?

    rname = node.reg_op
    if rname:
        # If op is my reg_op, then it will be marked "unavail" I think
        # but I want to route to it anyway I think
        node.show()
        if DBG: pwhere(1080, "hey look I have an associated reg_op '%s'" % rname)
        rnode = getnode(rname)
        if DBG: rnode.show()

        # Should be exactly one route associated w/the register; route dest should be b
        # route ['mul_307_308_309$binop.data.in.0'] = ['Tx0101_op1']
        reg_home = rnode.route.values()[0][0]
        if reg_home == op:
            if DBG: print("# op '%s' is same as reg_op '%s' so that's okay then" % (op, reg_home))
            return True

    # Still need to check availability
    return False


# FIXME this should be part of cgra_info.connect_within_tile() !!!
def serpent_connect_within_tile(node, a, b, T, DBG=0):

    # e.g. serpent_connect_within_tile(node, 'T136_in_s1t1', 'T136_op2', 136)?
    # BUT really should be called only via node.connect('T136_in_s1t1', 'T136_op2', 136) above
    # Returns False is unsuccessful, otherwise returns a->b path e.g.
    # ['Tx0508_in_s1t3 -> Tx0508_out_s2t3', 'Tx0508_out_s2t3 -> Tx0508_op1']

    DBG = max(0,DBG)
    if a[0] == 'T': T = int(re.search('^Tx([^_]+)', a).group(1), 16)
    if b[0] == 'T': T = int(re.search('^Tx([^_]+)', b).group(1), 16)

    # Canonicalize a,b to have embedded tile info e.g. 'T<t>_resource'
    if a[0] != 'T': a = "Tx%04X_%s" % (T,a)
    if b[0] != 'T': b = "Tx%04X_%s" % (T,b)

    if DBG>1: print ''
    if DBG>1: print "looking to connect '%s' and '%s'" % (a,b)

    if node != False:
        if not node.is_avail(a):
            if DBG>1: print "'%s' not avail to tile %d" % (a,T)
            return False

        if not can_skip_resource_check(node, b, DBG):
            if not node.is_avail(b):
                if DBG>1: print "'%s' not avail to tile %d" % (b,T)
                return False

        if DBG>1: print "       Looks like both are available to '%s' (%s)\n" % (node.name, where(451))
        #         print "       Ask cgra: can '%s' connect to '%s'? (%s)" % (a,b,where(457))

    else:
        if DBG>1: print "       Looks like tile %d not mapped yet" % T


    # Valid combinations:       a               b
    #                     pe_out|mem_out      out_.*
    #                          in.*           out_.*
    #                          in.*      {mem_in,op1,op2}   

    if cgra_info.connect_within_tile(T, a, b, max(0,DBG-1)):
        if DBG: print '     YES'
        return ['%s -> %s' % (a,b)]
    else:
        if DBG: print "     NO"

    # if b[-1] == 'b' and a[-1] != 'b':
    #     assert False, "\nOOPS SOOOOO looks like we tried to connect bit and non-bit wires4" 

    return can_connect_through_intermediary(node, T, a, b, DBG)


def can_connect_through_intermediary(node, T, a, b, DBG=0):
    # Try to find a legal path from a to b within tile T
    # "Cannot connect 'T21_in_s2t0' to 'T21_op2' directly"
    #   BUT can connect via  T21_out_s1t0 e.g.
    #   ['T21_in_s2t0 -> T21_out_s1t0', 'T21_out_s1t0 -> T21_op2']
    # 
    # (If node == False then tileno T not mapped yet)

    pwhere(469)
    print("  Cannot connect '%s' to '%s' directly.  BUT" % (a,b))
    print("  maybe can connect through intermediary?")

    if re.search('(op[12]|bit[012]|mem_in)', b):
        # "Cannot connect 'T21_in_s2t0' to 'T21_op2' directly BUT"
        # IN:  ['T21_in_s2t0,                                  'T21_op2']
        # OUT: ['T21_in_s2t0 -> T21_out_s1t0', 'T21_out_s1t0 -> T21_op2']
        return find_middle(a, b, T, DBG)

    else:
        # "Cannot connect 'T36_in_s5t0' to 'T36_out_s0t0' directly BUT"
        # IN:  ['T36_in_s5t0',                                 T36_out_s0t0']
        # OUT: ['T36_in_s5t0 -> T36_out_s7t0', 'T36_in_s1t0 -> T36_out_s0t0']
        path = CT.find_cornerconn(a,b)
        if len(path) == 2:
            print "     Connecting top and bottom:", path;
            return path
        else:
            print "     No dice.";
            return False


def find_middle(a, b, T, DBG=0):
    # Find a path from a to b using some intermediate node reachable by both e.g.
    # IN:  ['T21_in_s2t0,                                  'T21_op2']
    # OUT: ['T21_in_s2t0 -> T21_out_s1t0', 'T21_out_s1t0 -> T21_op2']

    # print "maybe can connect '%s' to '%s' through an intermediary" % (a,b)

    # E.g. a = 'T63_out_s1t4' , a_cgra = 'out_BUS16_S1_T4'
    a_cgra = cgra_info.canon2cgra(a)
    b_cgra = cgra_info.canon2cgra(b)

    # areach = all ports reachable from a
    # breach = all ports that can reach b
    # look for intermediary = intersection of sets a and b

    # areach = FO # from just up there
    areach = cgra_info.fan_out(a_cgra, T, DBG-1)
    print "'%s'/'%s' can a-reach %s" % (a,a_cgra,areach)

    # b_cgra = to_cgra(b, DBG-1)
    # breach = cgra_info.reachable(b_cgra, T, DBG=1)

    # breach = cgra_info.fan_in(to_cgra(b), T, DBG-1)
    breach = cgra_info.fan_in(b_cgra, T, DBG-1)
    print "'%s'/'%s' can be b-reached by %s" % (b,b_cgra,breach)

    middle = False
    for p in areach:
        print p, breach
        if p in breach:
            middle = p
            middle_canon = cgra_info.cgra2canon(middle, T)
            print "WHOOP! There it is:", p, middle_canon
            break

    if middle:
        middle_canon = cgra_info.cgra2canon(middle, T)

        # T41_out_s1t0b is not available to node 'bitnot_156_lut_bitPE'
        if middle_canon not in resources[T]:
            if DBG: print "Oops middle node is occupied; we will have to try again"
            # assert self.is_avail(middle_canon)
            return False

        print "Found double connection QUICKLY."
        p1 = '%s -> %s' % (a, middle_canon)
        p2 = '%s -> %s' % (middle_canon, b)
        pmiddle = [p1,p2]

        print "Found double connection.  What a day!"
        print "Remember quickfind was", middle, pmiddle
        return pmiddle

    else:
        print "NO MIDDLE"
        print "no good"
        return False


def addT(tileno, r):
    '''Embed tileno in resource 'r' e.g. "mem_out" => "Tx0406_mem_out"'''
    # return 'T' + str(tileno) + '_' + r
    return 'Tx%04X_%s' % (tileno, r)


# FIXME/TODO use CT.parse_resource(r) instead
def parse_resource(r):
    '''
    resource must be of the form "T0_in_s0t0" or "T3_mem_out"
    returns tileno+remains e.g. parse_resource("T0_in_s0t0") = (0, "in_s0t0")
    4/2018 now also works for e.g. "T0_in_s0t0b"
    '''
    return cgra_info.parse_resource(r)


def prettyprint_dict(dictname, dict):
    # So dumb.  But pretty maybe?
    maxlen = 0
    for d in sorted(dict):
        maxlen = max(maxlen, len(str([d])))
    fmt = "%%s%%-%ds = %%s" % maxlen
    for d in sorted(dict):
        # print "%s%-20s = %s" % (dictname, [d], dict[d])
        print fmt % (dictname, [d], dict[d])
    

# def reachable(a,b):
#     # Will use cgra_info.reachable(), but first have to rewrite some things
#     # E.g. 'T0_in_s1t2' => 'in_BUS16_S1_T2'
    

def to_cgra(name, DBG=0):
    # Valid names include "T0_in_s0t0","T3_mem_out"
    return cgra_info.canon2cgra(name, DBG)

# FIXME oh poots just DELETEME
# def from_cgra(name, tileno, DBG=0):
#     return cgra_info.cgra2canon(name, tileno, DBG)

# FIXME oh poots just DELETEME
# def parse_cgra_wirename(w, DBG=0):
#     return cgra_info.parse_cgra_wirename(w, DBG)

# List of output ports being used as registers
REGISTERS = []

def add_register(dtileno, d_in, DBG=0):
    global REGISTERS
    REGISTERS.append(d_in)

    if DBG>2: print "# Add reg's input wire to list of registers"
    if DBG>2: print '# 3039 added reg "%s" to REGISTERS' % d_in
    if DBG>2: print '# now registers is', REGISTERS


# FIXME do the thing with the globals and the init-globals...
nodes = {}
def build_nodes(DBG=0):
    # Build a global data structure from the dot file e.g.
    #
    #   "INPUT" -> "lb_p4_clamped_stencil_update_stream$mem_1$cgramem";
    #   "INPUT" -> "lb_p4_clamped_stencil_update_stream$reg_0_1";
    #   "INPUT" -> "mul_49119_492_PE";
    #
    # becomes
    #
    #   node["INPUT"].dests = ["mem_1" "reg_0_1", "mul_49119_492_PE"]

    global nodes; nodes = {}

    # filename = 'examples/build.171027/pointwise_mapped.dot'
    filename = dot_filename

    input_lines = []
    if DBG: print filename
    inputstream = open(filename);
    for line in inputstream: input_lines.append(line)
    inputstream.close()

    # for line in sys.stdin:
    for line in input_lines:
        line = line.strip()
        build_node(nodes, line, DBG)

    if DBG:
        print ''
        print "Found nodes and destinations (note wen_luts processed separately):"
        for n in sorted(nodes): print "  %-20s %s" % (n, getnode(n).dests)
        print ""


def build_node(nodes, line, DBG=0):
    # Rewrite to simplify
    # e.g. "INPUT" -> "lb_p4_clamped_stencil_update_stream$mem_1$cgramem"; # fifo_depth 64
    # =>   "INPUT" -> "mem_1"; # fifo_depth 64

    if DBG>1:
        print('\n\n'); 
        pwhere(1466, "# Building node for input line '%s'" % line)


    # NODE SIMPLIFICATION
    # I dunno this might be a bad idea; but it makes debugging more readable...?
    # E.g. "lb_p4_clamped_stencil_update_stream$lb1d_0$reg_1" -> "mul_307_308_309$binop.data.in.0"
    # ->   "lp4csus$reg_1" -> "mul_307_308_309$binop.data.in.0"
    line = re.sub('_p4_clamped_stencil_update_stream', '_p4csus', line)

    #    "INPUT" -> "lb_p4_clamped_stencil_update_stream$lbmem_1_0$cgramem"
    # -> "INPUT" -> "lb_p4csus$lbmem_1_0$cgramem"

    if DBG>1: pwhere(1474, "# Post-xform line: '%s'" % line)

    parse = re.search('["]([^"]+)["][^"]+["]([^"]+)["]', line)
    if not parse:
        if DBG: pwhere(1205, "# Could/did not parse input line '%s' (but that's okay!)" % line)
        return

    lhs = parse.group(1); rhs = parse.group(2)
    if DBG>1: print "# Found lhs/rhs", lhs, rhs, "\n";

    # json2dot is responsible to do this!
    # if lhs == "io16in_in_0.out": lhs = "INPUT"
    # if rhs == "io16_out.in"    : rhs = "OUTPUT"

    # Ignore lutcnst driving cg_en, ren, wen e.g.
    #  "lb_gx2sus$lbmem_1_0$c0_lutcnst" -> "lb_gx2sus$lbmem_1_0$cgramem.cg_en";
    #  "lb_gx2sus$lbmem_1_0$c1_lutcnst" -> "lb_gx2sus$lbmem_1_0$cgramem.ren";
    #  "lb_gx2sus_wen1_lutcnst"         -> "lb_gx2sus$lbmem_1_0$cgramem.wen";
    if (lhs.find('lutcnst') > 0) and re.search(r'[.](cg_en|ren|wen)$', rhs):
        if DBG: print('# Ignoring connection "%s" -> "%s"' % (lhs,rhs))
        return

    if DBG>1: print("Building rhs node " + rhs)
    addnode(rhs);

    # FIXME after new regime fully implemented
    # Backward compatibility---can delete after new regime fully implemented
    # Hm this is kind of terrible maybe FIXME/hack
    # Ignore wen_lut nodes e.g. 'lb_p4_clamped_stencil_update_stream_wen_lut_bitPE'
    if lhs.find('wen_lut') > 0:
        if DBG: print("Ignoring wen_lut node '%s'" % lhs)
        return

    # FIXME should this be part of addnode()?  yes i think so...
    # ALL mem nodes need wen luts....right...?
    if is_mem_node(rhs):
        # wenlut gets processed separately later i guess
        getnode(rhs).wen_lut = 'needs_wenlut'
        getnode(rhs).show()

    if DBG>1: print("Building lhs node", lhs)
    addnode(lhs)

    if DBG>1:
        print "LINE: %s" % line
        print "Attaching '%s' to '%s'" % (lhs,rhs)

    getnode(lhs).dests.append(rhs)

    # Uhhhh...look for and process fifo_depth comments
    process_fifo_depth_comments(rhs,line,DBG)

    # E.g. 'lb_grad_xx_2_stencil_update_stream$lbmem_1_0'
    # BUT NOT 'lb_grad_xx_2_stencil_update_stream$lbmem_1_0.wen'
    if re.search(r'lbmem[^.]*$', rhs) and getnode(rhs).fifo_depth == -1:
        errmsg = "\nERROR No fifo_depth comment on input line:\n%s\n" % line
        print errmsg
        assert False, errmsg

    # Uhhhh...look for and process lut_value comments
    process_lut_value_comments(lhs,line,max(0,DBG-1))


def process_lut_value_comments(lhs, line, DBG=0):
    '''
    Look for something like rhs="mem_1" and line=
        "bitand_3_1_4_lut_bitPE" -> "bitor_4_5_6_lut_bitPE.in0"; # lut_value 0x88
    and add lut_value to lhs node info
    '''
    #assert False, 'Uhhhh...look for and process lut_value comments'
    parse =  re.search('lut_value\s+0x(..)$', line)
    if not parse:
        return
    else:
        if DBG: pwhere(1266, "# Found a lut_value comment to process:")
        if DBG: pwhere(1267, "# %s" % line)
        lut_value = parse.group(1)
        getnode(lhs).lut_value = int(lut_value,16)
        if DBG: getnode(lhs).show()


def process_fifo_depth_comments(rhs, line, DBG=0):
    '''
    Look for something like rhs="mem_1" and line=
        "INPUT" -> "mem_1"; # fifo_depth 64
    and add fifo_depth to "mem_1" node info
    '''
    parse =  re.search('fifo_depth\s+(\d+)$', line)
    if not parse:
        return
    else:
        if DBG: pwhere(1283, "# Found a fifo_depth comment to process")
        errmsg='''

ERROR rhs[0:3] should be mem tile but rhs is actually:
ERROR  "%s"

''' % rhs

        # assert rhs[0:3] == 'mem', 'oops dunno what mem to config fifo_depth'
        # assert rhs[0:3] == 'mem', errmsg
        if not is_mem_node(rhs):
            print "ERROR line='%s'" % line
            print "ERROR rhs='%s'" % rhs
            assert is_mem_node(rhs),     errmsg

        fifo_depth = parse.group(1)
        getnode(rhs).fifo_depth = int(fifo_depth)
        # print "\n666foo", rhs, line; getnode(rhs).show()


def initialize_routes():
    for nodename in nodes:
        n = getnode(nodename)
        for d in n.dests:
            n.route[d] = []
            # n.routed[d] = False



# # Could also be a simple list resources[n]
# class Tile:
#     # Enumerate the tile resources
#     def __init__(self,tileno):
#         self.tileno = tileno
#         self.resources = []
#         for dir in ['in','out']:
#             for side in range(4):
#                 for track in range(5):
#                     port = "%s_s%dt%d" % (dir,side,track)
#                     self.resources.append(port)
#         # print self.resources
# 
# global tiles
# def init_tiles_old(DBG=0):
#     ntiles = cgra_info.ntiles()
# 
#     tiles = range(ntiles)
# 
#     for i in range(len(tiles)):
#         tiles[i] = Tile(i)
# 
#     if DBG: print "Initialized %d tiles" % ntiles
# 
#     # print ntiles
#     # print tiles
#     # print tiles[0]


def build_resource_list(tileno, suffix, DBG=0):

    i = tileno
    resources = []
    for dir in ['in','out']:
        # for side in range(4):
        nsides = 4
        if  is_mem_tile(i): nsides = 8
        for side in range(nsides):
            for track in range(5):
                port = "Tx%04X_%s_s%dt%d%s" % (i, dir,side,track,suffix)
                resources.append(port)

    # Tile-specific resources
    pfx = 'Tx%04x_' % int(i)

    if suffix == '':
        # BUS16 resources
        if  is_mem_tile(i):
            resources.extend([pfx+'mem_in',pfx+'mem_out'])
        elif is_pe_tile(i):
            resources.extend([pfx+'op1',pfx+'op2',pfx+'pe_out'])
    else:
        # BUS1 resources
        if  is_mem_tile(i):
            resources.extend([pfx+'wen'])
        elif is_pe_tile(i):
            # Note bit[012] maps to in[012] repsectively
            resources.extend([pfx+'bit0',pfx+'bit1',pfx+'bit2',pfx+'pe_outb'])
    return resources


def show_resources(tileno):
    print('['),
    i = 0
    for s in resources[tileno]:
        if re.search('(t0)|(op1)|(bit0)|(mem_in)|(wen)', s): print ''
        print('%-14s' % s),
        i = i + 1
    if (i%4 == 0): print ''
    print(']')


def init_tile_resources(DBG=0):
    '''E.g. resources[0] = ['in_s0t0', 'in_s0t1', ... 'out_s3t3', 'out_s3t4']'''

    # FIXME if resources is global it should be RESOURCES instead
    global resources
    resources = {}
    ntiles = 0

    printed_pe = False; printed_mem = False

    for tileno in cgra_info.list_all_pe_and_mem_tiles():
        ntiles = ntiles + 1
        # print(666,"%04x" % tileno)

        valid = is_pe_tile(tileno) or is_mem_tile(tileno)
        if not valid: continue

        resources_bus = build_resource_list(tileno, '')  # BUS16
        resources_bit = build_resource_list(tileno, 'b') # BUS1
        resources[tileno] = resources_bus + resources_bit

        if (not printed_pe) and is_pe_tile(tileno):
            print 'PE: ', ; show_resources(tileno)
            printed_pe = True

        if (not printed_mem) and is_mem_tile(tileno):
            print 'MEM:', ; show_resources(tileno)
            printed_mem = True

    if DBG: print "Initialized %d tiles" % ntiles


# def build_resource_list(tileno, DBG=0):
# 
#         i = tileno
#         resources = []
#         for dir in ['in','out']:
#             # for side in range(4):
#             nsides = 4
#             if  is_mem_tile(i): nsides = 8
#             for side in range(nsides):
#                 for track in range(5):
#                     port = "Tx%04X_%s_s%dt%d" % (i, dir,side,track)
#                     resources.append(port)
# 
#         # Tile-specific resources
#         pfx = 'T' + str(i) + '_'
#         if  is_mem_tile(i):
#             resources.extend([pfx+'mem_in',pfx+'mem_out'])
#         elif is_pe_tile(i):
#             resources.extend([pfx+'op1',pfx+'op2',pfx+'pe_out'])
# 
#         return resources



# def is_pe_tile(tileno):  return re.search("^pe",  cgra_info.tiletype(tileno))
# def is_mem_tile(tileno): return re.search("^mem", cgra_info.tiletype(tileno))

def is_pe_tile(tileno):  return cgra_info.mem_or_pe(tileno) == 'pe'
def is_mem_tile(tileno): return cgra_info.mem_or_pe(tileno) == 'mem'

# harris: slt_790_775_791$not$lut$lut.bit.in.0
def is_bit_node(nodename):
    # E.g. 'bitmux_157_157_149_lut_bitPE.bit.in.0' or 'OUTPUT_1bit'
    if   nodename.find('bit.in') >= 0: return True
    elif nodename  ==  'OUTPUT_1bit' : return True
    else: return False

def is_mem_node(nodename):
    # old style mem node must start with 'mem"
    if nodename[0:3] == 'mem': return True

    # new style mem node contains '$lbmem' maybe?
    # Yes, but old style does not; $lbmem got rewritten to just 'lbmem' :(
    c1 = (nodename.find('lbmem') >= 0)

    # ERROR rhs[0:3] should be mem tile but rhs is actually:
    # ERROR  "lb_p4_clamped_stencil_update_stream$mem_1$cgramem"
    c2 = (nodename.find('$cgramem') == (len(nodename) - len('$cgramem')))

    return c1 or c2


def initialize_node_INPUT():
    input  = INPUT_WIRE_T
    output = INPUT_WIRE_T
    tileno = INPUT_TILENO

    # Place 'name' in tile 'tileno' at location 'src'
    getnode('INPUT').place(tileno, input, output)


    # Really?
    # assert INPUT.name == 'INPUT'
    # assert INPUT.input0 == False
    # assert INPUT.input1 == False
    # assert INPUT.routed == False

def initialize_node_OUTPUT():
    # INPUT_WIRE_T =      'Tx%04X_in_s2t0' % INPUT_TILENO

    if 'OUTPUT' in nodes:
        # assert is_mem_tile(tileno) # Not relevant, maybe

        tileno = OUTPUT16_FEEDER_TILENO
        input = False # not routed yet

        # (For now at least) output must be track 0, see above
        # FIXME later could have an option to hop tracks maybe
        # So: One-bit output must come out track 0 on the right side (S0)
        # of the mem tile to the left of the pad (OUTPUT_TILE)
        trackno = 0; output = 'Tx%04X_out_s0t%d' % (tileno, trackno)
        # 0 is only track that goes to io16 output tile, right?
        # 'output' only used for no-longer-used output comment i think

        # Place 'name' in tile 'tileno' at location 'src'
        getnode('OUTPUT').place(tileno, input, output)
        getnode('OUTPUT').show()

def initialize_node_OUTPUT_1bit():
    if 'OUTPUT_1bit' in nodes:
        tileno = staging_area_onebit()
        # assert is_pe_tile(tileno) # not relevant maybe

        input    = False

        # output = False
        # 'output' only used for no-longer-used output comment i think
        # 0 is only track that goes to io16 output tile, right?
        trackno=0
        output   = 'Tx%04X_out_s1t%d' % (tileno, trackno) # this works
        # output = 'Tx%04X_out_s5t%d' % (tileno, trackno) # this works too (why?)

        getnode('OUTPUT_1bit').place(tileno, input, output)


def is_const(nodename):
    old_const = (nodename.find('const') == 0)
    # 
    # NEW: 'bitand_791_792_793$c0'
    # FIXME this looks fragile also not sure if 100% correct!
    # FIXME json should encode the constant as a comment like lut_value
    new_const = (re.search('[$]c[0-9]+$', nodename) != None)

    return old_const or new_const


def constval(nodename):
    # OLD: 'const0__334'
    kval = re.search('const(\d+)', nodename)
    if kval: return int(kval.group(1))
    #
    # NEW: slt_790_775_791$not$c0 is 0
    # NEW: slt_790_775_791$not$c01 is also 0
    # note $c0, $c01 NOT USED in harris, no need to fix for now :(
    # FIXME really should get value from json file
    kval = re.search('[$]c([0-9]+)$', nodename)
    if kval: return int(kval.group(1))
    # 
    return None


def is_reg(nodename):

    # old - still good!  with latest json2dot maybe
    if nodename.find('reg') == 0: return True

    # new (harris) "lb_padded_2_stencil_update_stream$lb1d_0$reg_1"
    else: return nodename.find('$reg') > 0


def is_mem(nodename):
    # return nodename.find('mem') == 0
    return is_mem_node(nodename)


# harris: ashr_760_763_764$binop.data.in.0
# harris: smax_788_789_790$cgramax.data.in.1
# harris: slt_790_775_791$comp$compop.data.in.0
# I guess luts are a pe for this definition
# harris: slt_790_775_791$not$lut$lut.bit.in.0
def is_pe(nodename):
    return (nodename) and (\
        # (nodename.find('add')   == 0) or \
        # (nodename.find('mul')   == 0) or \
        (nodename.find('PE')       >= 0) or \
        (nodename.find('$binop')   >= 0) or \
        (nodename.find('$compop')  >= 0) or \
        (nodename.find('$cgramax') >= 0) or \
        (nodename.find('$lut')     >= 0) or \
        (nodename.find('$mux')     >= 0) or \
        False)

# harris: ashr_760_763_764$binop.data.in.0
# harris: smax_788_789_790$cgramax.data.in.1
# harris: slt_790_775_791$comp$compop.data.in.0
# E.g. nodename = 'smax_780_781_782$cgramax.data.in.1' => portnum = 1
def pe_portnum(nodename):
    if   not is_pe(nodename) : return -1
    elif not re.search(r'\.data\.in\.(\d)$', nodename): return -1
    else: return int(nodename[-1])    


def is_io(nodename):
    return \
           (nodename != None) and \
           (re.search("(INPUT|OUTPUT)", nodename) != None)
         # (re.search("(INPUT)|(OUTPUT)|(OUTPUT_1bit)", nodename) != None)

# harris: slt_790_775_791$not$lut$lut.bit.in.0
def is_lut(nodename):
    '''E.g. "bitand_153_151_154_lut_bitPE" is a lut'''
    return (nodename) and (\
        (nodename.find('lut_bitPE') >= 0) or \
        (nodename.find('$lut') >= 0) or \
        False)


def find_regsolo_dstports(name, tile, track, DBG=0):
    DBG=1
    if DBG: pwhere(1684, "# '%s' is a 'regsolo' register I guess?" % name)
    ntracks = 5 # FIXME should be global i guess...?
    # so return names of all outports in the tile
    # as possible dest ports
    p = []

    if is_mem_tile(tile): nsides = 8 # Yes reg can be in a mem tile, why not
    else: nsides = 4

    if track == -1: trackrange = range(ntracks)
    else:           trackrange = [track]

    if DBG: print( "- make sure each outport goes somewhere valid!")
    for track in trackrange:
      for side in range(nsides):
        outport = "Tx%04X_out_s%dt%d" % (tile,side,track)
        n = CT.find_neighbor(outport, DBG=0)
        assert n[0:2] == 'Tx', "signal name '%s' looks wrong..." % n

        # '''E.g. parseT("T4_in_s2t4") = (4, "in_s2t4")'''
        (t,w) = parseT(n)
        if is_pe_tile(t) or is_mem_tile(t):
          if DBG: print("-- Hey '%s' you're okay you connect to '%s'" % (outport, n))
          p.append(outport)

        elif DBG: print("** Hmm '%s' neighbor '%s' not exist maybe **" % (outport, n))

        # if outport == 'T21_out_s3t0': print '666a here we is'

    if DBG: print ""
    return p


# dest node 'mux_793_794_795$mux.bit.in.0'
# dest port 'Tx0508_op1'
def dstports(name, tile, track, DBG=0):
    # 'dstports' is what you need to connect to to get the indicated node, yes?
    # E.g. for pe it's op1 AND op2; for mem it's 'mem_in'
    # for regsolo it's every outport in the tile
    # for regpe it's op1 or op2
    global MEMHEIGHT
    def T(port):
        if port[-4:2] == 'in':
            assert port in ['in.0', 'in.1', 'in.2']
            port = 'op%d' % (int(port[-1]) + 1)

        assert port in ['op1', 'op2', 'op3', 'mem_in'], 'Found port "%s"' % port
        return 'Tx%04X_%s' % (tile,port)
    DBG=1
    ntracks = 5
    if DBG: pwhere(1613, "okay here we are in dstports()")
    if   is_mem(name):  p = [T('mem_in')]
    elif is_pe(name):
        if is_commutative(name):
            if DBG: print "found pe; it's commutative\n"
            p = []
            # FIXME note currently no mechanism for commutative bit ops e.g. AND, OR
            if getnode(name).input0 == False: p.append(T('op1'))
            if getnode(name).input1 == False: p.append(T('op2'))
            # e.g. p = [T('op1'),T('op2')]

        else:
            if DBG: print "found pe; it's NOT commutative\n"
            p = [find_outport(tile, name)]

    elif is_regop(name):
        if DBG: print "found a reg_op"
        p = [T(getnode(name).input0)]

    elif name == 'OUTPUT_1bit':
        global OUTPUT01_FEEDER_SIDE
        out_side = OUTPUT01_FEEDER_SIDE

        if (MEMHEIGHT == 2) and (out_side == 2): out_side = 6
        # if DBG: pwhere(1395, "One-bit output can only go out on side %s (bottom)" % out_side)

        p = []
        for track in range(ntracks):
            outport = "Tx%04X_out_s%dt%db" % (tile, out_side, track)
            p.append(outport)

    elif name == 'OUTPUT':
        # Output on track 0 ONLY
        # FIXME yeah this should be more nuanced than that :(
        p = []

        nsides = 4;
        if (MEMHEIGHT == 2) and (is_mem_tile(tile)): nsides = 8

        for side in range(nsides):
            outport = "Tx%04X_out_s%dt0" % (tile,side)
            p.append(outport)
    else:
        assert is_regsolo(name)
        p = find_regsolo_dstports(name, tile, track, DBG)

    dplist = sorted(p)
    # In-ports avail to dest node 'add_305_313_314_PE.in1': ['T22_op1', 'T22_op2']
    if DBG: print "   DP In-ports avail to dest node '%s': %s" % (name,dplist)

    # if DBG: print 'found destination ports', p
    assert not (dplist == [False])
    return dplist


# Return pe input that contains the register
# e.g. regpe_input('reg_2_3') = 'op1' (unplaced regpe) or
# or   regpe_input('reg_2_3') = 'T6_op1' (placed regpe)
def regpe_input(name): return getnode(name).input0


def test_dstports():
    dstports('mem_1', 8, -1)
    dstports('add_1', 1, -1)
    dstports('mul_1', 1, -1)
    dstports('reg_1', 1, -1)
# test_dstports()


def constant_folding(DBG=0):
    # Combine "const" nodes with their associated PEs
    # DBG=9
    if DBG>2: pwhere(1770, "CONSTANT FOLDING")
    # Process the constants
    # dests['const16_16'] = ['mul_48716_488_PE']
    global nodes
    for n in nodes:
        if not is_const(n): continue

        k = getnode(n)
        if DBG>2: print("Folding constant node '%s'" % k.name)

        # Constant has only one destination (the PE)
        dest = k.dests
        assert len(dest) == 1

        pe = getnode(k.dests[0])
        assert is_pe(pe.name)

        op = pe.addop(k.name, 'either')

        # 'input0' is the integer value of the constant
#         kval = re.search('const(\d+)', k.name).group(1)
#         k.input0 = int(kval)

        k.input0 = constval(k.name)

        k.placed = True
        k.tileno = pe.tileno
        o = 'Tx%04X_%s' % (pe.tileno,op)
        k.output = o
        kroute = '%s -> %s' % (k.name, o)
        k.route[pe.name] = [kroute]

        if DBG:
            kstr = '%-14s' % ("'" + k.name + "'")
            pstr = '%-20s' % ("'" + pe.name + "'")
            print "#   Folded const %s into %s as %s" % (kstr,pstr,op)
        if DBG>1: pe.show(); print ""

# UNPLACED REGOP REG
# node='reg_2_2'
#   type='regsolo' ***
#   tileno= -1
#   input0='False' ***
#   input1='False'
#   output='False'
#   placed= False
#   dests=['mul_45911_460_PE']
#   route ['mul_45911_460_PE'] = []
#   net= []
# 
# PLACED REGOP REG
# node='reg_2_2'
#   type='regop' ***
#   tileno= -1
#   input0='op1' ***
#   input1='False'
#   output='mul_45911_460_PE'
#   placed= False
#   dests=['mul_45911_460_PE']
#   route ['mul_45911_460_PE'] = ['op1']
#   net= []
# 
# UNPLACED REGOP OP
# node='mul_45911_460_PE'
#   type='idunno'
#   tileno= -1
#   input0='False' ***
#   input1='False'
#   output='False'
#   placed= False
#   dests=['add_457_460_461_PE']
#   route ['add_457_460_461_PE'] = []
#   net= []
# 
# PLACED REGOP OP
# node='mul_45911_460_PE'
#   type='idunno'
#   tileno= -1
#   input0='reg_2_2' ***
#   input1='False'
#   output='False'
#   placed= False
#   dests=['add_457_460_461_PE']
#   route ['add_457_460_461_PE'] = []
#   net= []
# 
def register_folding(DBG=9):
    '''
    Process all the reg->pe pairs
    Mark by setting reg ouput to pe node e.g. 'add_x_y'
    And set input to operand e.g. 'op1'
    Also: set getnode('add_x_y').op1 = regname FIXME do we do this?
    Also: sname->dname route must be non-None !!
    '''

    global nodes
    if DBG: print "# Process all the reg->pe pairs"
    for reg_name in nodes:

        # Only look at nodes that are regs
        # if getnode(n_name).processed: continue
        if not is_reg(reg_name):      continue
        reg = getnode(reg_name)

        # Reg must have ONE dest and dest must be a PE
        if len(reg.dests) != 1: continue
        pe_name = reg.dests[0]
        if not is_pe(pe_name):   continue
        pe = getnode(pe_name)

        # Fold it! By setting output to e.g. "add_x_y"
        # Also set getnode('add_x_y').op1 = regname FIXME do we do this?
        # route [pe, "op1"] means duh obvious right?
        # Also: sname->dname route must be non-None !!

        # E.g. pe_name = 'smax_780_781_782$cgramax.data.in.1' => which_op = 'in.1'
        which_op = pe_name[-4:]
        #         print "pe_name=", pe_name
        #         print "which_op=", which_op
        #         print '\n\n'

        assert (which_op == "in.0") or (which_op == "in.1")
        op = pe.addop(reg_name, which_op) # "in.0" (OLD: "op2")

        reg.input0  = op       # E.g. "in.0"
        reg.output = pe_name  # E.g. "add_x_y"
        reg.route[pe_name] = [op]  

        # if DBG: print "Found foldable reg '%s'" % reg_name
        if DBG: print "#   Folded reg '%s' into pe '%s' as '%s'" % \
           (reg_name,pe_name,op)

        # Make a note for later
        getnode(pe_name).reg_op = reg_name

        # Folded 'lb_p3_cim_stencil_update_stream$lb1d_1$reg_2'
        # into pe 'smax_780_781_782$cgramax.data.in.1' as 'data.0'

        if DBG>1:
            reg.show()
            pe.show()
            print '-----'



# Happens automatically as long as we process non-regop regs LAST (right?)
# def process_input(DBG=1):
#     # INPUT tile is always tile 0
#     # INPUT wire is always wire_m1_1_BUS16_S1_T0 i.e. T0_in_s2t0
# 
#     INPUT = getnode('INPUT')
#     INPUT_dests  = sorted(INPUT.dests)
# 
#     # Look for a reg-pe pair that we can fold into the INPUT tile
#     print "Searching for regop (reg/pe pair) in INPUT dests %s" % INPUT_dests
#     for dname in INPUT_dests:
#         # print dname
#         if is_regop(dname):
#             print "Found a reg pair starting at '%s'" % dname
#             fold_regop_to_input(getnode(INPUT_tileno), d)
#             return
# 
#     if DBG: print "No regpe candidates found for input folding\n"
# 
#     # That failed.
#     # Now, look for a pe that we can foldinto the INPUT tile
# 
#     print "Searching for foldable pe in INPUT dests %s" % INPUT_dests
#     for dname in getnode('INPUT').dests:
#         if is_pe(dname):
#             print "# Found INPUT-connected pe '%s'" % dname
#             fold_input_connected_pe(dname)
#             return
# 
#     if DBG: print "No pe candidates found for input folding\n"
# 
# def fold_regop_to_input(n,d): print 'its not plugged in yet'

def parseT(wirename):
    '''E.g. parseT("T4_in_s2t4") = (4, "in_s2t4")'''
    return cgra_info.parse_resource(wirename)

def getboth(tileno, wirename):
    parse = re.search('^T[^_]+_(.*)',wirename)
    if parse: wirename = parse.group(1)
    tname = 'Tx%04X_%s' % (tileno,wirename)
    return (wirename,tname)

def stripT(wirename):
    print wirename
    return re.search('^T[^_]+_(.*)',wirename).group(1)





# ??? NEVER USED ???
# def add_route(sname, dname, tileno, src_port, dst_port, DBG=1):
#     '''
#     Within tile "tileno" build connection "src_port -> dst_port"
#     Add connection to src node as part of route[dst]
#     Add ports to netlist for 'src'
#     Port names have the form 'T0_in_s1t1'
#     '''
# 
#     if dst_port == 'choose_op':
#         # Must choose port indicated by name
#         # I.e. foo.in0,in1 must connect to op1, op2 respectively (that's right)
#         # (FIXME could make exception for commutative ops I spose)
#         parse = re.search('\.in\.([0-9])$', dname)
#         if not parse: assert False, 'oof what now'
#         which_in = int(parse.group(1));
#         op = 'op%d' % (which_in + 1)
#         dst_port = "Tx%04X_%s" % (getnode(dname).tileno, op)
#         if DBG: print "# I must connect '%s' to '%s' (%s)" % (sname, dname, op)
#             
#     # Can't route unplaced nodes, right?
#     assert getnode(sname).placed == True
#     assert getnode(dname).placed == True
# 
#     # Build the port-to-port connection
#     connection = "%s -> %s" % (src_port, dst_port)
#     if DBG: print "#   Routed ports '%s'" % connection
# 
#     # getnode(sname).show()
# 
#     # Add the connection to src->dst route list
#     getnode(sname).route[dname].append(connection)
#     if DBG: print "#   Added connection '%s' to route from '%s' to '%s'" % \
#        (connection, sname, dname)
#     # getnode(sname).routed[dname] = True
#     if DBG: print "#   Now node['%s'].route['%s'] = %s" % \
#        (sname,dname,getnode(sname).route[dname])
# 
#     # Add the ports to netlist of src node
#     getnode(sname).net.extend([src_port, dst_port])
#     if DBG: print "#   Added ['%s','%s'] to netlist" % (src_port, dst_port)
#     if DBG: print "#   Now node['%s'].net = %s" % (sname,getnode(sname).net)
# 
#     if DBG: getnode(sname).show()






# FIXME OH NOOOOOO too many names for the same thing?
# ALSO; shouldn't this be a func in class Node???
def is_regpe(node_name):      return is_regop(node_name)
def is_folded_reg(node_name): return is_regop(node_name)


def is_regop(regname):
    '''
    "regname" is a reg-pair if:
    - regname is the name of a reg node AND
    - regname.input0 is one of 'in.0','in.1' OR
    - regname.output is a PE node
    '''
    assert type(regname) == str
    if not is_reg(regname): return False

    reg_out = getnode(regname).output # E.g. "op1" or "T2_op1" # what?? don't think so...
    # print reg_src;
                
    if is_pe(reg_out): return True
    else:              return False

def is_regreg(regname):
    '''These dont exist yet (right?)'''
    return False

def is_regsolo(regname):
    assert type(regname) == str
    if not is_reg(regname):  return False
    if is_regop(regname):    return False
    if is_regreg(regname): return False
    return True


def already_placed(sname, dname, indent='# ', DBG=0):
    was_placed = is_placed(dname)
    was_routed = is_routed(sname,dname,indent)

    # Skip nodes that have already been placed and routed
    # EXCEPT INPUT NODE destinations

    if was_placed and was_routed:

        # Seems to work fine w/o this 6/27/2018
        #         # FIXME try with this (below) commented out, I think it does nothing
        #         if sname == 'INPUT':
        #             # INPUT is a weird special case
        #             if DBG: print 'INPUT still needs processing'
        #             return False
        if False: print('foo')

        # if sname is regop and dname is its dest,
        # - keep processing
        # - use special case in place_and_route to shortcut it
        if is_regop(sname) and getnode(sname).output == dname:
            if DBG: print indent+'REGOP still needs processing'
            return False

        else:
            print indent+"  (already processed '%s')" % dname
            return True

    return False

def sort_children(schildren):
    # Build an ordered list of what to process; pe and mem first, then regs
    # With any luck, regs get a free ride somewhere along the path.
    
#     if schildren == []: return []

    regchilds = []; otherchilds = []
    for dname in sorted(schildren):
        if   is_pe(dname):    otherchilds.append(dname)
        elif is_io(dname):    otherchilds.append(dname)
        elif is_mem(dname):   otherchilds.append(dname)
        elif is_regop(dname): otherchilds.append(dname)
        elif is_reg(dname):   regchilds.append(dname)

        # should have been caught by is_io, above
        #elif dname=='OUTPUT': otherchilds.append(dname)

        else:
            print "ERROR What is '%s'?" % dname
            assert False, "ERROR What is '%s'?" % dname

    sorted_schildren = otherchilds + regchilds

    return sorted_schildren


def process_nodes(sname, indent='# ', DBG=1):
    '''Place and route each unprocessed destination for nodename'''

    # print indent+"Processing node '%s'" % sname
    src = getnode(sname)
    if src.dests == []: return     # Early out

    # Build an ordered list of what to process; pe and mem first, then regs
    # With any luck, regs get a free ride somewhere along the path.
    sorted_schildren = sort_children(src.dests)

    # Place and route all dests
    if DBG: print indent+"Processing '%s' dests %s" % (sname,sorted_schildren)

    recurse_list = []
    for dname in sorted_schildren:

        # Skip nodes that have already been placed and routed
        # EXCEPT INPUT NODE destinations
        print indent+"  Processing '%s' dest '%s'" % (sname,dname)
        if already_placed(sname, dname, indent, DBG):
            continue

        # place_and_route has special cases for re-(place and routing) 'INPUT' and reg outputs
        rval = place_and_route(sname,dname,indent+' ')
        assert rval

        # Hmph! Hmph! Another special case!
        # If placed tile is a mem tile, we probably need to build an associated wen_lut
        if getnode(dname).wen_lut == 'needs_wenlut': build_wen_lut(sname, dname, DBG)

        # Build list of nodes to process next
        recurse_list.append(dname)

    # Recursively continue on each previously-unprocessed dest
    for dname in recurse_list:

        # For nicer output e.g. 'addnode_1706' instead of 'addnode_1706.data.in.0'
        dname = base_nodename(dname)

        # When indent gets too long start over w/ '##', '###', '####' etc
        new_indent = indent+'    '
        if len(new_indent) > 40: new_indent = re.sub(' ','',indent) + '# '
        process_nodes(dname, new_indent)


########################################################################
########################################################################
########################################################################
# True breadth-first seems to actually do worse...!
# 
# def process_nodes_new(sname, indent='# ', DBG=1):
#     '''Place and route each unprocessed destination for nodename'''
#     process_node_list([sname], indent='# ', DBG=1)
# 
# def process_node_list(src_list, indent='# ', DBG=1):
#     '''Place and route each unprocessed destination for nodename'''
#     if DBG: print(indent+"Processing source-node list '%s'" % src_list)
# 
#     next_level = []
#     for sname in src_list:
#         src = getnode(sname)
#         sorted_children = sort_children(src.dests)
#         if sorted_children == []: continue
#         if DBG: print indent+"Processing '%s' dests %s" % (sname,sorted_children)
#         for dname in sorted_children:
#             print(indent+"  Processing '%s' dest '%s'" % (sname,dname))
# 
#             # Skip nodes that have already been placed and routed
#             # EXCEPT INPUT NODE destinations
#             if already_placed(sname, dname, indent, DBG):
#                 print(indent+"    Already been done")
#                 continue
# 
#             # place_and_route has special cases for re-(place and routing) 'INPUT' and reg outputs
#             rval = place_and_route(sname,dname,indent+' ')
#             assert rval
# 
#             # Hmph! Hmph! Another special case!
#             # If placed tile is a mem tile, we probably need to build an associated wen_lut
#             if getnode(dname).wen_lut == 'needs_wenlut': build_wen_lut(sname, dname, DBG)
# 
#             # For nicer output e.g. 'addnode_1706' instead of 'addnode_1706.data.in.0'
#             dname = base_nodename(dname)
# 
#             # Add dname to list of nodes to process next
#             next_level.append(dname)
# 
#     # When indent gets too long start over w/ '##', '###', '####' etc
#     new_indent = indent+'    '
#     if len(new_indent) > 40: new_indent = re.sub(' ','',indent) + '# '
#     process_node_list(next_level, indent, DBG)


def place_dname_in_input_node(dname, indent, DBG=0):
    '''
    # If src is INPUT node and dest is an unallocated PE,
    # or if src is INPUT node and dest is a register,
    # we will put dest in same tile with INPUT.
    '''
    if DBG>2: pwhere(2179, 'place_dname_in_input_node()')
    
    global INPUT_OCCUPIED
    pptile = preplaced(dname, DBG)

    # Early outs
    if INPUT_OCCUPIED:
        if DBG>2: print('  input occupied');
        return False

    elif pptile != -1:
        print("ho HO '%s' cannot go in INPUT tile, it has a pre-designated home %d" \
              % (dname, pptile))
        return False

    elif INPUT_TILE_PE_OUT not in resources[INPUT_TILENO]:
        if DBG>2: print('  not in resources');
        return False

    elif is_pe(dname):
        place_pe_in_input_tile(dname)
        INPUT_OCCUPIED = True
        return True

    elif is_folded_reg(dname):
        place_folded_reg_in_input_tile(dname)
        # assert False, "TODO put reg-pe folded pair in INPUT tile :("
        INPUT_OCCUPIED = True
        return True

    return False



def place_dest(sname, dname, indent, DBG=0):
    '''
    # Get nearest tile compatible with target node 'dname'
    # "Nearest" means closest to input tile (NW corner)
    # dtileno = get_nearest_tile(sname, dname)
    '''
    if is_placed(dname):
        dtileno = getnode(dname).tileno
        print "Actually '%s' has a home already, in tile %04X" % (dname, dtileno)
        if dtileno in packer.EXCEPTIONS:
            print "exceptions = ", packer.EXCEPTIONS
            pwhere(1586, "OOPS Already tried and failed to reach Tx%04X oh nooooo" % dtileno)
            assert False, "Out of options"
    else:
        dtileno = get_nearest_tile(sname, dname)

    if DBG:
        if dname == "OUTPUT_1bit": msg = 'Connecting to one-bit OUTPUT tile %04X\n' % dtileno
        elif dname == "OUTPUT":    msg = 'Connecting to OUTPUT tile %04X\n' % dtileno
        else:                      msg = 'Nearest available tile is %04X\n' % dtileno
        pwhere(2161, msg)

    return dtileno


def replace_dest(sname, old_dest, new_dest, DBG=0):
    snode = getnode(sname)
    if DBG: pwhere(2130, \
                   "In 'sname' dest list, replace '%s' w/ '%s'" \
                   % (old_dest, new_dest))
    if DBG>2:
        print ''
        print("#   Before:")
        print snode.show()

    for i,n in enumerate(snode.dests):
        if n == old_dest: snode.dests[i] = new_dest

    # This should not exist right?
    assert snode.route[old_dest] == [], 'Freak out!'

    # Replace existing placeholder route w/ placeholder route for new dest
    del snode.route[old_dest]  # Delete entry for old_dest
    snode.route[new_dest] = [] # Add entry for new dest

    if DBG>2: 
        print("#   After:")
        print snode.show()
        print ''


def create_node_w_dest(sname, dname, DBG=0):
    if DBG: pwhere(2173, "# Create new node '%s' w/dest '%s'" % (sname, dname))
    # E.g.
    # node='const0_OUTPUT_ADJACENT'
    #   type='idunno'
    #   ----
    #   tileno= -1
    #   input0='False'
    #   input1='False'
    #   bit0='False'
    #   bit1='False'
    #   bit2='False'
    #   output='False'
    #   ----
    #   placed= False
    #   dests=['add_OUTPUT_ADJACENT$binop.data.in.1']
    #   route ['add_OUTPUT_ADJACENT$binop.data.in.1'] = []
    #   net= []

    addnode(sname)
    snode = getnode(sname)
    snode.dests = [dname]
    snode.route[dname] = []
    # Note 'constant_folding' will place this for us at the end (I hope)
    if sname[0:5] != 'const':
        assert False, 'should this be placed and routed now?'

    if DBG>2: snode.show()
    return snode


HELPERNUM = 0
def create_adj_node(dname, DBG=0):
    '''
    Need an intermediate (adj) node "adjname"
    between src and dst nodes (sname and dname).
    '''
    # Create new adj node 'add_adj000' and route it to old dest 'dname'
    # 
    # node='add_OUTPUT_ADJACENT$binop'
    #   type='idunno'
    #   ----
    #   tileno= 35
    #   input0='False'
    #   input1='False'
    #   bit0='False'
    #   bit1='False'
    #   bit2='False'
    #   output='T35_pe_out'
    #   ----
    #   placed= True
    #   dests=['OUTPUT']
    #   route ['OUTPUT'] = [could pre-populate]
    #   net= ['T35_pe_out']

    # New basename for helper nodes e.g. 'adj000', 'adj001', etc.
    global HELPERNUM
    helper_basename = 'adj%03d' % HELPERNUM; HELPERNUM = HELPERNUM+1

    # New intermediate (adjunct) node e.g. 'add_adj001$binop'
    adjname = 'add_' + helper_basename + '$binop'

    addnode(adjname)
    adjnode = getnode(adjname)
    adjnode.dests = [dname]
    adjnode.route[dname] = []

    #Maybe this happens later, by its own self
    #adjnode.net = [adjnode.output]

    # If going to OUTPUT (tile 36), put adj in tile 35;
    # FIXME OUTPUT tile should be more heuristic, see e.g. 'find_output_tile()
    # FIXME assuming output tile is rightmost tile in the row, set ADJ to the tile just before that
    # E.g. if output tile is 0x0210 (r2c16) then adj tile is 0x020F (r2c15)
    if dname == 'OUTPUT': adj_tileno = OUTPUT16_FEEDER_TILENO-0x0001
    else:                 adj_tileno = -1 # Let PNR place adj later
    adjnode.tileno = adj_tileno

    if adj_tileno == -1:
        if DBG: print('# Creating unplaced intermediate node "%s"' % adjname)
    else:
        packer.allocate(adj_tileno, DBG)
        if DBG: print('# Creating intermediate node "%s" in tile Tx%04X' % (adjname,adj_tileno))
        if DBG: print("# order after placing intermediate node '%s'" % adjname)
        packer.FMT.order()
        adjnode.output = 'Tx%04X_pe_out' % adj_tileno # E.g. 'T35_pe_out'
        adjnode.placed = True

    #Maybe this happens later, by its own self
    #adjnode.net = [adjnode.output]

    if DBG>2: adjnode.show()

    # Attach constant '0' to input 1 (op2) of adj node (add0 no-op)
    # Create new node 'const0_adj000' and connect to adj node input 1 (op2)
    cname = 'const0_' + helper_basename # E.g. 'const0_adj000'
    adjname1 = adjname + '.data.in.1'   # E.g. 'add_adj001$binop.data.in.1'
    cnode = create_node_w_dest(cname, adjname1, DBG)

    # Might need this later who knows
    return adjname


# FIXME this is no longer OUTPUT-specific should rename it
def try_again_OUTPUT(sname, dname, dtileno, DBG=0):
    DBG=9
    if DBG: pwhere(2176, '# Try again using intermediate/adjunct/adj node')


    # 29300
    # T142_out_s2t0 is not available to node 'add_adj005$binop'
    # ../../serpent.py/2359: # Try again using some dest OTHER THAN tile 21
    # ../../serpent.py/2273: oops cannot change dest, must insert intermediate node
    # ../../serpent.py/2176: # Try again using intermediate/adjunct/adj node
    # # Creating unplaced intermediate node "add_adj006$binop"




    if sname[0:7] == 'add_adj':
        assert False, "Wait, no, source '%s' already adjunct now what!?" % sname





    # May want to take this out, dunno if we need it at all...
    # if dname == 'OUTPUT': getnode('OUTPUT').show()

#     if dname != 'OUTPUT':
#         pwhere(2277, 'WARNING 666a this may only work for dname == OUTPUT')

    ########################################################################
    # Create new adj node 'add_adj000' and point it to old dest 'dname'
    # Attach constant 0 to its 'op2' input (input 1)
    adjname = create_adj_node(dname, DBG)

    ########################################################################
    # In 'sname' dests list, replace old dest 'dname' w/new dest 'add_adj000'
    # using input 0 (op1) as new dest
    adjname0 = adjname + '.data.in.0' # E.g. 'add_adj001$binop.data.in.0'
    replace_dest(sname, dname, adjname0, DBG)



    # WHILE NOT SUCCESS



    # Route src => adj by calling place-and-route recursively using new dname
    # This should place adj node if not done yet
    # (Could be combined in replace_dest(), yes?)
    if not place_and_route(sname, adjname0, indent='# ', DBG=0):
        assert False, 'well that didnt work did it'

    ########################################################################
    # Now route adj => dname; this will place dname if not done yet
    if not place_and_route(adjname, dname, indent='# ', DBG=0):
        assert False, 'well that didnt work did it'

        # BOOKMARK
        # WHEN THIS FAILS...?
        # Back out and try again; maybe add adj tileno to ADJ_EXCEPTIONS or sumpm
        # UNPLACE ADJNAME0
        # TRY AGAIN

#     pwhere(1489, 'Tile %04X no good; undo and try again:' % dtileno)
#     packer.unallocate(dtileno, DBG=0)

#     # Add dtileno as an EXCEPTION and try again
#     packer.EXCEPTIONS.append(dtileno) => adj_tileno
#     print "exceptions = ", packer.EXCEPTIONS
#     rval = place_and_route(sname,dname,indent='# ',DBG=0)
# 
#     # Restore EXCEPTIONS, return final result.
#     packer.EXCEPTIONS = []
# 




    print 'HOORAY completed OUTPUT hack'
    print 'wait no HOORAY completed non-OUTPUT-specific adj-node hack'
    return True


def try_again(sname, dname, dtileno, DBG=0):
    '''Try sname->dname again, using some dest OTHER THAN dtileno'''
    DBG=9
    if DBG: pwhere(2359, '# Try again using some dest OTHER THAN tile %s'% dtileno)

    if is_placed(dname):
        # Note 'is_placed' is not tentative; it only changes when route finalized
        pwhere(2273, 'oops cannot change dest, must insert intermediate node')
        # Okay we're gonna try and fix it.
        return try_again_OUTPUT(sname, dname, dtileno, DBG)

    # BOOKMARK CONTINUE CLEANING HERE maybe

#     elif (dname == "OUTPUT_1bit"):
#         print ""
#         print "Cannot find our way to OUTPUT, looks like we're screwed :("
#         assert False, "Cannot find our way to OUTPUT, looks like we're screwed :("


    assert not is_placed(dname)


    pwhere(1489, 'Tile %04X no good; undo and try again:' % dtileno)

    # CAREFUL! get_nearest_tile() may have tried to put sname and dname in same tile!
    # If it fails it may erroneously deallocate sname!
    # FIXME ORIG_ORDER is a very hacky way to address that...
    global ORIG_ORDER
    if ORIG_ORDER != False:
        if DBG>2: print("666f Tried and failed to put sname and dname in same tile")
        if DBG>2: print("666f restoring the natural order...")
        (oo_tileno, oo_order) = ORIG_ORDER
        packer.order[oo_tileno] = oo_order
        ORIG_ORDER = False
    else:
        packer.unallocate(dtileno, DBG=0)

    if dtileno in packer.EXCEPTIONS:
        print "2401 exceptions = ", packer.EXCEPTIONS
        pwhere(2402, "OOPS Already tried and failed to reach Tx%04X oh nooooo" % dtileno)
        assert False, "Out of options"

    # Add dtileno as an EXCEPTION and try again
    packer.EXCEPTIONS.append(dtileno)
    print "exceptions = ", packer.EXCEPTIONS
    rval = place_and_route(sname,dname,indent='# ',DBG=0)

    # Restore EXCEPTIONS, return final result.
    packer.EXCEPTIONS = []
    return rval


def find_trackrange_regsolo(nodename, DBG=0):

    # If sname already placed, track may be pre-ordained
    # E.g. in example below output='T73_in_s2t1'
    # So need to route on track 1, yes?
    # 
    # node='lb_p3_cim_stencil_update_stream$lb1d_0$reg_1'
    #   type='regsolo'
    #   ----
    #   tileno= 72
    #   input0='T72_out_s0t1'
    #   input1='False'
    #   bit0='False'
    #   output='T73_in_s2t1'

    if not is_regsolo(nodename): return False
    dnode = getnode(nodename)
    if DBG>2: dnode.show()
    if dnode.output:
        if DBG>2: print dnode.output
        assert is_regsolo(nodename)
        parse = re.search(r's[0-9]t([0-9])b?$', dnode.output)
        if parse:
            assert is_placed(nodename)
            out_track = int(parse.group(1))
            pwhere(2407, "dest '%s' is placed regsolo; " % nodename +
                   "must connect to '%s' on track %d" % (dnode.output, out_track))
            return [out_track]

    assert False, 'shouldna called this func if it was gunna fail...'
    return False


ANYTRACK = range(5)
def anytrack():
    '''Return [0,1,2,3,4] then [1,2,3,4,0] then [2,3,4,0,1] etc'''
    global ANYTRACK; global SWIZZLE_TRACKS; rval = ANYTRACK
    if SWIZZLE_TRACKS: ANYTRACK = ANYTRACK[1:] + ANYTRACK[0:1] # Rotate
    return rval


def find_trackrange(sname, dname, DBG=0):

    if sname == "INPUT":
        trackrange = [0]

    # (For now at least) output must be track 0, note I think OUTPUT is a mem tile
    elif dname == "OUTPUT":
        trackrange = [0]

    # FIXME i think onebit is a pe tile and could use any of the five tracks!?
    # NO! output only track 0.  (*input* can be any track)
    elif dname == "OUTPUT_1bit":
        trackrange = [0]

    # Check for if sname or dname is a placed regsolo
    elif is_placed(dname) and is_regsolo(dname):
        trackrange = find_trackrange_regsolo(dname, DBG)

    elif is_regsolo(sname):
        trackrange = find_trackrange_regsolo(sname, DBG)

    # If node is pe or mem, can try multiple tracks (see further below)
    elif is_mem(sname) or is_pe(sname):
        # assert not is_placed(dname) # Nope could be e.g. placed mul w/open input left
        # trackrange = range(5)
        trackrange = anytrack()

    else:
        assert False, "WARNING unknown tile this is probably bad..."
        trackrange = [0]

    return trackrange


def place_and_route(sname,dname,indent='# ',DBG=0):
    # DBG=9
    if DBG: print indent+"PNR '%s' -> '%s'" % (sname,dname)
    if is_routed(sname, dname, indent, DBG):
        print(indent+"  ('%s' -> '%s' route already exists" % (sname, dname))
        return True

    # Source should already be placed, yes?
    if not is_placed(sname):
        pwhere(1709, "ERROR 1709 '%s' has not been placed yet?" % sname)
        assert False

    if (sname == "INPUT"):
        # If src is INPUT node and dest is an unallocated PE,
        # or if src is INPUT node and dest is a register,
        # we'll put dest in same tile with INPUT.
        if place_dname_in_input_node(dname, indent, DBG):
            print(indent+" Placed '%s' in INPUT node (2420)" % dname)
            print indent+" Routed %s" % getnode(sname).route[dname]
            print indent+" Now node['%s'].net = %s" % (sname,getnode(sname).net)
            print ""
            return True

    # Does destination have a home?  YES, see above
    if True:
        #FIXME wtf with the 'if true' jazz

        DBG=1
        if DBG: print indent+"No route to '%s'" % dname

        # Get nearest tile compatible with target node 'dname'
        # "Nearest" means closest to input tile (NW corner)
        # dtileno = get_nearest_tile(sname, dname)
        dtileno = place_dest(sname, dname, indent, DBG)

        # Which track(s) should we search for a route?
        trackrange = find_trackrange(sname, dname, DBG)

        # BOOKMARK cleaning place_and_route()

        # FIXME this needs to be cleaned up?
        # DBG=9
        for track in trackrange:
            if DBG: print "TRYING TRACK", track, "OF", trackrange

            path = find_best_path(sname, dname, dtileno, track, DBG=1)
            if not path: print "TRACK", track, "no good"
            if path:
                if DBG: print "HEY FOUND PATH", path
                break
            else:
                if DBG: print "No path for you! (..on track '%d')" % track

            print track, trackrange[-1]
            if track != trackrange[-1]:
                pwhere(1607, "could not find path on track %d, try track %d" % (track, track+1))
                pwhere(1608, "trackrange = %s" % trackrange)

        if not path:


            if sname[0:7] == 'add_adj':
                pwhere(2528, "oops source '%s' already adjunct now what!?" % sname)
                return False
                       
            # Try again, using some dest OTHER THAN dtileno
            rval = try_again(sname, dname, dtileno, DBG)
            # try_again calls place and route, doing the cleanup work below.
            # So we can return immediately
            return rval

        # CAREFUL! get_nearest_tile() may have tried to put sname and dname in same tile!
        # If it fails it may erroneaousl deallocate sname!
        # FIXME ORIG_ORDER is a very hacky way to address that...
        global ORIG_ORDER
        if ORIG_ORDER != False:
            if DBG>2: print("666f Tried and SUCCEEDED putting put sname and dname in same tile")
            if DBG>2: print("666f restoring the natural order...")
            (oo_tileno, oo_order) = ORIG_ORDER
            packer.order[oo_tileno] = oo_order
            ORIG_ORDER = False



        print "# Having found the final path,"
        print "# 1. place dname '%s' in dtileno" % dname
        print '# 1a. If regsolo, add name to REGISTERS for later'
        print "# 1b. If regop, place (but don't route) assoc. pe"
        print "# 2. Add the connection to src->dst route list"
        print "# 3. add all the path ports to the src net"
        print "# 4. Remove path resources from the free list"
        print ""

        # First a quick sanity check
        shortmem_sanity_check(path)

        # print 666, dtileno
        # if dtileno == 15: print 666
        print "# 1. place dname in dtileno"
        d_in = CT.allports(path)[-1]

        if   is_pe(dname):
            # Connect endpoint to pe_out
            d_out = addT(dtileno,'pe_out')

        elif is_mem(dname): d_out = addT(dtileno, 'mem_out')

#         # BOOKMARK FIXME should not need this no mo
#         # elif dname == "OUTPUT":
#         elif dname == "OUTPUT":
#             # (For now at least) output must be track 0, see above
#             # FIXME later could have an option to hop tracks maybe
#             # So: One-bit output must come out track 0 on the right side (S0)
#             # of the mem tile to the left of the pad (OUTPUT_TILE)
#             trackno = 0
#             d_out = addT(dtileno,'out_s0t%d' % trackno)
# 
#         elif dname == "OUTPUT_1bit":
#             # One-bit output must come out track 0 on the bottom side (S5)
#             # of the mem tile above the pad (OUTPUT_TILE_onebit)
#             trackno = 0
#             d_out = addT(dtileno,'out_s5t%d' % trackno)
# 

        elif dname[0:6] == "OUTPUT":
            print('should be already done i think')
            d_out = getnode(dname).output


        elif is_regsolo(dname):
            print '# 1a. If regsolo, add name to REGISTERS for later'
            d_out = CT.find_neighbor(d_in, DBG=0)
            add_register(dtileno, d_in)

            # If neighbor tile is zero we did something wrong!
            assert d_out[0:3] != 'T0_', "regsolo neighbor tile does not exist maybe?"

        elif is_regop(dname):
            d_out = place_regop_op(dname, dtileno, d_in, DBG)

        elif is_regreg(dname):
            assert False, 'what do we do with regreg??'

        else:
            errmsg = '''

ERROR dname = "%s"
ERROR what is it?  
ERROR apparently not one of: pe, mem, output, io1_out, regsolo, reg or regreg

''' % dname

            # print errmsg
            # print 'is_reg?', is_reg(dname)
            # print 'is_regop?', is_regop(dname)
            # print 'is_regreg?', is_regreg(dname)

            # assert False, 'what do we do with regs?? (see below)'
            assert False, errmsg
            # ANSWER: make sure reg dest is registered in REGISTERS etc.
        
        getnode(dname).place(dtileno, d_in, d_out, DBG)
        print ""
        
        # DONE see above
#         print '# 1a. If regsolo, add name to REGISTERS for later'
#         if is_regsolo(dname):
#             getnode(dname).show()
#             print 'now what?'
#             print 'add reg to REGISTERS'

        # FIXME this exact code is repeated elsewhere!!!
        print "# 2. Add the connection to src node's src->dst route list 2767"
        getnode(sname).route[dname] = path
        if DBG: print "#   Added connection '%s' to route from '%s' to '%s'" % \
           (path, sname, dname)
        # getnode(sname).routed[dname] = True
        if DBG: print "#   Now node['%s'].route['%s'] = %s" % \
           (sname,dname,getnode(sname).route[dname])
        pwhere(1186)
        print ""

        print "# 3. add all the path ports to the src net (2603)"
        snode = getnode(sname)
        print "BEFORE: '%s' net is %s" % (sname, snode.net)
        for p in CT.allports(path):
            if p not in snode.net: snode.net.append(p)
        print "AFTER: '%s' net is %s" % (sname, snode.net)
        print ''
        
        print "# 4. Remove path resources from the free list"
        unfree_resources(path,DBG)

        print ''
        print "HOORAY connected '%s' to '%s' 2583" % (sname,dname)
        if DBG:
            print ''
            getnode(sname).show()
            print ''
            getnode(dname).show()
            print ''

        if DBG: print "# Route '%s -> %s' is now complete 1" % (sname,dname)

        # Hmph! Hmph! There's a special case to consider.
        # if dest_name appears twice in self.dests, that
        # means we have to duplicate the route for both op1 and op2.
        check_for_double_destination(sname,dname,DBG)

        # FIXME ?? ?? what the hell is this all about?
        if dname == 'reg_0_1': print 'GOT TWO ROUTES!  WOO AND HOO!'

        # FIXME We used to have this option for random placement I guess
        # FIXME Clean up this comment block?
        # if DBG: print indent+"For now just place it randomly"
        # (tileno,resource) = randomly_place(dname)

        (tileno,resource) = (dtileno, d_out)

    else:
        (tileno,resource) = (-1, "already_placed")

    if not is_routed(sname,dname):
        assert False, 'huh, this has still never happened i guess...'

        # assert False, 'cannot be placed without being routed...right??'
        # print 666
        print 'Cannot be placed without being routed...right??'
        print 'Wrong, sure it can! alu with op1 routed but not yet op2, yes?'
        print 'Off to new territory...'

#         if DBG: print indent+"No route '%s -> %s'" % (sname,dname)
#         if DBG: print indent+"For now just mark it finished"
#         bogus_route = "%s -> %s BOGOSITY" % (sname,dname)
#         getnode(sname).route[dname].append(bogus_route)
#         finish_route(sname,dname)

    # return (tileno,resource)

    # FIXME Whaaaat? This ain't right... :(
    # (tileno,resource) = (getnode(dname).tileno, getnode(dname).input0)
    # print indent+"  Placed '%s' at tile %04X port '%s'" % (dname,tileno,resource)
    # print indent+"  Routed '%s -> %s'" % (sname,dname)

#             print indent+"  1679 Placed '%s' in tile %04X at location '%s'" \
#                   % (dname, t, loc)


    # I think loc is last thing added to sname net...?
    print indent+" Placed '%s' in tile %04X at location '%s' (2676)" \
          % (dname, getnode(dname).tileno, getnode(sname).net[-1])
    print indent+" Routed %s" % getnode(sname).route[dname]
    print indent+" Now node['%s'].net = %s" % (sname,getnode(sname).net)
    print ""

    # FIXME OUTPUT placement is kind of a WART
    if (dname == 'OUTPUT'):
        pwhere(2639, 'this is the wrong place for this innit')
        packer.allocate(getnode(dname).tileno, DBG)
        print("# order after placing '%s'" % dname)
        packer.FMT.order()

    return True

# END def place_and_route()
########################################################################



########################################################################
# is_last_wen_lut_candidate() below is supposed to fix this error
# (tmp.srpent.log4a)
# -----
#  Placed 'lb_grad_yy_2_stencil_update_stream$lbmem_2_0' in tile 125
#  at location 'T125_mem_in' (2676)
# 
# ../../serpent.py/2243: # Must create a wen_lut for mem node
# 'lb_grad_yy_2_stencil_update_stream$lbmem_2_0'
# 
#   So...to my right is tile 126 (0x126).  Is it free? False
#  Okay, well then to my left is tile 124 (0x124), Is it free? False
#  NO FREE TILES FOR WENLUT!!
########################################################################
global HAS_WEN_LUT; HAS_WEN_LUT = []
def is_last_wen_lut_candidate(tileno):
    '''
    # Reserve tile to left of mem tile for wen lut
    # If tileno is last hope for such space, return True
    # Ha...
    '''
    global HAS_WEN_LUT
    DBG=1
    (r,c) = cgra_info.tileno2rc(tileno)
    if (r%2)==1: return False
    tile_to_right = cgra_info.rc2tileno(r,c+1)
    if is_mem_tile(tile_to_right):
        if DBG: pwhere(2880, "okay tile %04X, to my right, is a mem tile" % tile_to_right)
        if tile_to_right in HAS_WEN_LUT:
            if DBG: print "okay mem tile %04X has a wenlut already" % tile_to_right
            return False
        else:
            if DBG: print(\
               "I am tile %04X and I am the last hope for mem tile %04X to have a wen lut" \
               % (tileno, tile_to_right))
            return True
    return False

def build_wen_lut(sname, dname, DBG=0):
    assert getnode(dname).wen_lut == 'needs_wenlut'

    # For the purposes of this exercise I guess we get to ignore exceptions...?
    saved_exceptions = packer.EXCEPTIONS
    packer.EXCEPTIONS = []

    if DBG: pwhere(2243, "#   Must create a wen_lut for mem node '%s'" % dname)
    mtileno = getnode(dname).tileno
    (r,c) = cgra_info.tileno2rc(mtileno)
    # print "#   Mem tile is in tile %04X (0x%x)" % (mtileno,mtileno)

    # Check tile to right of memtile, then if not avail, check left
    candside = 'right'; cand = cgra_info.rc2tileno(r,c+1)
    print "#   So...to my right is tile %04X (0x%04X).  Is it free?" % (cand,cand),
    print packer.is_free(cand)
    if not packer.is_free(cand):
        # Not free
        candside = 'left'; cand = cgra_info.rc2tileno(r,c-1)
        if DBG: print "#  Okay, well then to my left is tile %04X (0x%x)," % (cand,cand),
        if DBG: print "Is it free?", packer.is_free(cand)
        if not packer.is_free(cand): assert False, "oh that's a shame"

    # Whew assert did not trigger so one of them works.
    # print "okay successfully found a candidate to hold the wen_lut hooray"
    if DBG:
        print '#   Great! Place the wen_lut in tile %04X(0x%x)' % (cand,cand)
        print ''
        print "# order before wen_lut alloc:"
        packer.FMT.order()
        print ''
    packer.allocate(cand, DBG=0)

    if DBG:
        print "# order after wen_lut alloc:"
        packer.FMT.order()
        print ''

    # Hmmm FIXME looks like we used two where one would do... :(
    # Remember cand for "is_last_wen_lut_candidate()" above
    global HAS_WEN_LUT; HAS_WEN_LUT.append(cand)

    # Make a note to build the LUT later
    global WEN_LUT_LIST; WEN_LUT_LIST.append(cand)

    # Make a note to build the wen_lut path later
    getnode(dname).wen_lut = (cand,candside) # E.g. "(25, 'right')"

    # Restore what we broke
    packer.EXCEPTIONS = saved_exceptions


def route_wen(memtile):
    '''
    # Route the stinkin wen_lut wire
    # E.g. if mem tile is 24 and wen_lut tile is 25, then emit:
    #   T25_pe_out_b0 -> T25_out_s2t0_b0
    #   T24_in_s0t0_b0 -> T24_out_s2t0_b0
    #   T24_out_s2t0_b0 -> T24_wen
    '''
    mtileno = getnode(memtile).tileno
    (wentileno,wenside) = getnode(memtile).wen_lut

    if wenside == 'right':
        print 'Tx%04X_pe_out_b0 -> Tx%04X_out_s2t0_b0'  % (wentileno, wentileno)
        print 'Tx%04X_in_s0t0_b0 -> Tx%04X_out_s2t0_b0' % (mtileno, mtileno)
        print 'Tx%04X_out_s2t0_b0 -> Tx%04X_wen'       % (mtileno, mtileno)
    else:
        print 'Tx%04X_pe_out_b0 -> Tx%04X_out_s0t0_b0' % (wentileno, wentileno)
        print 'Tx%04X_in_s2t0_b0 -> Tx%04X_wen'       % (mtileno, mtileno)
    print ''


# Removed 3/2018
# def process_output(sname,dname, DBG=1):
#     snode = getnode(sname)
#     dnode = getnode(dname)
#     src = snode.output
# 
#     if DBG>1:
#         snode.show()
#         dnode.show()
# 
#     if DBG:
#         print ''
#         print "1. Route from '%s' output '%s' to any avail outport in tile %04X"\
#               % (sname, src, snode.tileno)
# 
#     t = snode.tileno
#     if DBG>1: print "\n# Tile %04X free list: %s" % (t, resources[t])
# 
#     # if 'src' is an outport, just use that
#     if re.search('T\d+_out_', src): outwire = src
# 
#     # else choose first avail outwire
#     else:
#         for w in resources[t]:
#             if re.search('T\d+_out_', w):
#                 if DBG: print "#  - Found candidate '%s'.  Will it connect?" % w
#                 if cgra_info.connect_within_tile(t, src, w, DBG=0):
#                     if DBG: print '#  - YES'
#                     outwire = w
#                     break
#                 else:
#                     if DBG: print "#  - NO, keep looking."
# 
#     if DBG: print ''
# 
#     snode.route['OUTPUT'] = ['%s -> %s' % (src,outwire)]
#     snode.net.append(outwire)
#     if DBG: snode.show()
# 
#     dnode.type = 'OUTPUT'
#     dnode.tileno = snode.tileno
#     dnode.input0 = outwire
#     dnode.input1 = False
#     dnode.output = outwire
#     dnode.placed = True
#     dnode.net = [src,outwire]
#     if DBG: dnode.show()
# 
#     return
    
def squote(txt, f=''):
    fmt = '%'+str(f)+'s'  # E.g. '%-13s' when f=-13
    return fmt % ("'" + txt + "'")


# '%-13s' % ("'" + w + "'")
def sqw(w): return squote(w, -13)

def unfree_resources(path,DBG=0):
    '''Remove all path resources from free list(s)'''
    if (DBG>1): print("Unfree all resources in path:\n%s" % path)
    for r in CT.allports(path):
        (tileno,x) = CT.parse_resource(r)
        if (r in resources[tileno]):
            resources[tileno].remove(r)
            if DBG: print "     %s removed from tile %04X free list" \
               % (sqw(r), tileno)
            # print "  Before: %s" % resources[tileno]
            # print "  After:  %s" % resources[tileno]
        else:
            if DBG: print "     %s not in tile %04X free list" \
               % (sqw(r), tileno)


def place_and_route_test(sname,dname,indent='# ',DBG=1):
    if DBG: print indent+"  PNR '%s' -> '%s'" % (sname,dname)

    # Test
    getnode(dname).tileno = 999
    getnode(dname).input0    = dname
    getnode(sname).net.append(getnode(dname).input0)
    return


def place_pe_in_input_tile(dname):
    '''INPUT connects to pe 'dname'; place it in same node as INPUT'''
    DBG=1
    sname = 'INPUT'
    if DBG:
        print "# Place input-connected PE '%s' in INPUT tile" % dname
        print "Connecting '%s' to '%s'" % (sname,dname)

    assert getnode('INPUT').tileno == INPUT_TILE

    # Assumes: INPUT dest is a 16-bit pe operand op1 or op2
    # E.g. if dname = "mul_347_348_349_PE.data.in.0",
    # connect to op1 in node "mul_347_348_349_PE"
    parse = re.search('\.in\.([0-9])$', dname)
    if (parse):
        which_in = int(parse.group(1));
        op = 'op%d' % (which_in + 1)
        getnode(dname).place(INPUT_TILE, input=op, output=INPUT_TILE_PE_OUT)
    else:
        assert False, 'oof what now'


    # add_route(sname, dname, INPUT_TILE, INPUT_WIRE_T, 'choose_op')
    # Above assumes can connect input wire to chosen op e.g.
    # 'T21_in_s2t0 -> T21_op2'
    # BUT NO can connect to op1 but not op2 directly
    # how do we check?

# BOOKMARK
#     # e.g. serpent_connect_within_tile(node, 'T136_in_s1t1', 'T136_op2', 136)?
#     cend = serpent_connect_within_tile(dnode, endpoint, dstport, dtileno, DBG=DBG)

    sname = 'INPUT'
    p1 = INPUT_WIRE_T
    p2 = "Tx%04X_%s" % (INPUT_TILE, op)
    path = input_to_op(p2)

    # FIXME this exact code is repeated elsewhere!!!  multiple places even maybe
    print "# 2. Add the connection ('path') to src node's src->dst route list 3088"

    assert sname == 'INPUT'
    getnode(sname).route[dname] = path
    if DBG: print "#   Added connection '%s' to route from '%s' to '%s'" % \
       (path, sname, dname)
    # getnode(sname).routed[dname] = True
    if DBG: print "#   Now node['%s'].route['%s'] = %s" % \
       (sname,dname,getnode(sname).route[dname])
    pwhere(2281)
    print ""

    # getnode('INPUT').show()

    if DBG: print "# Route '%s -> %s' is now complete for INPUT" % (sname,dname)

    # Hm! Hm! There's a special case to consider.
    # if dest_name appears twice in self.dests, that
    # means we have to duplicate the route for both op1 and op2.
    check_for_double_destination(sname,dname,DBG)

    return

    # Long form:
    # TODO global INPUTWIRE = 'T0_in_s2t0', INPUTTILE=0
    # print "# Placing pe in INPUT tile..."
    # place(dname, itile, 'pe_out')
    # 
    # print "# Routing INPUT to pe..."
    # add_route(sname, dname, itile, 'T0_in_s2t0', 'choose_op')
    # 
    # print '# Mark route COMPLETED'
    # finish_route(sname, dname)       
    # 
    # # Check that pe_out got removed from INPUT (tile0) resources
    # assert not ('pe_out' in resources[INPUT_TILENO])


def input_to_op(op, DBG=0):
    '''E.g. op=Tx0101_op1 (old) or op=Tx0101_data0 (new)'''
    global INPUT_WIRE_T
    if DBG: print("3581 Connecting '%s' to '%s'" % (INPUT_WIRE_T, op))

    path = getnode('INPUT').connect(INPUT_WIRE_T,op,DBG=DBG)
    if not path:
        print 'oops no route from input_wire to op'
        print 'shoulda sorted your input nodes so ALU gets placed FIRST, right?'
        pstack()
        assert False

#     # FIXME this is same as above, what?
#     if path == False:
#         print "oops hey what. path is false!!?"
#         print 'shoulda sorted your input nodes so ALU gets placed FIRST, right?'
#         pstack()
#         assert False

    return path


def check_for_double_destination(sname,dname,DBG=0):
    # if dest_name appears twice in self.dests, that
    # means we have to duplicate the route for both op1 and op2.
    snode = getnode(sname)
    if snode.dests.count(dname) < 2: return

    if DBG:
        print "#   OH!  Maybe not?"
        print "#   I see '%s' in the 'dests' list TWICE" % dname
        print "#   That means we have a path to op1 (right?)",
        print "and now we have to build a path to op2"
        # if DBG>1: print snode.dests

    # Find the unused op (should be op2) (for now) and mark it in the destination
    op = getnode(dname).addop(sname)
    assert op == 'op2', "Well I guess it's time to fix this"
    dst_port = "Tx%04X_%s" % (getnode(dname).tileno, op)
    #    Connecting 'INPUT' to 'add_inst0'/'op2'
    if DBG: print "#   Connecting '%s' to '%s'/'%s'" \
              % (sname,dname,op)

    # Must add this: 'T21_in_s2t0 -> T21_op2' to snode.route[dname]
    #   Before: [ ... 'T21_in_s2t0 -> T21_op1']
    #   After:  [ ... 'T21_in_s2t0 -> T21_op1', 'T21_in_s2t0 -> T21_op2']
    route = snode.route[dname]
    path_to_op1 = route[-1]
    parse = re.search('^(.*)op1$', path_to_op1)
    if not parse: assert False, "Should have been a path to op1 I think"
    if DBG: print "#     1. Found path to op1 '%s'" % path_to_op1

    path_to_op2 = parse.group(1) + "op2"
    if DBG: print "#     2. Built path to op2 '%s'" % path_to_op2
    route.append(path_to_op2)
    if DBG>1: print "now route is", route

    # Gotta do this as well
    (i,o) = CT.parse_connection(path_to_op2)
    # E.g. path_to_op2 = 'T21_in_s2t0 -> T21_op2', o = "T21_op2"
    snode.net.append(o)
    if DBG>1: print "now net is", snode.net

    # Now here's the tricky part (NOW the tricky part?)
    # Remove one of the two dests so route doesn't get printed twice at the end.
    snode.dests.remove(dname)
    if DBG>1: print "now dests is ", snode.dests


def place_folded_reg_in_input_tile(dname):
    # assert False, 'Note this routine has never been tried in combat and will probably fail...'

    DBG=1
    sname = 'INPUT'

    # Set INPUT's reg_op field
    assert getnode(sname).reg_op == False
    getnode(sname).reg_op = dname

    if DBG:
        print "# Put reg-pe folded pair '%s' in INPUT tile " % dname
        print "Connecting '%s' to '%s'" % (sname,dname)
        getnode(sname).show()
        getnode(dname).show()
        pname = getnode(dname).output
        getnode(pname).show()
        # print "TODO put reg-pe folded pair in INPUT tile :("
        # assert False, "TODO put reg-pe folded pair in INPUT tile :("

    assert getnode('INPUT').tileno == INPUT_TILE

    dnode = getnode(dname) # The register, e.g. 'reg_op_1'
    dtileno = INPUT_TILENO


    # FIXME this is terrible; translates e.g. data.in.0 into op1
    # BOOKMARK PROBLEM IS HERE e.g. when input0 == 'in.0' get T21_in.0 and thatsa no good
    input0 = dnode.input0
    if   input0 == 'in.0': input0 = 'op1'
    elif input0 == 'in.1': input0 = 'op2'
    elif input0 == 'in.2': input0 = 'op3'
    # etc.


    d_in = 'Tx%04X_%s' % (dtileno,input0) # E.g. 'T0_op1'
    d_out = place_regop_op(dname, dtileno, d_in, DBG=9)
    getnode(dname).place(dtileno, d_in, d_out, DBG)

    # FIXME A lot of this is duplicated from place() :(
    print "# 2. Add the connection to src node's src->dst route list 3200"

    # Connect INPUT_WIRE_T to d_in
    # path = '%s -> %s' % (INPUT_WIRE_T, d_in)
    # haha no they don't always connect e.g. if INPUT_WIRE_T = Tx0101_in_s3t0
    #   and d_in = "Tx0101_op1" b/c op1, then can only connect to side 2
    path = input_to_op(d_in)

    getnode(sname).route[dname] = path
    if DBG: print "#   Added connection '%s' to route from '%s' to '%s'" % \
       (path, sname, dname)
    # getnode(sname).routed[dname] = True
    if DBG: print "#   Now node['%s'].route['%s'] = %s" % \
       (sname,dname,getnode(sname).route[dname])
    pwhere(1186)
    print ""

    # Note input goes to reg-mul_307 AND mul_312 !

    print "# 3. add all the path ports to the src net (2971)"
    snode = getnode(sname)
    print "BEFORE: '%s' net is %s" % (sname, snode.net)
    for p in CT.allports(path):
        if p not in snode.net: snode.net.append(p)
    print "AFTER: '%s' net is %s" % (sname, snode.net)
    print ''

    print "# 4. Remove path resources from the free list"
    unfree_resources(path,DBG=0)
    #         assert False, 'hey hows that'
    #         print resources[1]

    print ''
    print "HOORAY connected '%s' to '%s' 2975" % (sname,dname)
    if DBG:
        print ''
        getnode(sname).show()
        print ''
        getnode(dname).show()
        print ''

    if DBG: print "# Route '%s -> %s' is now complete" % (sname,dname)

    if dname == 'reg_0_1':
        print 'GOT TWO ROUTES!  WOO AND HOO!'
        # assert False,\
        #        '\n\n\nGOT TWO ROUTES!  WOO AND HOO!  What now.\n\n\n'

    return

def place_regop_op(dname, dtileno, d_in, DBG):
    DBG=9

    # d_in is last port in path leading up to dtileno;
    # Should be something like 'T25_op1'
    if DBG>2: print 7771, dname, d_in
    
    print "# 1b. If regop, place (but don't route) assoc. pe"
    d_out = getnode(dname).output
    if DBG>2: getnode(dname).show(); print ''
    
    pname = getnode(dname).output
    if DBG>2: getnode(pname).show(); print ''
    
    getnode(pname).place(dtileno, d_in, addT(dtileno,'pe_out'), DBG)
    getnode(pname).place(dtileno, d_in+'(r)', addT(dtileno,'pe_out'), DBG)
    if DBG>2: getnode(pname).show(); print ''

    add_register(dtileno, d_in)

    # dnode.route[pname] is going to be e.g. ['op1']
    # we'll need to change that to e.g. 'T10_op1' i.e. 'd_in'
    dnode = getnode(dname)
    if DBG>2: dnode.show()
    if DBG>2: print dnode.route[pname]

    # New stuff
    assert \
           (dnode.route[pname] == ['in.0']) or \
           (dnode.route[pname] == ['in.1'])

    print "# 1b. Set route to op"
    dnode.route[pname] = [d_in]
    if DBG>2: dnode.show()
    return d_out


def get_nearest_tile(sname, dname, DBG=0):
    DBG=1

    # Figure how to do the first placement INPUT -> mem_1 maybe
    # Use new connection thingies maybe

    if DBG:
        print ''
        print "# order before get_nearest():"
        packer.FMT.order()
        print ''

    pptile = preplaced(dname, DBG)
    if pptile != -1:
        print("ho HO '%s' has a pre-designated home %d" % (dname, pptile))
        packer.alloc_tile(pptile, DBG)
        if DBG:
            print "# order after get_nearest():"
            packer.FMT.order()
            print ''
        return pptile


    dtype = getnode(dname).tiletype()
    stileno = getnode(sname).tileno

    # If dname is a reg node, maybe it can go in the same tile with sname?
    # regsolo => not part of a regpe or regreg pair
    # if is_regsolo(dname) and not is_regop(sname) OOPS regop != reg :(
    if is_regsolo(dname) and not is_reg(sname):
        print "okay we will try to put it in the same tile with", sname

        if stileno in packer.EXCEPTIONS:
            print "oop no already tried and failed at that"
        else:
            # CAREFUL! get_nearest_tile() may try to put sname and dname in same tile!
            # If it fails it may erroneaousl deallocate sname!
            global ORIG_ORDER
            ORIG_ORDER = (stileno, packer.order[stileno])
            if DBG>2: print("666f Try to put sname and dname in same tile")
            return stileno

    ########################################################################
    save_exceptions = packer.EXCEPTIONS
    found_acceptable_tile = False
    while not found_acceptable_tile:
        # def is_last_wen_lut_candidate(tileno):

        # print 'foo looking for tile nearest to', stileno
        # print "# i'm in tile %s" % packer.FMT.tileT(sname)
        nearest = packer.find_nearest(stileno, dtype, DBG=0)
        assert getnode(dname).tiletype() == cgra_info.mem_or_pe(nearest)

        if is_last_wen_lut_candidate(nearest):
            # print "OOP thatsa no good 666"
            packer.unallocate(nearest, DBG=0)
            packer.EXCEPTIONS.append(nearest)
        else:
            found_acceptable_tile = True

    packer.EXCEPTIONS = save_exceptions
    ########################################################################


    # print 'found nearest tile', nearest
    assert nearest != -1

    # stile = getnode(sname).tileno
    # dtile = getnode(dname).tileno

    # print 'dname is type %s and...' % dtype,
    # print '"nearest" is type %s' % cgra_info.mem_or_pe(nearest)
    assert getnode(dname).tiletype() == cgra_info.mem_or_pe(nearest)

    if DBG:
        print "# order after get_nearest():"
        packer.FMT.order()
        print ''

    return nearest


########################################################################
########################################################################
########################################################################
# scrub scrub scrub!  from here down

# FIXME this is bad.  very very...bad
global ENDPOINT_MUST_BE_FREE
ENDPOINT_MUST_BE_FREE = False

def find_best_path(sname,dname,dtileno,track,DBG=1):
    # next:
    # trying to route sname/stileno to dname/dtileno
    # foreach path in connect_{hv,vh}connect(ptile,dtile)
    #   foreach port in snode.input0,snode.net
    #     (begin,end) = (path[0],path[-1])
    #     if src.canconnect(sname.input0,begin) and src.canconnect(end,dname)
    #        paths.append (begin,path,end)
    # choose a path in paths

    # trying to route sname/stileno to dname/dtileno
    snode = getnode(sname)
    dnode = getnode(dname)
    stileno = snode.tileno
    pwhere(1289,\
        "Want to route from src tile %04X ('%s') to dest tile %04X ('%s') on track '%d'\n" \
        % (stileno, sname, dtileno, dname, track))

    # output='Tx0505_in_s2t1'
    assert snode.output[0:2] == 'Tx', "signal name '%s' looks wrong..." % snode.output
    if DBG>2: print snode.output
    parse = re.search(r's[0-9]t([0-9])b?$', snode.output)
    if parse:
        print("...looking to connect '%s' on track %d" % (snode.output, track))
        out_track = int(parse.group(1))
        assert track == out_track

    getnode(sname).show()

    # Want tileno associated with output;
    # note for e.g. regsolo, input and output ports are in different tiles;
    # want tileno associated with output...right?  Right!
    stileno = int(re.search('^Tx([^_]+)', snode.output).group(1), 16)

    if dtileno == stileno:
        # This can happen when e.g. we're trying to connect an ALU
        # to a register, both in the same tile
        # assert dest==reg if you wanta...

        print 'src and dst in same tile; thats okay'
        print 'BUT must make sure we choose a free port'
        # FIXME this is bad
        global ENDPOINT_MUST_BE_FREE
        ENDPOINT_MUST_BE_FREE = True
        p = connect_endpoint(snode.output, dname, dtileno, track, DBG=DBG)
        ENDPOINT_MUST_BE_FREE = False
        return p




    print (stileno, dtileno)
    if (stileno==18) and (dtileno==31):
        print("666a RECURSE NOW?")


    # foreach path p in connect_{hv,vh}connect(ptile,dtile)
    # FIXME for now only looking at track 0(!)
    phv = CT.connect_tiles(stileno,dtileno,track,dir='hv',DBG=DBG-1)
    if DBG>2: print '  Found path phv', phv

    pvh = CT.connect_tiles(stileno,dtileno,track,dir='vh',DBG=DBG-1)
    if DBG>2: print '  Found path pvh', pvh

    # FIXME need a better way to determine if path is straight-line
    if pvh==phv:
        if DBG>2: print "  NOTE path is a straight line"

    which = 'pvh'
    for path in [pvh,phv]:
        if DBG: pwhere(1325,
                       "Evaluating %s path %s" % (which,path)); which = 'phv'
        if DBG>1:
            print "\nIs '%s' a bitnode?" % dname
            if     is_bit_node(dname): print("yes; yes it is\n\n")
            if not is_bit_node(dname): print("no it is not\n\n")

        # FIXME this is sooo bad; should never have built the wrong path in the first place
        # If BUS1 path, Change default (BUS16) wires to 'b' (BUS1) wires
        if is_bit_node(dname): fix_path(path, dname, DBG)

# ../../serpent.py/1289: Want to route from src tile 21
# ('lb_padded_2_stencil_update_stream$lb1d_0$reg_1') to dest tile 31
# ('mul_684_685_686$binop.data.in.0') on track '0'


        if (sname == 'lb_padded_2_stencil_update_stream$lb1d_0$reg_1') \
           and (dname == 'mul_684_685_686$binop.data.in.0'):
           print("666a about to recurse?")



        final_path = eval_path(path, snode, dname, dtileno, DBG)
        if final_path:
            # FIXME For now, use first path found
            # FIXME for future, keep findin paths and return them all
            return final_path

        if pvh==phv:
            # duh.  straight-line path
            # don't do it twicet
            break 

        # choose a path in paths

    # assert False, 'no path---thats bad right?'
    # No this is fine; later the callee will check to see if path exists or not
    return False


# FIXME WHY ISN'T ALL THIS CONNECT STUFF IN THE
# CONNECT_TILES LIBRARY WHERE IT BELONGS!!?
def fix_path(path, dname, DBG=0):
    assert is_bit_node(dname)

    if DBG:
        print('Dest "%s" is a single-bit node, yes?' % dname)
        print('Should use BUS1 path, right?\n')

    # dnode.buswidth = 1

    # Is this a hack?  This looks like a hack. FIXME
    # Change default (BUS16) wires to 'b' (BUS1) wires
    # before: ['T21_out_s1t0',  'T40_in_s3t0 -> T40_out_s0t0',   'T41_in_s2t0']
    # after:  ['T21_out_s1t0b', 'T40_in_s3t0b -> T40_out_s0t0b', 'T41_in_s2t0b']
    if DBG: print('before: ' + str(path))
    if DBG: print("---")

    for i in range(len(path)):
        path[i] = re.sub('(s.t.)','\\1b', path[i])

    if DBG: print('after: ' + str(path))


def rejoin_path(path_nodes):
    # Given path nodes e.g.
    # ['T154_out_s3t2', 'T139_in_s1t2', 'T139_out_s0t2', 'T140_in_s2t2']
    # Return "joined" path
    # ['T154_out_s3t2 -> T139_in_s1t2', 'T139_out_s0t2 -> T140_in_s2t2']

    assert (len(path_nodes)%2) == 0, 'malformed path'

    joined_path = []
    while len(path_nodes) >= 2:
        joined_path.append("%s -> %s" % (path_nodes[0], path_nodes[1]))
        path_nodes = path_nodes[2:]
                        
    assert len(path_nodes) == 0, 'malformed path'

    return joined_path

# TEST
# p = ['a']
# p = ['a', 'z']
# p = ['a', 'b', 'y', 'z']
# p = ['a', 'b', 'c', 'd', 'e', 'z']
# p = ['a', 'b', 'c', 'd', 'e', 'f', 'z']
# print p; print rejoin_path(p); print p; print ""


def unify_path(snode, path):
    # Check candidate path "path" (from snode to some dest dnode)
    # against existing snode->dest routes in snode;
    # if cand path shares a node with an existing route,
    # make sure both paths are the same up to and including that node

    # Eg if path = ['T154_out_s3t2 -> T139_in_s1t2', 'T139_out_s0t2 -> T140_in_s2t2']
    # then ports = ['T154_out_s3t2', 'T139_in_s1t2', 'T139_out_s0t2', 'T140_in_s2t2']
    ports = CT.allports(path)

    # Want to find the LAST port in cand path that matches in dports, not the first
    revports = list(ports); revports.reverse()

    for d in snode.dests:
        dports = CT.allports(snode.route[d])

        for p in revports:
            # print 68, p; print "FOO looking for '%s' in route '%s'" % (p, d)
            # print snode.route[d]

            if p in dports:
                # Found overlap with pre-existing route!
                # Build prefix based on pre-existing route in snode
                prefix = []
                for i in range(len(dports)):
                    # print i, range(len(dports))
                    prefix.append(dports[i])
                    if dports[i] == p: break

                # Build suffix based on divergent end-portion of cand path
                suffix = []
                for i in range(len(ports)):
                    if ports[i] == p:
                        suffix = ports[i+1:]
                        break

                # Turn ['a','b'] port list into ['a -> b'] path
                newports = (prefix + suffix)
                newpath  = rejoin_path(newports)

                if newpath == path:
                    if False: print 6666, "SAME"
                else:
                    print("")
                    pwhere(3830, "ALERT!  REWROTE OVERLAPPING PATH!  NOTSAME")
                    print("  existing path:", snode.route[d])
                    print("  my orig path: ", path)
                    print("  rewritten as: ", newpath)
                    print("")
                return newpath

    # Return orig path unchanged
    return path




#                 if False:
#                     print 6666, ""
#                     print 6666, ""
#                     print 6666, "FOUND COMMON NODE"
#                     print 6666, "existing path:  ", snode.route[d]
#                     print 6666, "existing ports: ", dports
#                     print 6666, "candidate path: ", path
#                     print 6666, "candidate ports:", ports
#                     print 6666, "common node '%s'" % p
#                     print 6666, ""
#                     print 6666, "REWRITING CANDIDATE PATH"

#                     print 6666, "NEW PATH"
#                     print 6666, 'prefix', prefix
#                     print 6666, 'suffix', suffix
#                     print 6666, "orig path: ", path
#                     print 6666, "new  path: ", newpath
#                     print 6666, "NOTSAME"
#                     print 6666, ""
#                     print 6666, ""

                # return newpath


#                 print 6666, "NEW PATH"
#                 # print 6666, begin
#                 print 6666, 'prefix', prefix
#                 print 6666, 'suffix', suffix
#                 # print 6666, end
#                 print 6666, "orig path: ", path
#                 print 6666, "new  path: ", newpath
#                 if newpath == path: print 6666, "SAME"
#                 else: print 6666, "NOTSAME"
#                 print 6666, ""
#                 print 6666, ""
# 

# TEST
# p = ['a', 'z']
# p = ['a', 'b', 'y', 'z']
# p = ['a', 'b', 'c', 'd', 'e', 'z']
# p = ['a', 'b', 'c', 'd', 'e', 'f', 'z']
# print p[0], p[-1], p[1:-2]
# exit()


def shortmem_sanity_check(path):
    # if this is a shortmem design, there had better not be
    # any e.g. side-6 connections :(
    DBG=9
    global MEMHEIGHT
    if MEMHEIGHT == 1:
        joined_path = ' '.join(path)
        if DBG>2: print "Checking for bad sides in path '%s'" % joined_path
        for badside in ['s4t','s5t','s6t','s7t']:
            if DBG>2: print "Checking for side '%s'" % badside
            if not (joined_path.find(badside) == -1):
                pwhere()
                errmsg = "\n" + \
                         "WARNING Found bad side '%s' in path" % badside \
                         + "\n" + \
                         "WARNING %s" % joined_path \
                         + "\n" + \
                         "WARNING Shortmem CGRA should not use side > 3" \
                         + "\n"
                print(errmsg)
                # sys.stderr.write(errmsg + '\n')
                assert False, errmsg


def eval_path(path, snode, dname, dtileno, DBG=0):
    # Given 'path' from src node 'snode' in stileno
    # to dst node 'dname' in possible dest tile 'dtileno',
    # see if path is valid
    stileno = snode.tileno
    sname   = snode.name

    # part 1 verify the tile-to-tile path
    # Check every port on the path for availability to snode
    if not ports_available(snode, path, DBG): return False
    if DBG:
        print "YES path from Tx%04X to Tx%04X is available\n" % (stileno,dtileno)

    # part 2 verify begin and end points
    final_path = can_connect_ends(path, snode, dname, dtileno, DBG)
    if not final_path:
        pwhere(2133, "  Cannot connect dst '%s' to endpoint '%s'?" % (dname, path[0]))
        # assert False, 'disaster could not find a path (and/or could try again with a different tile?'
        # Dude no need to die, it'll try again...right?
        return False

    final_path = unify_path(snode, final_path)
    return final_path


def buswidth(connection):
    if connection[-1] == 'b': return 1
    else:                     return 16

def can_connect_ends(path, snode, dname, dtileno, DBG=0):
    # DBG=9
    stileno = snode.tileno
    sname   = snode.name

    if DBG: print "Can we attach nodes to path endpoints '%s' and '%s'?"\
       % (path[0],path[-1])

    if DBG:
        print "1. Attach source node '%s' to path beginpoint '%s'"\
              % (sname, path[0])



    if snode.output not in snode.net:
        print snode.net
    assert snode.output in snode.net,\
           "'%s' output '%s' is not in '%s' net!!?" % (sname, snode.output, sname)



    cbegin = connect_beginpoint(snode, path[0], buswidth(path[0]), DBG)
    if not cbegin:
        err = "  Cannot connect beginpoint '%s' to path-begin '%s'?" % (snode.name, path[0])
        #         assert False, err
        #         assert False, 'disaster could not find a path'
        # 
        # died on line 23296: endpoints 'T218_out_s2t1' and 'T233_in_s3t1'
        # Dude no need to die, it'll try again...right?
        # print '666a'
        # pwhere(3292, err)
        # print("# Dude no need to die, it'll try again...right?")
        return False

    #######################################
    if DBG: print "2. Attach path endpoint '%s' to dest node '%s' (%s)"\
       % (path[-1], dname, where(1413))
    
    if (dname == 'OUTPUT') and re.search('in_s6', path[-1]):
        # Looks like we have the lower left half (side 6) of a mem
        # tile as our OUTPUT endpoint. We gotta do extra stuff to get
        # it to come out the upper right side where it belongs.
        output_endpoint_hack(dname, path, DBG)
        if DBG: print "2 (redo). Attach path endpoint '%s' to dest node '%s' (%s)"\
           % (path[-1], dname, where(2203))

    # BOOKMARK/FIXME should be dnode, right? below?
    # cend = connect_endpoint(snode, path[-1], dname, dtileno, DBG)

    dnode = nodetile(dtileno)
    anytrack = -1 # Any track
    cend = connect_endpoint(path[-1], dname, dtileno, anytrack, DBG)

    if not cend:
        pwhere(2169, "  Cannot connect src '%s' to endpoint '%s'?" % (sname, path[0]))
        # assert False, 'disaster could not find a path'
        # Dude no need to die, it'll try again...right?
        return False

    # print 'ready to connect endpoint! %s' % cend

    # For now, return first path found
    # FIXME for future, keep finding paths and return them all
    final_path = cbegin + path[1:-1] + cend
    print "SUCCESS! Final path from '%s' to '%s' is: %s\n" \
          % (sname,dname,final_path)

    # middle part was verified previously.
    # looks like we're good to go!

    # For now, return first valid path.
    # FIXME/TODO later will want to construct all paths
    # (or at least hv vs.vh) and compare thetwo
    return final_path
            
def output_endpoint_hack(dname, path, DBG=0):
    assert (dname == 'OUTPUT') and re.search('in_s6', path[-1])
    DBG=9
    if DBG: print '''
          Well.  For one reason or another, we have arrived
          at the lower left half (side 6) of a mem tile as
          our OUTPUT endpoint. We gotta do extra stuff to get
          it to come out the upper right side where it belongs.
          '''
    # Before: [ ...'T51_in_s2t0 -> T51_out_s0t0', 'T36_in_s6t0']
    # After:  [ ...'T51_in_s2t0 -> T51_out_s0t0', 'T36_in_s6t0 -> T36_out_s7t0', 'T36_in_s3t0']

    if DBG: pwhere(2207, "Before: path=[...'%s'" % path[-1])

    new_in  = 'Tx%04X_in_s6t0' % OUTPUT16_FEEDER_TILENO
    new_out = 'Tx%04X_out_s7t0' % OUTPUT16_FEEDER_TILENO
    assert path[-1] == new_in # why not
    path[-1] = '%s -> %s' % (new_in, new_out)

    new_endpoint = 'Tx%04X_in_s1t0' % OUTPUT16_FEEDER_TILENO
    path.append(new_endpoint)

    if DBG: pwhere(2219, "After:  path=[...'%s', '%s'\n" % (path[-2], path[-1]))


def ports_available(snode, path, DBG=0):
    # DBG=9
    stileno = snode.tileno
    sname   = snode.name
    if DBG>2: print "# is entire path available to src net?"
    path_ports = CT.allports(path)
    if DBG>2: print "#   entire path: ", path_ports

    for p in path_ports:
        if DBG>2: print("checking path port '%s'" % p)
        if not snode.is_avail(p,DBG):
            if DBG: print "NO path not available"
            return False

    return True


def connect_beginpoint(snode, beginpoint, buswidth, DBG=0):
    stileno = snode.tileno
    sname   = snode.name

    # canon_src = 'Tx%04X_%s' % (stileno, snode.input0)
    # plist = [canon_src] + snode.net

    plist = sorted(snode.net)
    # print plist
    # FIXME should only look at ports in same tile as beginpoint...RIGHT?
    # FIXME verify no redundancies in plist
    if DBG:
        print "   Ports avail to source node '%s': %s" % (sname,plist)
        print "   Take each one in turn"

    for p in plist:
        print "     Can '%s' connect to beginpoint '%s'?" % (p, beginpoint)

        cbegin = can_connect_begin(snode, snode.output, beginpoint, DBG)
        if cbegin: return cbegin
        else:
            print "  Cannot connect '%s' to beginpoint '%s'?" % (p, beginpoint)
            print "  Try next port in the list (2793)?"

    return False

def is_commutative(nodename):
    '''E.g. if nodename is "add_305_313_314_PE.in1" then return True'''
    if   nodename.find('add') == 0: return True
    elif nodename.find('mul') == 0: return True
    # FIXME could also include AND, OR, ...

    else:
        return False

def find_outport(tileno, nodename, DBG=0):
    '''
    Given tile number e.g. 22 and nodename e.g. "sub_305_313_314_PE.in1"
    or "bitmux_157_157_149_lut_bitPE.in0/in1/in2"
    return appropriate port e.g. T22_op2 or T22_bit1
    If nodename has no appropriate port, assume node is not a pe and return false
    '''
    # .*bitPE.in[012] maps to bit[012];
    # .*PE.in[01] map to op[12] (yes ug)
    # DBG=9
    # HAHA note this func is only called when we have a non-commutative pe op i.e.
    # onebit_bool is the ONLY one that gets here so far...!??
    if DBG>1: print "fooz want to find outport list for '%s'" % nodename

    ########################################################################
    # NEW

    # Sample NEW nodenames (6/2018)
    # add_754_755_756$binop.in1
    # sub_770_773_774$binop.in1
    # ashr_760_763_764$binop.in1
    #
    # bitand_791_792_793$lut$lut.in1
    # slt_790_775_791$not$lut$lut.in1
    # 
    # mux_793_794_795$mux.in1
    # sle100_775_792$compop.in1
    # smax_776_777_778$cgramax.in1

    # harris: ashr_760_763_764$binop.data.in.0
    # binop NEVER USED!!?  FIXME
    # if parse: (optype, portnum) = ('binop', int(parse.group(1)))

    # MUX
    # harris: mux_793_794_795.mux.bit.in.0
    parse = re.search(r'mux.bit.in.(\d)', nodename)
    if parse:

        # FIXME should be a func (below); also used for luts (below);
        # should cojmbine and just have one clause for all nodes .*bit.in.[0-2]
        portnum = int(parse.group(1))
        only_dest = 'Tx%04X_bit%d' % (tileno, portnum)

        # Little checkyweck to see if port is avail or did somebody already take it!
        bitnum = portnum
        if   (bitnum==0): assert getnode(nodename).bit0 == False
        elif (bitnum==1): assert getnode(nodename).bit1 == False
        elif (bitnum==2): assert getnode(nodename).bit2 == False
        return only_dest

    # harris: ashr_760_763_764$binop.data.in.0
    # harris: smax_788_789_790$cgramax.data.in.1
    # harris: slt_790_775_791$comp$compop.data.in.0
    #
    # parse = re.search(r'(binop|cgramax|compop)\.data\.in\.(\d)', nodename)
    # if parse: portnum = int(parse.group(2))
    #
    # SEE: def pe_porntum
    portnum = pe_portnum(nodename)
    if portnum >= 0:
        DBG=9
        if DBG>1: print("found binop/cgramax")
        if DBG>1: getnode(nodename).show()

        # Little checkyweck to see if port is avail or did somebody already take it!
        if   (portnum==0): assert getnode(nodename).input0 == False
        elif (portnum==1): assert getnode(nodename).input1 == False

        opnum = portnum + 1
        only_dest = 'Tx%04X_op%s' % (tileno, opnum)
        return only_dest

# Pretty sure this is covered by "other bit ops" below
#     # LUTS
#     # harris: slt_790_775_791$not$lut$lut.bit.in.0
#     parse = re.search(r'lut\.bit\.in\.(\d)', nodename)
#     if parse:
#         # (optype, portnum) = ('lut', int(parse.group(1)))
#         portnum = int(parse.group(1))
#         only_dest = 'Tx%04X_bit%d' % (tileno, portnum)
# 
#         # Little checkyweck to see if port is avail or did somebody already take it!
#         bitnum = portnum
#         if   (bitnum==0): assert getnode(nodename).bit0 == False
#         elif (bitnum==1): assert getnode(nodename).bit1 == False
#         elif (bitnum==2): assert getnode(nodename).bit2 == False
# 
#         return only_dest

    # LUTS and OTHER BIT OPS
    # OLD: parse = re.search(r'bitPE.in(\d)', nodename)
    # NEW: 'bitor_154_155_156_lut_bitPE.bit.in.0'
    # also harris: slt_790_775_791$not$lut$lut.bit.in.0
    parse = re.search(r'\.bit\.in\.(\d)', nodename)
    if parse:
        only_dest = 'Tx%04X_bit%s' % (tileno, parse.group(1))

        # Little checkyweck to see if port is avail or did somebody already take it!
        bitnum = int(parse.group(1))
        if   (bitnum==0): assert getnode(nodename).bit0 == False
        elif (bitnum==1): assert getnode(nodename).bit1 == False
        elif (bitnum==2): assert getnode(nodename).bit2 == False

        return only_dest

    # NEW support for harris
    parse = re.search('ashr', nodename)
    if parse:
        assert False, 'the rubber has hit the road'


    ########################################################################
    # OLD

    parse = re.search(r'mux.in(\d)', nodename)
    if parse:
        # Little checkyweck to see if port is avail or did somebody already take it!
        portnum = int(parse.group(1))
        if   (portnum==0): assert getnode(nodename).input0 == False
        elif (portnum==1): assert getnode(nodename).input1 == False

        opnum = portnum + 1
        only_dest = 'Tx%04X_op%s' % (tileno, opnum)
        return only_dest

    # OLD: parse = re.search(r'lut.in(\d)', nodename)
    # NEW: slt_790_775_791$not$lut$lut.bit.in.0
    parse = re.search(r'lut.in(\d)', nodename)
    if parse:
        (optype, portnum) = ('lut', int(parse.group(1)))
        only_dest = 'Tx%04X_bit%d' % (tileno, portnum)

        # Little checkyweck to see if port is avail or did somebody already take it!
        bitnum = portnum
        if   (bitnum==0): assert getnode(nodename).bit0 == False
        elif (bitnum==1): assert getnode(nodename).bit1 == False
        elif (bitnum==2): assert getnode(nodename).bit2 == False

        return only_dest

    # OLD: parse = re.search(r'bitPE.in(\d)', nodename)
    # NEW: 'bitor_154_155_156_lut_bitPE.bit.in.0'
    parse = re.search(r'bitPE\.bit\.in\.(\d)', nodename)
    if parse:
        only_dest = 'Tx%04X_bit%s' % (tileno, parse.group(1))

        # Little checkyweck to see if port is avail or did somebody already take it!
        bitnum = int(parse.group(1))
        if   (bitnum==0): assert getnode(nodename).bit0 == False
        elif (bitnum==1): assert getnode(nodename).bit1 == False
        elif (bitnum==2): assert getnode(nodename).bit2 == False

        return only_dest

    # OLD: ...PE.in1       => parse = re.search(r'PE.in(\d)', nodename)
    # NEW: ...PE.data.in.0 e.g. 'ult_152_147_153_uge_PE.data.in.0'
    parse = re.search(r'PE\.data\.in\.(\d)', nodename)
    if parse:
        if DBG>1: 'Found a pe'

        # Little checkyweck to see if port is avail or did somebody already take it!
        portnum = int(parse.group(1))
        if   (portnum==0): assert getnode(nodename).input0 == False
        elif (portnum==1): assert getnode(nodename).input1 == False

        opnum = portnum + 1
        only_dest = 'Tx%04X_op%s' % (tileno, opnum)
        return only_dest

    # Not a pe op i guess
    # assert False, 'hey wassamatta fa you "%s"' % nodename
    return False



def connect_endpoint(endpoint, dname, dtileno, track, DBG):

    # 'dstports' is what you need to connect to to get the indicated node, yes?
    # E.g. for pe it's op1 AND op2; for mem it's 'mem_in'
    # for regsolo it's every outport in the tile
    # for regpe it's op1 or op2
    dplist = dstports(dname, dtileno, track, DBG=1)

    if DBG:
        # In-ports avail to dest node 'add_305_313_314_PE.in1': ['T22_op1', 'T22_op2']
        print "   CE In-ports avail to dest node '%s': %s" % (dname,dplist)
        print "   Take each one in turn"

    # Hm. if nodename designates an in-port e.g. 'add_305_313_314_PE.in1'
    # must honor that request (note in1 connects to op2 huh)
    #
    # Unless it's commutative op (may regret this someday)

#     # NOPE this (below) does not help at all :(
#     # If endpoint is on side 0 or 3, choose op2 preferentially over op1 and vice versa
#     dplist = sort_dplist(endpoint,dplist)

    # FIXME this whole dplist only works for commutative operations.  Right?
    # Should not be doing this anyway, there are better ways maybe.
    # E.g. back off / retry after rewriting original serpent DAG input
    for dstport in dplist:

        print "     Can path endpoint '%s' connect to dest port '%s'?" \
              % (endpoint, dstport)

        global ENDPOINT_MUST_BE_FREE
        if ENDPOINT_MUST_BE_FREE and (dstport not in resources[dtileno]):
            print "     - OOP its being used by someone else, try another one\n"
            continue

# FIXME either delete this or make it like DBG>1 thing
#         if dstport == 'Tx0508_op1':
#             print("dname = %s" % dname)
#             getnode(dname).show()
#             print("dstports (dplist) = %s" % dplist)
# 
#             print("thinking we wanna connect to 'Tx0508_op1' right?")
#             assert False, "how things look now?"

        cend = can_connect_end(endpoint, dstport, DBG)

        if cend: return cend
        else:
            print "  Cannot connect path endpoint '%s' to dest port '%s'" \
                  % (endpoint, dstport)
            print "  Try next port in the list (2885)?"

    return False

# NOPE
# def sort_dplist(endpoint, dplist, DBG=9):
#     # E.g. endpoint='T2_in_20t0' and dplist = ['T2_op1', 'T2_op2']
#     # If endpoint is on side 0 or 2, choose op2 preferentially over op1 and vice versa
# 
#     (T,d,side,t) = cgra_info.parse_canon(endpoint)
#     if DBG:
#         print '666 Sorting dplist %s' % dplist
#         print '  I think endpoint is on side %d' % side
#         print '  That means we preferentially choose op%d' % (2-side%2)
# 
#     op1 = 'Tx%04X_op1' % T
#     op2 = 'Tx%04X_op2' % T
# 
#     newlist = []
#     if   (side%2==0) and (op2 in dplist): newlist = [op2]
#     elif (side%2==1) and (op1 in dplist): newlist = [op1]
#         
#     for dp in dplist:
#         if dp not in newlist: newlist.append(dp)
# 
#     if DBG:
#         print 'Sorted list is %s\n' % newlist
# 
#     return newlist


def can_connect_begin(snode,src,begin,DBG=0):

    if DBG>1: print "Can we connect '%s' to '%s' as part of '%s' net? (%s)"\
       % (src,begin,snode.name,where(2908))

    cbegin = snode.connect(src,begin,DBG=DBG)
    if not cbegin:
        if DBG>1: print 'oops no route from p1 to p2'
        # (will return False below, yes?)
    else:
        print '   Ready to connect beginpoint %s (%s)' % (cbegin, where(1509))
        print ''
    return cbegin


def can_connect_end(endpoint, dstport, DBG=0):

    #     if is_bit_node(dstport):
    #         print '''
    #         Found single-bit input; what now?
    # 
    #         '''
    #         # assert False

    dtileno = parseT(endpoint)[0]
    dnode = nodetile(dtileno)
    # DBG=9
    if DBG>1 and (dnode != False):
        # E.g. 'Can we connect 'T136_in_s1t1' to 'T136_op2' as part of
        # 'mul_649_649_650$binop' net? (../../serpent.py/2933)
        # 
        print "Can we connect '%s' to '%s' as part of '%s' net? (%s)"\
              % (endpoint,dstport,dnode.name,where(2933))

    if dnode != False:
        # e.g. dnode.connect('T136_in_s1t1', 'T136_op2')?
        cend = dnode.connect(endpoint, dstport, DBG=DBG)
    else:
        # e.g. serpent_connect_within_tile(node, 'T136_in_s1t1', 'T136_op2', 136)?
        cend = serpent_connect_within_tile(dnode, endpoint, dstport, dtileno, DBG=DBG)

    if not cend:
        if DBG>1: print 'oops no route from p1 to p2'
        # (will return False below, yes?)

    else:
        print '   Ready to connect endpoint %s (%s)' % (cend, where(1516))
        print ''

    return cend


# def randomly_place(dname, DBG=0):
#     '''
#     Assign dname to any random available resource
#     Well maybe not completely random.
#     Assign mem to mem tiles ONLY using resource 'mem_out'
#     '''
#     if is_mem(dname): dtype='mem'
#     else:             dtype='pe'
# 
#     ntiles = len(resources) # len(list) = length (number of items in) list
#     for tileno in range(ntiles):
# 
#         if is_mem_tile(tileno): ttype='mem'
#         else:                   ttype='pe'
#         if dtype != ttype: continue
# 
#         if is_regop(dname):
#             # regops come from register-folding optimization pass
#             # They look like this:
#             # 
#             # node='reg_2_2'
#             #   type='regop' ***
#             #   tileno= -1
#             #   input0='op1' ***
#             #   input1='False'
#             #   output='mul_45911_460_PE'
#             #   placed= False
#             #   dests=['mul_45911_460_PE']
#             #   route ['mul_45911_460_PE'] = ['op1']
#             #   net= []
#             # 
#             # Before placing regop, must first place target pe
#             pe = getnode(dname).dests[0]
#             if not is_placed(pe): randomly_place(pe)
# 
#             # regop goes in same tile as target pe as op1 or op2
#             tileno = getnode(pe).tileno
#             if   (re.search('op1$', getnode(dname).input0)): op = 'op1'
#             elif (re.search('op2$', getnode(dname).input0)): op = 'op2'
#             else: assert(0)
#                   
#             getnode(dname).place(tileno,'XXX',op)
#             return (tileno,op)
# 
#         elif  is_pe(dname): r='pe_out'
#         elif is_mem(dname): r='mem_out'
#         else:
#             # It's an unassigned register, yes?
#             # Although maybe could be double-register pair someday.
#             # Randomly choose the first outport you find
#             # (technically should be out-port but oh well
# 
#             regex = re.compile('^out')
#             outs = filter(regex.match, resources[tileno])
#             if outs == []: continue
#             else:          r = outs[0]
#         
#         if r not in resources[tileno]: continue
#         else:
#             if DBG:
#                 print "# Randomly assigning '%s' to tile %04X resource '%s'" \
#                       % (dname,tileno,r)
#             getnode(dname).place(tileno,'XXX',op)
#             return (tileno,r)

def is_placed(nodename):
    return getnode(nodename).is_placed()

def is_routed(sname, dname, indent="# ", DBG=0):
    # return getnode(sname).is_routed(dname)
    DBG=1
    if getnode(sname).is_routed(dname): return True
    else:
        # if DBG: print indent+"huh '%s' -> '%s' already been routed" % (sname,dname)
        if DBG: print indent+"huh already been done"
        return False


def test_connect():

    print '######################################################'
    print '# serpent.py: Read cgra info'
    cgra_info.read_cgra_info(verbose=True)


    print '######################################################'
    print '# serpent.py: Initialize node and tile data structures'
    init_tile_resources(DBG=0)
    build_nodes(DBG=0)
    initialize_routes()
    initialize_node_INPUT()

    print 'TEST: who can reach pe_out_res?'
    rlist = cgra_info.fan_out('pe_out_res', 0, DBG=1)
    print rlist


    print 'TEST: who can reach to_cgra(pe_out)?'
    rlist = cgra_info.fan_out(to_cgra('pe_out'), 0)
    print 'boo'
    print rlist


    print 'TEST: can connect pe_out to out_s1t1 in INPUT tile?'
    rval = getnode('INPUT').connect('pe_out', 'out_s1t1', T=0, DBG=9)
    print rval

    print 'TEST: can find double-connection from  in_s1t1 to op1 in tile 4?'
    print resources[0]
    rval = getnode('INPUT').connect('in_s1t1', 'op1', T=0, DBG=9)
    print rval

DO_TEST=0
if DO_TEST:
    test_manhattan_distance_rc()
    test_fan_out()

    print 'test the new stuff'
    test_connect()
    exit()


main()







# BOOKMARK
# NEXT: implement and test cgra_info.reachable (see below)

#         rlist = cgra_info.reachable(T,a)
#         if is_avail(b) and b in rlist: return a->b
#         else for r in rlist: if canconnect(r,b) return ['a->r','r->b']

# reachable(tileno,src)
# given tileno and src::src in {pe_out, mem_out, in_s1t1}
# return a list of everything that src can connect to in the tile

# #         else if b is out_s<S> and is_avail in_s<S> and in_s<S> in reachable:
# #             return ['a->in

#         # 'a' wires pe_out, mem_out (rdata) can connect to any outwire
#         if re.search('out$', a):
#             # If 'a' is an '_out' then b should be an outwire
#             assert re.search('^T[^_]+_out', b)
#             return '%s -> %s' % (a,b)
# 
#         # a should be inwire now
#         assert re.search('^T[^_]+_in', a)
# 
#         # 'a' inwire can connect to any wire not on same side
#         if re.search('^T[^_]+_out', b):
#             (Ta,da,sa,ta) = CT.parsewire(a)
#             (Tb,db,sb,tb) = CT.parsewire(b)
#             return not (sa == sb)
# 
#         # b is one of ['mem_in','op1','op2'] (mem_in == wdata maybe)
#         # who can connect to mem_in (wdata)? anything on side 2
# 
# 
# 
# 
#         (Ta,da,sa,ta) = CT.parsewire(a)
#         (Tb,db,sb,tb) = CT.parsewire(b)
#         assert Ta == Tb
# 

        
