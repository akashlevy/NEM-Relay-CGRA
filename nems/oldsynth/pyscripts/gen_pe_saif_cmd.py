import glob

cmdstr = "vcd2saif -i ../vcd/%s.vcd -o active/%s_pe_0x%s.saif -instance TOP/v/core/pe_0x%s\n"
with open('../saif/saif_gen.csh', 'w') as outf:
    outf.write('mkdir active\n')
    outf.write('mkdir active_renamed\n')
    for bsfile in glob.glob('../bitstreams/*.bsa'):
        bsname = bsfile[:-4].split('/')[-1]
        with open('../bitstreams/' + bsname + '_active_pes.txt') as inf:
            for peid in inf.readlines():
                peid = peid.strip()
                outf.write(cmdstr % (bsname, bsname, peid, peid))