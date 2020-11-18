#!/usr/bin/env python3

import re
import sys

global CGRA

import read_cgra_info
CGRA = read_cgra_info.read_cgra_info()

import traceback # sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()
def show_trace(nlines=100):
    sys.stdout.flush(); traceback.print_stack(); sys.stderr.flush()

def main():
    print("#### ALU Operations, bits 5-0")
    print(list_opcodes())


# FIXME the CGRA/xml portion of get_opcodes and list_opcodes
# should be in read_cgra_info module instead of here...!
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

def list_opcodes(DBG=0):
    '''Given a pointer to the "opcode" portion of the cgra_info file, generate a nice markdown table'''
    #         <opcode reg_address='0xff' bith='5' bitl='0'>
    #             <op sel='0x00' name='add'>
    #                 pe_out_res=op_a+op_b+op_d
    #                 comp_res_p=(op_a+op_b+op_d) gte 2^16
    #             </op> 
    table_body = []
    o = get_opcodes()
    for op in o.iter('op'):
        # print op.text

        op_sel  = op.attrib['sel']
        op_name = op.attrib['name']
        op_text = op.text.split('\n')

        if DBG:   print(op_sel, op_name)
        if DBG>2: print(op_text)

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

        if DBG>2:
            print(L1); print(L2); print("")

        L1 = cleanup(L1)
        L2 = cleanup(L2)
        if DBG:
            print(L1); print(L2); print("-----")
        
        table_body.append(op_table_md(op_sel, op_name, L1, L2))

    table = op_table_header() + '\n'
    # for line in table_body: print(line)
    for line in table_body: table = table + line + '\n'
    if DBG: print(table)

    notes = """\
Notes:
* a=data0, b=data1, d=bit0
* RSHFT/LSHFT 'Shift by' value b is unsigned
"""
    table = table + notes + '\n'

    return table



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
| 6'h0B | mult_0  |(a*b)[15:0]         |(a*b+c) gte 2^16  | Shift right                    |
| 6'h0C | mult_1  |(a*b)[23:8]         |(a*b+c) gte 2^24  | Shift left                     |
| 6'h0D | mult_2  |(a*b)[31:16]        | 0                | Multiply high                  |
| 6'h0F | rshft   | a rshft b[3:0]     |(a+b) gte 2^16    | Multiply middle                |
| 6'h11 | lshft   | a lshft b[3:0]     |(a+b) gte 2^16    | Multiply                       |
| 6'h12 | or      | a|b                |(a+b) gte 2^16    | Or                             |
| 6'h13 | and     | a and b            |(a+b) gte 2^16    | And                            |
| 6'h14 | xor     | a^b                |(a+b) gte 2^16    | Xor                            |
"""
    # "0x0f" => "6'h0F"
    op_sel = "6'h" + op_sel[2:100].upper()

    # "out16 = (a lte b)? a : b" => "(a lte b)? a : b" etc
    L1 = L1[8:1000]
    L2 = L2[8:1000]

    comment = {}
    comment['add']     = 'Addition'
    comment['sub']     = 'Subtraction'
    comment['abs']     = 'Absolute'
    comment['gte_max'] = 'Maximum/<br/>Greater or equal'
    comment['lte_min'] = 'Minimum/<br/>Less or equal'
    comment['sel']     = 'Select'
    comment['mult_0']  = 'Multiply'
    comment['mult_1']  = 'Multiply middle'
    comment['mult_2']  = 'Multiply high'
    comment['rshft']   = 'Shift right'
    comment['lshft']   = 'Shift left'
    comment['or']      = 'Or'
    comment['and']     = 'And'
    comment['xor']     = 'Xor'
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
    #
    eq = eq.replace('op_', '')
    eq = eq.replace('pe_out_res', 'out16')
    eq = eq.replace('comp_res_p', 'out1 ')
    eq = eq.replace('=', ' = ')
    #
    #     eq = eq.replace('= a', '=  a')
    #     eq = eq.replace('= d', '=  d')
    eq = re.sub(r'= ([ad0])', '=  \\1', eq)
    #
    eq = eq.replace('?', '? ')
    eq = re.sub(r'([^0-9]):([^0-9])', '\\1 : \\2', eq)
    #
    eq = eq.replace('gte', '>=')
    eq = eq.replace('lte', '<=')
    eq = eq.replace('gt',  '>')
    eq = eq.replace('lt',  '<')
    eq = eq.replace('a and b', 'a&b')
    #
    # Before:
    # | 6'h00 | add     | a+b+d              |(a+b+d) >= 2^16   | Addition                       |
    # | 6'h01 | sub     | a+~b+1             |(a+~b+1) >= 2^16  | Subtraction                    |
    # After:
    # | 6'h00 | add     | a+ b+d             |(a+ b+d) >= 2^16  | Addition                       |
    # | 6'h01 | sub     | a+~b+1             |(a+~b+1) >= 2^16  | Subtraction                    |
    eq = eq.replace('a+b+d', 'a+ b+d')
    # 
    eq = eq.replace('rshft', '>>')
    eq = eq.replace('lshft', '<<')
    #
    # Asterisk by itself is no good in markdown table!  Etc.
    eq = eq.replace('a*b',     'a\*b')
    eq = eq.replace('a|b',     'a\|b')
    return eq

# main()
