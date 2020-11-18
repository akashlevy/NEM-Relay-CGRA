#!/bin/csh -f

##############################################################################
# Build /tmp/msb1:
#
# // SIDE 0
# case(sb[1:0]) // TRACK 0
#     0: out_s0t0 <= in_s1t0    // (r0 & 00000003) == 00000000
#     1: out_s0t0 <= in_s2t0    // (r0 & 00000003) == 00000001
#     2: out_s0t0 <= in_s3t0    // (r0 & 00000003) == 00000002
#     3: out_s0t0 <=  pe_out    // (r0 & 00000003) == 00000003
# ...
# case(sb[39:38]) // TRACK 4
#     0: out_s3t4 <= in_s0t4    // (r1 & 000000C0) == 00000000
#     1: out_s3t4 <= in_s1t4    // (r1 & 000000C0) == 00000040
#     2: out_s3t4 <= in_s2t4    // (r1 & 000000C0) == 00000080
#     3: out_s3t4 <=  pe_out    // (r1 & 000000C0) == 000000C0
# 
# // SIDE 0 pipelining
#   sb[40]: enable pipereg for out_0_0   // (r1 & 00000100) == 00000100
#   sb[41]: enable pipereg for out_0_1   // (r1 & 00000200) == 00000200
#   sb[42]: enable pipereg for out_0_2   // (r1 & 00000400) == 00000400
#   sb[43]: enable pipereg for out_0_3   // (r1 & 00000800) == 00000800
#   sb[44]: enable pipereg for out_0_4   // (r1 & 00001000) == 00001000
# ...

# For now, ntracks is hardwired to 5.
set ntracks = 5

sb_encoder.py -ntracks $ntracks -full > /tmp/msb1
    # cat /tmp/msb1
    set out = /tmp/msb1
    echo $out; head $out; echo ...; tail $out; echo; echo

# set f = "$in"
# grep out_s3t0 $out




##############################################################################
# Build /tmp/sb_decode.mux.0
# 
# out_s0t0,in_s1t0,(r0 & 0x00000003) == 0x00000000
# out_s0t0,in_s2t0,(r0 & 0x00000003) == 0x00000001
# out_s0t0,in_s3t0,(r0 & 0x00000003) == 0x00000002
# out_s0t0,pe_out,(r0 & 0x00000003) == 0x00000003
# out_s0t1,in_s1t0,(r0 & 0x0000000C) == 0x00000000
# ...

set out = /tmp/sb_decode.mux.0
grep ' & ' /tmp/msb1      \
  # select mux lines only \
  | grep ': out'          \
  #                       \
  # strip prefix          \
  | sed 's/.*: //'        \
  #                       \
  # strip '//'            \
  | sed 's|//|  |g'       \
  #                       \
  # strip '<='            \
  | sed 's|<=|  |g'       \
  #                       \
  # comma-separate        \
  | sed 's|   *|,|g'      \
  #                       \
  # Add "0x" in front of hex numbers \
  | sed 's/ \([0-9A-F]\)/ 0x\1/g' \
  > $out
echo $out; head -n 5 $out; echo "..."; echo; echo

# grep out_s3t0 $out

##############################################################################
# Build /tmp/sb_decoder.mux.final
# 
#     if ((r0 & 0x00000003) == 0x00000000):   connex.append( "out_s0t0 <= in_s1t0" );
#     if ((r0 & 0x00000003) == 0x00000001):   connex.append( "out_s0t0 <= in_s2t0" );
#     if ((r0 & 0x00000003) == 0x00000002):   connex.append( "out_s0t0 <= in_s3t0" );
#     if ((r0 & 0x00000003) == 0x00000003):   connex.append( "out_s0t0 <= pe_out" );
#     ...

set in = $out
set out = /tmp/sb_decoder.mux.final

cat $in \
  | awk -F ',' '\
      # {printf("    if (%s):   connex.append( \"%s -> %s\" );\n", $3, $2, $1)} \
      {printf("    if (%s):   connex.append( \"%s <= %s\" );\n", $3, $1, $2)} \
  '\
  > $out

echo $out; head -4 $out; echo "    ..."; tail -4 $out; echo; echo

# grep out_s3t0 $out
# exit


