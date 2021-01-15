''' This script renames the pe_0x#### SAIF instances so they can be merged '''
import glob, re

for infile in glob.glob('../saif/active/*.saif'):
    outfile = re.sub('active', 'active_renamed', infile)
    print outfile
    subtext = re.sub('\(INSTANCE pe_0x....', '(INSTANCE pe_tile_new_unq1', open(infile).read())
    open(outfile, 'w').write(subtext)