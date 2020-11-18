#!/usr/bin/python
import sys
import re
import math # for sqrt

'''
NEXT
Want "whereami(x,y)" fn (enhancement to find_tile_clicked(x,y) probably)
that, given (x,y) coords, tells
- what tile am i closest to?
- what port (wirename) in that tile am i closest to?
- am i inside or outside of the tile?
'''

# FIXME dude you gotta pay attention to lists [] vs. tuples ()

# # gi a.k.a. pygobjects, pygtk
# import gi
# gi.require_version('Gtk', '3.0')
# from gi.repository import Gtk,Gdk

import pygtk
pygtk.require('2.0')
import gtk

import cairo
from subprocess import call

import traceback
# sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

import time # for time.sleep(2)

####################################################
# Some random utilities here in this random place...

def exit(): sys.exit(0)

def errmsg(m):
    sys.stdout.write("ERROR: %s\n" % (m))
    sys.exit(-1)

global PRINTED
PRINTED = [] # use [list] not (tuple)
def print_once(s):
    '''Keep a list of what's been printed.  Don't print the same thing twice.'''
    global PRINTED
    if (s not in PRINTED):
        PRINTED.append(s); print s

####################################################
# FIXME should have a CGRA class for globals...?
# FIXME how to specify globals vs. constants?
# Want to list all the random globals here?

# Initialize to "arrow"
global CUR_CURSOR # Currently includes 'magplus', 'magminus', 'arrow'
CUR_CURSOR = 'arrow'

# print dir(gtk.gdk.Window.props); sys.exit(0)

from math import pi
PI = pi
def deg2rad(rad): return rad*180/PI

# width and height of PE
global PE_WIDTH;  PE_WIDTH = 30
global PE_HEIGHT; PE_HEIGHT = 12

TILE_LIST = []

PRINTED_CONFIG = False

########################################################################
# Config-file (cgra_info.txt) reader
# Use existing library from decoder to read cgra info:
#   CGRAGenerator/bitstream/decoder/lib/cgra_info.py
# This gives us e.g. tileno2rc, rc2tileno...

import os
mypath = os.path.realpath(__file__)
mydir  = os.path.dirname(mypath)

decoder_path = mydir+"/../decoder"
# print decoder_path

sys.path.insert(0, decoder_path)
from lib import cgra_info

def tileno2rc(tileno):
    return cgra_info.tileno2rc(tileno)

def rc2tileno(row,col):
    return int(cgra_info.rc2tileno(row,col))

def tiletype(tileno):
    return TILE_LIST[tileno].type

# Could/should derive these from "BUS:5" etc.
NTRACKS_PE_BUS_H = 5;
NTRACKS_PE_BUS_V = 5;

NTRACKS_PE_WIRE_H = 0;
NTRACKS_PE_WIRE_V = 0;

# ARROWHEAD_LENGTH = 2; ARROWHEAD_WIDTH = 4; # meh
ARROWHEAD_LENGTH = 3; ARROWHEAD_WIDTH = 2; # this is nice

# AFAICT only used in zoom_to_tile()
# # Here's a dumb way to pass information from the button-press handler to the draw-event handler
# ZOOMTILE = -1;

# Diagram below shows dimensions for PORT_WIDTH (PW) 
# PORT_HEIGHT (PH) (aka PORT_LENGTH),
# REG_WIDTH (RW) and REG_HEIGHT (RH)
#
#    <--PW-->
#
#    +------+
#    |      |  ^
#    |      |  |
#    |      |  PH
#    |      |  |
#    |      |  v
#    +------+  ^
#     |>   |   RH
#     +----+   v
#
#     <-RW->

# TODO/FIXME maybe a Canvas class or a Dimensions class to handle/encapsulate
# PORT_WIDTH, PORT_HEIGHT, CANVAS_WIDTH etc. etc.

PORT_WIDTH  = 8;
# PORT_WIDTH  = 6;

PORT_HEIGHT = 16;
PORT_LENGTH = PORT_HEIGHT # Because sometimes I forget

PORT_PAD = PORT_WIDTH/2   # Padding before and between groups of ports

REG_WIDTH  = PORT_WIDTH - 2;
REG_HEIGHT = 2;

# Canvas size for displaying a single tile edge-to-edge w/ no padding
#   How big is a tile canvas?  Refer to diagram in doc
#   Short answer is:
#     Canvas width  = 2*plen + 2*ntracks_v*pwid + 3*pwid
#     Canvas height = 2*plen + 2*ntracks_h*pwid + 3*pwid
#   where each port is an arrow in a box that's portlength long and portwidth wide
#   and ntracks_v = ntracks_bus_v + ntracks_wire_v etc.
# CANVAS_WIDTH  = 2*PORT_HEIGHT + 2*NTRACKS_PE_BUS_V*PORT_WIDTH + 3*PORT_PAD
# CANVAS_HEIGHT = 2*PORT_HEIGHT + 2*NTRACKS_PE_BUS_H*PORT_WIDTH + 3*PORT_PAD

CANVAS_WIDTH  = 2*PORT_HEIGHT + 3*NTRACKS_PE_BUS_V*PORT_WIDTH + 3*PORT_PAD
CANVAS_HEIGHT = 2*PORT_HEIGHT + 3*NTRACKS_PE_BUS_H*PORT_WIDTH + 3*PORT_PAD

# E.g. for n = NTRACKS = 6
#       |<-----n*pw------>|<-----n*pw+pp------>|<------n*pw----->|
# |ph+pp|pw pw pw pw pw pw|pw pw pw pp pw pw pw|pw pw pw pw pw pw|ph+pp|
# +-----+--+--+--+--+--+--+--------------------+--+--+--+--+--+--+-----+
# |     |/\ /\ /\ /\ /\ /\|                    |/\ /\ /\ /\ /\ /\|     |
# |     ||| || || || || |||                    ||| || || || || |||     |


# Drawing area will be WIN_WIDTH x WIN_HEIGHT;
# actual enclosing window will be bigger or smaller as defined later
# (smaller window means scrollbars will be added)

# Edge of first tile in array (grid) view is UL_MARGIN + PORT_HEIGHT
UL_MARGIN = 60

# At this point, can set win_width/height to any value and program still
# works correctly; only affects initial window size (hooray!) sorta...
WIN_WIDTH  = 4*CANVAS_WIDTH + UL_MARGIN
WIN_HEIGHT = 4*CANVAS_HEIGHT+ UL_MARGIN

# A really dumb way (using a global) to keep track of current scale
# factor, for button-press events FIXME do something better maybe
CUR_SCALE_FACTOR = 1;
INIT_SCALE_FACTOR = 1;
def set_initial_scale_factor(grid_width, grid_height):
    global WIN_WIDTH; global WIN_HEIGHT; global UL_MARGIN
    global CUR_SCALE_FACTOR;
    global INIT_SCALE_FACTOR;

#     if (grid_width <= 2):
#         INIT_SCALE_FACTOR = 2.0
#         CUR_SCALE_FACTOR  = 2.0
#         # Show four tiles across
#         WIN_WIDTH  = int(4*CANVAS_WIDTH *CUR_SCALE_FACTOR) + UL_MARGIN
#         WIN_HEIGHT = int(4*CANVAS_HEIGHT*CUR_SCALE_FACTOR) + UL_MARGIN
# 
#     if (grid_width  > 4):

    if (1):
        global REQUESTED_SIZE    # E.g. REQUESTED_SIZE = [8,8]
        ntiles = REQUESTED_SIZE[0]
        # CANVAS_WIDTH is set such that a window fits four across.
        # To fit eight across, then, we scale by 1/2
        INIT_SCALE_FACTOR = 0.5 # Why squint?
        CUR_SCALE_FACTOR  = 0.5
        # Show eight tiles across
        WIN_WIDTH  = int(ntiles*CANVAS_WIDTH *CUR_SCALE_FACTOR) + UL_MARGIN
        WIN_HEIGHT = int(ntiles*CANVAS_HEIGHT*CUR_SCALE_FACTOR) + UL_MARGIN

       


##############################################################################
# These could all be part of a Wire class if we wanted to...

# E.g. given "out_s1t3", rval['inout'] = "out", rval['side'] = 1 and rval['track'] = 3
def parse_wirename(wirename):
    rval = {}

    # decode = re.search('(in|out)_s(.*)t(.*)', wirename);
    decode = re.search('(in|out)[01]*_s(.*)t(.*)', wirename);
    if (decode):
        rval['inout'] = str(decode.group(1))
        rval['side']  = int(decode.group(2))
        rval['track'] = int(decode.group(3))
        return rval

    else:
        print "WARNING PW does not understand wirename '%s' (yet)" % wirename
        print "WARNING (Arbitrarily) connecting unknown wire to 'outs3t4' instead"
        # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
        # print ""
        # print ""
        rval['inout'] = "out"
        rval['side']  = 3
        rval['track'] = 4
        return rval

def inout(wirename): return parse_wirename(wirename)['inout']
def side(wirename): return parse_wirename(wirename)['side']
def track(wirename): return parse_wirename(wirename)['track']
##############################################################################

# Called from: drawport and ...?
# This could be an extension of cr's class I suppose
def draw_arrow(cr, al, ahl,ahw,fill):
    # Draw an arrow of total length al and line_width aw
    # Arrowhead on the end is a triangle of length ahl, width ahw
    # if "fill" is true, fill in the triangle.
    # Arrow starts at location (0,0);
    # use cr.translate() and rotate() to place and rotate it
    # E.g. for down arrow starting at (x,y)
    # cr.save()
    #   cr.translate(x,y); cr.rotate(-PI/2)
    #   draw_arrow(al,aw,ahl,ahw,fill)
    # cr.restore()

    cr.save()
    if (1):

        # To get exact offset I'd have to do math :( with sin and cos or sumpm
        if (not fill):
            SQ2 = 1.4142
            offset = cr.get_line_width()/SQ2
            al = al - offset
            ahw = ahw - 2*offset

        # The line
        cr.move_to(0,0)
        if (fill): cr.line_to(al-ahl,0)
        else:      cr.line_to(al,0)
        cr.stroke()

        # The arrowhead
        if (fill): cr.set_line_width(1);
        cr.move_to(al-ahl, -ahw/2)
        cr.line_to(al,     0)
        cr.line_to(al-ahl, ahw/2)
        if (fill):
            cr.close_path()
            cr.fill()

        cr.stroke()
    cr.restore()

# # Big ghost arrows in background of grid view show prevailing port direction
# def draw_big_ghost_arrows(cr):
# 
#     # Ghost Arrow parms, used by big_ghost_arrow(), 
#     aw = 10                # line width
#     ahl = 20; ahw = 3*aw   # arrowhead length, width
# 
#     # Arrow goes across two tiles, sticks out apad on one side and (apad + ahl/2) on the other
#     apad = 10;
#     al = 2*CANVAS_WIDTH + 2*apad + ahl/2  # length of arrow
#     al = GRID_WIDTH*CANVAS_WIDTH + 2*apad + ahl/2  # length of arrow
# 
#     fill = True;  # For solid filled-in arrowhead
# 
#     # Ghost arrows are ghooooostly graaaaaay, woooooooo!
#     # graylevel = 0.9; cr.set_source_rgb(graylevel,graylevel,graylevel)
#     setcolor(cr, "ghostgray")
# 
#     def draw_big_ghost_arrow(cr,x,y,dir):
# 
#         cr.save()
#         if (1):
#             cr.translate(x,y)
#             cr.set_line_width(aw);
#             if (dir=='left'): cr.rotate(PI)
#             if (dir=='down'): cr.rotate(PI/2)
#             if (dir=='up'):   cr.rotate(3*PI/2)
#             draw_arrow(cr,al,ahl,ahw,fill)
#         cr.restore()
# 
#     # Right-pointing arrows start apad back from left edge of the tile
#     # and ra_v_offset down from the top
#     ra_start    = -apad;
#     ra_v_offset = PORT_LENGTH + 2 * PORT_WIDTH
# 
#     # Left-pointing arrows start apad beyond the right edge of the tile
#     # and ra_h_offset up from the bottom
#     la_start    = GRID_WIDTH*CANVAS_WIDTH + apad;
#     la_v_offset = CANVAS_HEIGHT - ra_v_offset
# 
#     for tilerow in range (0, GRID_HEIGHT):
#         draw_big_ghost_arrow(cr, ra_start, ra_v_offset + tilerow*CANVAS_HEIGHT, 'right')
#         draw_big_ghost_arrow(cr, la_start, la_v_offset + tilerow*CANVAS_HEIGHT, 'left')
# 
#     # Similar for up/down arrows
#     da_start = -apad;
#     da_h_offset = ra_v_offset;
#     ua_start = GRID_HEIGHT*CANVAS_HEIGHT + apad;
#     ua_h_offset = CANVAS_WIDTH - da_h_offset
# 
#     for tilecol in range (0, GRID_HEIGHT):
#         draw_big_ghost_arrow(cr, da_h_offset + tilecol*CANVAS_WIDTH, da_start, 'down')
#         draw_big_ghost_arrow(cr, ua_h_offset + tilecol*CANVAS_WIDTH, ua_start, 'up')

# This could be an extension of cr's class I suppose
def setcolor(cr, colorname):
    colordict = {}

    # Sixteen "official" HTML colors
    # https://en.wikipedia.org/wiki/Web_colors#HTML_color_names

    colordict["white"]   = ( 1.00, 1.00, 1.00)
    colordict["silver"]  = ( 0.75, 0.75, 0.75)
    colordict["gray"]    = ( 0.50, 0.50, 0.50)
    colordict["black"]   = ( 0.00, 0.00, 0.00)
    colordict["red"]     = ( 1.00, 0.00, 0.00)
    colordict["maroon"]  = ( 0.50, 0.00, 0.00)
    colordict["yellow"]  = ( 1.00, 1.00, 0.00)
    colordict["olive"]   = ( 0.50, 0.50, 0.00)
    colordict["lime"]    = ( 0.00, 1.00, 0.00)
    colordict["green"]   = ( 0.00, 0.50, 0.00)
    colordict["aqua"]    = ( 0.00, 1.00, 1.00)
    colordict["teal"]    = ( 0.00, 0.50, 0.50)
    colordict["blue"]    = ( 0.00, 0.00, 1.00)
    colordict["navy"]    = ( 0.00, 0.00, 0.50)
    colordict["fuchsia"] = ( 1.00, 0.00, 1.00)
    colordict["purple"]  = ( 0.50, 0.00, 0.50)

    # What, no orange!?
    colordict["orange"]  = ( 1.00, 0.50, 0.00)

    # My own ghostly gray
    graylevel = 0.9;
    colordict["ghostgray"] = (graylevel,graylevel,graylevel)

    # return colordict[colorname]
    (r,g,b) = colordict[colorname];
    cr.set_source_rgb(r,g,b)

# This could be an extension of cr's class I suppose NO!!!! it's a time waster
def drawdot(cr, x, y, color):

    # For debugging purposes, draw a colorful dot at location (x,y)

    dotsize = 1.0
    dotsize = 0.8

    # cr.set_line_width (10.0); # For BIG dots

    cr.save()
    if (1):
        setcolor(cr, color)
        cr.arc (x, y, dotsize, 0, 2*PI);
        cr.fill ();
        cr.stroke ();
    cr.restore()

    # Instead of cr.stroke(), could do this: "path = cr.copy_path()"
    # and then return the path for later use e.g. "cr.append_path(path); cr.stroke()"
    

def connectionpoint(tileno, wirename):

    # Given wirename e.g. "out_s0t0", return x,y coords of its connection
    # point on the edge of the tile, relative to edge of canvas.

    # FIXME rewrite this littel snippet below
    # outs1/ins3 blocks start in SE/NE and go left (neg x direction)
    # outs2/ins0 blocks start in SW/SE and go up   (neg y direction)
    # outs3/ins1 blocks start in NW/NE and go right (pos x direction)

    DBG=0
    # Translate newstyle memwire names to oldstyle e.g. 'out_s6t0' => 'out1_s2t0'
    if (tiletype(tileno) == "memory_tile"):
        if not re.search("(in|out)[01]", wirename):
            # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
            # sys.exit(-1)
            # print "Can we recover?  Default to 10,10"; return (10,10)
            wnew = memwire_translate(wirename)
            if DBG: 
                print "ERROR Invalid wire name '%s' in memtile %d" % (wirename,tileno)
                print "ERROR Should have this format: 'out1_s2t3'"
                print "Can we recover?  Translate '%s' => '%s'\n" % (wirename, wnew)
            wirename = wnew

    decode = re.search('(in[01]*_s.*|out[01]*_s.*)t(.*)', wirename);

    if (decode):
        b = decode.group(1);      # blockno e.g. "in_s1" or "in1_s1"
        t = int(decode.group(2)); # trackno e.g. "3"
    else:
        print "WARNING CP does not understand wirename '%s' (yet)" % wirename
        print "WARNING (Arbitrarily) connecting unknown wire to 'outs3t4' instead"
        (b,t) = ("out_s3",4)


    ########################################################################
    # TODO/FIXME maybe this should be a separate add_fudge() function
    # 
    # Need to fudge side s1 (bottom) wires on mem tiles.
    # 
    # Earlier, we rewrote wire names and now e.g.
    #   'out_0_BUS16_2_0' is called 'out0_s2t0'
    # 
    # Mem tile bottom-half wires e.g. east-west wires
    # - bottom-half east-west wires 'out1_s0t3' or 'in1_s2t2'
    # - bottom-half switchbox wires e.g. 'sb_wire_in1.*'
    # - any side s1 (south) wire) e.g. 'in_s1t0' or 'out_s1t1'
    # must be moved down one before drawing.
    # For this we add "yfudge"
    # 
    # memtile wire     xfudge       yfudge
    # in_s3.*          0            0
    # in0.*            0            0
    # sb_wire_in0.*    0            0
    # 
    # memtile wire     xfudge       yfudge
    # in_s1.*          0            CH
    # in1.*            0            CH
    # sb_wire_in1.*    0            CH

    # E.g. "in_s1t1" is in a normal 1x1 block;
    # in1_s1t1" is in bottom half of a 1x2 block (memtile)

    # FIXME globals are evil.  Also this evil memtile hack
    yfudge = 0  # FIXME fudge factors for e.g. out_0_ etc.
    if (tiletype(tileno) == "memory_tile"):
        DBG=0
        if DBG:
            print "CP found memory tile %d, wirename '%s', block '%s'"\
                  % (tileno, wirename, b)

        # All the "normal" side1 (south) ports in a mem tile must move DOWN one
        if (b == "out_s1") or (b ==  "in_s1"):
            if DBG: print "CP adding downward fudge b/c memtile side 1 (bottom)"
            yfudge = CANVAS_HEIGHT
        
        # In addition (maybe) all the out1/in1 switchbox etc. ports have to move down
        if re.search("(in|out)1", b):
            if DBG: print "CP adding downward fudge b/c memtile bottom half"
            yfudge = CANVAS_HEIGHT
    ########################################################################

    ########################################################################
    # FIXME this is a hacky hack i guess
    # Rewrites e.g. "in1_s2" => "in_s2"
    decode = re.search('(in|out)[01]_(s.*)', b)
    if decode:
        # print "FOO rewriting block '%s'" % b,
        inout = decode.group(1)
        side  = decode.group(2)
        b = "%s_%s" % (inout,side)
        # print "=> '%s'" % b


    # Canvas consists of a single tile padded on each side by space equal to "PORT_LENGTH"
    
    # A tile's edge is PORT_LENGTH away from the canvas edge
    # The first connection point begins "PORT_PAD + PORT_WIDTH/2" from nearest tile edge.
    # The distance from one track to the next is PORT_WIDTH.
    # So track t connects at a distance CD = PL+PP+PW/2+t*PW from edge of canvas
    CD = PORT_LENGTH + PORT_PAD + PORT_WIDTH/2 + (t * PORT_WIDTH)
    PL = PORT_HEIGHT

    # Sides (0,1,2,3) are (E,S,W,N) sides of tile respectively

    # out_s0 wires start at NE corner and go DOWN
    # in_s0 tracks start at SE corner and go UP
    if (b == "out_s0"): (x,y) = (CANVAS_WIDTH - PL,                 CD)
    if (b ==  "in_s0"): (x,y) = (CANVAS_WIDTH - PL, CANVAS_HEIGHT - CD)

    # out_s1 wires start at SE corner and go LEFT
    #  in_s1 wires start at SW corner and go RIGHT
    if (b == "out_s1"): (x,y) = (CANVAS_WIDTH - CD, CANVAS_HEIGHT - PL)
    if (b ==  "in_s1"): (x,y) = (               CD, CANVAS_HEIGHT - PL)

    # out_s2 wires start at SW corner and go UP
    #  in_s2 wires start at NW corner and go DOWN
    if (b == "out_s2"): (x,y) = (PL, CANVAS_HEIGHT - CD)
    if (b ==  "in_s2"): (x,y) = (PL,                 CD)

    # out_s3 wires start at NW corner and go RIGHT
    #  in_s3 wires start at NE corner and go LEFT
    if (b == "out_s3"): (x,y) = (               CD, PL)
    if (b ==  "in_s3"): (x,y) = (CANVAS_WIDTH - CD, PL)

    try: x
    except: print "ERROR Could not find connection point for " + wirename

    # print "yfudge is (still) %d" % yfudge
    return (x, y + yfudge);