##############################################################################
# Build /tmp/sb_decoder.reg.final
# 
#     if ((r1 & 0x00000100) == 0x00000100):   connex.append("reg out_s0t0");
#     if ((r1 & 0x00000200) == 0x00000200):   connex.append("reg out_s0t1");
#     if ((r1 & 0x00000400) == 0x00000400):   connex.append("reg out_s0t2");
#     if ((r1 & 0x00000800) == 0x00000800):   connex.append("reg out_s0t3");
#     if ((r1 & 0x00001000) == 0x00001000):   connex.append("reg out_s0t4");
# ...

set out = /tmp/sb_decoder.reg.final
grep ' & ' /tmp/msb1      \
  # select reg lines only \
  | grep ': enable'       \
  #                       \
  # strip prefix          \
  | sed 's/.* for //'     \
  #                       \
  # strip '//'            \
  | sed 's|//|  |g'       \
  #                       \
  # comma-separate        \
  | sed 's|   *|,|g'      \
  #                       \
  # Add "0x" in front of hex numbers \
  | sed 's/ \([0-9A-F]\)/ 0x\1/g' \
  #                                               \
  # change e.g. "out_0_0" to "out_s0t0"           \
  | sed 's/out_\([0-9]*\)_\([0-9]*\)/out_s\1t\2/' \
  #                       \
  # go ahead and build it \
  | sed 's/\([^,]*\),\(.*\)/    if (\2):   connex.append("reg \1");/' \
  > $out
echo $out; head -n 5 $out; echo "..."; echo; echo







##############################################################################
# Build /tmp/sb_decode_r0.py
# 
# def sb_decode_r0(r0):
#     connex = [];
#     if ((r0 & 0x00000003) == 0x00000000):   connex.append( "out_s0t0 <= in_s1t0" );
#     ...
#     if ((r0 & 0xC0000000) == 0x40000000):   connex.append( "out_s3t0 <= in_s1t0" );
#     if ((r0 & 0xC0000000) == 0x80000000):   connex.append( "out_s3t0 <= in_s2t0" );
#     if ((r0 & 0xC0000000) == 0xC0000000):   connex.append( "out_s3t0 <= pe_out" );
#     return connex;

set in  = "/tmp/sb_decoder.mux.final /tmp/sb_decoder.reg.final"
set out = "/tmp/sb_decode_r0.py"

cat << eof > $out
def sb_decode_r0(r0):
    connex = [];
eof
cat $in | grep r0 >> $out
echo "    return connex;" >> $out

echo '-------------------'; 
echo $out; 
echo '-------------------'; 
head -8 $out; echo "    ..."; tail -4 $out; echo; echo


##############################################################################
# Build /tmp/sb_decode_r1.py
# 
# def sb_decode_r1(r1):
#     connex = [];
#     if ((r1 & 0x00000003) == 0x00000000):   connex.append( "out_s3t1 <= in_s0t1" );
#     ...
#     if ((r1 & 0x02000000) == 0x02000000):   connex.append("reg out_s3t2");
#     if ((r1 & 0x04000000) == 0x04000000):   connex.append("reg out_s3t3");
#     if ((r1 & 0x08000000) == 0x08000000):   connex.append("reg out_s3t4");
#     return connex;

set in  = "/tmp/sb_decoder.mux.final /tmp/sb_decoder.reg.final"
set out = "/tmp/sb_decode_r1.py"

cat << eof > $out
def sb_decode_r1(r1):
    connex = [];
eof
cat $in | grep r1 >> $out
echo "    return connex;" >> $out

echo '-------------------'; 
echo $out; 
echo '-------------------'; 
head -8 $out; echo "    ..."; tail -4 $out; echo; echo


##############################################################################
# Build /tmp/sb_decode_5tracks.py

set out = /tmp/sb_decode_${ntracks}tracks.py
# echo '#\!/usr/bin/python' > $out
cat << eof > $out
#!/usr/bin/python

def sb_decode(rnum, data):
  if (rnum == 0): return sb_decode_r0(data)
  if (rnum == 1): return sb_decode_r1(data)

eof
cat /tmp/sb_decode_r0.py >> $out
(echo; echo)             >> $out
cat /tmp/sb_decode_r1.py >> $out
echo                     >> $out
echo "Final sb decoder is here: $out"
