#!/usr/bin/python

DO_TEST=0
import sys;
import re;

import traceback # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

# tstring = ''.join(str(x) for x in range(0,5))

# Another thing you could do:
#   '-test packer' and/or '-help packer'

try:
    for i in sys.argv:
        if i == '--test_packer':
            print "Time to test the packer I guess..."
            DO_TEST=1

        # if i == '-test' and i+1 == 'packer' ...
        # if i == '-help' and i+1 == 'packer' ...

except: DO_TEST=0

USE_CGRA_INFO = False

# GLOBALS and their defaults
GRID_WIDTH = 8
GRID_HEIGHT = GRID_WIDTH

NTILES = GRID_HEIGHT * GRID_WIDTH
tiles = []
order = []

TYPE_NEEDED = 'any'


cgra_info = False

def init_globals(grid_width = 8, grid_height = 8, DBG=0):

    if USE_CGRA_INFO:
        sys.path.append("../decoder")
        global cgra_info
        from lib import cgra_info
        # cgra_info.read_cgra_info()

        try: cgra_info.ntiles()
        except:
            print "Loading cgra_info..\n" 
            cgra_info.read_cgra_info()

    # Declare these
    # E.g. if third tile placed is 0x0101 then order[0x0101] = 2 (right?)
    global order; order = {};

    # Set these
    global GRID_WIDTH
    global GRID_HEIGHT

    # Derive these
    global NTILES
    global tiles

    GRID_WIDTH  = grid_width
    GRID_HEIGHT = grid_height
    NTILES = GRID_HEIGHT * GRID_WIDTH

    # print(661, GRID_WIDTH, GRID_HEIGHT)
    if USE_CGRA_INFO:
        # FIXME should also use cgra_info to set width, height
        NTILES = cgra_info.ntiles()
        (GRID_WIDTH,GRID_HEIGHT) = cgra_info.grid_dimensions()

    print "# Grid is maybe %dx%d" % (GRID_WIDTH,GRID_HEIGHT)
    # print(662, GRID_WIDTH, GRID_HEIGHT)

    tiles = range(NTILES)
    if DBG: print "# tiles:"; print '#', tiles, '\n'

# If a tile didn't work out, you can uanllocate() it (see below),
# add it to EXCEPTIONS list, and try again.
EXCEPTIONS = []
def is_free(tileno, DBG=0):
    if DBG>2:
        if tileno in order: 
            print "is_free: tileno %04X has order %d" % (tileno, order[tileno])
        else:
            print "is_free: tileno %04X not yet ordered" % tileno
    if tileno in EXCEPTIONS:
        if DBG: print 'Cannot choose tile(s) %s\n' % EXCEPTIONS
        return False

    elif tileno not in order:
        return True

    else:
        return False

def ntiles_free():
    global NTILES
    global order
    return NTILES - len(order)

def allocate(tileno, DBG=0):
    '''tileno will be next in the ordered list'''

    # E.g. if third tile placed is 0x0101 then order[0x0101] = 2 (right?)
    global order

    n_allocated = len(order)
    order[tileno] = n_allocated+1
    n_allocated   = n_allocated+1

    if DBG: print "#   Allocated %s as %dth tile." \
       % (FMT.tileT(tileno),n_allocated),
    if DBG: print "Remaining free tiles: %d" % ntiles_free()
    if DBG: print ""

    if DBG>5:
        print "# Pattern so far:"
        print "# "
        FMT.order()
        print "# "

def unallocate(tileno, DBG=0):
    del order[tileno]
    if DBG>5:
        print "# order after unallocate(%d):" % tileno
        print "# "
        FMT.order()


def tileno2rc(tileno):
    if USE_CGRA_INFO: return cgra_info.tileno2rc(tileno)
    else:
        return (int(tileno)/8,int(tileno)%8)

def rc2tileno(r,c):
    if (r < 0) or (c < 0): return -1
    if USE_CGRA_INFO: return cgra_info.rc2tileno(r,c)
    else:
        # FIXME this should never happen...riiight?
        assert False, 'FALSE since 3/7/2018'
        tno = 8*r + c
        if tno > NTILES: return -1
        return tno


