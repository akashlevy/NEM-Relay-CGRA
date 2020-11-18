#!/usr/bin/python2


# -*- coding: utf-8 -*-
# python

# example of reading JSON from a file

import json
import re
import sys
# filename = "examples/cascade_mapped.json"
# my_data = json.loads(open(filename).read())

my_data = json.loads(sys.stdin.read())

# print my_data
# print "------------------------------------------------------------------------------"

instances   = my_data["namespaces"]["global"]["modules"]["DesignTop"]["instances"]
connections = my_data["namespaces"]["global"]["modules"]["DesignTop"]["connections"]


def print_header():
    print "digraph Diagram {"
    print "  node [shape=box]; # Comment"

def print_trailer():
    print "}"

print_header()

DBG=0
if DBG:
    print "INSTANCES"
    for k in instances:
        # print "%s - %s" % (k, instances[k])
        # try:    print "%-12s %s" % (k, instances[k]['configargs'])
        try:    print "%-12s %s" % (k, instances[k]['modargs'])
        except: print "%-12s %s" % (k, "N/A")

def simplify(nodename):
    '''Try to improve readability of dot file e.g.
    # "io16in_in_0.out" => "INPUT"
    # "io16_out.in"     => "OUTPUT"
    # "io1_out_0_0.in"  => "OUTPUT_1bit"
    '''

    # "io16in_in_0.out" => "INPUT"
    # "io16_out.in"     => "OUTPUT"
    # "io1_out_0_0.in"  => "OUTPUT_1bit"
    if   re.search("^io16.*\.out",   nodename): return "INPUT"
    elif re.search("^io16.*\.in",    nodename): return "OUTPUT"
    elif re.search("^io1_out.*\.in", nodename): return "OUTPUT_1bit"

    # Dammit *every* lhs node is an "out" ; so delete the redundant info ('out' suffix)
    # 
    # "const0__304.out"   -> "const0__304"
    # "const5__308$1.out" -> "const5__308$1"
    # "add_305_309_310_PE.data.out" -> "add_305_309_310_PE"
    # "mul_307_308_309_PE.data.out" ->  "mul_307_308_309_PE.data"
    # "lb_p4_clamped_stencil_update_stream$reg_0_1.out" ->     "lb_p4_clamped_stencil_update_stream$reg_0_1"
    newname = nodename
    newname = re.sub(r'\.(data|bit)\.out$', '', newname)
    newname = re.sub(r'\.out$',             '', newname)

    # Similarly,
    # "wdata" and "rdata" at the end of a mem is superfluous,
    # can/should be deduced from lhs vs. rhs etc.
    newname = re.sub(r'\.[rw]data$', '', newname)

    # Note: regs only have one input and one output, so...
    # "lb_p4_clamped_stencil_update_stream$reg_0_1.in" => "lb_p4_clamped_stencil_update_stream$reg_0_1"
    parse = re.search(r'^(.*\$reg.*)\.in$', newname)
    if parse: newname = parse.group(1)

    return newname


    # NOPE
    ########################################################################
    ########################################################################
    ########################################################################
    # "bitmux_157_lut_bitPE.bit.in.1" => "bitmux_157_lut_bitPE.in1"
    parse = re.search('([^.]*)\.bit\.in\.([0-9])', nodename)
    if parse:
        rval = '%s.in%s' % (parse.group(1), parse.group(2))

        # # Things will break later if this does not conform
        # assert rval.find('bitPE.in') >= 0
        # Let it break later, I guess, and then we can fix it maybe.

        return rval

    # "PE_U8.data.in.1" => "PE_U8.in1"
    parse = re.search('([^.]*)\.data\.in\.([0-9])', nodename)
    if parse:
        rval = '%s.in%s' % (parse.group(1), parse.group(2))
        return rval

    # "PE_U70.data.out" => "PE_U70"
    parse = re.search('([^.]*)[.]', nodename)
    if parse: nodename = parse.group(1)

    # if it's a _PE thing, leave it alone I guess
    parse = re.search("(.*)_PE", nodename)
    if parse: return nodename
    
