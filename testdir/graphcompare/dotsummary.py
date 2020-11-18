#!/usr/bin/python
import sys
import re

# Sample input:
#     "T15_ADD"   -> "T8_ADD";   
#     "T10_MUL"   -> "T8_ADD";   
#   # "T1_ADD"    -> "T1_ADD";   # (tautology)
#   # "T10_MUL"   -> "T10_MUL";  # (tautology)
# 
# Sample output (in_edges,out_edges)
#    3 ADD(1,2)     # Found three ADD nodes each with 1 in_edge and 2 out_edges
#    1 const16(0,1) # Found one 'const16' node with 1 out_edge

DBG=0
global node_dict
node_dict = {} # Dictionary?  Is that what this is?
for line in sys.stdin:

    # Strip crlf
    line = line.strip()

    # Strip comments
    line = re.sub(r'#.*', '', line)

    # Only want lines containing "node" -> "node"
    parse = re.search('("\s*->\s*")', line)
    if not parse: continue
    # else: print " FOO %s" % parse.group(1)

    DBG=0
    if DBG: print "LINE '%s'" % line

    # '"T1_0x0000" -> "T1_ADD" -> "T10_out_s3t2_latch";'
    # becomes
    # 'T1_0x0000 T1_ADD T10_out_s3t2_latch'

    line1 = re.sub('[-">;]', '', line)
    line1 = re.sub('\s+', ' ', line1)
    line1 = re.sub('\s+$', '', line1)
    if DBG and (line != line1):
        print "\nFOO< '%s'"   % line
        print   "FOO> '%s'\n" % line1

    # 'T1_0x0000 T1_ADD T10_out_s3t2_latch'
    # becomes list
    # (T1_0x0000,T1_ADD,T10_out_s3t2_latch)

    DBG=0
    line_array = line1.split(' ')

    # Count input, output edges of each node in list.
    # First node has one output edge
    # Last node has one input edge
    # All others have one edge in, one edge out

    # In: (T1_0x0000,T1_ADD,T10_out_s3t2_latch)
    # Out: node_dict["T1_0x0000"]          += (0,1)
    #      node_dict["T1_ADD"]             += (1,1)
    #      node_dict["T10_out_s3t2_latch"] += (1,0)

    firstnode = line_array[0]
    lastnode  = line_array[-1]
    line_array = line_array[1:-1]
    if DBG: print "FOO %s\nFOO %s\nFOO %s\n" (firstnode, lastnode, str(line_array))

    def incnode(node,ein,eout):
        '''Add "in" in-edges and "out" out_edges to "node"'''

        DBG=0
        global node_dict
        if (node not in node_dict):
            # print "> initialize node '%s' = (%d,%d)" % (node, ein, eout)
            node_dict[node] = (ein,eout) # One edge OUT only
        else:
            # print "> inc node '%s' by (%d,%d)" % (node, ein,eout)
            (ein0,eout0) = node_dict[node]
            node_dict[node] = (ein0+ein, eout0+eout)

        if DBG: print "> %s %s" % (node, node_dict[node])

    # First node in list: add one out edge ONLY
    incnode(firstnode, 0, 1)
    incnode(lastnode,  1, 0)
    for node in line_array: incnode(node, 1, 1)

    if DBG: print ""
    continue


# Okay now we're done with phase 1
DBG=0
if DBG:
    print "phase 1 complete"
    for node in sorted(node_dict):  # Same as sorted(node_dict.keys()) 
        print node, node_dict[node]
    sys.exit(0)


# Phase 2: canonicalize and merge
# IN:
#    T10_MUL (2, 1)
#    T10_out_s3t2_latch (1, 1)
#    T14_ADD (2, 1)
#    T15_ADD (2, 1)
#    T16_0x000e (0, 1)
#    T16_MUL (2, 1)
#    T16_regA (1, 1)
#
# OUT:
#    MUL(2,1)   2
#    latch(1,1) 2
#    ADD(2,1)   2
#    const15    1
# 

rewrite_bsa = (
    # Rewrite-rules for *.bsa files (use tuples because immutable or whatever)

    # T1_ADD             => ADD
    # T1_0x000b          => const11 (this happens elsewhere)
    # T10_out_s3t2_latch => latch
    # T16_regA           => latch

    ('^T\d+_', ''),        # Strip off tile number
    ('.*latch.*','latch'), # All regs and latches are 'latch'
    ('^reg.*','latch'),
    # Maybe this is dumb, I dunno
    ('ADD','add'),
    ('MUL','mul'),
    ('self.in','INPUT'),
    ('self.out','OUTPUT'),

)

rewrite_map = (
    # Rewrite-rules for map files

    # add_335_339_340  => add
    # mul_337_338_339  => mul
    # const0      => const0
    # const999    => const999
    
    # lb_conv1_2_stencil_update_stream$mem_1    => mem
    # lb_conv1_2_stencil_update_stream$mem_2    => mem
    # lb_conv1_2_stencil_update_stream$reg_0_1  => latch

    ('^add.*', 'add'),
    ('^mul.*', 'mul'),
    ('.*[$]mem.*', 'mem'),
    ('.*[$]reg.*', 'reg')
)

howmany = {}
for node in sorted(node_dict):
    DBG=0
    if DBG: print "NODE %s %s" % (node, node_dict[node])
    (ein,eout) = node_dict[node] # We'll need these later.
    
    # T1_ADD             => ADD
    # T10_out_s3t2_latch => latch
    # T1_0x000b          => const11
    # T16_regA           => latch
    # etc.

    for subpair in rewrite_bsa + rewrite_map:
        search = subpair[0]
        replace = subpair[1]
        node = re.sub(search, replace, node)

    # All constants should be dec e.g. '0x0011' => 'const17'
    # (Actually it's possible that bsview does this for us now...?

    if re.search('^0x', node):
        node = 'const%d' % int(node,16)
        if DBG: print "> %s" % node

    # Add in,out edges e.g. "const17" => "const17(0,1)"

    # node = "%s(i%d,o%d)" % (node,ein,eout)
    # node = "(i%d -> %-8s -> o%d)" % (ein,node,eout)
    node = "(i%d -> %s -> o%d)" % (ein,node,eout)

    if DBG: print "> %s" % node

    # Count 'em up!
    try: # Is this terrible?  It seems terrible
        howmany[node] = howmany[node] + 1
    except: howmany[node] = 1

    if DBG: print "> %s %d\n" % (node, howmany[node])


# The final accounting
if DBG: print "phase 3"
for node in sorted(howmany):
    print "%3d %-15s" % (howmany[node], node)
