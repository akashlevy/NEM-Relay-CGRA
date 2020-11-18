#!/usr/bin/python

def sb_decode(rnum, data):
  if (rnum == 0): return sb_decode_r0(data)
  if (rnum == 1): return sb_decode_r1(data)

def sb_decode_r0(r0):
    connex = [];
    if ((r0 & 0x00000003) == 0x00000000):   connex.append( "out_s0t0 <= in_s1t0" );
    if ((r0 & 0x00000003) == 0x00000001):   connex.append( "out_s0t0 <= in_s2t0" );
    if ((r0 & 0x00000003) == 0x00000002):   connex.append( "out_s0t0 <= in_s3t0" );
    if ((r0 & 0x00000003) == 0x00000003):   connex.append( "out_s0t0 <= pe_out" );
    if ((r0 & 0x0000000C) == 0x00000000):   connex.append( "out_s0t1 <= in_s1t1" );
    if ((r0 & 0x0000000C) == 0x00000004):   connex.append( "out_s0t1 <= in_s2t1" );
    if ((r0 & 0x0000000C) == 0x00000008):   connex.append( "out_s0t1 <= in_s3t1" );
    if ((r0 & 0x0000000C) == 0x0000000C):   connex.append( "out_s0t1 <= pe_out" );
    if ((r0 & 0x00000030) == 0x00000000):   connex.append( "out_s0t2 <= in_s1t2" );
    if ((r0 & 0x00000030) == 0x00000010):   connex.append( "out_s0t2 <= in_s2t2" );
    if ((r0 & 0x00000030) == 0x00000020):   connex.append( "out_s0t2 <= in_s3t2" );
    if ((r0 & 0x00000030) == 0x00000030):   connex.append( "out_s0t2 <= pe_out" );
    if ((r0 & 0x000000C0) == 0x00000000):   connex.append( "out_s0t3 <= in_s1t3" );
    if ((r0 & 0x000000C0) == 0x00000040):   connex.append( "out_s0t3 <= in_s2t3" );
    if ((r0 & 0x000000C0) == 0x00000080):   connex.append( "out_s0t3 <= in_s3t3" );
    if ((r0 & 0x000000C0) == 0x000000C0):   connex.append( "out_s0t3 <= pe_out" );
    if ((r0 & 0x00000300) == 0x00000000):   connex.append( "out_s0t4 <= in_s1t4" );
    if ((r0 & 0x00000300) == 0x00000100):   connex.append( "out_s0t4 <= in_s2t4" );
    if ((r0 & 0x00000300) == 0x00000200):   connex.append( "out_s0t4 <= in_s3t4" );
    if ((r0 & 0x00000300) == 0x00000300):   connex.append( "out_s0t4 <= pe_out" );
    if ((r0 & 0x00000C00) == 0x00000000):   connex.append( "out_s1t0 <= in_s0t0" );
    if ((r0 & 0x00000C00) == 0x00000400):   connex.append( "out_s1t0 <= in_s2t0" );
    if ((r0 & 0x00000C00) == 0x00000800):   connex.append( "out_s1t0 <= in_s3t0" );
    if ((r0 & 0x00000C00) == 0x00000C00):   connex.append( "out_s1t0 <= pe_out" );
    if ((r0 & 0x00003000) == 0x00000000):   connex.append( "out_s1t1 <= in_s0t1" );
    if ((r0 & 0x00003000) == 0x00001000):   connex.append( "out_s1t1 <= in_s2t1" );
    if ((r0 & 0x00003000) == 0x00002000):   connex.append( "out_s1t1 <= in_s3t1" );
    if ((r0 & 0x00003000) == 0x00003000):   connex.append( "out_s1t1 <= pe_out" );
    if ((r0 & 0x0000C000) == 0x00000000):   connex.append( "out_s1t2 <= in_s0t2" );
    if ((r0 & 0x0000C000) == 0x00004000):   connex.append( "out_s1t2 <= in_s2t2" );
    if ((r0 & 0x0000C000) == 0x00008000):   connex.append( "out_s1t2 <= in_s3t2" );
    if ((r0 & 0x0000C000) == 0x0000C000):   connex.append( "out_s1t2 <= pe_out" );
    if ((r0 & 0x00030000) == 0x00000000):   connex.append( "out_s1t3 <= in_s0t3" );
    if ((r0 & 0x00030000) == 0x00010000):   connex.append( "out_s1t3 <= in_s2t3" );
    if ((r0 & 0x00030000) == 0x00020000):   connex.append( "out_s1t3 <= in_s3t3" );
    if ((r0 & 0x00030000) == 0x00030000):   connex.append( "out_s1t3 <= pe_out" );
    if ((r0 & 0x000C0000) == 0x00000000):   connex.append( "out_s1t4 <= in_s0t4" );
    if ((r0 & 0x000C0000) == 0x00040000):   connex.append( "out_s1t4 <= in_s2t4" );
    if ((r0 & 0x000C0000) == 0x00080000):   connex.append( "out_s1t4 <= in_s3t4" );
    if ((r0 & 0x000C0000) == 0x000C0000):   connex.append( "out_s1t4 <= pe_out" );
    if ((r0 & 0x00300000) == 0x00000000):   connex.append( "out_s2t0 <= in_s0t0" );
    if ((r0 & 0x00300000) == 0x00100000):   connex.append( "out_s2t0 <= in_s1t0" );
    if ((r0 & 0x00300000) == 0x00200000):   connex.append( "out_s2t0 <= in_s3t0" );
    if ((r0 & 0x00300000) == 0x00300000):   connex.append( "out_s2t0 <= pe_out" );
    if ((r0 & 0x00C00000) == 0x00000000):   connex.append( "out_s2t1 <= in_s0t1" );
    if ((r0 & 0x00C00000) == 0x00400000):   connex.append( "out_s2t1 <= in_s1t1" );
    if ((r0 & 0x00C00000) == 0x00800000):   connex.append( "out_s2t1 <= in_s3t1" );
    if ((r0 & 0x00C00000) == 0x00C00000):   connex.append( "out_s2t1 <= pe_out" );
    if ((r0 & 0x03000000) == 0x00000000):   connex.append( "out_s2t2 <= in_s0t2" );
    if ((r0 & 0x03000000) == 0x01000000):   connex.append( "out_s2t2 <= in_s1t2" );
    if ((r0 & 0x03000000) == 0x02000000):   connex.append( "out_s2t2 <= in_s3t2" );
    if ((r0 & 0x03000000) == 0x03000000):   connex.append( "out_s2t2 <= pe_out" );
    if ((r0 & 0x0C000000) == 0x00000000):   connex.append( "out_s2t3 <= in_s0t3" );
    if ((r0 & 0x0C000000) == 0x04000000):   connex.append( "out_s2t3 <= in_s1t3" );
    if ((r0 & 0x0C000000) == 0x08000000):   connex.append( "out_s2t3 <= in_s3t3" );
    if ((r0 & 0x0C000000) == 0x0C000000):   connex.append( "out_s2t3 <= pe_out" );
    if ((r0 & 0x30000000) == 0x00000000):   connex.append( "out_s2t4 <= in_s0t4" );
    if ((r0 & 0x30000000) == 0x10000000):   connex.append( "out_s2t4 <= in_s1t4" );
    if ((r0 & 0x30000000) == 0x20000000):   connex.append( "out_s2t4 <= in_s3t4" );
    if ((r0 & 0x30000000) == 0x30000000):   connex.append( "out_s2t4 <= pe_out" );
    if ((r0 & 0xC0000000) == 0x00000000):   connex.append( "out_s3t0 <= in_s0t0" );
    if ((r0 & 0xC0000000) == 0x40000000):   connex.append( "out_s3t0 <= in_s1t0" );
    if ((r0 & 0xC0000000) == 0x80000000):   connex.append( "out_s3t0 <= in_s2t0" );
    if ((r0 & 0xC0000000) == 0xC0000000):   connex.append( "out_s3t0 <= pe_out" );
    return connex;


