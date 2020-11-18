#!/usr/bin/python

import os
import sys
import re
import random

# FIXME/TODO if tile 3 is memtile, use non-io templates etc.

# 16x16 grid w/ io pads
# Input must come in to T21_s2t0, output from T36_s0t0
# Input from PE tile 21 (0x15), output to mem tile T36 (0x24)
# PE: 21, 22, 23 MEM: 24
# Replace 'DEPTH' with a decimal integer %03d
MEM_TEMPLATE='''
  #DELAY DEPTH,DEPTH
  #
  # INPUT::mem
  self.in        -> Tx0101_in_s3t0
  Tx0101_in_s3t0 -> Tx0101_out_s0t0
  Tx0102_in_s2t0 -> Tx0102_out_s0t0
  Tx0103_in_s2t0 -> Tx0103_out_s0t0
  #
  # Configure mem tile
  Tx0104_in_s2t0 -> Tx0104_mem_in
  Tx0104_mem_DEPTH # (fifo_depth=DEPTH)
  Tx0104_mem_out -> Tx0104_out_s0t0
  #
  # mem in Tx0104, wen_lut in adjoining tile Tx0105
  Tx0105_lutFF(const0,const0,const0)
  Tx0105_pe_out_b0 -> Tx0105_out_s2t0_b0
  Tx0104_in_s0t0_b0 -> Tx0104_out_s2t0_b0
  Tx0104_out_s2t0_b0 -> Tx0104_wen
  #
  # mem::OUTPUT
  Tx0105_in_s2t0 -> Tx0105_out_s0t0
  Tx0106_in_s2t0 -> Tx0106_out_s0t0
  Tx0107_in_s2t0 -> Tx0107_out_s0t0
  Tx0108_in_s2t0 -> Tx0108_out_s0t0
  # 
  Tx0109_in_s2t0 -> Tx0109_out_s0t0
  Tx010A_in_s2t0 -> Tx010A_out_s0t0
  Tx010B_in_s2t0 -> Tx010B_out_s0t0
  Tx010C_in_s2t0 -> Tx010C_out_s0t0
  # 
  Tx010D_in_s2t0 -> Tx010D_out_s0t0
  Tx010E_in_s2t0 -> Tx010E_out_s0t0
  Tx010F_in_s2t0 -> Tx010F_out_s0t0
  Tx0110_in_s2t0 -> Tx0110_out_s0t0 -> self.out
'''

# OOPS with IO tiles included, first PE tile is...? tile 11?
# Replace OPNAME with name of operand e.g. 'add'

# 16x16 grid w/ io pads
# Input must come in to T21_s2t0, output from T36_s0t0
# Input from PE tile 21 (0x15), output to mem tile T36 (0x24)
# PE: 21, 22, 23 MEM: 24

# (dta0,data1) only connect to (S2,S1) :(
#   <mux snk='data0'>
#     <src sel='0'>in_BUS16_S2_T0</src>
#     <src sel='5'>out_BUS16_S2_T0</src>
#   <mux snk='data1'>
#     <src sel='0'>in_BUS16_S1_T0</src>
#     <src sel='5'>out_BUS16_S1_T0</src>
OP_TEMPLATE='''
  #DELAY 1,1
  #
  # INPUT decl
  self.in -> Tx0101_in_s3t0
  #
  # INPUT::data0(S2)
  Tx0101_in_s3t0 -> Tx0101_out_s2t0
  Tx0101_out_s2t0 -> Tx0101_data0
  #
  # INPUT::data0(S1) registered/delayed
  Tx0101_in_s3t0 -> Tx0101_out_s1t0
  Tx0101_out_s1t0 -> Tx0101_data1 (r)
  #
  # pe_out = OPNAME(data0,data1)
  Tx0101_OPNAME(wire,reg)
  #
  # pe_out::OUTPUT
  Tx0101_pe_out  -> Tx0101_out_s0t0
  Tx0102_in_s2t0 -> Tx0102_out_s0t0
  Tx0103_in_s2t0 -> Tx0103_out_s0t0
  Tx0104_in_s2t0 -> Tx0104_out_s0t0
  # 
  Tx0105_in_s2t0 -> Tx0105_out_s0t0
  Tx0106_in_s2t0 -> Tx0106_out_s0t0
  Tx0107_in_s2t0 -> Tx0107_out_s0t0
  Tx0108_in_s2t0 -> Tx0108_out_s0t0
  # 
  Tx0109_in_s2t0 -> Tx0109_out_s0t0
  Tx010A_in_s2t0 -> Tx010A_out_s0t0
  Tx010B_in_s2t0 -> Tx010B_out_s0t0
  Tx010C_in_s2t0 -> Tx010C_out_s0t0
  # 
  Tx010D_in_s2t0 -> Tx010D_out_s0t0
  Tx010E_in_s2t0 -> Tx010E_out_s0t0
  Tx010F_in_s2t0 -> Tx010F_out_s0t0
  Tx0110_in_s2t0 -> Tx0110_out_s0t0 -> self.out
'''





