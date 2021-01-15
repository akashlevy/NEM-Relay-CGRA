''' Generates a merge_saif command to merge activities for PE tiles '''
import glob

files = glob.glob('../saif/active_renamed/*.saif.gz')
weight = 100./len(files)
output = 'merge_saif -input_list { \\\n'
for f in files:
  output += '-input ../%s -weight %s \\\n' % (f, weight)
output += '} -instance TOP/v/core/pe_tile_new_unq1 -output ../../saif/merged.saif.gz'
print(output)
