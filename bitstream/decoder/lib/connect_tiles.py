#!/usr/bin/python

import sys;
import re;

# # from ../decoder/lib import cgra_info
# sys.path.append("../decoder")
# from lib import cgra_info

# Should be in same dir as this one, yes?
import cgra_info

# INDEX
# FIXME/TODO build a index

DO_TEST=0
def do_test():
    if not DO_TEST: return
    cgra_info.read_cgra_info()

    test_ctsr()
    test_ctsc()
    test_all()

def test_all():
    track = 0

    print "########################################"
    print "# Begin any-to-any testing"
    print ""

    results = range(100)
    nresults = len(results)

    testname = 'anypath'; resno = 0

    # anypath 0
    print "########################################"
    print "# End turn takes us down a mem column"
    p = connect_tiles(src=0,dst=17,track=0,dir='hv',DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    # assert False

    print "########################################"
    print "# Same thing except vh instead of hv"
    p = connect_tiles(src=0,dst=17,track=0,dir='vh',DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    # TODO/FIXME more vh tests maybe

    print "########################################"
    print "# End turn takes us further down a mem column"
    p = connect_tiles(src=0,dst=39,track=0,dir='hv',DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "########################################"
    print "# A long path straight down column zero"
    p = connect_tiles(src=0,dst=36,track=0,dir='hv',DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    # anypath 4
    p = connect_tiles_same_row(0, 1, track, DBG=1);
    verify(p, results,resno,testname); resno = resno+1

    # anypath 5
    p = connect_tiles_same_col(0, 8, track, DBG=1);
    verify(p, results,resno,testname); resno = resno+1

    p =          connect_tiles(0,10, track, DBG=1);
    verify(p, results,resno,testname); resno = resno+1

    # What happens if tile is straight across from bottom half of mem tile?
    p  =          connect_tiles(8,10, track, DBG=1);
    verify(p, results,resno,testname); resno = resno+1


def verify(path, result_list, rnum=0, test='ctsr'):
    (begin,path,end) = (path[0],path[1:-1],path[-1])

    # Set result_list to e.g. range(100) if not doing compares.
    DO_COMPARE = (result_list[0] != 0)

    print '# '
    print "# Check %s %d" % (test, rnum),
    print (begin,path,end)
    if DO_COMPARE:
        assert (begin,path,end) == result_list[rnum], 'path looks wrong'
        print "# Result checks out!\n"
    else:
        print "# (Use above result for verification.)\n"

def test_ctsr():
    track = 0

    print "########################################"
    print "# Begin ctsr testing"
    print ""

    results = [
        ('T0_out_s0t0', [], 'T1_in_s2t0'),
        ('T0_out_s0t0', ['T1_in_s2t0 -> T1_out_s0t0'], 'T2_in_s2t0'),
        ('T2_out_s2t0', ['T1_in_s0t0 -> T1_out_s2t0'], 'T0_in_s0t0'),
        ('T0_out_s0t0', ['T1_in_s2t0 -> T1_out_s0t0', 'T2_in_s2t0 -> T2_out_s0t0', 'T3_in_s2t0 -> T3_out_s0t0', 'T4_in_s2t0 -> T4_out_s0t0'], 'T5_in_s2t0'),
        ('T5_out_s2t0', ['T4_in_s0t0 -> T4_out_s2t0', 'T3_in_s0t0 -> T3_out_s2t0', 'T2_in_s0t0 -> T2_out_s2t0', 'T1_in_s0t0 -> T1_out_s2t0'], 'T0_in_s0t0'),
        ('T0_out_s0t0', ['T1_in_s2t0 -> T1_out_s0t0', 'T2_in_s2t0 -> T2_out_s0t0'], 'T3_in_s2t0'),
        ('T8_out_s0t0', ['T9_in_s2t0 -> T9_out_s0t0', 'T10_in_s2t0 -> T10_out_s0t0'], 'T3_in_s6t0'),
        ('T8_out_s0t0', ['T9_in_s2t0 -> T9_out_s0t0', 'T10_in_s2t0 -> T10_out_s0t0', 'T3_in_s6t0 -> T3_out_s4t0', 'T11_in_s2t0 -> T11_out_s0t0', 'T12_in_s2t0 -> T12_out_s0t0'], 'T13_in_s2t0')
        ]

    testname = 'ctsr'; resno = 0

    p = connect_tiles_same_row( 0, 1, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_row( 0, 2, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_row( 2, 0, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_row( 0, 5, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_row( 5, 0, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# Connect to top half of a memory tile"
    p = connect_tiles_same_row( 0, 3, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# Connect to bottom half of a memory tile"
    p = connect_tiles_same_row( 8, 3, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# This one crosses bottom half of a memory tile"
    p = connect_tiles_same_row( 8, 13, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1


def test_ctsc():
    track = 0

    print "########################################"
    print "# Begin ctsc testing"
    print ""

    results = range(100)
    nresults = len(results)

    testname = 'ctsc'; resno = 0
    p = connect_tiles_same_col(0, 8, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_col(0,14, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_col(14,0, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_col(0,36, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    p = connect_tiles_same_col(36,0, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# What happens if we try to make a path through mem column?"
    p = connect_tiles_same_col(3,45,track,DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# What happens if we try to make a path UP through mem column?"
    p = connect_tiles_same_col(45,3,track,DBG=1)
    verify(p, results,resno,testname); resno = resno+1

    print "# Connect adjacent NS mem tiles"
    p = connect_tiles_same_col(3, 17, track, DBG=1)
    verify(p, results,resno,testname); resno = resno+1

def connect_tiles(src=0,dst=17,track=0,dir='hv',DBG=0):
    '''tile17 should be row 2, col 3 maybe'''
    (rsrc,csrc) = cgra_info.tileno2rc(src)
    (rdst,cdst) = cgra_info.tileno2rc(dst)

    # if (src==18) and (dst==31): DBG=9

    if DBG:
        print "# Connect tile %d (r%d,c%d)" % (src,rsrc,csrc),
        print "to tile %d (r%d,c%d)" % (dst,rdst,cdst),
        print "on %s path" % dir
        if is_mem_rc(rdst,cdst):
            print "# Destination is a memory tile"

    # No need for a corner if sr, dst are in same row or col
    (cornerconn,path1,path2) = ([],[],[])


    # FIXME okay maybe this is kinda terrible.
    memstraight = False

    # Case 1: hpath ends at bottom of mem tile
    # If mem tile is 2 rows high, can match rsrc to either rdst or rdst+1
    # if rsrc == (rdst+1) and is_mem_rc(rdst,cdst):
    if rsrc == (rdst+1) and is_2hi_rc(rdst,cdst):
        if DBG: print "# connect_tiles.py: Straight enough! (For a memory tile anyway) 237"
        memstraight = True

    # Case 2: hpath *begins* at bottom of mem tile
    # Hm I wonder what would happen if...
    # elif is_mem_rc(rsrc, csrc) and ((rsrc+1) == rdst):
    elif is_2hi_rc(rsrc, csrc) and ((rsrc+1) == rdst):
        if DBG: print "# connect_tiles.py: Straight enough! (For a memory tile anyway) 243"
        print 'new stuff bar'
        memstraight = True

    if (rsrc==rdst) or memstraight:
        if DBG: print "# Both tiles are in same row\n# "
        p = connect_tiles_same_row(src,dst,track,DBG=DBG-1)
        (begin,path1,end) = unpack_path(p)
        if DBG: prettyprint_path(dir, begin, path1, cornerconn, path2, end)

        # Note this does not trigger until harris
        # if is_mem_rc(rsrc, csrc) and ((rsrc+1) == rdst): assert False, "well?  how'd we do?"

        return pack_path(begin,path1,end)

    elif csrc==cdst:
        if DBG: print "# Both tiles are in same column\n# "
        p = connect_tiles_same_col(src,dst,track,DBG=DBG-1)
        (begin,path2,end) = unpack_path(p)
        if DBG: prettyprint_path(dir, begin, path1, cornerconn, path2, end)
        return pack_path(begin,path2,end)

    elif dir=='hv':
        # First go horizontal (EW), then vertical (NS)
        # Find corner tile: same row as src, same col as dst
        (rcorn,ccorn) = (rsrc,cdst)

        if (src==18) and (dst==31):
            print("666c RECURSE NOW?")
            # assert False

        p = connect_through_corner(src,dst,rcorn,ccorn,track,dir,DBG)
        return p

    elif dir=='vh':
        # First go vertical (NS), then horizontal (EW)
        # Find corner tile: same row as dst, same col as src
        (rcorn,ccorn) = (rdst,csrc)
        p = connect_through_corner(src,dst,rcorn,ccorn,track,dir,DBG)
        return p

    assert False, 'unknown case in connect_tiles()'
    return [-1,-1,-1]

def unpack_path(p):
    (begin,path,end) = (p[0],p[1:-1],p[-1])
    return (begin,path,end)

def pack_path(begin,path,end):
    p = [begin]+path+[end]
    return p

def connect_through_corner(src,dst,rcorn,ccorn,track=0,dir='hv',DBG=0):
    # DBG=9
    # if (src==18) and (dst==31): print("666d RECURSE NOW?")
        # assert False

    if DBG>2:
        print (rcorn,ccorn)
        print 'src=', src
        print 'dst=', dst
    
    corn = cgra_info.rc2tileno(rcorn,ccorn)
    if DBG: print "# Found corner tile %d (r%d,c%d)"\
       % (corn, rcorn, ccorn)
    assert corn > 0

    # horizontal (or vert) path from src to corn
    p = connect_tiles(src,corn,track,DBG=0)
    if DBG>1: print "# path1:", p
    # path1: ['T121_out_s3t4', 'T89_in_s5t4']

    (begin1,path1,end1) = unpack_path(p)
    if DBG>1: print "# "

    # vert (or horiz) path from corn to dest
    # (begin2,path2,end2) = connect_tiles(corn,dst,track,DBG=DBG-1)
    p = connect_tiles(corn,dst,track,DBG=0)
    if DBG>1: print "# path2:", p
    # path2: ['T89_out_s1t4', 'T89_in_s7t4 -> T89_out_s6t4', 'T106_in_s0t4']

    (begin2,path2,end2) = unpack_path(p)
    if DBG>1: print "# "

    # In corner tile, connect end1 to begin2
    # eg cornerconn = ["%s -> %s"] % (end1,begin2)
    # or cornerconn = ["%s -> %s", "%s -> %s"] % (end1,mid1,mid2,begin2)]
    cornerconn = find_cornerconn(end1,begin2,DBG=DBG)

    final_path = path1 + cornerconn + path2
    if DBG: prettyprint_path(dir, begin1, path1, cornerconn, path2, end2)
    return pack_path(begin1, final_path, end2)


def find_cornerconn(end1,begin2,DBG=0):
    '''Connect end1 to begin2 in same tile'''

    # Trigger (end1,begin2) = ('T89_in_s5t4','T89_out_s1t4')
    # if end1 == "T89_in_s5t4": DBG=99

    (tileno1, dir1, side1, track1) = cgra_info.parse_canon(end1)
    assert (track1 >=0) and (side1 >= 0), \
           "WHOOPS '%s' does not look like a wire..." % end1

    (tileno2, dir2, side2, track2) = cgra_info.parse_canon(begin2)
    assert (track2 >=0) and (side2 >= 0), \
           "WHOOPS '%s' does not look like a wire..." % begin2

    (half1, half2) = (side1/4,side2/4) # Note '/' div only works for pos ints!!!?
    if half1 == half2:
        cornerconn = ["%s -> %s" % (end1,begin2)]

    else:
        # Cannot connect top and bottom halves directly e.g. in_s6 -> out_s3
        # corner: ['T69_in_s6t0 -> T69_out_s3t0'] must change to
        # corner: ['T69_in_s6t0 -> T69_out_s7t0', 'T69_in_s1t0 -> T69_out_s3t0']

        if DBG>1: print "# OOPS Cannot connect side %d to side %d w/o intermediary" % (side1,side2)

        # BUG connecting T89_in_s7t0 to T89_out_s3t0
        # yields conn1 'T89_in_s7t0 -> T89_out_s7t0'  *** BAD/IMPOSSIBLE

        if (side1==7):
            if DBG: print '# OOPS cannot connect mem tile in_s7 to out_s7!'
            return [False]

        if (side1==1):
            if DBG: print '# OOPS cannot connect mem tile in_s1 to out_s1!'
            return [False]

        if side1 < 4:
            if DBG>1: print "# Going from top to bottom half"
            mid1 = 'Tx%04X_out_s1t%d' % (tileno1, track1)
            mid2 = 'Tx%04X_in_s7t%d'  % (tileno1, track1)
        else:
            if DBG>1: print "# Going from bottom to top half"
            mid1 = 'Tx%04X_out_s7t%d' % (tileno1, track1)
            mid2 = 'Tx%04X_in_s1t%d'  % (tileno1, track1)
        conn1 = "%s -> %s" % (end1,mid1)
        conn2 = "%s -> %s" % (mid2,begin2)
        cornerconn = [conn1,conn2]

    if DBG>1: print "# corner:", cornerconn
    if DBG: print "# "

    # This will assert error if path buswidths are inconsistent
    check_bus_consistency(cornerconn)

    return cornerconn


def prettyprint_path(dir, begin, path1, cornerconn, path2, end):
    if dir == 'hv': (p1,p2) = ('hpath','vpath')
    else:           (p1,p2) = ('vpath','hpath')

    print "# Begin: %s" % [begin]
    if path1: print "# %s  %s" % (p1,path1)
    if cornerconn:  print "# corner %s" % cornerconn
    if path2: print "# %s  %s" % (p2,path2)
    if True:  print "# End:   %s" % [end]
    print "# "

    final_path = path1 + cornerconn + path2
    print "# Complete path: %s%s%s" % ([begin], final_path,[end])


def connect_tiles_same_row(src=0,dst=5,track=0,DBG=0):
    if DBG<0: DBG=0 # ugh

    (rsrc,csrc) = cgra_info.tileno2rc(src)
    (rdst,cdst) = cgra_info.tileno2rc(dst)

    # Case 1: hpath ends at bottom of mem tile
    # If mem tile is 2 rows high, can match rsrc to either rdst or rdst+1
    if rsrc == (rdst+1) and is_2hi_rc(rdst,cdst):
        # Source row matches bottom half of mem tile
        rdst = rdst+1

    # Case 2: hpath *begins* at bottom of mem tile
    start_on_bottom = False
    if (rsrc+1) == rdst and is_2hi_rc(rsrc,csrc):
        print 'new stuff foo'
        # Source row matches bottom half of mem tile
        # rsrc = rsrc+1
        start_on_bottom = True

    else:
        # tiles must be on same row; must be two different tiles
        # (unless start_on_bottom :o )
        assert rsrc == rdst, 'foo'
    assert src != dst, 'bar'


    if DBG: print "# Connect tile %d (r%d,c%d) to tile %d (r%d,c%d) on track %d 336" %\
       (src,rsrc,csrc, dst,rdst,cdst, track)

    
    if cdst>csrc: (inside,outside) = (2,0) # left-to-right
    else:         (inside,outside) = (0,2) # right-to-left

    path = []
    if start_on_bottom:
        # Case 2: hpath *begins* at bottom of mem tile
        # That's okay!
        beginwire = build_wire_rc(rsrc,csrc,'out',outside+4,track)
        rsrc = rsrc+1
    else:
        beginwire = build_wire_rc(rsrc,csrc,'out',outside,track)
    
    if (cdst>=csrc): cols = range(csrc+1,cdst, 1) # left-to-right
    else:            cols = range(csrc-1,cdst,-1) # right-to-left

    for c in cols:
        # Note build_wire will apply mem offset on NS sides
        # depending on top/bottom half vs. up/down dir of flow

        inwire  = build_wire_rc(rsrc,c,'in' ,inside, track)
        outwire = build_wire_rc(rsrc,c,'out',outside,track)
        connection = "%s -> %s" % (inwire, outwire)
        path.append(connection)

    endwire = build_wire_rc(rdst,cdst,'in',inside,track)

    if DBG: printpath(beginwire, path, endwire)
    return pack_path(beginwire, path, endwire)


def connect_tiles_same_col(src,dst,track,DBG=0):
    if DBG<0: DBG=0 # ugh

    (rsrc,csrc) = cgra_info.tileno2rc(src)
    (rdst,cdst) = cgra_info.tileno2rc(dst)

    # Special case for mem tile DOWN => start in bottom half
    # FIXME may want to rethink this later...
    if is_2hi_rc(rsrc,csrc) and (rdst>rsrc): # down
        # print "foo mem tile down"
        if (rsrc%2==0): rsrc = rsrc+1
        else          : rsrc = rsrc%2

    # Special case for mem tile UP => end in bottom half
    # FIXME may want to rethink this later...
    if is_2hi_rc(rsrc,csrc) and (rdst<rsrc): # up
        # print "foo mem tile up"
        if (rdst%2==0): rdst = rdst + 1 # Stop when get to *bottom* of dest tile
        else          : rdst = dst%2

    if DBG: print "# Connect tile %d (r%d,c%d) to tile %d (r%d,c%d) on track %d 388" %\
       (src,rsrc,csrc, dst,rdst,cdst, track)

    # tiles must be on same col; must be two different tiles
    assert csrc == cdst; assert src != dst
    
    if rdst>rsrc: (inside,outside) = (3,1) # down
    else:         (inside,outside) = (1,3) # up

    beginwire = build_wire_rc(rsrc,csrc,'out',outside,track)

    path = []

    if (rdst>=rsrc): rows = range(rsrc+1,rdst)
    else:            rows = range(rsrc-1,rdst,-1)
    # print rows

    for r in rows:
        # Note build_wire will apply mem offset (mo) on EW sides if
        # row is odd and tile is mem mo=s02_mem_offset(rsrc,c)

        inwire  = build_wire_rc(r,csrc,'in' ,inside, track)
        outwire = build_wire_rc(r,csrc,'out',outside,track)
        connection = "%s -> %s" % (inwire, outwire)
        path.append(connection)

    endwire = build_wire_rc(rdst,cdst,'in',inside,track)

    if DBG: printpath(beginwire, path, endwire)
    return pack_path(beginwire, path, endwire)


def build_wire_rc(r,c,inout,side,track):
    tileno = cgra_info.rc2tileno(r,c)

    # Need mem offset if row==odd indicates mem tile bottom-half
    if is_2hi_rc(r,c) and (r%2==1): mo=4
    else                          : mo=0

    return "Tx%04X_%s_s%dt%d" % (tileno, inout, side+mo, track)

def is_2hi_rc(r,c):
    if cgra_info.MEMTILE_HEIGHT == 1: return False
    else:                             return is_mem_rc(r, c)

def is_mem_rc(r,c):
    tileno   = cgra_info.rc2tileno(r,c)
    tiletype = cgra_info.tiletype(tileno)

    # print "Tile %d has type '%s'" % (tileno,tiletype)

    # "return re.search()" DOES NOT WORK! (why?)
    if re.search("^mem", tiletype): return True
    else:                           return False


def allports(path):
    # Path looks like this:
    # ['T0_out_s0t0', 'T1_in_s2t0 -> T1_out_s0t0', 'T2_in_s2t0 -> T2_out_s0t0', 'T3_in_s2t0']
    # Want list of all the ports

    pstring = ' -> '.join(path)
    # "T0_out_s0t0 -> T1_in_s2t0 -> T1_out_s0t0 -> T2_in_s2t0 -> T2_out_s0t0 -> T3_in_s2t0"

    plist = pstring.split(' -> ')
    ['T0_out_s0t0', 'T1_in_s2t0', 'T1_out_s0t0', 'T2_in_s2t0', 'T2_out_s0t0', 'T3_in_s2t0']

    return plist

def printpath(begin,path,end):
    if path == []:
        print "# %s -> %s" % (begin,end)

    else:
        # print "#               %s ->" % begin
        # print "# ............. %s ->" % begin
        print "# -------------> %12s ->" % begin
        # print "path=", path
        for p in path:
            (i,o) = parse_connection(p)
            print "# %11s -> %12s ->" % (i,o)
        print "# %11s" % (end)

    return


# Given a path ['T41_in_s0t0b -> T41_out_s1t0', 'T41_in_s7t0 -> T41_bit1']
# Check to see that all path connections have the same bus width
def check_bus_consistency(path):
    # allports() gives us a list of all the ports in the path
    plist = allports(path)
    bus_width = cgra_info.get_bus_width_canon(plist[0])
    for p in plist[1:]:
        assert bus_width == cgra_info.get_bus_width_canon(p),\
               'Inconsistent path %s' % path


def parse_connection(c):
    match = re.search('(\S+)\s*[-][>]\s*(\S+)', c)
    inwire = match.group(1)
    outwire = match.group(2)
    return (inwire,outwire)


def parse_resource(r):
    '''
    resource must be of the form "T0_in_s0t0" or "T3_mem_out"
    returns tileno+remains e.g. parse_resource("T0_in_s0t0") = (0, 'in_s0t0')
    '''
    return cgra_info.parse_resource(r)


# lifted from bsview.py
def find_neighbor(w, DBG=0):
    '''E.g. find_neighbor_wire("T4_in_s1t1") => ("T5_out_s3t1")'''
    # FIXME this can all be cleaned up...

    if (0):
        (tilefoo,wfoo) = (3, ("sb_wire_in1_s3t2", "out0_s1t2"))
        (tilefoo,wfoo) = (1, ("in_s2t4"))
        if (tileno == tilefoo) and (w in wfoo):
            DBG=1; print "\nWant match for tile %d wire '%s'" % (tileno,w)

    # find_neighbor_wire("T4_in_s1t1") => ("T5_out_s3t1")
    # 
    (tileno, dir, side, track) = cgra_info.parse_canon(w)

    # Only works for 'out' wires (HA!)
    assert dir == 'out'

    in_or_out = dir

    if (in_or_out=="out"): in_or_out="in"
    else:                  in_or_out="out"

    (r,c) = cgra_info.tileno2rc(tileno)
    if DBG: print("FN: I am '%s' at (r,c) = (%d,%d)" % (w, r,c))

    # top_or_bottom = parse.group(2)  # 'None', '0' or '1'
    top_or_bottom = side/4 # '0' or '1'

    # Adjust for wire in bottom of a memtile
    if (top_or_bottom == '1'): r = r + 1

    if   (side==0): (r,c,side) = (r,c+1,side+2)
    elif (side==1): (r,c,side) = (r+1,c,side+2)
    elif (side==2): (r,c,side) = (r,c-1,side-2)
    elif (side==3): (r,c,side) = (r-1,c,side-2)

    # Yes, yes, I know
    elif (side==4): (r,c,side) = (r,c+1,side+2)
    elif (side==5): (r,c,side) = (r+1,c,side+2)
    elif (side==6): (r,c,side) = (r,c-1,side-2)
    elif (side==7): (r,c,side) = (r-1,c,side-2)

    if (r < 0): return (False,False)
    if (c < 0): return (False,False)

    #   print (r,c,side)
    if DBG: print("FN: My neighbor is (r,c) = (%d,%d)" % (r,c))
    nbr_tileno = cgra_info.rc2tileno(r,c)
    # Note should return 'False' if (r,c) invalid
    if DBG: print "Found neighbor tile number '%s'" % str(nbr_tileno)

    # Adjust for mem tile top/bottom
    # Even row means top, odd row means bottom
    if (cgra_info.tiletype(nbr_tileno) == "memory_tile"):
        if DBG: print "HO found memory tile.  is it a top or a bottom :)"
        if (r%2)==0:
            if DBG: print " You're the top!"
        else:
            if DBG: print " It's a bottom"
            side = side + 4

    nbr_wire = "Tx%04X_%s_s%dt%d" % (nbr_tileno, in_or_out, side, track)

    # if DBG: print "%s on tile %d matches %s on tile %d\n" % (w, tileno, nbr_wire, nbr_tileno)
    if DBG: print "'%s' connects to neighbor '%s'\n" % (w, nbr_wire)

    return nbr_wire


if (DO_TEST): do_test()

# MAYBE STILL NEED THIS (or maybe not)
# def get_default_cgra_info_filename():
#     '''
#     Look for default cgra_info file in <decoder-directory>/examples/cgra_info.txt
#     '''
#     import os
#     mydir = os.path.dirname(os.path.realpath(__file__))
#     cgra_filename = mydir + "../decoder/examples/cgra_info.txt"
# 
#     VERBOSE=0
#     # global verbose #(implied because use before def)
#     if VERBOSE: print("I think I am here:\n  %s" % mydir)
#     if VERBOSE: print("Default cgra_info file is\n  %s" % cgra_filename)
#     return cgra_filename