def memwire_translate(w):
    # Given newstyle mem wirename translate to old style e.g.
    # out_s2t0 => out0_s2t0
    # out_s6t0 => out1_s2t0
    parse = re.search('(in|out)_s(\d+)t(\d+)', w)
    dir = parse.group(1)
    side = int(parse.group(2))
    track = int(parse.group(3))
    return '%s%d_s%dt%d' % (dir, side/4, side%4, track)



def drawreg(cr, w,h, color='white'):
    # Draw a register with UL at (0,0), height h and width w
    cr.save()

    # cr.translate(ULx,ULy)

    # Draw the register
    cr.rectangle(0,0,  w, h) # ULx, ULy, width, height
    cr.stroke()
    if (1):
        cr.save()
        # TODO find and use background color instead of white!
        # setcolor(cr, 'white')
        setcolor(cr, color)
        cr.rectangle(0,0,  w, h) # ULx, ULy, width, height
        cr.fill()
        cr.stroke()
        cr.restore()


    # Draw the little triangle for the clock
    cr.move_to(0,0);
    cr.line_to(h/2,h/2)
    cr.line_to(0,h)
    cr.stroke()
    cr.fill()
    cr.restore()

# def draw_pe(cr, opname, **keywords):
def draw_pe(cr, opname, A, B):
    DBG=1
    # if (opname != "setup_only"): print "FOO DRAW PE opname=%s A=%s B=%s" % (opname, A, B)

    # Use cases I want to support:
    # draw_pe(cr, "ADD") => basic PE including input and output arrows
    # draw_pe(cr, "ADD", regA="2", regB="0") => basic PE + reg(s) w/labels

    # if (self.col==0): draw_pe(cr, "ADD", "0x00002", "0x0000")
    # if (self.col==1): draw_pe(cr, "ADD", "0x00002", "wireB")
    # if (self.col==2): draw_pe(cr, "ADDYO DADDY", "wireA", "wireB")
    # if (self.col==3): draw_pe(cr, "FOO", "wireA", "regB")
    # if (self.col==3): draw_pe(cr, "I/O", "wireA", None)
    # if (self.col==3): draw_pe(cr, "I/O", None, None)

#     (regA,regB) = (None,None)
#     if ('regA' in keywords): regA = keywords['regA']
#     if ('regB' in keywords): regB = keywords['regB']

#     inputs = True;
#     if ('inputs' in keywords): inputs = keywords['inputs']

#     if DBG:
#         if (regA == None): print "No regA"
#         else:              print "Found regA = '%s'" % str(regA)

    # Draw the main functional unit

    # (pe_w,pe_h) = (30,12)
    (pe_w,pe_h) = (PE_WIDTH,PE_HEIGHT)

    pe_linewidth   = 0.5

    headwidth   = 3    # see how it looks
    headlength  = 2 #reg_height/3

    # width and height of input registers
    reg_width  = 0.4*pe_w
    reg_height = 6 # for now, say
    reg_sep    = headlength+1 # Gap b/w reg and PE

    arrowlength = reg_height+reg_sep+2
    arrowlength_out = headlength+2
    fill        = False
    # txt_linewidth = float(pe_linewidth)/2.0
    txt_linewidth = pe_linewidth

    # pe_ulx = -w/2; pe_uly = -h/2
    centerx = CANVAS_WIDTH/2
    centery = CANVAS_HEIGHT/2
    pe_ulx = centerx - pe_w/2
    pe_uly = centery - pe_h/2

    global PE_OUTX; PE_OUTX = pe_ulx+pe_w/2
    global PE_OUTY; PE_OUTY = pe_uly+pe_h+arrowlength_out


    # FIXME this is terrible; breaks if connections happen before PE draw
    # A fix would be to do a setup_pe() call that initializes globals
    # Another fix would be to set up the globals at the beginning
    global PE_AX; PE_AX = pe_ulx+pe_w/4
    global PE_AY; PE_AY = pe_uly-arrowlength

    global PE_BX; PE_BX = pe_ulx+3*pe_w/4
    global PE_BY; PE_BY = pe_uly-arrowlength

    # Egregious hack
    if (opname == "setup_only"): return

    if (1):
        cr.save()
        # Put a big PE in the middle of the tile, with A and B inputs,
        # each w/optional input registers

        # Draw the main PE
        setcolor(cr, "black")
        cr.set_line_width(pe_linewidth)

        cr.rectangle(pe_ulx,pe_uly,  pe_w, pe_h) # pe_ulx, pe_uly, width, height

        # Add a label.  Just center it, like did w/ ghost numbers

        cr.set_font_size(0.8*pe_h)
        cr.select_font_face("Sans", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_BOLD)
        
        # This works, don't know why
        (text_ulx, text_uly, w, h, nextx, nexty) = cr.text_extents(opname)

        # (centerx,centery)    = (CANVAS_WIDTH/2,      CANVAS_HEIGHT/2)
        (text_ulx,text_uly)    = (CANVAS_WIDTH/2 - w/2 - text_ulx, CANVAS_HEIGHT/2 + h/2)
        cr.move_to(text_ulx,text_uly)
        cr.show_text(opname)
        cr.stroke()




        # Output arrow at w/2 on bottom
        if (1):
            cr.save()
            cr.set_line_width(txt_linewidth)
            cr.translate(PE_OUTX,PE_OUTY-arrowlength_out)
            cr.rotate(PI/2) # point DOWN
            fill = False
            draw_arrow(cr, arrowlength_out, headlength, headwidth, fill)
            cr.stroke(); cr.restore()


        # Input arrows at w/4 and 3w/4 across the top
        if (A or B):
            # setcolor(cr, 'red')
            # cr.set_line_width(txt_linewidth)
            # print "FOO " + str(pe_linewidth)
            # print "BAR " + str(txt_linewidth)
            # cr.set_line_width(0.5)


            #             cr.translate(pe_ulx,pe_uly) # UL corner of PE
            #             cr.translate(pe_w/4, -arrowlength)


            if (A):
                cr.save()
                cr.set_line_width(txt_linewidth)
                cr.translate(PE_AX,PE_AY)
                cr.rotate(PI/2) # point DOWN
                fill = False
                draw_arrow(cr, arrowlength, headlength, headwidth, fill)
                cr.stroke(); cr.restore()

            if (B):
                cr.save()
                # setcolor(cr, 'red')
                # cr.set_line_width(txt_linewidth)
                # print "FOO " + str(pe_linewidth)
                # print "BAR " + str(txt_linewidth)
                cr.set_line_width(txt_linewidth)
                # cr.set_line_width(0.5)


                #             cr.translate(pe_ulx,pe_uly) # UL corner of PE
                #             cr.translate(3*pe_w/4, -arrowlength)

                cr.translate(PE_BX,PE_BY)

                cr.rotate(PI/2) # point DOWN
                fill = False
                draw_arrow(cr, arrowlength, headlength, headwidth, fill)
                cr.stroke(); cr.restore()

        cr.stroke()
        cr.restore()

    # Draw the A/B input registers

    # draw_pe_reg(A)

    # FIXME/TODO un-nest this def maybe; requires making things global or something
    def draw_pe_reg(cr, reg, a_or_b):
        # Sample usage cases:
        #    draw_pe_reg(cr, "0x0002", "A") => Build A reg w/label "2"
        #    draw_pe_reg(cr, "regB", "B")   => build B reg, no label

        # A port is centered in left half of PE
        # B port is centered in right half of PE
        if (a_or_b == "A"): reg_ulx = pe_ulx + 1*pe_w/4 - reg_width/2
        if (a_or_b == "B"): reg_ulx = pe_ulx + 3*pe_w/4 - reg_width/2

        # Both ports are at same height
        reg_uly = CANVAS_HEIGHT/2 - pe_h/2 - reg_height - reg_sep

        # Draw register
        if (1):
            cr.save()
            setcolor(cr, 'black')
            # cr.set_line_width(.2)
            cr.set_line_width(pe_linewidth)
            cr.translate(reg_ulx,reg_uly)
            drawreg(cr, reg_width,reg_height) # pretty sure this does the stroke too
            cr.restore()

        # Draw label
        if (1):
            cr.save()
            setcolor(cr, 'black')
            font_size = 0.8*reg_height
            font_size = 0.9*reg_height

            # FIXME Assumes all constants are of the form "0x0002" else breaks
            label = ''
            if (not re.search("^reg", reg)): 
                label = str(int(reg,16))  # E.g. want "0x0002" => "2"

            # Find textbox parms
            cr.set_font_size(font_size)
            cr.select_font_face("Sans", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_NORMAL)
            # FIXME (below)
            if (label == ''):
                msg = "WARNING neva-2 crashes when label=''; "\
                      + "changing to label=' '\n"
                print_once(msg)
                label = ' '
            (text_ulx, text_uly, text_w, text_h, nextx, nexty) = cr.text_extents(label)
            # print "fs=%f" % font_size

            # font_size more reliable than text_extents for textbox height!
            # text_extents("2") yields height=4, text_extents("0") gives 5(!!)
            fudge = -reg_height/4.0 # HACK ALERT!
            text_h = font_size + fudge

            # Calculate x coord of LL corner of text box
            regcenter_x = reg_ulx + reg_width/2
            textbegin_llx = regcenter_x - text_w/2 - text_ulx

            # Caclulate y coord of LL corner of text box
            regcenter_y = reg_uly + reg_height/2
            textbegin_lly = regcenter_y + text_h/2 # + text_h + text_uly/2

            # drawdot(cr, textbegin_llx, textbegin_lly, 'blue')

            cr.move_to(textbegin_llx, textbegin_lly)
            cr.show_text(label)
            cr.stroke();
            cr.restore()

    if (A and re.search("^[0-9r]",A)): draw_pe_reg(cr, A, "A")
    if (B and re.search("^[0-9r]",B)): draw_pe_reg(cr, B, "B")

def drawtileno(cr, tileno):

    if TILE_LIST[tileno].type == None:
        sys.stderr.write('WARNING cannot/will not draw nonexistent tile 0x%02x\n' % tileno)
        return

    cr.save()
    # stoopid keywords ghost number ghost-number ghost_number
    # Put a big ghost number in top-left corner of tile
    # See https://www.cairographics.org/manual/cairo-text.html#cairo-text-extents

    # Needs to be a string.
    tileno = str(tileno)

    # Ghost color= light gray
    # setcolor(cr, 'ghostgray')

    graylevel = 0.5; cr.set_source_rgb(graylevel,graylevel,graylevel)

    cr.set_font_size(20)
    cr.select_font_face("Sans", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_BOLD)

    # E.g. cr.text_extents("100") => (3, -15, 38, 15, 42, 0) => (UL(x,y), w, h, begin_next(x,y)
    # print cr.text_extents(tileno)
    (text_ulx, text_uly, text_w, text_h, nextx, nexty) = cr.text_extents(tileno)

#     # For centered text
#     centerx = CANVAS_WIDTH/2
#     centery = CANVAS_HEIGHT/2
# 
#     x = centerx - text_w/2 - text_ulx
#     y = centery + text_h/2

    # For left-justified
    x = PORT_LENGTH + 0.5*text_h; y = PORT_LENGTH + 1.5*text_h


    # cr.set_source_rgb(1,0,0); drawdot(cr, centerx, centery, 'red'
    # cr.set_source_rgb(0,0,1); drawdot(cr, x+text_ulx, y+text_uly, 'blue')
    # cr.set_source_rgb(1,0,1); drawdot(cr, x, y, 'purple')

    cr.move_to(x,y)
    cr.show_text(tileno)
    cr.stroke()

    # Also useful to print out (r,c)
    cr.set_font_size(12)
    cr.move_to(x,y+15)
    cr.show_text("%d,%d" % tileno2rc(tileno))
    cr.stroke()

    cr.restore()

# Draw tile outline
def drawtile(cr):
    cr.save()
    setcolor(cr,'black')
    cr.set_line_width(.5)
    w = CANVAS_WIDTH  - 2*PORT_HEIGHT
    h = CANVAS_HEIGHT - 2*PORT_HEIGHT
    (ULx,ULy) = (PORT_HEIGHT,PORT_HEIGHT)
    cr.rectangle(ULx,ULy,  w, h) # ULx, ULy, width, height
    cr.stroke()
    cr.restore()

# Draw memtile outline
def drawmemtile(cr):
    cr.save()
    setcolor(cr,'black')
    cr.set_line_width(.5)
    (ULx,ULy) = (PORT_HEIGHT,PORT_HEIGHT)
    w = CANVAS_WIDTH  - 2*PORT_HEIGHT
    h = 2*CANVAS_HEIGHT - 2*PORT_HEIGHT
    cr.rectangle(ULx,ULy,  w, h) # ULx, ULy, width, height
    cr.stroke()
    cr.restore()

def get_connection_type(c):
    # connection type will be one of "port" "pe_in" "pe_out" "const"

    # Okay right order matters, this one should go before pe_in search obviously
    # ?? What idiot is writing these comments!!???  Oh wait it's me

    # if re.search(",",c): return "pe"
    # if re.search("^[oi],*",c): return "port"
    # if re.search("wire.|reg.",c): return "pe_in"

    # For connections of the form "MUL(wireA,regB)" or "MUL(wireA,0x0002)"
    # parse = re.search("^(.*).(wire.|reg.|[0-9].*),(wire.|reg.|[0-9].*)", connection)
    type = "unknown"
    if   (c == "pe_out"):           type = "pe_out"
    elif re.search(",",c):          type = "pe"
    elif re.search("^[oi],*",c):    type = "port"
    elif re.search("^sb_wire_[oi],*",c):    type = "port"
    elif re.search("wire.|reg.",c): type = "pe_in"
    elif re.search("^0x",c):        type = "const"

    # FIXME/hack map din == pe_in for now, but it be UUUUGLYYYY etc.
    # Why it's bad: din is the one-bit input (not currently drawing one-bits!)
    # Eventually need separate pe_in_bus and pe_in_bit or something
    elif (c == "din"):
        type = "pe_in"
        print_once( "\nWARNING MEMHACK modeling '%s' as '%s'" % (c, type) )
    elif (c == "mem_out"):
        type = "pe_out"
        print_once( "\nWARNING MEMHACK modeling '%s' as '%s'" % (c, type) )

    elif (c == "pe_out_p"):
        type = "pe_out"
        print "ERROR Don't know what to do with '%s' (yet)" % c
        print "Will attempt recovery; modeling '%s' as '%s'" % (c,type)
        print ""


    elif c=='wdata': type = 'pe_in'
    elif c=='rdata': type = 'pe_out'

    # elif (c == "wen" or c == 'wdata'):
    # elif c in ("wen", 'wdata', 'rdata'):
    elif c in ("wen"):
        print c
        type = "pe_in"
        print "ERROR Don't know what to do with '%s' (yet)" % c
        print "Will attempt recovery; modeling '%s' as '%s'" % (c,type)
        print ""

    else:
        print "ERROR Unknown type for connection '%s'" % c
        sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
        sys.exit(-1)

    DBG=0
    if DBG: print "GCT connection '%s' = type '%s'" % (c, type)
    return type

