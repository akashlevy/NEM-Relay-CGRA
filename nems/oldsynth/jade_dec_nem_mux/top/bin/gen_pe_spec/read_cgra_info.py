#!/usr/bin/python
import re
import sys

import traceback # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
def show_trace(nlines=100):
    sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

global CGRA
CGRA = False

def get_generated_cgra_info_filename():
    CGRA_FILENAME_TOP = "CGRAGenerator/hardware/generator_z/top/cgra_info.txt"
    import os
    mydir = os.path.dirname(os.path.realpath(__file__))
    # print(mydir)
    parse = re.search('^(.*/)CGRAGenerator', mydir)
    if not parse:
        return ''
    else:
        gendir = parse.group(1)
        return gendir + CGRA_FILENAME_TOP

def get_cached_cgra_info_filename():
    CGRA_FILENAME_CACHED = "../examples/cgra_info.txt.shortmem"
    import os
    mydir = os.path.dirname(os.path.realpath(__file__))
    return mydir + "/" + CGRA_FILENAME_CACHED

def read_cgra_info(filename='', grid='8x8', verbose=False):
    # https://docs.python.org/3/library/xml.etree.elementtree.html
    # Default config file is e.g. 'cgra_info_8x8.txt' in this directory
    import os
    mydir = os.path.dirname(os.path.realpath(__file__))

    if (filename == ''):
        sys.stdout.flush()
        sys.stderr.write("WARNING No cgra_info file was specified\n")
        sys.stderr.write("WARNING Looking for generated cgra_info.txt\n")
        sys.stdout.flush()
        filename = get_generated_cgra_info_filename()
        if filename != '':
            sys.stderr.write("WARNING Using '%s'\n" % filename)
        else:
            sys.stderr.write("WARNING Could not find generated info; will default to local copy\n")
        sys.stderr.flush()

    # If cannot open indicated config file (or if config file is blank), try default file
    global CGRA
    import xml.etree.ElementTree
    if verbose: sys.stdout.write("Using config file '%s'\n\n" % filename)
    if os.path.exists(filename):
        CGRA = xml.etree.ElementTree.parse(filename).getroot()

    else:
        sys.stderr.write("WARNING cgra_info.py(392) "\
                         +"Could not find cgra_info file '%s'\n" % filename)
        filename = get_cached_cgra_info_filename()
        sys.stderr.write("WARNING cgra_info.py(392) "\
                         +"Will try using local cached copy '%s'\n" % filename)
        CGRA = xml.etree.ElementTree.parse(filename).getroot()
        sys.stderr.write("WARNING cgra_info.py(392) "\
                         +" Loaded local copy '%s'\n\n" % filename)

    global CGRA_FILENAME
    CGRA_FILENAME = filename

    return CGRA
    
#     global MEMTILE_HEIGHT
#     MEMTILE_HEIGHT = mem_tile_height()


# $top/cgra_info.txt:


def get_opcodes():
    #   <tile type='pe_tile_new' tile_addr='0x0101' row='1' col='1' tracks='BUS1:5 BUS16:5 '>
    #     <pe feature_address='0'>
    #         <opcode reg_address='0xff' bith='5' bitl='0'>
    #             <op sel='0x00' name='add'>
    #                 pe_out_res=op_a+op_b+op_d
    #                 comp_res_p=(op_a+op_b+op_d) gte 2^16
    #             </op> 
    for tile in CGRA.findall('tile'):
        if tile.attrib['type'] != 'pe_tile_new': continue
        for p in tile.iter('pe'):
            for o in p.iter('opcode'): return o

def list_opcodes():
    #         <opcode reg_address='0xff' bith='5' bitl='0'>
    #             <op sel='0x00' name='add'>
    #                 pe_out_res=op_a+op_b+op_d
    #                 comp_res_p=(op_a+op_b+op_d) gte 2^16
    #             </op> 
    o = get_opcodes()
    print("")
    table_body = []
    for op in o.iter('op'):
        # print(op.text)

        op_sel  = op.attrib['sel']
        op_name = op.attrib['name']
        op_text = op.text.split('\n')

        if (1):
            print(op_sel, op_name)
            if 0: print(op_text)

        # Should be four lines of text e.g.
        # (blank)
        #     pe_out_res=op_a+op_b+op_d
        #     comp_res_p=(op_a+op_b+op_d) gte 2^16
        # (blank)
        assert len(op_text) == 4
        # First and last lines are blank
        assert op_text[0].strip() == ''
        assert op_text[3].strip() == ''

        L1 = op_text[1].strip()
        L2 = op_text[2].strip()

        assert L1[0:10] == "pe_out_res"
        assert L2[0:10] == "comp_res_p"

        if (0):
            print(L1); print(L2); print("")

        L1 = cleanup(L1)
        L2 = cleanup(L2)
        print(L1)
        print(L2)
        print("-----")
        
        table_body.append(op_table_md(op_sel, op_name, L1, L2))

    print(op_table_header())
    for line in table_body: print(line)


