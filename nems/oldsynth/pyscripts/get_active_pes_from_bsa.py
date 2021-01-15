'''
Takes all bitstream files (.bsa) and outputs PEs which are active to file.
Bitstream activity is inferred depending on an FF feature number being present
for the corresponding PE.
'''
import glob

for bsfile in glob.glob('../bitstreams/*.bsa'):
    bsname = bsfile[:-4]
    with open(bsfile) as inf, open(bsname + '_active_pes.txt', 'w') as outf:
        for line in inf.readlines():
            print line
            if line[:2] == 'FF':
                peid = line[4:8]
                outf.write(peid + '\n')