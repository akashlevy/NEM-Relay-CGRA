#! /bin/tcsh
# Takes in top level design name as argument and
# runs basic synthesis script
setenv DESIGN $1
if (-d synth/$1) then
  rm -rf synth/$1
endif
mkdir synth/$1
cd synth/$1
dc_shell -topographical -o "$1_syn.log" -f ../../scripts/report.tcl
#dc_shell -o "$1_syn.log" -f ../../scripts/synthesize.tcl
cd ../..