def op_table_header(): return """\
| Value | Op      | Result 16b         | Result 1b        | Comment                        |
| :---- | :----   | :----              | :----            | :----                          |\
"""
def op_table_md(op_sel, op_name, L1, L2):
    """Generate this (ish):
| 6'h00 | add     | a+b+d              |(a+b+d) gte 2^16  | Addition                       |
| 6'h01 | sub     | a+~b+1             |(a+~b+1) gte 2^16 | Subtraction                    |
| 6'h03 | abs     |(a lt 0)? (0-a) : a | a[15]            | Absolute                       |
| 6'h04 | gte_max |(a gte b)? a : b    | a gte b          | Maximum/<br/>Greater or equal  |
| 6'h05 | lte_min |(a lte b)? a : b    | a lte b          | Minimum/<br/>Less or equal     |
| 6'h08 | sel     | d? a : b           |(a+b) gte 2^16    | Select                         |
| 6'h0b | mult_0  |(a*b)[15:0]         |(a*b+c) gte 2^16  | Shift right                    |
| 6'h0c | mult_1  |(a*b)[23:8]         |(a*b+c) gte 2^24  | Shift left                     |
| 6'h0d | mult_2  |(a*b)[31:16]        | 0                | Multiply high                  |
| 6'h0f | rshft   | a rshft b[3:0]     |(a+b) gte 2^16    | Multiply middle                |
| 6'h11 | lshft   | a lshft b[3:0]     |(a+b) gte 2^16    | Multiply                       |
| 6'h12 | or      | a|b                |(a+b) gte 2^16    | Or                             |
| 6'h13 | and     | a and b            |(a+b) gte 2^16    | And                            |
| 6'h14 | xor     | a^b                |(a+b) gte 2^16    | Xor                            |
"""
    # "0x01" => "6'h01"
    op_sel = "6'h" + op_sel[2:100]

    # "out16 = (a lte b)? a : b" => "(a lte b)? a : b" etc
    L1 = L1[8:1000]
    L2 = L2[8:1000]

    comment = {}
    comment['add'] = 'Addition'
    comment['sub'] = 'Subtraction'
    comment['abs'] = 'Absolute'
    comment['gte_max'] = 'Maximum/<br/>Greater or equal'
    comment['lte_min'] = 'Minimum/<br/>Less or equal'
    comment['sel'] = 'Select'
    comment['mult_0'] = 'Shift right'
    comment['mult_1'] = 'Shift left'
    comment['mult_2'] = 'Multiply high'
    comment['rshft'] = 'Multiply middle'
    comment['lshft'] = 'Multiply'
    comment['or'] = 'Or'
    comment['and'] = 'And'
    comment['xor'] = 'Xor'
    #       | Value| Op   |Res16b|Res1b |Comment|
    return "| %-5s | %-7s |%-19s |%-17s | %-30s |" % (op_sel, op_name, L1, L2, comment[op_name])


def cleanup(eq):
    # IN:
    #   pe_out_res=(op_a lte op_b)?op_a:op_b
    #   comp_res_p=op_a lte op_b
    # 
    # OUT:
    #   out16 = (a lte b)? a : b
    #   out1  =  a lte b



    eq = eq.replace('op_', '')
    eq = eq.replace('pe_out_res', 'out16')
    eq = eq.replace('comp_res_p', 'out1 ')
    eq = eq.replace('=', ' = ')
#     eq = eq.replace('= a', '=  a')
#     eq = eq.replace('= d', '=  d')
    eq = re.sub(r'= ([ad0])', '=  \\1', eq)
    eq = eq.replace('?', '? ')
    eq = re.sub(r'([^0-9]):([^0-9])', '\\1 : \\2', eq)
    return eq





#                 if getnum(b.text) != bitno: continue
#                 id  = getnum(tile.attrib['tile_addr'])
#                 row = getnum(tile.attrib['row'])
#                 col = getnum(tile.attrib['col'])
#                 return (id, row, col)



# PLAN: use cgra_info.py as template to read cgra_info below etc

# $top/cgra_info.txt:
#   <tile type='pe_tile_new' tile_addr='0x0101' row='1' col='1' tracks='BUS1:5 BUS16:5 '>
#     <pe feature_address='0'>
#         <opcode reg_address='0xff' bith='5' bitl='0'>
#             <op sel='0x00' name='add'>
#                 pe_out_res=op_a+op_b+op_d
#                 comp_res_p=(op_a+op_b+op_d) gte 2^16
#             </op> 
