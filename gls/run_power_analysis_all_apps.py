import os
 
apps = ['conv_1_2', 'conv_2_1', 'conv_3_1', 'conv_bw', 'cascade', 'harris', 'pointwise']
design_type = 'nems'
experiment='invd1'
starting_dir = os.getcwd()

for app in apps:
    os.system('python gls.py ' + app)
    os.system('gzip outputs/*')
    os.chdir(starting_dir + '/synopsys-ptpx-gl')
    os.system('./run.sh ' + app + ' ' + design_type + ' ' + experiment)
    os.chdir(starting_dir + '/results')
    os.system('python powjson.py')
    os.chdir(starting_dir)
    os.system('rm -rf outputs/*')