class Format:
    def tile(self,r,c=-1):
        '''
        E.g. Format.tile(10)  = "10 (r1,c2)"
        E.g. Format.tile(1,2) = "10 (r1,c2)"
        '''
        if c == -1: tileno = r; (r,c) = tileno2rc(tileno)
        else:       tileno = rc2tileno(r,c)
        return "%d (r%d,c%d)" % (tileno,r,c)

    def tileT(self,r,c=-1):
        '''
        E.g. tile(10)  = "T10 (r1,c2)"
        E.g. tile(0,2) = "T09 (r1,c2)"
        '''
        if c == -1: tileno = r; (r,c) = tileno2rc(tileno)
        else:       tileno = rc2tileno(r,c)
        return "T%02d (r%d,c%d)" % (tileno,r,c)

    def order(self):
        for r in range(GRID_HEIGHT):
            print '#   ',
            for c in range(GRID_WIDTH):
                tno = rc2tileno(r,c)
                if tno not in order: print ' .',
                else: print '%2d' % order[tno],
            print ''

    def grid(self):
        print '#      ',
        for c in range(GRID_WIDTH):
            print('%02X ' % c),
        print("")

        for r in range(GRID_HEIGHT):
            print('#  %02X ' % r),
            for c in range(GRID_WIDTH):
                print("..."),
            print("")




FMT = Format()

def print_nearest(src,dst):
    print "# Avail perp-first tile",
    print "nearest to %s in NW direction" % FMT.tileT(src),
    print "is %s maybe" % FMT.tileT(dst)
    
def find_nearest(tileno, type='any', DBG=1):
    # Search in expanding circles from center tile 'tileno'

    global TYPE_NEEDED
    TYPE_NEEDED = type

    if DBG: print "# Find perp-first tile nearest to tile %s in NW direction" \
          % FMT.tile(tileno)

    if DBG: print "# Note tile must be type '%s'" % TYPE_NEEDED


    if DBG>1: print "# Search for avail tile in expanding circles from %s"\
       % FMT.tile(tileno)
    
    for radius in range(1, GRID_WIDTH):
        tile = search_box(tileno,radius,DBG)
        if (tile != -1):
            if DBG: print_nearest(tileno,tile)
            return tile

    return -1
        
def test_find_nearest():
    DBG=0

    print "# Starting with tile 0, trace a path through the grid"

    if USE_CGRA_INFO: 
        allocate(34,DBG=1) # little clunker in there at random
    else:
        allocate(NTILES-1,DBG=1) # yeah, sorry

    print "# Begin pattern:"
    print "# "
    FMT.order()
    print "# "
    print ""
    print ""

    allocate(0,DBG=1)
    next = 0
    while next != -1:
        if DBG: print "# Find tile nearest to T%d" % next
        next = find_nearest(next,DBG=1)

    print "# Final pattern:"
    print "# "
    FMT.order()
    print ''

    #  1  4  5 16 17 36 37 -1 
    #  2  3  6 15 18 35 38 -1 
    #  9  8  7 14 19 34 39 -1 
    # 10 11 12 13 20 33 40 -1 
    # 25 24 23 22 21 32 41 -1 
    # 26 27 28 29 30 31 42 -1 
    # 49 48 47 46 45 44 43 -1 
    # 50 51 52 53 54 55 56  0 



def search_box(ctr, L, DBG=1):

    sp = search_pattern(ctr, L, DBG=DBG)

    # Search perps (straight-line routes) FIRST
    t = search_perps(ctr, L, sp, DBG=DBG)
    if (t != -1): return t

    #     FMT.order()
    #     sys.exit(1)
    #     return -1

    if DBG: print "#   Found no perps."

    t = search_sides(ctr, L, sp, DBG=DBG)
    if (t != -1):
        # print "found", t
        return t

    return -1

def search_sides(ctr, L, sp='nwes', DBG=1):

    for side in sp:
        if DBG: print "#   Searching '%s' side L%d for any avail tile..." \
           % (side,L)

        # Farthest corner is always SE, check that LAST
        (r,c) = tileno2rc(ctr)
        if (side == 'n'): (rbegin,cbegin) = (r-L,c-L) # NW
        if (side == 'e'): (rbegin,cbegin) = (r-L,c-L) # NW
        if (side == 's'): (rbegin,cbegin) = (r-L,c+L) # NE
        if (side == 'w'): (rbegin,cbegin) = (r+L,c-L) # SW


        rend = rbegin+2*L+1
        cend = cbegin+2*L+1

        # (optional) shortcuts
        (rmin,rmax) = (0,GRID_WIDTH-1)
        (cmin,cmax) = (0,GRID_HEIGHT-1)
        if   (rend < rmin) or   (cend < cmin):
            continue
        if (rbegin > rmax) or (cbegin > cmax): continue
        rbegin = max(rmin,rbegin)
        cbegin = max(cmin,cbegin)

        rend = min(rmax,rend)
        cend = min(cmax,cend)

        if DBG: print "#     Search r(%d,%d) x c(%d,%d)" \
           % (rbegin,rend,cbegin,cend)


        for r in range(rbegin,rend+1):
            if (r < 0) or (r > GRID_WIDTH-1): return -1

            for c in range(cbegin,cend+1):
                if (c < 0) or (c > GRID_HEIGHT-1): return -1


                tno = rc2tileno(r,c)

                if DBG: print '#     Checking location (%d,%d)...' % (r,c),

                t = alloc_tile(tno, DBG=DBG)
                if t != -1: return t
        if DBG: print ""

                
    return -1