# using get will return `None` if a key is not present rather than raise a `KeyError`
# print os.environ.get('KEY_THAT_MIGHT_EXIST')
# os.getenv is equivalent, and can also give a default value instead of `None`
# print os.getenv('KEY_THAT_MIGHT_EXIST', default_value)

if os.getenv('NO_IO_TILES'):
    MEM_TEMPLATE = MEM_TEMPLATE_OLD
    OP_TEMPLATE  =  OP_TEMPLATE_OLD


# So what we gonna do is...
# we gonna modify top_tb to send one-bit outputs
# from pre-specified output wire like maybe "T4_out_s2t0.1",
# to a separate output file something like CGRA_1bit.out

# Use PEs to process input pixel(s) for LUT
# Use EQ function
LUT_TEMPLATE='''
  # First we bring in 0/1 pixels and turn them into 0/1 bits
  self.in -> T11_in_s2t0
  T11_in_s2t0 -> T11_op1
  T11_eq(const_1, wire)
  T11_pe_out_res_p -> T11_out_s0t0.1

  T12_bit0 <- T12_in_s2t0
  T12_bit3 <- T12_in_s2t0 (r)
  T12_LUT(wire,const_0,reg) <- 0x01
  T12_pe_out_res_p -> T12_out_s1t0.1
'''

# Simple one to get us started
LUT_TEMPLATE='''
  T12_LUT(wire,const,reg) <- 0x01
  T4_LUT <- 0xFF
  T4_pe_out_res_p -> T4_out_s2t0.1
'''






# bsbuilder now has support for...
# op_data['add']     = 0x00000000
# op_data['sub']     = 0x00000001
# op_data['abs']     = 0x00000003
# op_data['gte']     = 0x00000004
# op_data['lte']     = 0x00000005
# op_data['eq']      = 0x00000006
# op_data['sel']     = 0x00000008
# op_data['rshft']   = 0x0000000F
# op_data['lshft']   = 0x00000011
# op_data['mul']     = 0x0000000B
# op_data['or']      = 0x00000012
# op_data['and']     = 0x00000013
# op_data['xor']     = 0x00000014

OP_LIST=[
    'add',
    'sub',
    'abs',
    'gte_max',
    'lte_min',
    'eq',
    'sel',
    'rshft',
    'lshft',
    'mul',
    'or',
    'and',
    'xor',
    ]

LBUF_LIST=[
    'lbuf10',
    'lbuf09'
    ]

DBG=0
VERBOSE = True

def main ():
    # For each test e.g. 'lbuf10' build bsb file 'lbuf10.bsb'
    # plus input and output files 'lbuf10_{input,output}.raw'

    if VERBOSE: print "gen_bsb_files.py:"

    # Run only specified tests, default to ALL tests
    tests = sys.argv[1:] # [0] is the command name
    if len(tests) == 0:      tests = OP_LIST+LBUF_LIST
    elif tests[0] == 'all':  tests = OP_LIST+LBUF_LIST
    elif tests[0] == '-all': tests = OP_LIST+LBUF_LIST

    # for testname in OP_LIST:   build_optest(testname)
    # for testname in LBUF_LIST: build_lbuftest(testname)

    for testname in tests:
        if testname in OP_LIST:   build_optest(testname)
        if testname in LBUF_LIST: build_lbuftest(testname)

def build_optest(testname):
    bsb = re.sub('OPNAME','%s' % testname, OP_TEMPLATE)
    write_bsb('op_' + testname, bsb, DBG=DBG)

def build_lbuftest(testname):
    delay = str(int(re.search('lbuf(\d+)', testname).group(1)))
    bsb = re.sub('DEPTH','%s' % delay, MEM_TEMPLATE)
    write_bsb('mem_' + testname, bsb, DBG=DBG)

def write_bsb(testname, bsb, DBG=1):
    # Remove excess indentation
    bsb = re.sub('\n\s+', '\n', bsb)

    # Add test name
    bsb = ('#TEST %s' % testname) + bsb
    if DBG: print bsb

    # ...and write the bsb file
    testfile = testname + '.bsb'
    outputstream = my_open(testfile, "w")
    outputstream.write(bsb)
    outputstream.close()
    if VERBOSE: print "  Built " + testfile

def my_open(filename, mode):
    no_overwrite = False
    if no_overwrite and os.path.exists(filename):
        sys.stderr.write("Don't wanna write over existing file '%s'" % filename)
        sys.exit(-1)
    return open(filename, mode)

main()