#     # Sample PE node:
#     #   "add_335_343_344_PE":{
#     #     "genref":"cgralib.PE",
#     #     "genargs":{"numbitports":["Int",3], "numdataports":["Int",2], "op_kind":["String","alu"], "width":["Int",16]},
#     #     "modargs":{"alu_op":["String","add"], "data0_mode":["String","BYPASS"], "data0_value":[["BitVector",16],0], "data1_mode":["String","BYPASS"], "data1_value":[["BitVector",16],0]}
#     #   },

    # Sample const node:
    #     "five_const":{
    #       "genref":"coreir.const",
    #       "genargs":{"width":["Int",16]},
    #       "modargs":{"value":[["BitVector",16],"16'h0005"]}
    #     },
    # Must change node name to 'const5_five_const' maybe

    DBG=0
    if DBG: print "FOO %s" % nodename

    has_genref = True
    try: dummy = instances[nodename]['genref']
    except: has_genref = False

    has_modref = True
    try: dummy = instances[nodename]['modref']
    except: has_modref = False

    if has_genref and (instances[nodename]['genref'] == "coreir.const"):

        value = instances[nodename]['modargs']['value'][1]
        if DBG: print "# FOO found const", nodename
        if DBG: print "# FOO found const value %s %s" % (value, type(value))

        # Old style const value: "2"
        # Old style const value: "16'h0005"

        # if type(value) == str:
        # Oops apparently "16'h0005" can be <type 'unicode'> !! :(
        if type(value) != int:
            assert value[0:4] == "16'h"
            value = int(value[4:], 16)
        
        if nodename.find('const') == 0:
            # Old style nodename, probably fine as is
            return nodename

        newnodename = 'const%d_%s' % (value,nodename)
        return newnodename

    # "bitand_791_792_793$c0":{
    #     "modref":"corebit.const",
    #     "modargs":{"value":["Bool",false]}
    # 
    if has_modref and (instances[nodename]['modref'] == "corebit.const"):
        value = instances[nodename]['modargs']['value'][1]
        assert type(value) == bool
        if value:
            newnodename = 'const1_%s' % nodename
        else:
            newnodename = 'const0_%s' % nodename
        return newnodename


    # Memory nodes:
    # "lb_p4_clamped_stencil_update_stream$mem_1$cgramem" => "mem_1"
    parse = re.search("^lb.*[$](mem_\d+)[$]cgramem", nodename)
    if parse:
        nodename = parse.group(1)
        return nodename

    # Memory nodes:
    # "lb_p4_clamped_stencil_update_stream_wen_lut_bitPE" => "wen_lut"
    parse = re.search("wen_lut", nodename)
    if parse:
        nodename = 'wen_lut'
        return nodename

    # Inputs and outputs BEFORE:
    #   io16in_U0 -> PE_U48_mul
    #   io16_U1 -> PE_U4_add
    #   io16in_U0 -> lb_repeat_edge_2_stencil_update_stream$reg_0_1
    #   io16in_U0 -> lb_repeat_edge_2_stencil_update_stream$mem_1
    # AFTER:
    #   INPUT -> PE_U48_mul
    #   PE_U4_add -> OUTPUT (!!???) (fixed elsewhere i guess)
    #   INPUT -> lb_repeat_edge_2_stencil_update_stream$reg_0_1
    #   INPUT -> lb_repeat_edge_2_stencil_update_stream$mem_1
    parse = re.search("^io16_", nodename)
    if parse: return "OUTPUT"

    parse = re.search("^io16in_", nodename)
    if parse: return "INPUT"

    return nodename


def to_or_from(nodename):

    # Apparently connections are unordered!!?
    # I guess ".in", ".out" is supposed to be some kind of clue... :(

    # Some node names include:
    # OLD
    #   PE_U6.data.out
    #   PE_U66.data.in.1
    #   lb_conv1_2_stencil_update_stream$mem_1.rdata
    #   lb_conv1_2_stencil_update_stream$mem_1.wdata
    #   lb_conv1_2_stencil_update_stream$reg_0_1.out
    # NEW
    #   mul_347_348_349_PE.data.out

    #     # Special cases for i/o nodes: up is down and down is up
    #     if re.search("io16in.*\.out$", nodename): return "from"
    #     if re.search("io16.*\.in$",    nodename): return "to"

    parse = re.search("\.out$", nodename)
    if parse:
        # connections go FROM output TO input
        # print "FOO I think conn goes FROM %s" % nodename
        return "from"

    parse = re.search("\.in\.\d+$", nodename)
    if parse:
        # connections go FROM output TO input
        return "to"

    # Not sure this case ever happens
    parse = re.search("\.in$", nodename)
    if parse:
        # connections go FROM output TO input
        return "to"

    if re.search("\.rdata$", nodename): return "from"
    if re.search("\.wdata$", nodename): return "to"
    if re.search("\.wen$",   nodename): return "to"
    if re.search("\.ren$",   nodename): return "to"
    if re.search("\.cg_en$", nodename): return "to"

    # return "unknown"
    sys.stdout.flush()
    sys.stderr.write("\nERROR I don't know what '%s' is\n\n" % nodename)
    assert False