# FIXME/TODO Not used presently I think.  Do we keep it?
# At this point, it probably wouldn't work even if it did get turned on...
def drawgrid(cr):

    cr.save()

    cr.set_line_width(.1)
    # cr.set_dash((1,1), 0) # on/off array, length of dashes, begin
    b = 0.8 # brightness
    # cr.set_source_rgb(b,b,0) # ghostly yellow
    # cr.set_source_rgb(0,0,0)
    setcolor(cr,'black') # black for debug

    ntracks_v = NTRACKS_PE_BUS_V + NTRACKS_PE_WIRE_V
    ntracks_h = NTRACKS_PE_BUS_H + NTRACKS_PE_WIRE_H
    pwid = PORT_WIDTH; plen = PORT_HEIGHT

    # NW corner
    print "Drawing NW corner"
    cr.rectangle(0,0,  plen,plen) # ULx, ULy, width, height
    # cr.stroke()

    # 2nh+3 port boxes
    nboxes = 3 + 2 * ntracks_h;
    print "Drawing %d port boxes" % nboxes
    print "plen = %d, pwid = %d" % (plen,pwid)
    cr.move_to(0,0)
    for i in range (0, nboxes):
        (ULx,ULy) = (0, plen + i * pwid)
        # print "Box %2d at %d,%d  %d,%d" % (i, ULx, ULy, LRx,LRy)
        cr.rectangle(ULx, ULy, plen,pwid) # ULx, ULy, width, height

    ULx = 0;  ULy = plen
    for i in range (0, nboxes):
        print "Box %2d at %d,%d" % (i, ULx, ULy)
        cr.rectangle(ULx, ULy, plen,pwid) # ULx, ULy, width, height
        ULy = ULy + pwid
    # cr.stroke()

    # SW corner
    print "Drawing NW corner"
    cr.rectangle(ULx,ULy,  plen,plen) # NW(x,y),  SE(x,y)
    cr.stroke()

    cr.restore()

def find_tile_center(tileno):
    '''
    Return (x,y) = dead center of tile 'tileno'
    '''
    DBG=0
    scaled_array_pad     = UL_MARGIN     * CUR_SCALE_FACTOR
    scaled_canvas_width  = CANVAS_WIDTH  * CUR_SCALE_FACTOR
    scaled_canvas_height = CANVAS_HEIGHT * CUR_SCALE_FACTOR
    if DBG: print "Calculated win width is...%d...?" % \
          (4 * scaled_array_pad + 8 * scaled_canvas_width)
    if DBG: print "Original win width was...%d...?" % \
          (4 * UL_MARGIN + 8 * CANVAS_WIDTH)

    pad = scaled_array_pad
    col = TILE_LIST[tileno].col
    row = TILE_LIST[tileno].row

    x = pad + col * scaled_canvas_width  + scaled_canvas_width/2
    y = pad + row * scaled_canvas_height + scaled_canvas_height/2

    if DBG: print "x is %d" % x; print "pad is %d" % pad

    return (x,y)

# def zoom_to_tile2(tileno):
#     '''
#     Button-press event calls zoom_to_tile1() to queue up the zoom.
#     Later, draw event calls zoom_to_tile2(), which does final scroll-adjust for the zoom.
# 
#     '''
#     print "Zoom in to tile %s!" % str(tileno)
# 
#     (x,y) = find_tile_center(tileno)

#     (hadj,vadj) = (SW.get_hadjustment(),SW.get_vadjustment())
#     if DBG: print "Window width now = %d" % hadj.upper
# 
#     # Each "value_changed" triggers a "draw" event I think...
#     # Seems to work fine w/o them
#     hadj.set_value(x); # hadj.value_changed()
#     vadj.set_value(y); # vadj.value_changed()
# 
#     if DBG:
#         u = hadj.upper; l = hadj.lower; v = hadj.value
#         print "AFTER AFTER AFTER: [%4d|-> %4d   <-| %-4d]\n" % (int(l), int(v), int(u))


def refresh():
    '''Redraw the entire canvas'''
    # https://stackoverflow.com/questions/14514374/force-pygtk-main-to-redraw
    da = CUR_DRAW_WIDGET
    da.queue_draw() # redraw
    rect = da.get_allocation()        
    da.window.invalidate_rect(rect, False) # refresh
    while gtk.events_pending(): gtk.main_iteration(False) # enforce

# Invaluable cairo drawing reference:
# http://pygtk.org/articles/cairo-pygtk-widgets/cairo-pygtk-widgets.htm
# Looks good but did not use: http://zetcode.com/gui/pygtk/
# Ditto for: http://pygtk.org/pygtk2tutorial/ch-DrawingArea.html

# Not used AFAICT
# global PREV_HUPPER; PREV_HUPPER = -1

def draw_handler(widget, cr):
    global CUR_DRAW_WIDGET; CUR_DRAW_WIDGET = widget;

    # FIXME probably don't need "cr" parm (above) anymore!
    context = widget.window.cairo_create()
    cr = context

    draw_all_tiles(cr);

# def set_zoom_scale_factor():
# 
#     # This is good enough...right?
#     # scale factor 4 means tile occupies same as four unzoomed tiles
#     global CUR_SCALE_FACTOR;
#     CUR_SCALE_FACTOR = 4.0;
# 
#     # Better: find current window dimensions;
#     # set zoom factor such that tile fits in current window plus some margin
#     # current window is CUR_WINDOW i think
# 
#     print "FOOOO CW = ", ; print CUR_WINDOW.get_width()
#     
# 
# 
#     return;

#     # OLD: Draw at 4x requested size; CUR_SCALE_FACTOR = 4
#     # NEW:
#     #   For now, unzoomed (grid) view is scaled to 2x (USF=2).
#     #   And zoomed (onetile) view is 2x of that.  Ish.
#     #   Except that, for no good reason, want the zoomed tile
#     #   to occupy the same space as four unzoomed tiles.
# 
#     # Canvas width = tile width + length of ports on each side
#     # In zoomed view, want width of one tile to match
#     # (two tiles + gap) in unzoomed (2x) view
#     # unzoomed_scale_factor = 2 # Scale factor for unzoomed tiles
#     unzoomed_scale_factor = 1/(0.5) # Scale factor for unzoomed tiles
#     tile_width            = CANVAS_WIDTH - 2*PORT_WIDTH
#     two_tiles_plus_gap_2x = (2*tile_width + 2*PORT_LENGTH)*unzoomed_scale_factor
#     fudge                 = .09 # yeah I dunno whatevs OCD OKAY?
#     CUR_SCALE_FACTOR = float(two_tiles_plus_gap_2x)/float(tile_width) + fudge

# def draw_one_tile(cr, tileno):
# 
#     # Save
#     global CUR_SCALE_FACTOR;
#     save_scale_factor = CUR_SCALE_FACTOR
#     cr.save()
# 
#     # scalefactor = 10 # zoom in for debugging
#     # cr.scale(scalefactor,scalefactor)
# 
#     ########################################################################
#     # Scale and translate
# 
#     set_zoom_scale_factor()
#     cr.scale(CUR_SCALE_FACTOR,CUR_SCALE_FACTOR)
# 
#     if (0): print "Zoom scale factor %d/%d = %f." \
#         % (two_tiles_plus_gap_2x, tile_width, CUR_SCALE_FACTOR)
# 
#     ########################################################################
#     # OLD: cr.translate(UL_MARGIN, UL_MARGIN) [draw tile such that UL corner is at (AP,AP)
#     # NEW: -----------------------------------------------------------------
#     # Translate so that zoomed tile corners match unzoomed tile corners
#     # Unzoomed corners were centered in window, and above scaling (supposedly)
#     # ensures that zoomed corners are same distance apart as unzoomed,
#     # so: should suffice to make sure zoomed corners are centered.
# 
#     # Things that were 40px wide in unzoomed view are now just 10px wide ish
#     scaled_win_width    = WIN_WIDTH/CUR_SCALE_FACTOR
#     scaled_canvas_width = CANVAS_WIDTH
#     print "sww=%0.2f scw=%0.2f" % (scaled_win_width,scaled_canvas_width)
#     xmargin = (scaled_win_width - scaled_canvas_width)/2
#     ymargin = xmargin
#     cr.translate(xmargin, ymargin)
# 
#     # Okay done with scale and translate.  Now draw!
#     if (0): print "...at scale factor %f." % CUR_SCALE_FACTOR
#     TILE_LIST[tileno].draw(cr)
# 
#     # Restore
#     cr.restore()
#     CUR_SCALE_FACTOR = save_scale_factor

global TILES_DRAWN_AT_LEAST_ONCE           # FIXME Yes this is awful
TILES_DRAWN_AT_LEAST_ONCE = False          # FIXME Yes this is awful
def draw_all_tiles(cr):
    DBG=0
    if DBG: print "Draw all tiles!"

    cr.save()
    cr.scale(CUR_SCALE_FACTOR,CUR_SCALE_FACTOR)
    cr.translate(UL_MARGIN, UL_MARGIN)     # Whitespace margin at top and left
    # draw_big_ghost_arrows(cr)            # Big ghost arrows in background of grid
                                           # view show general flow dir for tracks
    for tile in TILE_LIST:                 # Draw ALL the tiles
        if (tile): tile.draw(cr)           # uh...unless they don't exist :)

    global TILES_DRAWN_AT_LEAST_ONCE      # FIXME Yes this is awful
    TILES_DRAWN_AT_LEAST_ONCE = True      # FIXME Yes this is awful
    cr.restore()

def test_ports():  # Meh

    cr.save()
    cr.translate(UL_MARGIN, UL_MARGIN); cr.scale(2,2)
    if (0):
        drawport(cr, "in_s0t0", options="foo,bar,baz")
        drawport(cr, "out_s0t0", options="foo")

        drawport(cr, "in_s0t1")

        drawport(cr, "out_s1t0")
        drawport(cr, "in_s1t0")

        drawport(cr, "out_s2t0")
        drawport(cr, "in_s2t0")

        drawport(cr, "out_s3t0")
        drawport(cr, "in_s3t0")

    if (0):
        draw_all_ports(cr)

    tile = TILE_LIST
    tile[0].draw(cr)
    tile[1].draw(cr)
    tile[2].draw(cr)
    tile[3].draw(cr)

def get_icon_arrow():

    xpm_data = [
        # <width> <height> <colors> <char on pixel>
        "16 16 2 1",
        # Defining the two colors
        "       c None",          # clear
        ".      c #000000000000", # black
        # The pixels ----
        "                ",
        "                ",
        "    .           ",
        "    ..          ",
        "    ...         ",
        "    ....        ",
        "    .....       ",
        "    ......      ",
        "    ....        ",
        "    . ...       ",
        "       ..       ",
        "        ..      ",
        "        ..      ",
        "        ..      ",
        "                ",
        "                "
        ]

    # http://www.pygtk.org/pygtk2reference/class-gtkiconset.html
    # http://www.pygtk.org/pygtk2reference/class-gtkimage.html#method-gtkimage--set-from-pixbuf
    # pixbuf_new_from_xpm_data() segfaults if xpm_data has its commas wrong :(
    pixbuf = gtk.gdk.pixbuf_new_from_xpm_data(xpm_data)
    image = gtk.Image()
    image.set_from_icon_set(
        gtk.IconSet(pixbuf),
        gtk.ICON_SIZE_SMALL_TOOLBAR)

    # image.show() # why?
    return(image)


def get_cursor_magplus():

    xpm_data = [
        "15 15 3 1",
        "       c None",          # clear
        ".      c #000000000000", # white
        "X      c #FFFFFFFFFFFF", # black
        "               ",
        "               ",
        "               ",
        "               ",
        "      . .      ",
        "    .     .    ",
        "   .   .   .   ",
        "   .  ...  .   ",
        "   .   .   .   ",
        "    .     .    ",
        "      . . .    ",
        "           .   ",
        "            .  ",
        "             . ",
        "               "
        ]

    pixbuf = gtk.gdk.pixbuf_new_from_xpm_data(xpm_data)
    display = gtk.gdk.display_get_default()
    magplus = gtk.gdk.Cursor(display, pixbuf, 07, 7)
    global CUR_CURSOR
    CUR_CURSOR = 'magplus'
    return magplus

def get_cursor_magminus():

    xpm_data = [
        "15 15 3 1",
        "       c None",
        ".      c #000000000000",
        "X      c #FFFFFFFFFFFF",
        "               ",
        "               ",
        "               ",
        "               ",
        "      . .      ",
        "    .     .    ",
        "   .       .   ",
        "   .  ...  .   ",
        "   .       .   ",
        "    .     .    ",
        "      . . .    ",
        "           .   ",
        "            .  ",
        "             . ",
        "               "
        ]

    pixbuf = gtk.gdk.pixbuf_new_from_xpm_data(xpm_data)
    display = gtk.gdk.display_get_default()
    magminus = gtk.gdk.Cursor(display, pixbuf, 07, 7)
    global CUR_CURSOR
    CUR_CURSOR = 'magminus'
    return magminus

# FIXME These next two routines have a lot of overlap...
def set_button_image_zfc(button):
    xpm_data = [
        "15 15 3 1",
        "       c None",
        ".      c #000000000000",
        "X      c #FFFFFFFFFFFF",
        "               ",
        " .           . ",
        "  .  .   .  .  ",
        "   . .   . .   ",
        "    ..   ..    ",
        "  ....   ....  ",
        "               ",
        "               ",
        "               ",
        "  ....   ....  ",
        "    ..   ..    ",
        "   . .   . .   ",
        "  .  .   .  .  ",
        " .           . ",
        "               "
        ]
    tooltip = "show prev view"
    pixbuf = gtk.gdk.pixbuf_new_from_xpm_data(xpm_data)
    image = gtk.image_new_from_pixbuf(pixbuf)
    image.set_name("zoom_from_chip")
    image.show()
    button.add(image)
    button.set_tooltip_text(tooltip)
    
def set_button_image_ztc(button):
    xpm_data = [
        "15 15 3 1",
        "       c None",
        ".      c #000000000000",
        "X      c #FFFFFFFFFFFF",
        "               ",
        " .....   ..... ",
        " ..         .. ",
        " . .       . . ",
        " .  .     .  . ",
        " .   .   .   . ",
        "      . .      ",
        "               ",
        "      . .      ",
        " .   .   .   . ",
        " .  .     .  . ",
        " . .       . . ",
        " ..         .. ",
        " .....   ..... ",
        "               "
        ]
    tooltip = "show whole chip"
    pixbuf = gtk.gdk.pixbuf_new_from_xpm_data(xpm_data)
    image = gtk.image_new_from_pixbuf(pixbuf)
    image.set_name("zoom_to_chip")
    image.show()
    button.add(image)
    button.set_tooltip_text(tooltip)
    
# FIXME some of these are only called from class CGRAWin maybe
def toggle_chipzoom(button, image_name):
    if image_name == 'zoom_to_chip':
        set_button_image_zfc(button)
        zoom_to_chip()

    elif image_name == 'zoom_from_chip':
        set_button_image_ztc(button)
        zoom_from_chip()

# FIXME some of these are only called from class CGRAWin maybe
def get_button(widget, bname):
    vbox = widget.get_children()[0]
    top_toolbar = vbox.get_children()[0]
    for c in top_toolbar.get_children():
        if (c.get_name() == "mag100"): return c

# TODO someday maybe
# A GdkWindow is a rectangular region on the screen. It's a low-level
#  object, used to implement high-level objects such as
# GtkWidget and GtkWindow on the GTK+ level. A GtkWindow is a toplevel
# window, the thing a user might think of as a "window" with a titlebar
# and so on; a GtkWindow may contain many GdkWindow.

# https://en.wikibooks.org/wiki/PyGTK_For_GUI_Programming/First_Steps

# The gtk.VBox object can contain and organize multiple widgets into a
# Vertical column. Similarly, the gtk.HBox object is also available,
# organizing its child widgets into a Horizontal row. To create more
# sophisticated layouts, you can nest the container objects, i.e. have a
# gtk.HBox inside a gtk.VBox.