def search_perps(ctr, L, sp='nwes', DBG=1):
    '''Look for tiles in perpendicular directions from center (src) tile'''

    for side in sp:
        if DBG: print "#   Looking '%s' for perp at dist %d..." % (side,L),

        # check perpendicular tile first
        # then run through the side starting w/tile nearest to INPUT tile 0
        # nearest(n,s,e,w) = (nw,nw,ne,sw)

        # check perpendicular tile first
        perp = go_straight(ctr, L, side)

        t = alloc_tile(perp, DBG=DBG)
        if t != -1: return t

    return -1

def alloc_tile(tno, DBG=0):
    # not usefule
    # if not tile_exists(tno):
    #     if DBG: print "no tile exists."
    #     return -1

    if DBG: print "found %s. Free:" % FMT.tileT(tno),
    if not is_free(tno):
        if DBG: print "no."
        return -1

    if TYPE_NEEDED == 'any':
        if DBG: print "yes."
        allocate(tno, DBG=DBG)
        return tno

    if DBG: print "yes. Type '%s':" % TYPE_NEEDED,

    if TYPE_NEEDED != cgra_info.mem_or_pe(tno):
        if DBG: print "no."
        return -1
    
    if DBG: print "yes."
    allocate(tno, DBG=DBG)
    return tno


def search_pattern(ctr, L, DBG=1):
    '''Search all tiles in a ring of radius L away from center tile ctr'''
    (r,c) = tileno2rc(ctr)

    # Find the tile closest to INPUT tile 0
    # => Search box sides n and e first, depending on which is closest
    # => Can determine which is closest by looking at whether tile is
    #    NE or SW of dividing line going SE from INPUT in NW corner (0,0)
    #    (draw a picture if you want...)

    if r>c:
        search_pattern = 'nwes'; why='r>c'
    else:
        search_pattern = 'wnse'; why='c<=r'

    if DBG: print "# Because (%s), search pattern is '%s'" % (why,search_pattern)
    return search_pattern


# FWIW canonical side numbering is 0123 = eswn

def go_straight(t=0, L=3, dir='e'):
    '''
    Find the tile 'L' tiles away from tile 't' in direction 'dir'
    Examples 8x8 grid):
        go_straight(t=0, L=3, 'e') ==  3
        go_straight(t=9, L=1, 's') == 17
    '''
    (r,c) = tileno2rc(t)

    # print "# Looking straight '%s' from tile %s" % (dir, FMT.tile(t))
    # print r,c, 'L=',L

    if (dir == 'n'): (rdst,cdst) = (r-L, c+0)
    if (dir == 'e'): (rdst,cdst) = (r+0, c+L)
    if (dir == 's'): (rdst,cdst) = (r+L, c+0)
    if (dir == 'w'): (rdst,cdst) = (r+0, c-L)
    
    # rc2tileno does this
    # if (rdst<0) or (cdst<0): return -1

    return rc2tileno(rdst, cdst)


def test_all():
    init_globals(8,8,DBG=1) # this is crucial out there

    if USE_CGRA_INFO:
        assert go_straight(0, 3, 'e') == 3
        assert go_straight(9, 1, 's') == 15
    else:
        assert go_straight(0, 3, 'e') == 3
        assert go_straight(9, 1, 's') == 17

    # sp = search_box(ctr=9, L=1, DBG=1)

    ##########################################################
    print ""
    print "# Quick test of find_nearest:"

    n = find_nearest(17,DBG=0)
    print_nearest(17,n)

    n = find_nearest(17,DBG=0)
    print_nearest(17,n)
    
    n = find_nearest(17,DBG=0)
    print_nearest(17,n)
    
    n = find_nearest(17,DBG=0)
    print_nearest(17,n)
    
    ##########################################################
    print ""
    print ""
    print "# More exhaustive test of find_nearest:"
    
    test_find_nearest()

if DO_TEST:
    USE_CGRA_INFO = False
    test_all()

    # Okay this should be fun
    print ""
    print '############################################################'
    print "# Try it using cgra_info...!"
    print ""
    USE_CGRA_INFO = True
    init_globals() # this is crucial out there

    print '# So...cgra_info says grid should look like...'
    print '# '
    FMT.grid()
    print ''
    test_all()

    print '############################################################'
    print "# Try mem tiles only"
    print ""
    TYPE_NEEDED = 'mem'
    init_globals() # this is crucial out there
    test_all()

    print '############################################################'
    print "# Try pe tiles only"
    print ""
    TYPE_NEEDED = 'pe'
    init_globals() # this is crucial out there
    test_all()