# FIXME hacky hack wacky wack
# Ignore connections to cg_en, ren, wcgw?
def ignoble_node(n):
    if re.search('cg_en$', n):
        if DBG: print('# WARNING Ignoring connection to cg_en signal "%s" wcgw?\n' % n);
        return True
    elif re.search('ren$', n):
        if DBG: print('# WARNING Ignoring connection to ren signal "%s" wcgw?\n' % n);
        return True
    else:
        return False

# FIXME find_depth() and find_lut_value() are quite similar, no?
def find_depth(nodename):
    # "lb_p4_clamped_stencil_update_stream$mem_1$cgramem":{
    #   "genref":"cgralib.Mem",
    #   "genargs":{"depth":["Int",1024], "width":["Int",16]},
    #   "modargs":{"almost_full_cnt":["Int",0], "fifo_depth":["Int",64], ...
    # Insert a fifo_depth comment
    # (for some reason, node name has a '.wdata' on the end)

    # OLD
    parse = re.search('(.*).wdata', nodename)
    if not parse:

        # NEW
        parse = re.search('^(.*[$]cgramem)$', nodename)
        if not parse:
            assert False

    k1 = parse.group(1)
    if DBG: print "# FOO found wdata node", k1
    fifo_depth = int(instances[k1]['modargs']['depth'][1])
    if DBG: print "# FOO found fifo depth", fifo_depth
    assert fifo_depth > 1 and fifo_depth <= 1024
    annotation = ' # fifo_depth %d' % fifo_depth
    return annotation


def find_lut_value(nodename):
    # Insert a lut_load_value comment
    # Node will have name like "bitnot_156_lut_bitPE"
    # mapper json:
    #   "bitand_153_151_154_lut_bitPE":{
    #     "modargs":{
    # "bit0_mode":["String","BYPASS"], "bit0_value":["Bool",false], 
    # "bit1_mode":["String","BYPASS"], "bit1_value":["Bool",false], 
    # "bit2_mode":["String","BYPASS"], "bit2_value":["Bool",false], 
    # "lut_value":[["BitVector",8],"8'h88"]}
    #   },

    if DBG: print "# FOO found lut", nodename
    lut_value  =     instances[nodename]['modargs']['lut_value'][1]
    if DBG: print "# FOO found LUT value", lut_value
    assert lut_value[0:3] == "8'h"
    annotation = ' # lut_value 0x%s' % lut_value[3:]
    return annotation

##############################################################################
if DBG:
    print "CONNECTIONS"
    print connections

if DBG: print "CONNECTIONS"
for k in connections:
    if DBG: print "# %s , %s" % (k[0], k[1])

#     # FIXME temporary bug: onebit_bool generates OUTPUT on lhs
#     # FIXME shouldn't have to do it anyway, see to/from below
#     if k[0] == "io1_out_0_0.in":
#         k[0] = k[1]
#         k[1] = "io1_out_0_0.in"
#         if DBG: print "# Oops no that's backwards.  Rearranged:"
#         if DBG: print "# %s , %s" % (k[0], k[1])

    # FIXME hacky hack wacky wack - ignore connections to cg_en, ren, wcgw?
    if ignoble_node(k[1]): continue

    u0 = simplify(k[0])
    u1 = simplify(k[1])

    # E.g. "# fifo_depth 10"

    # Turn "PE_U70.data.out, PE_U8.data.in.1" into "PE_U70, PE_U8"
    from_node = u0
    to_node   = u1

    tf0 = to_or_from(k[0]); 
    tf1 = to_or_from(k[1]); 
    
    if (tf0 == "to") or (tf1 == "from"):
        from_node = u1
        to_node   = u0

    # if re.search('(.*).wdata', k[1]):
    if re.search('(.*).wdata', to_node) or re.search(r'.*[$]cgramem$', to_node):
        annotation = find_depth(to_node)
    else:
        annotation = ''

#     # print "  %s" % instances[innode]['modargs']
# 
#     # E.g. "# lut_value 0x88"
#     if re.search('(.*_lut_bitPE)$', from_node):
#         annotation = find_lut_value(from_node)
# 
#     # "slt_790_775_791$not$lut$lut"
# 
#     # Can also look like: "lb_grad_xx_2_stencil_update_stream$lbmem_1_0$c0_lutcnst"
#     if re.search('(.*lutcnst)$', from_node):
#         annotation = find_lut_value(from_node)
# 

    # Try a new thing for luts maybe
    # "slt_790_775_791$not$lut$lut":{
    #    "modargs":{
    #    "bit0_mode":["String","BYPASS"],
    #    "bit0_value":["Bool",false],
    #    "bit1_mode":["String","BYPASS"],
    #    "bit1_value":["Bool",false],
    #    "bit2_mode":["String","BYPASS"],
    #    "bit2_value":["Bool",false],
    #    "flag_sel":[["BitVector",4],"4'he"],
    #    "flag_sel_debug":["String","F_LUT"],
    #    "lut_value":[["BitVector",8],"8'h55"]
    #    }
    has_lut_value = True
    try: dummy = instances[from_node]['modargs']['lut_value']
    except: has_lut_value = False
    if has_lut_value: annotation = find_lut_value(from_node)

    print '    "%s" -> "%s";%s' % (from_node, to_node, annotation)
    if DBG: print ""