def sb_decode_r1(r1):
    connex = [];
    if ((r1 & 0x00000003) == 0x00000000):   connex.append( "out_s3t1 <= in_s0t1" );
    if ((r1 & 0x00000003) == 0x00000001):   connex.append( "out_s3t1 <= in_s1t1" );
    if ((r1 & 0x00000003) == 0x00000002):   connex.append( "out_s3t1 <= in_s2t1" );
    if ((r1 & 0x00000003) == 0x00000003):   connex.append( "out_s3t1 <= pe_out" );
    if ((r1 & 0x0000000C) == 0x00000000):   connex.append( "out_s3t2 <= in_s0t2" );
    if ((r1 & 0x0000000C) == 0x00000004):   connex.append( "out_s3t2 <= in_s1t2" );
    if ((r1 & 0x0000000C) == 0x00000008):   connex.append( "out_s3t2 <= in_s2t2" );
    if ((r1 & 0x0000000C) == 0x0000000C):   connex.append( "out_s3t2 <= pe_out" );
    if ((r1 & 0x00000030) == 0x00000000):   connex.append( "out_s3t3 <= in_s0t3" );
    if ((r1 & 0x00000030) == 0x00000010):   connex.append( "out_s3t3 <= in_s1t3" );
    if ((r1 & 0x00000030) == 0x00000020):   connex.append( "out_s3t3 <= in_s2t3" );
    if ((r1 & 0x00000030) == 0x00000030):   connex.append( "out_s3t3 <= pe_out" );
    if ((r1 & 0x000000C0) == 0x00000000):   connex.append( "out_s3t4 <= in_s0t4" );
    if ((r1 & 0x000000C0) == 0x00000040):   connex.append( "out_s3t4 <= in_s1t4" );
    if ((r1 & 0x000000C0) == 0x00000080):   connex.append( "out_s3t4 <= in_s2t4" );
    if ((r1 & 0x000000C0) == 0x000000C0):   connex.append( "out_s3t4 <= pe_out" );
    if ((r1 & 0x00000100) == 0x00000100):   connex.append("reg out_s0t0");
    if ((r1 & 0x00000200) == 0x00000200):   connex.append("reg out_s0t1");
    if ((r1 & 0x00000400) == 0x00000400):   connex.append("reg out_s0t2");
    if ((r1 & 0x00000800) == 0x00000800):   connex.append("reg out_s0t3");
    if ((r1 & 0x00001000) == 0x00001000):   connex.append("reg out_s0t4");
    if ((r1 & 0x00002000) == 0x00002000):   connex.append("reg out_s1t0");
    if ((r1 & 0x00004000) == 0x00004000):   connex.append("reg out_s1t1");
    if ((r1 & 0x00008000) == 0x00008000):   connex.append("reg out_s1t2");
    if ((r1 & 0x00010000) == 0x00010000):   connex.append("reg out_s1t3");
    if ((r1 & 0x00020000) == 0x00020000):   connex.append("reg out_s1t4");
    if ((r1 & 0x00040000) == 0x00040000):   connex.append("reg out_s2t0");
    if ((r1 & 0x00080000) == 0x00080000):   connex.append("reg out_s2t1");
    if ((r1 & 0x00100000) == 0x00100000):   connex.append("reg out_s2t2");
    if ((r1 & 0x00200000) == 0x00200000):   connex.append("reg out_s2t3");
    if ((r1 & 0x00400000) == 0x00400000):   connex.append("reg out_s2t4");
    if ((r1 & 0x00800000) == 0x00800000):   connex.append("reg out_s3t0");
    if ((r1 & 0x01000000) == 0x01000000):   connex.append("reg out_s3t1");
    if ((r1 & 0x02000000) == 0x02000000):   connex.append("reg out_s3t2");
    if ((r1 & 0x04000000) == 0x04000000):   connex.append("reg out_s3t3");
    if ((r1 & 0x08000000) == 0x08000000):   connex.append("reg out_s3t4");
    return connex;