class CGRAWin(gtk.Window):
    def __init__(self):
        '''
        Set up the main window and connect to callback routine that draws everything.
        '''
        # DBG = 2

        def set_initial_window_size():
            # See above for definition of globals WIN_WIDTH, WIN_HEIGHT
            # resize() see http://pygtk.org/pygtk2reference/class-gtkwindow.html

            screen_width  = self.get_screen().get_width()
            screen_height = self.get_screen().get_height()
            desired_width  = min( WIN_WIDTH + 40, screen_width  - 40) # Extra for borders etc
            desired_height = min(WIN_HEIGHT + 40, screen_height - 40)

            self.resize(desired_width, desired_height)

        title = "Tilesy" # haha LOL haha
        gtk.Window.__init__(self)
        self.props.title = title

        # set_initial_scale_factor()
        # already done by initialize_tile_list...
        set_initial_window_size()

        # FIXME minimum width (above) should be based on screen height,
        # not just an arbitrary 600.
        # FIXME2 currently cannot resize window below requested w,h...why?

        # AFAICT only used in zoom_to_tile()
        # global ZOOMTILE; ZOOMTILE = -1 # Always start zoomed OUT

        da = gtk.DrawingArea()
        da.props.width_request = WIN_WIDTH
        da.props.height_request= WIN_HEIGHT
        # self.add(da)

        #         def focus_in(widget, event, adj):
        #             global ADJ; adj = ADJ
        #             adj.set_value(200.0)
        #             adj.value_changed()

        # White background for better contrast / less ink wastage when printing
        MAXCOLOR = 65535
        col = gtk.gdk.Color(MAXCOLOR,MAXCOLOR,MAXCOLOR)
        # col = gtk.Color('#fff') WRONG
        # col = gtk.gdk.Color('#fff') # fails on neva2
        da.modify_bg(gtk.STATE_NORMAL, col)

        ########################################################################
        # To toolbar FIXME should be separate function maybe
        # top_toolbar = build_toolbar()
        # def build_toolbar():

        # How to add icon images to buttons
        # https://stackoverflow.com/questions/2188659/stock-icons-not-shown-on-buttons

        # BUTTON: arrow
        # button_arrow   = gtk.Button("no zoom")
        tooltip =   "arrow tool:\n" \
                  + "  single-click to select/deselect a wire\n" \
                  + "  double-click for single-tile zoom in/out "
        button_arrow   = gtk.Button()
        image = get_icon_arrow()
        button_arrow.add(image)
        button_arrow.connect("clicked", self.button_arrow_action)
        button_arrow.set_tooltip_text(tooltip)
        button_arrow.show()


        # BUTTON: zoom-in magnifying glass
        # button_magplus = gtk.Button("+")
        tooltip = "magplus tool: zoom in and recenter"
        #
        image = gtk.Image()
        # image.set_from_stock(gtk.STOCK_ZOOM_IN, gtk.ICON_SIZE_SMALL_TOOLBAR)
        # gtk_image_set_from_stock() deprecated since version 3.10.
        # Use gtk_image_set_from_icon_name() instead.
        image.set_from_icon_name("zoom-in", gtk.ICON_SIZE_SMALL_TOOLBAR)
        image.show()
        #
        button_magplus = gtk.Button()
        button_magplus.add(image)
        button_magplus.connect("clicked", self.button_magplus_action)
        button_magplus.set_tooltip_text(tooltip)
        button_magplus.show()
        

        # BUTTON: zoom-out magnifying glass
        # button_magminus= gtk.Button("-")
        tooltip = "magminus tool: zoom out and recenter"
        #
        image = gtk.Image()
        # image.set_from_stock(gtk.STOCK_ZOOM_OUT, gtk.ICON_SIZE_SMALL_TOOLBAR)
        # gtk_image_set_from_stock() deprecated since version 3.10.
        # Use gtk_image_set_from_icon_name() instead.
        image.set_from_icon_name("zoom-out", gtk.ICON_SIZE_SMALL_TOOLBAR)
        image.show()
        #
        button_magminus= gtk.Button()
        button_magminus.add(image)
        button_magminus.connect("clicked", self.button_magminus_action)
        button_magminus.set_tooltip_text(tooltip)
        button_magminus.show()


        # BUTTON: zoom_to_chip
        button_mag100= gtk.Button()
        set_button_image_ztc(button_mag100)
        button_mag100.set_name("mag100")
        button_mag100.connect("clicked", self.button_mag100_action)
        button_mag100.show()


        # BUTTON: reset to default view
        button_reset= gtk.Button('         RESET')
        button_reset.connect("clicked", self.button_reset_action)
        button_reset.show()


        # BUTTON: grabby hand
        button_hand    = gtk.Button("grabby hand")

        # BUTTON: exit
        button_exit   = gtk.Button("exit")
        button_exit.connect("clicked", self.button_exit_action)
        button_exit.show()

        # Pack buttons into a toolbar on top
        expand = False; fill = False;
        top_toolbar = gtk.HBox()
        # neva-2 wants height 30; kiwi is happy with 25 FIXME
        top_toolbar.props.height_request = 30
        top_toolbar.pack_start(button_arrow,    expand, fill)
        top_toolbar.pack_start(button_magplus,  expand, fill)
        top_toolbar.pack_start(button_magminus, expand, fill)
        top_toolbar.pack_start(button_mag100,   expand, fill)
        top_toolbar.pack_start(button_reset,    expand, fill)
        # top_toolbar.pack_start(button_hand,   expand, fill)
        top_toolbar.pack_start(button_exit,     expand, fill)
        # print dir(top_toolbar.props)
        ########################################################################

        # Create a new scrolled window.
        scrolled_window = gtk.ScrolledWindow()
        scrolled_window.set_border_width(10)
        scrolled_window.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_ALWAYS)
        scrolled_window.add_with_viewport(da)
        scrolled_window.show() # FIXME What does this do??  Is it necessary?
        da.show()              # FIXME What does this do??  Is it necessary?
        
        vbox = gtk.VBox()
        vbox.pack_start(top_toolbar, expand, fill)
        vbox.pack_start(scrolled_window, True, True, 0)
        self.add(vbox)

        global SW
        SW = scrolled_window
        # scrolled_window = gtk.ScrolledWindow()
        adj = scrolled_window.get_vadjustment()
        # ... create child widget
        # da.connect('focus_in_event', focus_in, adj)
        # self.connect('focus_in_event', focus_in, adj)



        self.show()

        #       if (0):
        #           # Cannot set cursor until after show()!!
        #           # Change the cursor to a awful watch thing
        #           watch = gtk.gdk.Cursor(gtk.gdk.WATCH)
        #           self.window.set_cursor(watch)
        #           sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

        # A dumb way to keep track of the current window and drawing area widget
        # global CUR_WINDOW;      CUR_WINDOW = win;
        global CUR_DRAW_WIDGET; CUR_DRAW_WIDGET = da;
        
        # Some/all of this maybe doesn't belong in win init,
        # but oh well here it is for now anyway

        # win = self

        # "draw" event results in drawing everything on drawing area 'da'
        # draw_handler_id = da.connect("draw", draw_handler)
        draw_handler_id = da.connect("expose-event", draw_handler)

        # https://stackoverflow.com/questions/23946791/mouse-event-in-drawingarea-with-pygtk
        # http://www.pygtk.org/pygtk2tutorial/sec-EventHandling.html
        button_press_handler_id = da.connect("button-press-event", button_press_handler)

        # FIXME/TODO add to 0bugs and/or 0notes: gtk.gdk.BUTTON_PRESS_MASK = Gdk.EventMask.BUTTON_PRESS_MASK
        # da.set_events(Gdk.EventMask.BUTTON_PRESS_MASK)

        # da.set_events(gtk.gdk.EventMask.BUTTON_PRESS_MASK)
        da.set_events(gtk.gdk.BUTTON_PRESS_MASK)

        self.connect("delete-event", gtk.main_quit)

        # https://stackoverflow.com/questions/6718586/pygtk-hide-cursor
        # As stated in the PyGTK FAQ, you should set the cursor on the
        # realize signal. If you don't wait for the realize signal,
        # the gtk.gdk.window hasn't been created yet, so you can't
        # change the cursor.
        # 
        # self.connect("realize", self.realize_cb)
        # def realize_cb(self, widget): set_cursor()

    def button_arrow_action(widget, event):
        # Reset cursor back to normal (arrow)
        widget.window.set_cursor(None)
        global CUR_CURSOR
        CUR_CURSOR = 'arrow'

        # c = gtk.gdk.Cursor(gtk.gdk.ARROW)
        # widget.window.set_cursor(c)

    def button_magplus_action(widget, event):
        # OLD: zoom('in')
        c = get_cursor_magplus()
        widget.window.set_cursor(c)

    def button_magminus_action(widget, event):
        # OLD: zoom('out')
        c = get_cursor_magminus()
        widget.window.set_cursor(c)

    def button_mag100_action(widget, event):
        c = get_button(widget, 'mag100')
        image_name = c.get_children()[0].get_name()
        c.remove(c.get_children()[0])
        # print "FOO image name: "+image_name
        # BOOKMARK FIXME is this the only place we call toggle?  should we inline it here??
        toggle_chipzoom(c, image_name)

    def button_reset_action(widget, event):

        # Reset scale-factor, mag100
        button_mag100 = get_button(widget, 'mag100')
        button_mag100.remove(button_mag100.get_children()[0])
        set_button_image_ztc(button_mag100)
        global CUR_SCALE_FACTOR
        CUR_SCALE_FACTOR = INIT_SCALE_FACTOR
        zoom_to_chip()

        # Reset zoom_to_tile
        global ZTT_PREV
        ZTT_PREV = [0,0, 1.0, 'unzoomed']


    def button_exit_action(widget, event):
        gtk.main_quit()

def adjust_scrollbar(adj, amt, centered, DBG):
    if DBG:
        ps = adj.page_size
        pagewidth = int(WIN_WIDTH  * CUR_SCALE_FACTOR)
        hupper = adj.upper
        sf = pagewidth/hupper
        scaled_amt = sf * amt
        amt_prime = (scaled_amt-10) - adj.page_size/2
        print "  clicked x is ", ; print amt
        print "  value is    ", ; print adj.get_value()
        print "  hupper is    ", ; print hupper
        print "  pagewidth is ", ; print pagewidth
        print "  page_size is ", ; print ps
        print "  scale factor is", ; print sf
        print "  scaled  x = ", ; print scaled_amt
        print "  CUR_SCALE_FACTOR is    ", ; print CUR_SCALE_FACTOR
        print "  sf is                  ", ; print sf

    # Comment-out the centering (below) to debug maybe
    # Center it in the window
    if (centered == 'centered'): amt = amt - adj.page_size/2

    # print "about to adjust..."; sys.stdout.flush(); time.sleep(2)

    if DBG: print "Adjusting to",; print amt
    adj.set_value(amt)

    # THIS CAUSES REDRAW even though a zoom is coming...
    adj.value_changed()

    u = adj.upper; l = adj.lower; v = adj.value
    # print "AFTER  lvu = (%4d-> %4d    <-%-4d)" % (int(l), int(v), int(u))
    if DBG: print "[%4d|-> %4d   <-| %-4d]" % (int(l), int(v), int(u))
    # print "PAGESIZE %d" % ps
    if DBG: print ""

def recenter(x,y):
    '''
    Recenter on the given (x,y) coords.
    If calling after zoom, remember to use post-zoom amount e.g.
       zoom(1.2)
       recenter(1.2*x,1.2*y)
    '''
    # print "RECENTER  :",

    # Hide and show, otherwise jumps around disturbingly
    SW.hide();
    if (1):
        DBG=0
        if DBG: print "HADJUST   :",
        adjust_scrollbar(SW.get_hadjustment(), x, 'centered', DBG)
        # print "\nDRAWING AREA NOW (%d,%d)\n" % CUR_DRAW_WIDGET.get_size_request()

        DBG=0
        if DBG: print "VADJUST   :",
        adjust_scrollbar(SW.get_vadjustment(), y, 'centered', DBG)

    SW.show()
    return

    # print "ALLOCX", ; print SW.get_allocation().x
    # print "ALLOCX_DA", ; print CUR_DRAW_WIDGET.get_allocation().x

def zoom(sf):
    DBG=0
    global CUR_SCALE_FACTOR

    # round = DISASTER.  Why?  WHY??
    # CUR_SCALE_FACTOR = round(CUR_SCALE_FACTOR * sf, 1)

    CUR_SCALE_FACTOR = float(CUR_SCALE_FACTOR * sf)
    # print "magplus! 2 scale factor now %s" % str(CUR_SCALE_FACTOR)
    # float v. round doesn't seem to make much diff WRONG!  IDIOT!!
    # round gets stuck at (0.2 * (1.2,0.8)) = (0.2)
    
    (h,w) = CUR_DRAW_WIDGET.get_size_request()

    # global ZU1; ZU1 = SW.get_hadjustment().upper; print "pre-zoom hupper = " + str(ZU1)

    if DBG: print "ZOOM %sx :" % str(sf), # Usually sf is 0.8 or 1.2
    if DBG: print "Scale factor now %f" % CUR_SCALE_FACTOR
    if DBG: print "Drawing area size (%d,%d) " % (h,w),

    h = int(sf * h)
    w = int(sf * w)

    CUR_DRAW_WIDGET.set_size_request(h, w)
    if DBG: print "=> (%d,%d)\n" % (h,w)

    # These don't seem to be necessary?  Also, Each one causes a draw event I think.
    # SW.get_hadjustment().value_changed()
    # SW.get_vadjustment().value_changed()

    # global ACTUAL_SCALE; ACTUAL_SCALE = float(h)/hprev    # print "SF " + str(ACTUAL_SCALE)

def unscramble(x,y):
    '''
    Given (x,y) in current transformation space, return (x,y) for
    untransformed space such that (0,0) is TL corner of tile (0,0)
    '''
    DBG = 0
    if DBG: print "clicked on %d %d" % (x,y)
    if DBG: print "  UL_MARGIN = " + str(UL_MARGIN)
    if DBG: print "  CUR_SCALE_FACTOR = " + str(CUR_SCALE_FACTOR)

    unscaled_x = x/CUR_SCALE_FACTOR
    unbordered_unscaled_x = unscaled_x - UL_MARGIN

    unscaled_y = y/CUR_SCALE_FACTOR
    unbordered_unscaled_y = unscaled_y - UL_MARGIN
    if DBG: print "  Unbordered unscaled x,y = (%d,%d)" \
       % (unbordered_unscaled_x,unbordered_unscaled_y)

    return(unbordered_unscaled_x,unbordered_unscaled_y)

def find_rc_clicked(x,y):
    '''
    Find tile row, col corresponding to the given (x,y) coordinates
    '''
    DBG = 0
    (unbordered_unscaled_x,unbordered_unscaled_y) = unscramble(x,y)
    if DBG: print "  Unbordered unscaled x,y = (%d,%d)" \
       % (unbordered_unscaled_x,unbordered_unscaled_y)

    col = int(unbordered_unscaled_x/CANVAS_WIDTH)
    row = int(unbordered_unscaled_y/CANVAS_HEIGHT)
    return (row,col)

def find_tile_clicked(x,y):
    '''
    Find closest tile to the given (x,y) coordinates
    '''
    DBG=0
    if DBG>1: print "clicked on %d %d" % (x,y)
    (row,col) = find_rc_clicked(x,y)
    if DBG: print "I think you clicked the tile at (r%d,c%d)" % (row,col)
    # Find tile number indicated by (row,col)
    tileno = rc2tileno(row,col)
    if DBG: print "I think this is tile %d (r%d,c%d)" % (tileno, row,col)
    return tileno

def find_port_clicked(x,y):
    '''
    Find connected port nearest to given (x,y) coords.
    Return None if tile contains no valid (connected) ports.
    '''
    DBG=0
    (row,col) = find_rc_clicked(x,y)
    (TLx,TLy) = (col*CANVAS_WIDTH,row*CANVAS_HEIGHT)
    if DBG: print "Unscrambled TL corner of clicked tile is maybe (%d,%d)"\
          % (TLx,TLy)

    (ux,uy) = unscramble(x,y)
    if DBG: print "Unscrambled click-spot is maybe (%d,%d)" % (ux,uy)

    tileno = rc2tileno(row,col)
    (ux,uy) = (ux-TLx,uy-TLy)
    if DBG>1: print "So this is like (%d,%d) in tile %d" % (ux,uy,tileno)

    # If clicked in lower half of memtile, must add one tileheight to y
    ismem = (tiletype(tileno) == "memory_tile")
    if (ismem and (row%2)):
        uy = uy + CANVAS_HEIGHT
        if DBG: print "But it's a memory tile so...(%d,%d)" % (ux,uy)

    mindist = CANVAS_WIDTH
    minport = "UNKNOWN"
    
    DBG=0
    minwire = None
    dirlist = ("in", "out")
    if ismem: dirlist = ("in0", "in1", "out0", "out1")
    for dir in dirlist:
        for side in (0,1,2,3):
            for track in range (NTRACKS_PE_BUS_V): # FIXME what about BUS_H??
                portname = "%s_s%dt%d" % (dir,side,track)

                # BUT! Is portname valid?
                valid = TILE_LIST[tileno].is_connected(portname)
                vstr =           "..... NOT VALID"
                if valid: vstr = "VALID ........."
                if DBG>1: print "I think port '%8s' is %s" % (portname, vstr)
                if not valid: continue

                # DBG = (tileno == 3) and (re.search("out[01]_s2t0", portname))
                (x,y) = connectionpoint(tileno, portname)

                # Come on you know this
                (xd,yd) = (x-ux, y-uy)
                dist = math.sqrt(xd*xd+yd*yd)
                if DBG:
                    print "wire %8s = (%4d,%4d)" % (portname,x,y),
                    print       "me = (%4d,%4d)" % (ux,uy),
                    print     "dist = (%.1f)" % dist
                if (dist < mindist):
                    mindist = dist
                    minwire = portname
                    if DBG>1: print "=> %s is closest port so far" % (portname)

    # Note returns None if no valid ports found in tile
    if DBG: print "Closest port is maybe '%s'in tile %d?\n" % (minwire,tileno)
    return minwire

def print_scrolledwindow_info(SW):
    # sw value does not change with zoom in/out
    # dw gets larger when you zoom in
    (sh,sw) = SW.window.get_size()
    dw = CUR_DRAW_WIDGET.window.get_size()

    # PREV_HUPPER = SW.get_hadjustment().upper
    print ""
    print "------------------------------------------------------------------------"
    print "FOO screenwidth =? ",; print sw
    print "FOO screenwidth =? ",; print sw_w
    print "FOO screenheith =? ",; print sw_h
    print "FOO tilewidth   =? ",; print CANVAS_WIDTH
    print "FOO DAwidth     =? ",; print dw
    print ""
    print "FOO after_scale_zoom = ",; print after_scale_zoom
    print "------------------------------------------------------------------------"
    print ""

def how_many_tiles_are_visible_now():

        # Currently the window fits n tiles across/down where
        #   n = mindim / tilewidth, and
        #       mindim = min(sw_w,sw_h)
        #       tilewidth = CANVAS_WIDTH * CUR_SCALE_FACTOR
        #
        # E.g. typical startup values for an 8x8 grid are
        #   mindim = 557, CW = 164 and CSF = 0.5 (for 8x8)
        #   so as to fit 8 tiles across and down in a 600x600 ish window
        #
        # Want the window to show exactly ONE tile so need to scale by sf = n

        global SW # wtf? FIXME?
        sw_w = SW.get_hadjustment().page_size
        sw_h = SW.get_vadjustment().page_size

        mindim = min(sw_h,sw_w)
        tile_width = float(CANVAS_WIDTH) * CUR_SCALE_FACTOR
        ntiles_visible = mindim/tile_width
        sf_new = mindim/tile_width

        DBG=0
        if DBG:
            print_scrolledwindow_info(SW)
            print "FOO sf=%0.2f sfnew=%0.2f" % (sf,sf_new)
            CSF = CUR_SCALE_FACTOR; sw1 = min(sw_h,sw_w); CW = CANVAS_WIDTH; TW = tile_width
            # ntiles_visible_prezoom = CSF * sw1 / CW = sw1/TW
            ntiles_visible_prezoom = sw1/TW
            print "FOO tilewidth = %.2f, sw = %.2f" % (TW, sw1)
            print "FOO prezoom shows %.2f tiles in the window" % ntiles_visible_prezoom

        return ntiles_visible

def zoom_to_tile(x,y):
    DBG = 0
    tileno = find_tile_clicked(x, y)
    if DBG: print "Zoom in to tile %s!" % str(tileno)
    sf = how_many_tiles_are_visible_now()
    zoom(sf)
    # MUST refresh before recenter.
    refresh()
    (x,y) = find_tile_center(tileno)
    recenter(x,y)
    # refresh() # Don't need to refresh after recenter I guess

ZTT_PREV = [0,0, 1.0, 'unzoomed']
def toggle_zoom_to_tile(event):
    '''
    If not yet zoomed in, save current coords for later zoom-out and
    zoom in to clicked tile at event.(x,y)
    If already zoomed in, zoom out to saved coords and scale factor.
    '''
    DBG = 0
    global ZTT_PREV
    if ZTT_PREV[3] == 'unzoomed':
        # Save current view for later unzooming
        ZTT_PREV = [event.x, event.y, CUR_SCALE_FACTOR, 'zoomed']
        zoom_to_tile(event.x, event.y)

    else:
        # Restore to pre-zoom view
        [x,y,sf,z] = ZTT_PREV
        zoom(sf/CUR_SCALE_FACTOR)
        recenter(x,y)
        ZTT_PREV = [0,0, 1.0, 'unzoomed']