print_trailer()

# mydict = 
# for k0 in mydict:
#     print k0
# #     parse = re.search("u'(.*)'", k0)
# #     if parse: k0 = parse.group(1)
#     print mydict[k0]
# #     print "------------------------------------------------------------------------------"
# #     for k1 in my_data[k0]:
# #         print k1



# json file looks like this:
# 
# {"top":"global.DesignTop",
# "namespaces":{
#   "global":{
#     "modules":{
#       "DesignTop":{
#         "type":["Record",{
#           "in":["Array",1,["Array",16,"BitIn"]],
#           "out":["Array",16,"Bit"]
#         }],
#         "instances":{
#           "add_335_339_340_PE":{
#             "genref":"cgralib.PE",
#             "genargs":{"numbitports":["Int",3], "numdataports":["Int",2], "op_kind":["String","alu"], "width":["Int",16]},
#             "modargs":{"alu_op":["String","add"], "data0_mode":["String","BYPASS"], "data0_value":[["BitVector",16],0], "data1_mode":["String","BYPASS"], "data1_value":[["BitVector",16],0]}
#           },
#           "add_335_343_344_PE":{
#             "genref":"cgralib.PE",
#             "genargs":{"numbitports":["Int",3], "numdataports":["Int",2], "op_kind":["String","alu"], "width":["Int",16]},
#             "modargs":{"alu_op":["String","add"], "data0_mode":["String","BYPASS"], "data0_value":[["BitVector",16],0], "data1_mode":["String","BYPASS"], "data1_value":[["BitVector",16],0]}
#           },
#           "const0__334":{
#             "genref":"coreir.const",
#             "genargs":{"width":["Int",16]},
#             "modargs":{"value":[["BitVector",16],0]}
#           },
# ...
#           "io16_out":{
#             "genref":"cgralib.IO",
#             "genargs":{"width":["Int",16]},
#             "modargs":{"mode":["String","o"]}
#           },
#           "io16in_in_0":{
#             "genref":"cgralib.IO",
#             "genargs":{"width":["Int",16]},
#             "modargs":{"mode":["String","i"]}
#           },
#           "lb_p4_clamped_stencil_update_stream$mem_1$cgramem":{
#             "genref":"cgralib.Mem",
#             "genargs":{"depth":["Int",1024], "width":["Int",16]},
#             "modargs":{"almost_full_cnt":["Int",0], "fifo_depth":["Int",10], "mode":["String","linebuffer"]}
#           },
#           "lb_p4_clamped_stencil_update_stream_wen_lut_bitPE":{
#             "genref":"cgralib.PE",
#             "genargs":{"numbitports":["Int",3], "numdataports":["Int",2], "op_kind":["String","bit"], "width":["Int",16]},
#             "modargs":{"bit0_mode":["String","BYPASS"], "bit0_value":["Bool",false], "bit1_mode":["String","BYPASS"], "bit1_value":["Bool",false], "bit2_mode":["String","BYPASS"], "bit2_value":["Bool",false], "lut_value":[["BitVector",8],1]}
#           },
# ...
#         "connections":[
#           ["const0__334.out","add_335_339_340_PE.data.in.0"],
#           ["const7__338.out","mul_337_338_339_PE.data.in.1"],
#           ["const7__338$1.out","mul_342_338_343_PE.data.in.1"],
#           ["io16_out.in","add_335_343_344_PE.data.out"],
#           ["io16in_in_0.out","lb_p4_clamped_stencil_update_stream$mem_1$cgramem.wdata"],
#           ["io16in_in_0.out","mul_342_338_343_PE.data.in.0"],
#           ["lb_p4_clamped_stencil_update_stream$mem_1$cgramem.rdata","mul_337_338_339_PE.data.in.0"],
#           ["lb_p4_clamped_stencil_update_stream$mem_1$cgramem.wen","lb_p4_clamped_stencil_update_stream_wen_lut_bitPE.bit.out"],
#           ["add_335_339_340_PE.data.out","add_335_343_344_PE.data.in.0"],
#           ["mul_337_338_339_PE.data.out","add_335_339_340_PE.data.in.1"],
#           ["mul_342_338_343_PE.data.out","add_335_343_344_PE.data.in.1"]
