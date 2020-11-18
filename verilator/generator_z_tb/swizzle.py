#!/usr/bin/python

import sys;
import os;
import re;

xform = {}
xform['00'] = '00'
xform['01'] = '04'
xform['02'] = '08'
xform['03'] = '0C'

xform['04'] = '01'
xform['05'] = '05'
xform['06'] = '09'
xform['07'] = '0D'

xform['08'] = '02'
xform['09'] = '06'
xform['0A'] = '0A'
xform['0B'] = '0E'

xform['0C'] = '03'
xform['0D'] = '07'
xform['0E'] = '0B'
xform['0F'] = '0F'


inputstream = sys.stdin;
for line in inputstream:
    line = line.strip();
    parse = re.search("(......)(..) (........)", line)
    if (0):
        print "BEFORE: " + line
        print "AFTER1: %s %s    %s" % (parse.group(1), parse.group(2), parse.group(3))
        print "AFTER2: %s%s %s" % (parse.group(1), xform[parse.group(2)], parse.group(3))
        print ""

    print "%s%s %s" % (parse.group(1), xform[parse.group(2)], parse.group(3))