def get_scrollbars():
    hamt = SW.get_hadjustment().get_value()
    vamt = SW.get_vadjustment().get_value()
    return [hamt,vamt]

def set_scrollbars(h,v):
    SW.hide()
    SW.get_hadjustment().set_value(h); SW.get_hadjustment().value_changed()
    SW.get_vadjustment().set_value(v); SW.get_vadjustment().value_changed()
    SW.show()

def zoom_to_chip():
    '''
    Save current coords for later zoom-back, then
    zoom out so that entire chip is visible.
    '''
    global ZTC_PREV
    # Save current view for later unzooming
    [hamt,vamt] = get_scrollbars()
    ZTC_PREV = [CUR_SCALE_FACTOR, hamt, vamt]
    # print "FOO saved    sf %f and hv values %f,%f" % (CUR_SCALE_FACTOR, hamt, vamt)
    # Zoom all the way out
    zoom(INIT_SCALE_FACTOR/CUR_SCALE_FACTOR) # right?
    refresh() # Redraw after zoom! (optional probably)
    set_scrollbars(0,0)

def zoom_from_chip():
    '''Restore to pre-zoom view.'''
    # Retrieve and zoom to previously-saved coords
    [sf, hamt, vamt] = ZTC_PREV
    # print "FOO restored sf %f and hv values %f,%f" % (sf, hamt,vamt)
    zoom(sf/CUR_SCALE_FACTOR)
    refresh() # Redraw after zoom!
    set_scrollbars(hamt,vamt)

def trace_wire(tileno, portname, action):
    '''
    If 'action'=="highlight" and indicated wire 'portname'
    is already highlighted, do nothing.  Otherwise
      * highlight the wire
      * find connecting ports in same and neighboring tiles
      * recursively call highlight_wire on each.
    '''
    highlight = (action == "highlight")
    hlist = TILE_LIST[tileno].highlights

    DBG=0
    if (0):
        (tilefoo,wfoo) = (0, "out_s0t4")
        if (tileno == tilefoo) and (portname == wfoo):
            DBG=1; print "Tracing port '%s' in tile %d" % (wfoo,tilefoo)

    # If already in desired state, do nothing (return)
    if   (highlight)     and (portname     in hlist): return
    elif (not highlight) and (portname not in hlist): return

    if (highlight):
        hlist.append(portname)
        # if portname == 'in_1_s0t0':
        #     sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

        if DBG: print "FOO added '%s' to highlight-list for tile %d" % (portname,tileno)
    else:
        hlist.remove(portname)
        if DBG: print "FOO removed '%s' from highlight-list for tile %d" % (portname,tileno)

    if DBG: print "FOO Now hlist = %s" % str(hlist)

    # Highlight/unhighlight connected port in same tile
    cport = TILE_LIST[tileno].find_connected_ports(portname)
    for c in cport: trace_wire(tileno, c, action)

    # Highlight/unhighlight connected port in neighboring tile
    (adj_tileno,adj_wire) = find_matching_wire(tileno, portname)
    if (adj_wire): trace_wire(adj_tileno,adj_wire, action)

def toggle_highlight(tileno,portname):
    global TILE_LIST
    hlist = TILE_LIST[tileno].highlights
    if (portname in hlist):
        trace_wire(tileno,portname, "unhighlight")
    else:
        trace_wire(tileno,portname,   "highlight")
    refresh()

def button_press_handler(widget, event):
    double_click = (event.type == gtk.gdk._2BUTTON_PRESS)
    single_click = (event.type == gtk.gdk.BUTTON_PRESS)
    
    DBG=0
    if DBG and double_click: print "\ndouble click (%d,%d)" % (event.x,event.y)
    if DBG and single_click: print "\nsingle click (%d,%d)" % (event.x,event.y)

    # ZOOM TO TILE (ugh FIXME should be a separate routine)
    # Double click should ALWAYS be zoom-to-tile maybe
    # Nope that's just a mess
    # 
    global CUR_CURSOR
    if double_click and (CUR_CURSOR == 'arrow'):
        if DBG: print "zoom to tile"
        toggle_zoom_to_tile(event)
        refresh() # Redraw after zoom
        # print "\n Z2 DRAWING AREA NOW (%d,%d)\n" % CUR_DRAW_WIDGET.get_size_request()

    elif single_click and (CUR_CURSOR == 'arrow'):
        # print "Where is the nearest wire to me?"
        tileno = find_tile_clicked(event.x, event.y)
        portname = find_port_clicked(event.x, event.y)
        if (portname):
            if DBG: print "I think you clicked near port '%s' in tile %d" % (portname,tileno)
            toggle_highlight(tileno,portname)
        else:
            if DBG: print "Found no valid ports in tile %d" % tileno

    # print "CC='%s'" % CUR_CURSOR
    elif single_click and (CUR_CURSOR == 'magplus'):
        DBG = 1
        if DBG: print "  clicked x = ", ; print event.x
        scale = 1.2
        zoom(scale)
        recenter(scale * event.x, scale * event.y)
        # recenter(100,0)
        # recenter(event.x, event.y)

    elif single_click and (CUR_CURSOR == 'magminus'):
        scale = 0.8
        zoom(scale)
        recenter(scale * event.x, scale * event.y)

#     # ZOOM TO TILE (ugh FIXME should be a separate routine)
#     # Only zoom on 1) normal (arrow) cursor and 2) double-click
# 
#     if event.type != gtk.gdk._2BUTTON_PRESS: return
#     if (CUR_CURSOR != 'arrow'): return
# 
#     print "zoom to tile"
#     zoom_to_tile(event)
# 
#     # Redraw after zoom
#     CUR_DRAW_WIDGET.queue_draw()

class Tile:

    # def __init__(self, tileno, rc):
    def __init__(self, tileno):

        # List of ports (wires) currently being highlighted e.g.
        # if ('out_s1t1' in highlights): setcolor(cr, red)
        self.highlights = []
        # self.highlights.append("in_s2t0") # To test it/them FIXME

        self.label          = ""     # E.g. "ADD", "MUL", "I/O"
        self.tileno         = tileno

        self.type = None
        (self.row,self.col) = (-1,-1)
        if cgra_info.tile_exists(tileno):
            self.type = cgra_info.tiletype(tileno)
            if self.type == 'gst': self.type = None

        if self.type != None:
            (self.row,self.col) = cgra_info.tileno2rc(tileno)

        # TODO could check to see that rc = cgra_info.tileno2rc(tileno)
        self.connectionlist = []

        # List of output wires that should be latched
        self.outreglist     = []

    def connect(self,connection):
        self.connectionlist.append(connection)

    def is_connected(self,portname):
        '''Return True is porname is connected to an active wire'''
        for c in self.connectionlist:
            parse = re.search("^([^ ]*) .* ([^ ]*)$", c)
            pto = parse.group(1); pfrom = parse.group(2)
            if portname in (pfrom,pto): return True
        return False

    def find_connected_ports(self,portname):
        '''Find the other end of the wire connected to "portname"'''
        DBG=0
        if (0): # GREAT for debugging
            (tileno,w) = (self.tileno,portname)
            (tilefoo,wfoo) = (3, ("sb_wire_in1_s3t2", "out0_s1t2", "in0_s0t2"))
            if (tileno == tilefoo) and (portname in wfoo):
                DBG=1; print "\nWho's connected to tile %d wire '%s'?" % (tileno,w)
                self.printprops();

        rval = []
        for c in self.connectionlist:
            parse = re.search("^([^ ]*) .* ([^ ]*)$", c)
            pto = parse.group(1); pfrom = parse.group(2)

            # Note a wire can connect to TWO other wires e.g.
            #              sb_wire_in1_s3t2 <= in0_s0t2
            # out1_s0t2 <= sb_wire_in1_s3t2
            if   (pto   == portname): rval.append(pfrom)
            elif (pfrom == portname): rval.append(pto)

        if False: # for debugging DOT print things
            t = self.tileno
            if rval: print "      T%s: '%s' is connected to %s" % (t, portname,rval)
            else   : print "      T%s: '%s' is connected to NOHBODY" % (t, portname)

        if DBG:
            if rval: print "\n'%s' is connected to %s" % (portname,rval)
            else   : print "\n'%s' is connected to NOHBODY" % (portname)

        return rval

    def printprops(self):
        print "Tile %d (r%d,c%d)" % (self.tileno, self.row, self.col)
        indent = "  "
        print indent + ("\n"+indent).join(sorted(self.connectionlist))

    # TODO/FIXME need at least one more pass on drawport() below!

    # Called from: pe_out_connect and ...?
    # E.g. 'drawport(cr, "out_s1t0")' or 'drawport(cr, wirename, options="ghost")'
    def drawport(self, cr, wirename, **keywords):
        DBG = 0

        # if (self.tileno == 3) and (wirename == "in0_s0t4"):
        #     DBG=1; print "FOO HERE IT IS.  Highlights = " + str(self.highlights)

