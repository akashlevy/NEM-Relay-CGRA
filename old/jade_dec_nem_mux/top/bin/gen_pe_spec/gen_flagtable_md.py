#!/usr/bin/env python3
import re
import sys


# Desired output (sample):
# <!------------------------------------------------------------------------>
# <a name="pe_flags" />
# 
# #### PE flags, bits 15-12
# 
# Note: flags should be same as ARM condition codes (see Appendix A).
# 
# | flag_sel | res_p | -------- | flag_sel | res_p   |
# | :------: | ----: | -------- | :------: | :----  |
# | 4'h0     |   Z   | -------- | 4'h8     |  C & ~Z |
# | 4'h1     |  ~Z   | -------- | 4'h9     | ~C | Z  |
# | 4'h2     |   C   | -------- | 4'hA     |  N == V  |
# | 4'h3     |  ~C   | -------- | 4'hB     |  N != V  |
# | 4'h4     |   N   | -------- | 4'hC     | ~Z & (N == V) |
# | 4'h5     |  ~N   | -------- | 4'hD     |  Z | (N != V) |
# | 4'h6     |   V   | -------- | 4'hE     | lut_code[ {bit2,bit1,bit0} ] |
# | 4'h7     |  ~V   | -------- | 4'hF     | comp_res_p (see ALU ops table) |
# 
# * **C** - 'carry out' flag
# * **V** - 'overflow' flag
# * **Z** - 16b-output == 0
# * **N** - res[16] == sign(res)
# * **lut_code[...]** - value stored in LUT
# * **comp_res_p** - see ALU ops table

########################################################################
# INPUT FROM VERILOG
# I think we'll have to pull this info directly from the verilog...
# E.g.
# grep PE_FLAG $top/genesis_verif/test_pe_unq1.sv 
#     localparam PE_FLAG_EQ = 4'h0;
#     localparam PE_FLAG_NE = 4'h1;
#     localparam PE_FLAG_CS = 4'h2;
#     localparam PE_FLAG_CC = 4'h3;
#     localparam PE_FLAG_MI = 4'h4;
#     localparam PE_FLAG_PL = 4'h5;
#     localparam PE_FLAG_VS = 4'h6;
#     localparam PE_FLAG_VC = 4'h7;
#     localparam PE_FLAG_HI = 4'h8;
#     localparam PE_FLAG_LS = 4'h9;
#     localparam PE_FLAG_GE = 4'hA;
#     localparam PE_FLAG_LT = 4'hB;
#     localparam PE_FLAG_GT = 4'hC;
#     localparam PE_FLAG_LE = 4'hD;
#     localparam PE_FLAG_LUT = 4'hE;
#     localparam PE_FLAG_PE  = 4'hF;
#     PE_FLAG_EQ  : result_flag = Z;
#     PE_FLAG_NE  : result_flag = ~Z;
#     PE_FLAG_CS  : result_flag = C;
#     PE_FLAG_CC  : result_flag = ~C;
#     PE_FLAG_MI  : result_flag = N;
#     PE_FLAG_PL  : result_flag = ~N;
#     PE_FLAG_VS  : result_flag = V;
#     PE_FLAG_VC  : result_flag = ~V;
#     PE_FLAG_HI  : result_flag = C & ~Z;
#     PE_FLAG_LS  : result_flag = ~C | Z;
#     PE_FLAG_GE  : result_flag = (N == V);
#     PE_FLAG_LT  : result_flag = (N != V);
#     PE_FLAG_GT  : result_flag = ~Z & (N == V);
#     PE_FLAG_LE  : result_flag = Z | (N != V);
#     PE_FLAG_LUT : result_flag = res_lut;
#     PE_FLAG_PE  : result_flag = comp_res_p;

import subprocess

def main(DBG=0):
    print(gen_flagtable(DBG))

