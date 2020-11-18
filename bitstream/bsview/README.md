<pre>

bsview shell "bsview" is a wrapper for the python script "bsview.py"

bsview shell usage:
    bsview <bitstream.bs>     # Decodes and displays bitstream
    bsview -demo              # Runs through a couple built-in demos
    bsview --help             # Displays this help message


Things that work (wrapper 'bsview'):
    bsview --help      # Displays help message
    bsview             # Displays help message
    bsview -demo       # Runs through a couple built-in demos

Things that work (calling python script 'bsview.py' directly):
    bsview.py --help                  # Displays help message
    bsview.py                         # Runs through a couple built-in demos
    bsview.py -demo                   # Runs through a couple built-in demos
    bsview.py examples/*.bs-decoded   # Display predecoded bitstreams




Things that don't work yet:
    bsview exampes/*.bs


</pre>