#         if wirename in self.outreglist:
#             print "HO! I see a wire that should be registered"
#             print "    Tile %d wire '%s'" % (self.tileno, wirename)
#             print ""

        # Draw the port for the indicated wire in the context of the current canvas
        # Ports are labeled arrows; input ports point in to the tile and
        # output ports point out.
        # connectionpoint() will tell where to start (for outputs) or end (for inputs)
        # [Optionally] options='leave off the label
        # options='ghost' => draw lightly

        # NEVER USED (right?)
        # [Optionally] options='reg' => attach a register to the port inside the tile.

        if DBG: print "Drawing port for wire '%s'..." % (wirename)

        # Only valid option so far is "ghost", meaning draw the port in light background color
        # TODO: options for reg/noreg, label/nolabel

        optionlist = []
        if ('options' in keywords):
            if DBG: print 'options parameter found, it is ', keywords['options']
            optionlist = keywords['options'].split(',')
            if DBG: print "Found the following options: "+ str(optionlist)
            # for o in options: print "  " + o
        else:
            if DBG: print 'no options parameter, sorry'

        cr.save()

        if (1):
            # Translate and rotate the world...
            # if DBG: print "Translate to %d,%d" % (x,y),
            (x,y) = connectionpoint(self.tileno, wirename)
            cr.translate(x,y)
            drawdot(cr, 0, 0, "black") # Mark the connection point with a black dot

            # if (wirename == "sb_wire_out_1_BUS16_3_0"): print "FOO x,y is %d,%d" % (x,y)

            # Side 0,1,2,3 out-wires point E, S, W and N respectively
            s = side(wirename)
            rot = s * 3.1416/2
            if DBG: print "rotate %d degrees\n" % int(180*rot/3.1416)
            cr.rotate(rot)

            # Now origin is connection point and world is oriented to the appropriate side

            # This should be, like "if (arrow)"
            if (1):
                ########################################################################
                # Arrow

                cr.save()
                setcolor(cr, 'blue') # Blue arrows (unless ghost)
                if ('ghost' in optionlist): cr.set_source_rgb(.8,.8,1) # slightly darker ghost
                highlight = (wirename in self.highlights)
                if highlight:
                    # print "FOO arrow should be RED"
                    setcolor(cr, 'red')

                # Thick and thin arrows for buses vs. tracks
                # For demonstration purposes,
                # tracks 0-2 are buses (thick) and tracks 3,4 are wires (thin)
                # FIXME maybe should hav global parms LINEWIDTH_BUS LINEWIDTH_WIRE
                if (track(wirename) < 3): linewidth = 1.0;
                else:                     linewidth = 0.5;
                cr.set_line_width(linewidth)

                (ahl,ahw) = (ARROWHEAD_LENGTH, ARROWHEAD_WIDTH)

                margin = 2*linewidth

                # Flip the sense of the arrow for "in" wires
                flip = False;
                if (inout(wirename) == "in"): flip = (not flip);

                if (flip):
                    cr.translate(PORT_HEIGHT,0)
                    cr.rotate(3.1416)

                fill = False
                ahl = ahl + margin
                # FIXME shouldn't need margin...right? Should be baked in to draw_arrow...yessss?
                draw_arrow(cr, PORT_HEIGHT-margin, ahl, 2*ahw, fill)
                cr.restore()


            # if (1):
            # if ('reg' in optionlist):
            if wirename in self.outreglist:
                ########################################################################
                # Register

                cr.save()
                # setcolor(cr, "red")
                setcolor(cr, "black")
                # cr.set_line_width(.2)
                cr.set_line_width(1.0)
                # cr.set_line_width(.5)

                # rh = REG_HEIGHT  # I know, I know
                # rw = REG_WIDTH

                rh = 2*REG_HEIGHT  # I know, I know
                rw = 2*REG_WIDTH

                # Copied from draw_pe
                (pe_w,pe_h) = (PE_WIDTH,PE_HEIGHT)
                headwidth   = 3    # see how it looks
                headlength  = 2 #reg_height/3
                reg_width  = 0.4*pe_w
                reg_height = 6 # for now, say
                reg_sep    = headlength+1 # Gap b/w reg and PE

                rh = reg_height; rw = reg_width

                # (ULx,ULy) = (0, -REG_WIDTH/2)
                # (ULx,ULy) = (0, -rw/2)
                (ULx,ULy) = (-reg_sep, -rw/2)

                cr.translate(ULx,ULy)
                # cr.translate(ULx,ULy)

                # Drawreg default is to draw horizontal;
                # but this routine's default is oriented to side 0 (90d cw)
                cr.rotate(PI/2)

                # h = 2*REG_HEIGHT  # I know, I know
                # w = 2*REG_WIDTH

                # drawreg(cr, rw,rh, 'blue')
                # drawreg(cr, rw,rh, 'red')
                drawreg(cr, rw,rh, 'red')

                cr.stroke()
                cr.restore()



            # should be "if (option[label])
            if (1):
                ########################################################################
                # Label

                cr.save() # Save early, save often

                # Label color: light gray for "ghost" text, otherwise just red
                # FIXME Areall the ghostgrays different!!?  Should they be??
                setcolor(cr, 'red')
                if ('ghost' in optionlist): cr.set_source_rgb(1,.8,.8)  # darker light gray

                # Position: one pixel in, and just high enough to clear the arrowhead
                (x,y) = (1, -ARROWHEAD_WIDTH)
                # drawdot(cr,x,y,"blue"); drawdot(cr,0,0,"red")

                # Unrotate side 2 (west) else they will be upsie-down!
                if (side(wirename)==2):
                    cr.rotate(PI);
                    cr.translate(-PORT_HEIGHT, 0)

                # "input" wires get moved to right to get out of the way of the arrowhead
                # Unless they're on the W side (side 2) in which case they're okay b/c unrotate above
                if (inout(wirename) == "in"):
                    if (side(wirename) != 2): x = x + (ARROWHEAD_LENGTH + 1)

                # Could I think use "text_path" to e.g. right-justify labels etc.
                cr.set_font_size(2.5)
                # cr.select_font_face("Sans", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_BOLD)
                cr.select_font_face("Sans", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_NORMAL)
                cr.move_to(x,y)
                cr.show_text(wirename)
                cr.stroke()
                cr.restore()

        cr.restore()

    # Called from Tile.connectwires ONLY
    # def manhattan_connect(cr, xy1, xy2):
    def manhattan_connect(self, cr, outport, inport):

        # BACKWARDS: outport="out_s2t0" inport="in_s3t0"

        #     cr.save()
        #     (x,y) = connectionpoint("out_s2t0")
        #     drawdot(cr,x,y,'red')
        #     cr.stroke(); cr.restore()

        # Given two points (x1,y1) and (x2,y2) on tile edge, draw
        # a manhattan connection through the interior of the tile.
        # Put a dot at the corner when the wire turns (you'll thank me later)

        (x1,y1) = connectionpoint(self.tileno, outport)
        (x2,y2) = connectionpoint(self.tileno, inport)

        DBG = 0
        if DBG: print "tileno=%d inport='%s' outport='%s'" \
           % (self.tileno, inport, outport)

        # Only draw non-ghost ports if connections exist.
        # self.drawport(cr, outport, options='reg');
        self.drawport(cr, outport);
        self.drawport(cr, inport)

        # drawdot(cr,x1,y1,'red'); drawdot(cr,x2,y2,'red')

        # Find internal join point
        # x1 == +/- PORT_HEIGHT means x1 is an edge and x2 is interior
        if   (x1 ==  PORT_HEIGHT): interior = (x2,y1)
        elif (x1 == -PORT_HEIGHT): interior = (x2,y1)
        else:                      interior = (x1,y2)

        # if (outport == "sb_wire_out_1_BUS16_3_0"): print "FOO1 interior = %s" % str(interior)

        # Maybe it works better if join point goes a little bit in toward the
        # two respective incoming sides

        k=2
        sx1 = k*x1/abs(x1) # sign(x1)
        sx2 = k*x2/abs(x2) # sign(x2)

        sy1 = k*y1/(y1) # sign(y1)
        sy2 = k*y2/(y2) # sign(y2)

        if   (abs(x1) ==  PORT_HEIGHT): interior = (x2-sx1,y1+sy2)
        else:                           interior = (x1-sx2,y2-sy1)

        (join_x,join_y) = (0,0)

        k=PORT_WIDTH/3.0
        l_edge = PORT_HEIGHT
        r_edge = CANVAS_WIDTH-PORT_HEIGHT
        t_edge = PORT_HEIGHT
        b_edge = CANVAS_HEIGHT-PORT_HEIGHT
        if   (x1 == x2):     join_x = x1
        elif (x1 == l_edge): join_x = x2-k
        elif (x1 == r_edge): join_x = x2+k
        elif (x2 == l_edge): join_x = x1-k
        elif (x2 == r_edge): join_x = x1+k

        if   (y1 == y2):     join_y = y1
        elif (y1 == t_edge): join_y = y2-k
        elif (y1 == b_edge): join_y = y2+k
        elif (y2 == t_edge): join_y = y1-k
        elif (y2 == b_edge): join_y = y1+k

        interior = (join_x,join_y)

        # if (outport == "sb_wire_out_1_BUS16_3_0"): print "FOO2 interior = %s" % str(interior)
        # if (outport == "sb_wire_out_1_BUS16_3_0"):
        #     print "begin here: %s" % str((x1,y1))
        #     print "then  here: %s" % str(interior)
        #     print "end   here: %s" % str((x2,y2))

        # FIXME hackity hack hack hack FIXME
        # hack for when a lower wire connects to an upper wire in a memory tile
        # omg i'm losing it
        # if (interior[1] == 0): interior[1] = CANVAS_HEIGHT
        # FIXME "TypeError: object does not support item assignment" on neva-2!!?
        interior_x = interior[0]; interior_y = interior[1]
        if (interior_y == 0):
            # print "interor y = zero means a mem-sb1 connection"
            # print "inport '%s' => outport '%s' in tile %d" % (inport, outport, self.tileno)

            (y1_prev,y2_prev) = (y1,y2)


            # YOU'RE ON PROBATION BUSTER!
            if re.search("^sb_wire_in_1_", outport):
                print "ERROR did not rewrite '%s'" % wirename
                sys.exit(-1)
                y1 -= PORT_HEIGHT
                # print "subtracting from y1 was %d now %d" % (y1_prev,y1)
            elif re.search("^sb_wire_out_1_", inport):
                print "ERROR did not rewrite '%s'" % wirename
                sys.exit(-1)
                y2 -= PORT_HEIGHT
                # print "subtracting from y2 was %d now %d" % (y2_prev,y2)




            # FIXME this could be better
            (interior_x,interior_y) = (x1,y1)
            # print ""

        # Okay now connect the dots!  With a blue line.  Unless highlighting.
        # TODO if (isbus): linewidth = 1 etc.
        if (1):
            highlight = (outport in self.highlights) or (inport in self.highlights)
            (linewidth,color) = (0.5,'blue');
            if highlight: (linewidth,color) = (1.0,'red')

            cr.save()
            setcolor(cr,color)
            cr.set_line_width(linewidth)
            # drawdot(cr,interior[0],interior[1],'blue')
            cr.move_to(x1,y1)
            cr.line_to(interior_x,interior_y)
            cr.line_to(x2,y2)
            cr.stroke()
            cr.restore()

    # called from Tile.connectwires() ONLY
    # E.g. ab_connect(cr, "in_s3t0", "wireA")
    def ab_connect(self, cr, inport, PE_input, highlight=False):
        DBG=0;
        if (TILES_DRAWN_AT_LEAST_ONCE): DBG=0

        if DBG: print "AB connecting wire '%s' to pe_in wire '%s'" % (inport, PE_input)
        (x1,y1) = connectionpoint(self.tileno, inport)

        if (PE_input == "wireA"): (x2,y2) = (PE_AX,PE_AY)
        else:                     (x2,y2) = (PE_BX,PE_BY)

        self.drawport(cr, inport)

        # FIXME/TODO:
        # Parms (blue, .5 etc.) should be global and shared w/ manhattan_connect etc. below
        if (1):
            highlight = (inport in self.highlights)
            (linewidth,color) = (0.5,'blue');
            if highlight: (linewidth,color) = (1.0,'red')

            cr.save()
            # setcolor(cr,'blue')
            # cr.set_line_width(.5)
            # drawdot(cr,x2,y2,'blue')
            setcolor(cr,color)
            cr.set_line_width(linewidth)
            drawdot(cr,x2,y2,color)
            cr.move_to(x1,y1)
            cr.line_to(x2,y2)
            cr.stroke()
            cr.restore()

    # called from Tile.connectwires() ONLY
    def pe_out_connect(self, cr, outport):
        (x1,y1) = (PE_OUTX,PE_OUTY)
        (x2,y2) = connectionpoint(self.tileno, outport)

        # Draw a non-ghost output port
        # self.drawport(cr, outport, options='reg');
        self.drawport(cr, outport);

        # Draw wire connecting pe to output port
        # FIX<E/TODO should be shared w/other connect routines!
        if (1):
            highlight = (outport in self.highlights)
            (linewidth,color) = (0.5,'blue');
            if highlight: (linewidth,color) = (1.0,'red')

            cr.save()
            setcolor(cr,color)
            cr.set_line_width(linewidth)
            drawdot(cr,x2,y2,color)
            cr.move_to(x1,y1)
            cr.line_to(x2,y2)
            cr.stroke()
            cr.restore()

    # Called from Tile.draw() ONLY
    def connectwires(self, cr, connection):

        # Draw a manhattan blue line connecting the two indicated ports inside a tile
        # I've given a lot of leeway as to how connections are specified.
        # E.g. these should all work for connection parm:
        #     "in_s3t0 => out_s2t3"
        #     "in_s3t0 out_s2t3"
        #     "in_s3t0 connects to out_s2t3"
        #     "  in_s3t0 connects to out_s2t3  "
        #     "wireA <= in_s3t0"
        #     "pe_out <= MUL(wireA,wireB)"
        #     "pe_out <= ADD(0x0002,0x0000)"


        DBG = 0;

        # Find the names of the two wires to connect.
        # parse = re.search( "([A-z_0-9]+).*[^A-z_0-9]([A-z_0-9]+)[^A-z_0-9]*$", connection)

        # A better way?
        connection = connection.strip() # Eliminate leading/trailing space

        # parse = re.search("^(o[^ ]*) .* (i[^ ]*)$", connection)
        parse = re.search("^([^ ]*) .* ([^ ]*)$", connection)
        pto = parse.group(1); pfrom = parse.group(2)

        # connection type will be one of "port" "pe_in" "pe_out" "const" (more?)

        to_type   = get_connection_type(pto)
        from_type = get_connection_type(pfrom)

        if DBG: print "CONNECT to '%s' from '%s'" % (pto,pfrom)

    #     if (pfrom == 'mem_out'):
    #         print "FOO okay found FROM 'mem_out' type '%s' in tile %d" % (from_type,self.tileno)
    #         print "FOO connects TO '%s' type '%s'" % (pto, to_type)

        DBG=0
        if (DBG>1): print "FOO1 %s - %s" % (to_type, from_type)
        # For connections of the form "out_s0t0 <= in_s1t0"
        if (to_type == "port" and from_type == "port"):
            w1 = pto; w2 = pfrom
            if DBG:
                print "CW connection = " + connection
                print "CW connecting wires '%s' and '%s'\n" % (w1,w2)

            # Draw a blue rectilinear line connecting w1 and w2 ports
            self.manhattan_connect(cr, pto, pfrom)
            return True;

        # still in Tile.connectwires()

        if (DBG>1): print "FOO2 %s - %s" % (to_type, from_type)
        # For connections of the form "wireA <= in_s3t0"
        if (to_type == "pe_in" and from_type == "port"):
            DBG=0
            # if (self.tileno == 0): DBG=1
            if DBG: print "CW found valid connection %s" % connection
            if DBG: print "CW connecting port '%s' to pe_in '%s'" % (pfrom,pto)
            self.ab_connect(cr, pfrom, pto)
            return True;

        # still in Tile.connectwires()

        if (DBG>1): print "FOO3 %s - %s" % (to_type, from_type)
        # For connections of the form "out_s1t0 <= pe_out"
        if (to_type == "port" and from_type == "pe_out"):
            DBG = 0;
            if DBG: print "CW/pe_out found valid connection %s" % connection
            self.pe_out_connect(cr, pto)
            return True;

        if (DBG>1): print "FOO4 %s - %s" % (to_type, from_type)
        # For connections of the form "pe_out <= MUL(wireA,regB)" or "pe_out <= MUL(wireA,0x0002)"
        # parse = re.search("^(pe_out) .* (.*).(wire.|reg.|[0-9].*),(wire.|reg.|[0-9].*)", connection)
        if (from_type == "pe"):
            DBG = 0;
            if (TILES_DRAWN_AT_LEAST_ONCE): DBG=0
            if DBG: print "CW/pe found valid connection %s" % connection
            parse = re.search("^(.*)[(](wire.|reg.|[0-9].*),(wire.|reg.|[0-9].*)[)]", pfrom)
            pe_name = parse.group(1)
            pe_a    = parse.group(2)
            pe_b    = parse.group(3)
            if DBG: print "Found PE '%s' w/ inputs a='%s' b='%s'" % (pe_name,pe_a,pe_b)

            if (pe_name == "INPUT"): pe_name = "IN"
            if (pe_name == "OUTPUT"): pe_name = "OUT"

            draw_pe(cr, pe_name, pe_a, pe_b)
            return True

            # TODO: draw_pe(pe_name) etc.
    #             if (self.col==0): draw_pe(cr, "ADD", regA=2, regB=0)

        else:
            # print "ERROR Do not understand connection %s (yet)" % connection
            return False


    # Todo: maybe two separate routines,
    # one for draw-in-grid and one for draw-standalone etc

    def draw_all_ports(self,cr):
        # ismem = (tiletype(self.tileno) == "memory_tile")
        ismem = (self.type == "memory_tile")
        dirlist = ("in", "out")
        if ismem: dirlist = ("in0", "in1", "out0", "out1")
        for side in (0,1,2,3):
            for dir in dirlist:
                if (side%2 == 0): ntracks = NTRACKS_PE_BUS_H + NTRACKS_PE_WIRE_H; # EW
                if (side%2 == 1): ntracks = NTRACKS_PE_BUS_V + NTRACKS_PE_WIRE_V; # NS
                for track in range(0,ntracks):
                    wirename = "%s_s%dt%d" % (dir, side, track)
                    self.drawport(cr, wirename, options="ghost")

    def draw(self, cr):
        if self.type == None: return

        cr.save()

        # If not zooming, draw relative to tile's col, row coords;
        # (otherwise draw tile at canvas' actual 0,0)
        # if (ZOOMTILE == -1):
        if (1):
            cr.translate(self.col*CANVAS_WIDTH, self.row*CANVAS_HEIGHT)

        # note draw_pe MUST HAPPEN BEFORE CALLING connectwires()
        # draw_pe() sets up join points for PE inputs

        draw_pe(cr, "setup_only", None, None)

        drawtileno(cr, self.tileno)
        # draw_pe(cr, "ADD", regA=2)
        if   (self.label == "OUT"): draw_pe(cr, "OUT", "wireA", None)
        elif (self.label == "MEM"): draw_pe(cr, "MEM", None, "wireB")
        elif (self.label != ""):    draw_pe(cr, self.label, None, None)
        # else:
        #     # if (self.col==0): draw_pe(cr, "ADD", "0x00002", "0x0000")
        #     # if (self.col==1): draw_pe(cr, "ADD", "0x00002", "wireB")
        #     if (self.col==2): draw_pe(cr, "ADDYO DADDY", "wireA", "wireB")
        #     if (self.col==3): draw_pe(cr, "FOO", "wireA", "regB")

        self.draw_all_ports(cr)
        for c in self.connectionlist:
            if (not self.connectwires(cr, c) and self.tileno == 0):
                print "ERROR Do not understand connection %s in tile %d (yet);" % (c, self.tileno)
                print "ERROR Removing '%s' from Tile %d connection list" % (c, self.tileno)
                # print "BEFORE: %s" % str(self.connectionlist)
                self.connectionlist.remove(c)
                # print "AFTER: %s\n\n\n" % str(self.connectionlist)

        # if (tiletype(self.tileno) == "memory_tile"):
        if (self.type == "memory_tile"):
            drawmemtile(cr)
        else: drawtile(cr)

        cr.restore()

def build_default_connection(tileno, out_wire):
    '''
    Output wire "out_wire" in tile "tileno" has not been explicitly
    connected, so we will show the default (zero) connection.
    '''
    # Should be easy.  Default connections for "out_s[123]t<T>" is "in_s0t<T>"
    # Default connection for "out_s0tT" is "in_s1tT"
    parse = re.search("out_s(\d+)t(\d+)", out_wire)
    if parse:
        out_side  = int(parse.group(1))
        out_track = int(parse.group(2))

        if (out_side == 0): in_side = 1
        else:               in_side = 0
        in_track = out_track;
        in_wire = "in_s%dt%d" % (in_side, in_track)

        if (0): print "Connecting out_wire %s to in_wire %s" % (out_wire, in_wire)
        newconnection = "%s => %s" % (in_wire, out_wire)
        print "Tile %d add missing connection %s" % (tileno,newconnection)
        TILE_LIST[tileno].connect(newconnection)

# def connect_missing_wires():
#     DBG=1;
#     # Each input connection must have matching output and maybe that will suffice
#     if DBG: print "------------------------------------------------------------------------------"
#     if DBG: print "CONNECT MISSING WIRES"
#     for T in TILE_LIST:
#         if (not T): continue
#         for c in T.connectionlist:
#             if DBG: print "found connection '%s' in tile %d" % (c,T.tileno)
#             parse = re.search("(in_s\d+t\d+)", c)
#             if (parse):
#                 w = parse.group(1)
#                 if DBG: print "connects to input wire '%s'" % w
#                 (mT,mw) = find_matching_wire(T.tileno, w)
# 
#                 # print range (0, NTILES)
#                 if mT not in range (0, NTILES):
#                     print "WARNING Ignoring edge wire %s on tile %d" % (w, T.tileno)
#                     return()
# 
#                 # print mT
#                 # print TILE_LIST[mT].connectionlist
#                 found_matching_connection = False
#                 for mc in TILE_LIST[mT].connectionlist:
#                     if DBG: print "  looking for %s in %s" % (mw, mc)
#                     if (re.search(mw,mc)):
#                         found_matching_connection = True
#                         if DBG: print "Found a match for %s in tile %d (I think)" % (mw, mT)
#                 if (not found_matching_connection):
#                     # build_default_connection(mT,mw)
#                     # Under new regime, should be no missing conections...right?
#                     print "ERROR wire '%s' was supposed to connect to '%s' in tile %d" % (w,mw,mT)
#                     print "ERROR found no connection for '%s'" % mw
#                     sys.exit(-1)
#     if DBG: print "------------------------------------------------------------------------------"


# Set up the main window and connect to callback routine that draws everything.
def build_and_launch_main_window(title):

    # Not supposed to need this no more under new regime...
    # # At this point all connections have been made; now we can go through
    # # and add missing defaults
    # connect_missing_wires()

    DBG=1;
    print "------------------------------------------------------------------------"
    print title
    print "------------------------------------------------------------------------"

    win = CGRAWin();
    win.props.title = title
    # if DBG: win.move(0,0) # put window at top left corner of screen
    if (DBG>=2): print dir(win.props)
    win.show_all()
    gtk.main()
    print "------------------------------------------------------------------------"

def demo_connections_2x2():

    # Connections make sense for a 2x2 grid

    tile = TILE_LIST; # A convenient handle

    tile[0].connect("in_s3t1 => out_s2t1")
    tile[0].connect("in_s3t1 connects to out_s1t1")
    tile[0].connect("in_s3t0 => out_s0t0")
    tile[0].printprops()

    tile[1].connect("in_s3t1 => out_s2t1")
    tile[1].connect("in_s3t1 => out_s1t1")
    tile[1].connect("in_s3t1 => out_s0t1")
    tile[1].printprops()

    tile[2].connect("in_s2t0 => out_s0t0")
    tile[2].connect("in_s1t1 => out_s0t1")
    tile[2].printprops()

    tile[3].connect("in_s2t1 => out_s3t1")
    tile[3].printprops()

def demo_connections_4x4():

    # Connections make sense for a 4x4 grid
    # Note same as 2x2 except tiles numbered differently

    tile = TILE_LIST; # A convenient handle

    tile[0].connect("in_s3t1 => out_s2t1")
    tile[0].connect("in_s3t1 connects to out_s1t1")
    tile[0].connect("in_s3t0 => out_s0t0")
    tile[0].printprops()

    tile[1].connect("in_s3t1 => out_s2t1")
    tile[1].connect("in_s3t1 => out_s1t1")
    tile[1].connect("in_s3t1 => out_s0t1")
    tile[1].printprops()

    tile[4].connect("in_s2t0 => out_s0t0")
    tile[4].connect("in_s1t1 => out_s0t1")
    tile[4].printprops()

    tile[5].connect("in_s2t1 => out_s3t1")
    tile[5].printprops()

def initialize_tile_list(w, h):

    # Let set_inital_scale_factor() do this...
    set_initial_scale_factor(w,h)

    DBG=9
    i = 0
    global TILE_LIST  
    if (DBG): print "Initializing tiles"

#     while cgra_info.tile_exists(i):
#         # rc = tileno2rc(i)
#         # TILE_LIST.append(Tile(i,rc))
#         TILE_LIST.append(Tile(i))
#         if (DBG): print "%2s" % i,
#         if (DBG and (i%16 == 15)): print ""
#         i = i + 1

    if DBG: (prev_row,prev_col) = (0,0)
    for i in range(cgra_info.ntiles()):
        # rc = tileno2rc(i)
        # TILE_LIST.append(Tile(i,rc))
        TILE_LIST.append(Tile(i))
        if TILE_LIST[i].type:
            (row,col) = (TILE_LIST[i].row, TILE_LIST[i].col)
            if DBG:
                # Print a pretty grid (see below)
                if row != prev_row:
                    print '';   prev_col = 0
                while (prev_col+1) < col:
                    print '--', ; prev_col = prev_col + 1
                print "%02x" % i,
                (prev_row,prev_col) = (row,col)

                # Initializing tiles
                # 00 -- 02 03 04 05 06 07 08 09 
                # 0a -- 0b 0c 0d 0e 0f 10 11 12 -- 13 
                # 14 -- 15 16 17 -- 18 19 1a -- -- 1b 
                # 1c -- 1d 1e 1f 20 21 22 23 24 -- 25 
                # 26 -- 27 28 29 -- 2a 2b 2c -- -- 2d 
                # 2e -- 2f 30 31 32 33 34 35 36 -- 37 
                # 38 -- 39 3a 3b -- 3c 3d 3e -- -- 3f 
                # 40 -- 41 42 43 44 45 46 47 48 -- 49 
                # 4a -- 4b 4c 4d -- 4e 4f 50 -- -- 51 


def DOT_print_connection(t1, w1, t2, w2):
    print "  FOO 'T%s_%s' connects to 'T%s_%s'" % (t1, w1, t2, w2)
    print ''