def gen_flagtable(DBG=0):
    # test_my_syscall(); exit()
    # 
    # 1. Find genesis_verif
    gendir = find_CGRAGenerator()
    gvdir  = gendir + "/hardware/generator_z/top/genesis_verif/"
    test_pe_file = gvdir + "test_pe_unq1.sv"
    if DBG>2:
        print("I think I found test_pe file here:\n  %s" % test_pe_file)

    filename = test_pe_file
    (out,err) = my_syscall("/bin/csh -c 'grep PE_FLAG %s'" % filename, DBG=DBG)

    flagname = {}
    flagdef  = {}
    maxnum = 0
    for line in out.split('\n'):
        sline = line.strip() 
        if DBG: print(666, sline)
        # localparam PE_FLAG_EQ = 4'h0;
        # localparam PE_FLAG_NE = 4'h1;
        # ...
        # PE_FLAG_EQ  : result_flag = Z;
        # PE_FLAG_NE  : result_flag = ~Z;
        # ...
        parse = re.search("localparam\s*PE_FLAG_(\S*).*[']h([0-9a-fA-F])", sline)
        if parse:
            name = parse.group(1).lower()
            num  = int(parse.group(2), 16)
            if DBG: print(667, name, num)
            flagname[num] = name
            if num > maxnum: maxnum = num

        parse = re.search("PE_FLAG_([^:\s]*).*result_flag[^=]*=\s*([^;]*)", sline)
        if parse:
            name = parse.group(1).lower()
            defn = parse.group(2)

            # Note '|' symbols must be escaped
            defn = defn.replace('|', '\|')

            if DBG: print(668, name, defn)
            flagdef[name] = cleandef(defn)

        if DBG: print("")

    # 2-column table because i is a idiot
    # Oddly specific, really only works well for maxnum == 15 / current flag config probably :(
    header1 = "| flag_sel | res_p | -------- | flag_sel | res_p           |\n"
    header2 = "| :------: | ----: | -------- | :------: | :------------:  |\n"

    table = header1 + header2
    assert (maxnum%2) == 1
    halfmax = int((maxnum+1)/2)
    for i in range(halfmax):
        if flagname[i] != None:
            i1 = i; i2 = i + halfmax
            name1 = flagname[i]
            name2 = flagname[i+halfmax]
            # print(name1, flagdef[name1], name2, flagdef[name2])
            table = table + ("| %3s 4'h%X |  %2s   | -------- | %3s 4'h%X | %-15s |\n" %
                  (name1, i1, flagdef[name1], name2, i2, flagdef[name2]))
    table = table + footnotes()
    return table

def cleandef(s):
    """E.g. given a def string 'C & ~Z', return ' C & ~Z' so it lines
    up with other table rows i.e.
    BEFORE:
      |  eq 4'h0 |   Z   | -------- |  hi 4'h8 | C & ~Z |
      |  ne 4'h1 |  ~Z   | -------- |  ls 4'h9 | ~C \| Z |
    AFTER:
      |  eq 4'h0 |   Z   | -------- |  hi 4'h8 |  C & ~Z |
      |  ne 4'h1 |  ~Z   | -------- |  ls 4'h9 | ~C \|  Z |"""
    
    if s ==  "C & ~Z" : s = " C & ~Z"
    if s == "~C \| Z" : s = "~C |  Z"
    if s == "(N == V)": s = " N == V"
    if s == "(N != V)": s = " N != V"
    if s == "Z \| (N != V)": s = " Z | (N != V)"
    if s == "res_lut" : s = "lut_code[{bit2,bit1,bit0}]"
    return s

def footnotes():
    return '''\
* **C** - 'carry out' flag
* **V** - 'overflow' flag
* **Z** - 16b-output == 0
* **N** - res[16] == sign(res)
* **lut_code[...]** - value stored in LUT
* **comp_res_p** - See ALU ops table\
'''

def test_my_syscall():
    my_syscall('ls /tmp/t*; ls -l /tmp/foo661313666')
def my_syscall(cmd, DBG=0):
    '''
    # (out,err) = my_syscall("/bin/csh -c 'grep PE_FLAG /tmp/tmp'", DBG=9)
    '''

    # "The subprocess module is the preferred way of running other programs
    # from Python -- much more flexible and nicer to use than os.system."

    # This works, basically...
    #     out = subprocess.check_output(['ls','-l'])
    # but...
    #   * annoying to break command into a list like that
    #   * where is stderr, err code?
    # 
    # Solution: use Popen instead:
    #    from subprocess import Popen, PIPE, STDOUT
    #    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    #    output = p.stdout.read()
    # 
    # but...
    #   * read() does not wait for call to complete
    #
    # Solution: use p.wait()

    import subprocess
    from subprocess import Popen, PIPE, STDOUT
    if DBG: print("mysyscall() executing:\n'%s'\n" % cmd)
    # p = subprocess.Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    p = subprocess.Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=True)
    p.wait()
    (stdout, stderr) = p.communicate()

    # Interpret bytes as utf-8
    stdout = stdout.decode('utf-8')
    stderr = stderr.decode('utf-8')

    # print(p.returncode; print stdout; print stderr)
    if p.returncode != 0:
        print(stdout);
        if stdout == None: stdout = ""
        if stderr == None: stderr = ""
        errmsg = "\n\n"\
               + "Subprocess call failed!  With errcode %d.\n\n" % p.returncode \
               + ("%% %s\n" % cmd) \
               + "STDOUT:\n%sSTDERR:\n%s" % (stdout, stderr) \
               + "\n";
        assert False, errmsg
    return stdout, stderr

def find_CGRAGenerator(DBG=0):
    import os
    mydir = os.path.dirname(os.path.realpath(__file__))
    parse = re.search('^(.*/CGRAGenerator)', mydir)
    if not parse:
        assert False, 'Could not find CGRAGenerator'
    else:
        gendir = parse.group(1)
        if DBG>2:
            print("# I think I found CGRAGenerator here:")
            print(gendir)
        return gendir

# main()