def DOT_trace_wire(tileno, portname):
    DBG=0

    # Did we trace our way back to a latch??!
    latchname = "T%s_%s" % (tileno, portname)
    if (latchname in LATCHES):
        if DBG: print "FOO Whoa found a latch"
        outwire = portname + "_latch"
        return (tileno, outwire)

    # Constant: we're done.
    if re.search('^0x', portname): return(tileno, portname)

    # pe_out: Find and return the FU connected to pe_out
    if (portname == 'pe_out'):
        if DBG: print "  FOO '%s' is a pe_out; find and return opname" % portname
        # A typical connected-ports list would be ['out_s3t4', 'ADD(wireA,wireB)']
        cport = TILE_LIST[tileno].find_connected_ports(portname)
        if DBG: print "  FOO connected ports = " + str(cport)
        for c in cport:
            parse = re.search("([A-Z]+)\((.*),(.*)\)", c)
            if parse:
                # Change 'ADD(wireA,wireB)' to just 'ADD'
                opname = parse.group(1)
                return (tileno, opname)

        sys.stdout.flush()
        sys.stderr.write("ERROR No PE connects to 'pe_out'(?)\n")
        sys.exit(-1)

    # Note a wire can have multiple sinks but only ONE source
    # Therefore must trace wire to SOURCE for common name.

    is_input = re.search('^in', portname)
    
    # Problem: any mem-tile sb_wire e.g. 'T17_sb_wire_in1_s3t0' gets
    # its own separate node but it shouldn't it's just a wire dude
    # 
    # Solution: It seems to work if we 1) treat all "sb_wire" ports as
    # outputs and 2) only trace BACK from the sbwire, never forward

    # Treat "wireA" "wireB" and "pe_out" as outputs e.g. look for internal connections
    #     is_output = re.search('^out', portname) \
    #                 or re.search('^wire', portname) \
    #                 or re.search('sb_wire', portname) \
    #                 or (portname == 'pe_out')

    is_output = re.search('^out', portname) \
                or (portname == 'pe_out')


    if is_input:
        if DBG: print "  FOO 'T%d_%s' is a input; find neighbor output" % (tileno,portname)
        (adj_tileno,adj_wire) = find_matching_wire(tileno, portname)
        if adj_wire=='INPUT':
            # print '  FOO hey its a input'
            return (tileno, 'INPUT')

        elif (adj_wire):
            # Continue tracing until find something interesting...
            if DBG: DOT_print_connection(tileno, portname, adj_tileno,adj_wire)
            return DOT_trace_wire(adj_tileno,adj_wire)

    elif is_output:
        if DBG: print "  FOO '%s' is a output; find connected ports" % portname
        cport = TILE_LIST[tileno].find_connected_ports(portname)
        found_input = False
        if DBG: print "  FOO connected ports = " + str(cport)
        for c in cport:
            # FIXME weird hack: if port is an "sb_wire" only trace "in" connections
            if re.search('sb_wire', portname) and re.search('^out', c): continue

            if DBG: print "  FOO found connected port 'T%s_%s'" % (tileno,c)
            if DBG: DOT_print_connection(tileno, portname, tileno, c)
            return DOT_trace_wire(tileno, c)

    else:
        return (tileno,portname)

    sys.stdout.flush()
    sys.stderr.write("ERROR in DOT_trace_wire()\n")
    sys.stderr.write("ERROR cannot classify port '%s'\n" % portname)
    sys.exit(-1)

# def DOT_connect_input(tileno):
#     t_input   = '"self.in"'
#     t_output  = '"T%s_%s"' % (tileno, "pe_out")
#     print '  DOT    %-15s->%-15s' % (t_input, t_output)
# 
# def DOT_connect_output(tileno):
#     t_input   = '"T%s_%s"' % (tileno, "pe_out")
#     t_output  = '"self.out"'
#     print '  DOT    %-15s->%-15s' % (t_input, t_output)

def DOT_print(s):
    DBG = 0
    if DBG: print '  DOT  ' + s;
    print>>DOT_STREAM, s

def DOT_rewrite(node):
    # Dec vs. hex:
    # "T12_0x0013" => "T12_const19"

    DBG=0
    parse = re.search('T(\d+)_0x(.*)', node)
    if parse:
        tileno = parse.group(1)
        k      = int(parse.group(2),16)
        newnode= "T%s_const%d" % (tileno, k)
        if DBG: print "FOO was '%s' now '%s'" % (node, newnode)
        return newnode

    # Simplified latch names:
    # "T32_out_s3t1_latch" => "T32_latch_s3t1"
    parse = re.search('T(\d+)_out_([^_]+)_latch', node)
    if parse:
        tileno    = parse.group(1)
        sidetrack = parse.group(2)
        newnode= "T%s_latch_%s" % (tileno, sidetrack)
        if DBG: print "FOO was '%s' now '%s'" % (node, newnode)
        return newnode

    return node

def DOT_connectem(input, output):

    # Here's a special case.  What would life be without special cases?
    # Anything that traces back to INPUT gets rewritten to originate at 'self.in'
    if re.search('T.*_INPUT', input): input = 'self.in'
    if re.search('T.*_INPUT', output): return

    # Rewrite e.g. T1_mem_out => T1_mem and T1_din => T1_mem
    # input = re.sub(r'(in|out)_([01])_BUS16_(\S+)_(\S+)', r"\1\2_s\3t\4", line)
    input = re.sub(r'(T.*)_(din|mem_out)', r"\1_mem", input)
    output = re.sub(r'(T.*)_(din|mem_out)', r"\1_mem", output)
    # if DBG: print "FOO found a din; changing it to a 'mem'"
    # print "FOO found a mem_out"

    if (input == output):
        if 0: print "WARNING Found tautology '%s-> %2s'" % (input, output)
        input  = '"%s"'  % input
        output = '"%s";' % output
        DOT_print("  # %-12s-> %-12s# (tautology)" % (input, output))
        return

    input  = '"%s"'  % DOT_rewrite(input)
    output = '"%s";' % DOT_rewrite(output)
    DOT_print('    %-12s-> %-12s' % (input, output))

# def DOT_globalwire(t, w):
#     parse = re.search("^in", w)
#     if parse:
#         (gt,gw) = find_matching_wire(t,w)
#         if gw:
#             print "('%s' is really 'T%s_%s')" % (w, gt, gw)
#             (t,w) = (gt,gw)
#     return "T%s_%s" % (t,w)

def DOT_build_graph():
    DBG=0

    try:
        global DOT_STREAM
        DOT_STREAM = open(DOT_FILENAME, 'w')
    except IOError:
        print ""
        print "ERROR Did you forget to specify a filename for '-dot'?"
        sys.exit(-1);

    # Header
    DOT_print("digraph Diagram {"   )
    DOT_print("  node [shape=box]; # Comment")
    DOT_print("")
    DOT_print("    # Comment")

    # Latch hack
    # DOT_add_latches()

    # Body
    for t in TILE_LIST:
        # print t.tileno; print t.connectionlist; print "-----"
        for c in t.connectionlist:
            if DBG: print "Tile %2d found connection '%s'" % (t.tileno,c)
            # DOT_print("")
            # DOT_print("    # Tile %2d found connection '%s'" % (t.tileno,c))
            DOT_build_dots(t.tileno,c)

    # Trailer
    DOT_print("}")
    DOT_STREAM.close()

def DOT_build_dots(tileno, connection):
    DBG=0
    if DBG: print "\nprocessing connection '%s' in tile %d" % (connection, tileno)

    # This: Tile  4, 'pe_out <= INPUT(wireA,wireB)'
    # Should turn into: "self.in"->"T4_pe_out"
    parse = re.search("pe_out <= INPUT", connection)
    # WHY does it fail without this line (below)?
    if parse: return
        # DOT_connect_input(tileno)
        # DOT_connectem("self.in", "T%s_pe_out" % tileno)
        # return

    # This: Tile  5, 'pe_out <= OUTPUT(wireA,wireB)'
    # Should turn into: "T5_pe_out"->"self.out"
    parse = re.search("pe_out <= OUTPUT", connection)
    if parse:
        # # DOT_connect_output(tileno)
        # DOT_connectem("T%s_pe_out" % tileno, "self.out")
        outwire = 'self.out'
        inwire  = "T%s_%s" % DOT_trace_wire(tileno, 'wireA')
        DOT_connectem(inwire, outwire)
        return

    line = connection # foo

    # Ignore (redundant) constants assigned to registers e.g.
    # Tile  8 found connection 'regA <= 0x0000'
    parse = re.search("reg. <= 0x", line)
    if (parse): return


    # This: "Tile  8 found connection 'pe_out <= ADD(0x0000,wireB)'"
    # Should turn into:
    #    "T8_0x0000"->"T8_ADD";
    #    "T8_wireB"->"T8_ADD";
    #    "T8_ADD"->"T8_pe_out";

    parse = re.search("pe_out <= ([A-Z]+)\((.*),(.*)\)", line)
    if (parse):
        DBG=0
        # tileno = parse.group(1)
        opname = "T%s_%s" % (tileno, parse.group(1))

        # Hm gotta trace 'em now I guess
        # input1 = "T%s_%s" % (tileno, parse.group(2))
        # input2 = "T%s_%s" % (tileno, parse.group(3))

        input1 = "T%s_%s" % DOT_trace_wire(tileno, parse.group(2))
        input2 = "T%s_%s" % DOT_trace_wire(tileno, parse.group(3))

        if DBG: print "  tileno=%s" % tileno
        if DBG: print "  opname=%s" % opname
        if DBG: print "  inputs=('%s','%s')" % (input1,input2)
        if DBG: print ""

        DOT_connectem(input1, opname)
        DOT_connectem(input2, opname)

        # Don't need this no more I thinks
        # DOT_connectem(opname, "T%s_pe_out" % tileno)

        if DBG: print ""
        return

    # Tile  1 found connection 'out_s1t1 <= in_s0t1' (should be ignored)
    # Tile  1 found connection 'wireA <= in_s1t1' (should be traced)

    DOT_wire2wire(tileno,line)


def DOT_wire2wire(tileno,line):
    # parse = re.search("(/d+) found connection '", line)
    parse = re.search("(.*) <= (.*)", line)
    if (parse):
        DBG=0
        # tileno  = parse.group(1)
        outwire = parse.group(1)
        inwire  = parse.group(2)

        # Some throuh-wires turn into latches...
        # FIXME possible optimization: add condition for
        #    if inwire not in LATCHES and outwire not in LATCHES
        # if (re.search('^(in|out)', inwire)) and (re.search('^in|out', outwire)):
        #     if DBG: print "    # Skipping through-wire '%s'" % line
        #     return

        if (inwire == "pe_out") or (inwire == "mem_out"):
            if DBG: print "    # Skipping '%s' tautology" % inwire
            return

        if DBG: print "  FOO tracing T%s '%s'" % (tileno,inwire)
        (t,w) = DOT_trace_wire(tileno, inwire)
        if DBG: print "  FOO FINAL ANSWER: 'T%s_%s'" % (t,w)
        intile = t
        inwire = w

        if DBG: print "  FOO ---------------------"

        if DBG: print "  FOO tracing T%s '%s'" % (tileno,outwire)
        (t,w) = DOT_trace_wire(tileno, outwire)
        if DBG: print "  FOO FINAL ANSWER: 'T%s_%s'" % (t,w)
        outtile = t
        outwire = w

        if DBG: print ""

        if DBG: print "  tileno=%s" % tileno
        if DBG: print "  inwire='%s'" % inwire
        if DBG: print "  outwire='%s'" % outwire
        if DBG: print ""

        # inwire  = DOT_globalwire(tileno,  inwire)
        # outwire = DOT_globalwire(tileno, outwire)

        inwire = 'T%s_%s' % (intile,inwire)
        outwire = 'T%s_%s' % (outtile,outwire)

        DOT_connectem(inwire, outwire)
        if DBG: print ""
        return

# Fool it's never a list
# def build_connections(tileno, connection_list):
#     print "FARRRK" + str(connection_list)
#     while True:
#         # Want to find all connections of the form "out_s0t0 <= in_s1t0"
#         # BUT NOT e.g. "regB <= 0x0000" 'out_s1t0 <= pe_out' 'out <= MUL(wireA,wireB)'
#         # x = re.search("(o[^ ]* *<= *i[^ ]*)(.*)", teststring)
#         
#         # NO list all connections and let GOD sort 'em out...
#         parse = re.search("([^ ]* *<= *[^ ]*)(.*)", connection_list)
#         
#         # OR: x = re.search("(\S*\s*<=\s*\S*)(.*)", connection_list)
#         if (parse):
#             DBG = 1
#             connection = parse.group(1).strip()
#             if DBG: print "Tile %2d found connection '%s'" % (tileno,connection)
#             connection_list = parse.group(2).strip()
#             TILE_LIST[tileno].connect(connection)
#         else:
#             break;

def build_connections(tileno, connection):
    DBG = 0
    if DBG: print 666, tileno, connection

    # Weed out comments e.g.
    # "# data[(14, 14)] : @ tile (0,..."
    # FIXME I'm sure there's a MUCH better way to weed out the comments!
    parse = re.search("([^ ]* *<= *[^ ]*)(.*)", connection)
    if not parse: return

    TILE_LIST[tileno].connect(connection)
    if DBG: print "Tile %2d found connection '%s'" % (tileno,connection)
    return

#     print "FARRRK" + str(connection_list)
#     while True:
#         # Want to find all connections of the form "out_s0t0 <= in_s1t0"
#         # BUT NOT e.g. "regB <= 0x0000" 'out_s1t0 <= pe_out' 'out <= MUL(wireA,wireB)'
#         # x = re.search("(o[^ ]* *<= *i[^ ]*)(.*)", teststring)
#         
#         # NO list all connections and let GOD sort 'em out...
#         parse = re.search("([^ ]* *<= *[^ ]*)(.*)", connection_list)
#         
#         # OR: x = re.search("(\S*\s*<=\s*\S*)(.*)", connection_list)
#         if (parse):
#             DBG = 1
#             connection = parse.group(1).strip()
#             if DBG: print "Tile %2d found connection '%s'" % (tileno,connection)
#             connection_list = parse.group(2).strip()
#             TILE_LIST[tileno].connect(connection)
#         else:
#             break;


def process_opname(tileno, opname, operand, reg):
    if (operand['A'] == 'wire'): reg['A'] = 'wireA' # Confusing enough?
    if (operand['B'] == 'wire'): reg['B'] = 'wireB'
    line2 = 'pe_out <= %s(%s,%s)' % (opname, reg['A'], reg['B'])
    (reg['A'], reg['B']) = ("regA", "regB") # defaults
    build_connections(tileno, line2)
    return reg


global LATCHES
LATCHES = []

def process_decoded_bitstream(bs):
    DBG=0
    # initialize_tile_list(4,4)
    global REQUESTED_SIZE
    (nrows,ncols) = REQUESTED_SIZE
    initialize_tile_list(nrows, ncols)
    tile = TILE_LIST; # A convenient handle

    # (r,c) = (6,1)
    # t = rc2tileno(r,c); print "Row %d col %d = tileno %s\n" % (r, c, t); sys.exit(0)

    # tileno = 43;
    # (r,c) = tileno2rc(tileno)
    # print "Tile %d = row %d col %d" % (tileno, r, c)
    # print "Row %d col %d = tileno %d\n" % (r, c, rc2tileno(r,c))

    reg = {}
    (reg['A'], reg['B']) = ("regA", "regB") # defaults

    operand = {} # operand['a'], operand['b']

    DBG=0
    if DBG: print ""
    opname = False
    for line in bs:
        if (DBG>1): print line.rstrip()
        line = line.strip() # why not

        # This happens sometimes
        if re.search('^cat.*', line): continue;

        # Need to know current tile
        # Every non-comment line is a bitstream ADDR/DATA pair;
        # Last four hex digits of 8-digit ADDR is tile number
        parse = re.search('^[0-9A-Fa-f]...(....)', line)
        if (parse):
            # If op_info exists, build the op
            if (opname):
                
                # if (operand['A'] == 'wire'): reg['A'] = 'wireA' # Confusing enough?
                # if (operand['B'] == 'wire'): reg['B'] = 'wireB'
                # line2 = 'pe_out <= %s(%s,%s)' % (opname, reg['A'], reg['B'])
                # (reg['A'], reg['B']) = ("regA", "regB") # defaults
                # build_connections(tileno, line2)

                reg = process_opname(tileno, opname, operand, reg)
                opname = False;

            tileno = int(parse.group(1), 16)
            if DBG: print "%s => tile number %d" % (line, tileno)
            continue

        if DBG: print ""
        if DBG: print "BEFORE: " + line

        # Find inputs and outputs
        # Note this must happen BEFORE finding other op names :(
        if   re.search("op = input",  line):
            (operand['A'],operand['B']) = ('wire','wire')

        elif   re.search("op = output",  line):
            (operand['A'],operand['B']) = ('wire','wire')

        # elif re.search("mem_out",     line): tile[tileno].label = "MEM"
        elif re.search("rdata",     line): tile[tileno].label = "MEM"

        # Transformations
        # < "# data[(1, 0)] : connect wire 3 (pe_out_res) to out_BUS16_S0_T0"
        # > "out_s1t0 <= in_s0t0"

        # mild FIXME/TODO b/c in a loop regex's should probably be compiled first
        # 'pe_out_res' => 'pe_out'
        line = re.sub("pe_out_res", "pe_out", line)


        # So now we're doing this thing, with the " ; 26" on the end.
        # data[(1, 0)] : @ tile (4, 1) connect wire 1 (in_BUS16_S2_T0) to out_BUS16_S0_T0 ; 26
        line2 = re.sub(r" ; [0-9]+", "", line)
        if (line2 != line):
            print "WARNING rewrote line"
            print "BEFORE: " + line
            print "AFTER:  " + line2
            print ""
            line = line2


        if re.search("REG_", line):
            if DBG: print "OOOOF it's a REG line"


        # prior regime
        if (0):
            # NEW
            # data[(13, 12)] : op_b_in: REG_CONST
            # data[(15, 14)] : op_a_in: REG_BYPASS

            # OLD
            # data[(13, 13)] : read from reg `b`
            # data[(15, 15)] : read from wire `a`

            parse = re.search(".* op_(.)_in: REG_CONST", line)
            if (parse):
                if DBG: print "BEFORE: " + line
                line = "# data[(13, 13)] : read from reg `%s`" % parse.group(1)
                if DBG: print "AFTER:  " + line


            parse = re.search(".* op_(.)_in: REG_BYPASS", line)
            if (parse):
                if DBG: print "BEFORE: " + line
                line = "# data[(13, 13)] : read from wire `%s`" % parse.group(1)
                if DBG: print "AFTER:  " + line

        # newer regime
        if (1):
            # NEW...
            # data[(19, 18)]: data1: REG_CONST
            # data[(17, 16)]: data0: REG_DELAY
            # data[(19, 18)]: data1: REG_BYPASS
            
            # ...must be backtranslated to OLD
            # data[(13, 13)] : read from reg `b`
            # data[(13, 13)] : read from reg `a`
            # data[(15, 15)] : read from wire `b`

            # parse = re.search(".* op_(.)_in: REG_CONST", line)
            parse = re.search(".*: data([01]): REG_(CONST|DELAY)", line)
            if (parse):
                if parse.group(1) == '0': r='a'
                else: r='b'

                if DBG: print "BEFORE: " + line
                line = "# data[(13, 13)] : read from reg `%s`" % r
                if DBG: print "AFTER:  " + line


            # parse = re.search(".* op_(.)_in: REG_BYPASS", line)
            parse = re.search(".*: data([01]): REG_BYPASS", line)
            if (parse):
                if parse.group(1) == '0': r='a'
                else: r='b'
                if DBG: print "BEFORE: " + line
                line = "# data[(13, 13)] : read from wire `%s`" % r
                if DBG: print "AFTER:  " + line

        # prior regime
        if (0):
            # New regime uses "op_a_in" and 'op_b_in" instead of just a and b
            line = re.sub("op_a_in", "a", line)
            line = re.sub("op_b_in", "b", line)

        # newer regime
        if (1):
            # Newer new regime uses 'data0' and 'data1' instead of a and b
            line = re.sub("data0", "a", line)
            line = re.sub("data1", "b", line)


        # New regime uses "alu_op" instead of just "op" maybe
        line = re.sub("alu_op", "op", line)

        # "to a" => "to wireA", "to b" => "to wireB"
        # FIXME so egregious!!!
        line = re.sub("to a", "to wireA", line)
        line = re.sub("to b", "to wireB", line)



        # Okay this is even more terrible FIXME TODO
        # Cannot handle one-bit wires (yet), so rewrite as 16-bit
        line2 = re.sub('_BUS1_', "_BUS16_", line)
        # print "FOO %s" % line;         print "BOO %s" % line2;         print ""

        if (line != line2):
            print "WARNING Rewriting 1b wire(s) as 16b bus(es):"
            print "WARNING Was: '%s'" % line
            print "WARNING Now: '%s'" % line2
            print ""
            line = line2


        # 'out_BUS16_S0_T0' => 'out_s0t0'
        line = re.sub(r'(in|out)_BUS16_S(\S+)_T(\S+)', r"\1_s\2t\3", line)
        # print "AFTER:  " + line

        # Rewrite crazy memtile wire names
        # 'out_1_BUS16_0_0'        => 'out1_s0t0'
        # 'sb_wire_in_1_BUS16_3_2' => 'sb_wire_in1_s3t2'
        line2 = re.sub(r'(in|out)_([01])_BUS16_(\d+)_(\d+)', r"\1\2_s\3t\4", line)
        if DBG and (line != line2):
            print "Rewrote line\n   '%s' =>\n   '%s'" % (line,line2)
        line = line2

        # Or maybe sometimes it looks like this:
        # 'out_1_BUS16_S0_T0'        => 'out1_s0t0'
        # 'sb_wire_in_1_BUS16_S3_T2' => 'sb_wire_in1_s3t2'
        line2 = re.sub(r'(in|out)_([01])_BUS16_S(\S+)_T(\S+)', r"\1\2_s\3t\4", line)
        if DBG and (line != line2):
            print "Rewrote line\n   '%s' =>\n   '%s'" % (line,line2)
        line = line2






        # 'data[(1, 0)] : connect wire 3 (X) to Y'
        # => 'Y <= X'
        line = re.sub(
            r'.*connect wire \S+ \(([^)]+)\) to (\S+)',
            r'\2 <= \1',
            line)

        # print "tileno = %s" % str(tileno)
        # Yes.  Sometimes this gets called more than once unnecessarily.
        build_connections(tileno,line)

        # Process constants
        parse = re.search('.*load `(.)` reg with const: (\S+)', line)
        if parse: print "WARNING deprecated format"
        # Oops it changed; now it looks like:
        #    "# data[(15, 0)] : init `b` reg with const `7`"
        if not parse: parse = re.search('.*init `(.)` reg with const `(\S+)`', line)
        if (parse):
            AB = (parse.group(1)).upper()
            k = "0x%04x" % int(parse.group(2))
            reg[AB] = k
            if DBG: print "reg['%s'] = %s" % (AB, reg[AB])
            line = "reg%s <= %s" % (AB,k)
            build_connections(tileno,line)
            continue

        # "# data[14] : load `a` reg with wire"
        # => regA <= wireA
        parse = re.search("load `(.)` reg with wire", line)
        if (parse):
            AB = parse.group(1).upper()
            line = "reg%s <= wire%s" % (AB,AB)
            build_connections(tileno,line)
            continue

        # Gather op info for later emission (see above)
        # E.g. if input line is "# data[15] : read from wire `a`"
        # then operand["A"] = "wire"
        parse = re.search("read from (reg|wire) `(.)`", line)
        if (parse):
            AB = parse.group(2).upper()
            operand[AB] = parse.group(1)
            continue

        # Gather op info for later emission (see above)
        # E.g. if input line is "# data[(4, 0)] : op = mul"
        # Then opname = "MUL"

        # OLD: 'data[(4, 0)] : op = mul'
        # NEW: 'data[(4, 0)] : alu_op = mul'
        # 
        # parse = re.search(" (alu_)*op = (\S+)", line)
        # This is taken care of in the rewrites ( I think)

        parse = re.search(" op = (\S+)", line)
        if (parse):
            opname = parse.group(1).upper()
            # Defer the rest (see above)
            continue

        # data[(23, 23)] : @ tile (2, 4) latch output wire out_BUS16_S3_T0
        # data[(15, 15)] : @ tile (0, 2) latch output wire out_BUS16_S1_T2
        parse = re.search("latch output wire (\S+)", line)
        if (parse):
            DBG=0
            wirename = parse.group(1)
            rlist = TILE_LIST[tileno].outreglist
            rlist.append(wirename)

            global LATCHES
            w = "T%s_%s" % (tileno, wirename)
            LATCHES.append(w)

            if DBG: print "FOO found latch for wire '%s'" % (wirename)
            if DBG: print "FOO tile %d outreg list now: %s" % (tileno,str(rlist))
            if DBG: print "FOO LATCHES=%s" % str(LATCHES)
            if DBG: print ""

    # One last thing
    if (opname):
        reg = process_opname(tileno, opname, operand, reg)
        opname = False;

# END process_decoded_bitstream(bs):
##############################################################################


##############################################################################
# Actual runcode starts here!  (FINALLY)

def display_decoded_bitstream_file(filename):
    DBG=0
    # call(["ls", "-l", "examples"]) # exec/run/shell

    if DBG: print ""
    if DBG: print "Using", filename, "as input";

    # Let's make the title a bit more attractive
    # e.g. "debugconv.bsa" instead of "../examples/debugconv.bsa"
    title = re.sub(r'.*/([^/]+)$', r'\1', "/"+filename)
    if DBG: print "Using", title, "as window title";

    try:
        inputstream = open(filename);
    except IOError:
        # TODO/FIXME yeah these were copied from somewhere else obviously
        print ""
        print "ERROR Cannot find processor bitstream file '%s'" % filename
        print main.__doc__
        sys.exit(-1);

    process_decoded_bitstream(inputstream)
    inputstream.close()
    # build_and_launch_main_window(filename)
    if PRINT_CONNECTIONS_AND_QUIT:
        DOT_build_graph()
        sys.exit(0)
    else:
        build_and_launch_main_window(title)


def demo_sb_2x2():
    # Simple 2x2 array with a few switchbox connections

    # Initialize a 2x2 tile array
    initialize_tile_list(2,2)

    # Demo 1 assumes a 2x2 grid and makes some connections
    demo_connections_2x2()

    # Set up the main window and connect to callback routine that draws everything.
    # Currently builds a window such that 2x2 grid fits in window at 2x scale
    title = func_name(); 
    build_and_launch_main_window(title)

def demo_sb_4x4():
    # Simple 4x4 array with a few switchbox connections

    # TBD: demo_sb_4x4 builds sample connections for a 4x4 grid at 1x scale (demo_sb_2x2 was 2x)

    initialize_tile_list(4,4)    # Initialize 4x4 tile array

    # Demo 2 makes same connections as 2x2 except in a 4x4 grid now
    demo_connections_4x4()

    # Set up the main window and connect to callback routine that draws everything.
    # Currently builds a window such that 2x2 grid fits in window at 2x scale
    title = func_name(); 
    build_and_launch_main_window(title)

def demo_sb_8x8():
    initialize_tile_list(8,8)    # Initialize 8x8 tile array
    demo_connections_4x4()       # For now let's use the 4x4 connections, see what happens
    title = func_name(); 
    build_and_launch_main_window(title)


def func_name():
    import traceback
    return traceback.extract_stack(None, 2)[0][2]
    # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

def demo_cd_jimmied():
    DBG=0

    # print func_name(); sys.exit(0)

    initialize_tile_list(4,4)  # Initialize 4x4 tile array
    example = '''
                        TILE 0 (0,0)
00050000 00000C00 [sb1] out_s1t0 <= pe_out
F0000000 FFFFFFFF [pe ] IO HACK: regA <= 0xFFFF
F1000000 FFFFFFFF [pe ] IO HACK: regB <= 0xFFFF
FF000000 000000F0 [pe ] IO HACK: pe_out is CGRA INPUT 

                        TILE 1 (1,0)
00020001 00000005 [cb1] wireA <= in_s3t0
00030001 00000000 [cb2] wireB <= in_s0t0
00050001 00000C00 [sb1] out_s1t0 <= pe_out
FF000001 0000A00B [pe ] pe_out <= MUL(wireA,wireB) 

                        TILE 2 (2,0)
00020002 00000005 [cb1] wireA <= in_s3t0
F1000002 FFFFFFFF [pe ] IO HACK: regB <= 0xFFFF
FF000002 000000FF [pe ] IO HACK: pe_in_a (wireA) is CGRA OUTPUT 

                        TILE 5 (1,1)
00050005 00300000 [sb1] out_s2t0 <= pe_out 
F0000005 00000002 [pe ] regA <= 0x0002
F1000005 00000000 [pe ] regB <= 0x0000
FF000005 00000000 [pe ] pe_out <= ADD(0x0002,0x0000) 
'''
    if DBG: print example
    example = example.split('\n')
    process_decoded_bitstream(example)
    title = func_name(); 
    build_and_launch_main_window(title)


def demo_an2_jimmied():
    DBG=0

    # print func_name(); sys.exit(0)

    initialize_tile_list(4,4)  # Initialize 4x4 tile array
    example = '''
                        TILE 4 (0,1)
00020004 00000000 [cb1] wireA <= in_s1t0
FF000004 00000000 [pe ] pe_out <= ADD(regA,regB)

                        TILE 5 (1,1)
00050005 00000000 [sb1] out_s3t0 <= in_s0t0

                        TILE 8 (0,2)
00020008 00000000 [cb1] wireA <= in_s1t0
00030008 00000000 [cb2] wireB <= in_s0t0
FF000008 0000F00B [pe ] pe_out <= MUL(wireA,wireB)
00050008 00000C00 [sb1] out_s1t0 <= pe_out

                        TILE 9 (1,2)
FF000009 00000000 [pe ] pe_out <= ADD(0x0002,0x0000)
F0000009 00000002 [pe ] regA <= 0x0002
F1000009 00000000 [pe ] regB <= 0x0000
00050009 00200003 [sb1] out_s0t0 <= pe_out     out_s3t0 <= in_s0t0
                        out_s2t0 <= in_s3t0

                        TILE 12 (0,3)
0005000C 00100C00 [sb1] out_s1t0 <= pe_out     out_s2t0 <= in_s1t0
FF00000C 00000000 [pe ] pe_out <= ADD(regA,regB)

                        TILE 13 (1,3)
0005000D 80200000 [sb1] out_s2t0 <= in_s3t0    out_s3t0 <= in_s2t0
'''
    if DBG: print example
    example = example.split('\n')
    process_decoded_bitstream(example)
    title = func_name(); 
    build_and_launch_main_window(title)

def do_demos():

    # FIXME FIXME FIXME
    print "ERROR Demos no longer work because NOT-SWAP not supported."
    print "ERROR *Somebody* needs to rewrite the demos."
    print "ERROR NOT-SWAP is no longer supported!"; sys.exit(-1)

    # return
    global SWAP
    global REQUESTED_SIZE
    if (1):
        REQUESTED_SIZE = [8,8]
        # display_decoded_bitstream_file("../decoder/examples/cd387-newmem-8x8.bs-decoded")
        display_decoded_bitstream_file("../decoder/examples/cd387-newmem-8x8-nodefaults.bsd")

    REQUESTED_SIZE = [4,4]
    SWAP = False # Demos were all written under old regime
    demo_cd_jimmied()
    demo_an2_jimmied()
    demo_sb_4x4()
    demo_sb_2x2()
    if (1):
        # Open a channel to the example decoded bitstream
        # filename = sys.argv[1];
        # filename = args[0];
        # filename = "./examples/an2.bs-decoded"
        # filename = "./examples/cd.bs-decoded"
        SWAP = False # old regime
        display_decoded_bitstream_file("./examples/cd-jimmied.bs-decoded")
        display_decoded_bitstream_file("./examples/an2-jimmied.bs-decoded")
        # SWAP = False # This should fail
        # display_decoded_bitstream_file("../decoder/examples/cd387-decoded-nodefaults-newmem.bs")
        SWAP = True  # newmem / new regime
        # display_decoded_bitstream_file("../decoder/examples/cd387-decoded-nodefaults-newmem.bs")
        display_decoded_bitstream_file("cd387-newmem-nodefaults.bsd")

    demo_sb_8x8()
    return

def main():
    '''
    Usage:
        bsview.py -cgra_info <cgra_info.txt> <b1.bsa> <b2.bsa> ...
        # Displays decoded bitstreams b1, b2...

        bsview.py -demo    # Runs through a couple built-in demos
        bsview.py --help   # Displays this help message
    ''' 
    DBG=0
    if DBG: print "ARGS=%s" % str(sys.argv)
    args = sys.argv[1:]  # argv[0] is command name

    # Default grid size is 8x8
    global REQUESTED_SIZE    # FIXME yes this is bad
    REQUESTED_SIZE = [8,8]   # default

    bsfiles = []
    cgra_filename = ''
    global PRINT_CONNECTIONS_AND_QUIT; PRINT_CONNECTIONS_AND_QUIT = False
    if    (len(args) == 0): do_demos() # no args
    # if    (len(args) == 0): demo_sb_8x8() # no args
    while (len(args)  > 0):            # args
        # print "arg0 = %s" % (args[0])
        if   (args[0] == "-demo"):  do_demos()
        elif (args[0] == "--help"): print main.__doc__
        elif (args[0] ==   '-8x8'): REQUESTED_SIZE = [8,8]
        elif (args[0] ==   '-dot'):
            PRINT_CONNECTIONS_AND_QUIT = True
            args = args[1:]
            global DOT_FILENAME
            DOT_FILENAME = args[0]
        elif (args[0] == "-cgra_info"):
            args = args[1:]
            cgra_filename = args[0]
        else:
            bsfiles.append(args[0])
        args = args[1:]

    # Load cgra_info
    if REQUESTED_SIZE == [4,4]:
        cgra_info.read_cgra_info(cgra_filename, '4x4')
    else:
        cgra_info.read_cgra_info(cgra_filename, '8x8')

    # Run through each bsa file requested on command line
    for bsa in bsfiles:
        display_decoded_bitstream_file(bsa)


# called from trace_wire() ONLY
def find_matching_wire(tileno, w):
    DBG=0
    if (0):
        (tilefoo,wfoo) = (3, ("sb_wire_in1_s3t2", "out0_s1t2"))
        (tilefoo,wfoo) = (1, ("in_s2t4"))
        if (tileno == tilefoo) and (w in wfoo):
            DBG=1; print "\nWant match for tile %d wire '%s'" % (tileno,w)

    # find_matching_wire(4,"in_s1t1") => (5, "out_s3t1")
    # 
    # parse = re.search("(in|out)_s([0-9]+)t([0-9]+)", w)
    # -> But oops mem tiles have wire names that look like
    # -> out_1_s2t0 ("1" means bottom half of tile, "0" means top)
    #
    # parse = re.search("(in|out)(_[01])*_s([0-9]+)t([0-9]+)", w)
    # -> But oops rewrote wire names; now they look like 'out0_s1t1' not 'out_0_s1t1'
    parse = re.search("(in|out)([01])*_s([0-9]+)t([0-9]+)", w)

    if not parse:
        # It's okay if wirename not valid e.g. 'wireA' has no match
        if DBG: print "Wire '%s' is not a port but that's okay" % w
        # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
        # print "\n\n\n"
        return (False,False)

    in_or_out = parse.group(1)
    top_or_bottom = parse.group(2)  # 'None', '0' or '1'
    side      = int(parse.group(3))
    track     = int(parse.group(4))

    if (in_or_out=="out"): in_or_out="in"
    else:            in_or_out="out"

    (r,c) = tileno2rc(tileno)

    # Adjust for wire in bottom of a memtile
    if (top_or_bottom == '1'): r = r + 1

    if   (side==0): (r,c,side) = (r,c+1,side+2)
    elif (side==1): (r,c,side) = (r+1,c,side+2)
    elif (side==2): (r,c,side) = (r,c-1,side-2)
    elif (side==3): (r,c,side) = (r-1,c,side-2)


    # if (r < 0): return (False,False)
    # if (c < 0): return (False,False)

    if (r < 0) or (c < 0):
        if in_or_out == 'out': return (-1,'INPUT')
        else                : return (-1,'OUTPUT')

    #   print (r,c,side)

    adj_tileno = rc2tileno(r,c)
    # Note should return 'False' if (r,c) invalid
    if DBG: print "Found adjacent tile number '%s'" % str(adj_tileno)

    top_or_bottom = ''
    if (tiletype(adj_tileno) == "memory_tile"):
        if DBG: print "HO found memory tile.  is it a top or a bottom :)"
        # '0' means top, '1' means bottom
        top_or_bottom = str(r % 2)
        if DBG:
            if (top_or_bottom): print " It's a bottom"
            else              : print " You're the top!"

    adj_wire = "%s%s_s%dt%d" % (in_or_out, top_or_bottom, side, track)
    if DBG: print "%s on tile %d matches %s on tile %d\n" % (w, tileno, adj_wire, adj_tileno)
    return (adj_tileno, adj_wire)

main()


#################################################################
# Notes
# 
# http://pycairo.readthedocs.io/en/latest/reference/context.html?
# highlight=set_dash#cairo.Context.set_dash
# 
#################################################################

