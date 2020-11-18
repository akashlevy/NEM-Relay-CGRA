#!/bin/csh -f

# Generate a CGRA using generator's default "run.csh" script.

# Script should be in CGROOT/bin

##############################################################################
# Not used in the new regime;
# safe to delete after we've finished the move.
setenv CGRA_GEN_ALL_REG 1
##############################################################################

# Not everyone has access to readlink -f
unset no_readlink
readlink -f >& /dev/null || set no_readlink
if ($?no_readlink) then
  set scriptpath = "$0"
  set scriptpath = $scriptpath:h
  if ("$scriptpath" == "$0") then
    set scriptpath = `pwd`
    set CGROOT = `cd $scriptpath:h; pwd`
  else
    set CGROOT = `cd $scriptpath/..; pwd`
  endif
else
  # set scriptpath = "$0" # No good if symlinks exist maybe
  set scriptpath = `readlink -f $0`
  set scriptpath = $scriptpath:h
endif


# # Script lives in $CGROOT/bin/$0
# # Therefore scriptpath is "$CGROOT/bin"
# # Therefore CGROOT is $scriptpath:h
# set CGROOT = $scriptpath:h


# echo "I think CGRAGenerator is here: $CGROOT"; exit

##############################################################################
# Set up to run Genesis2; installs genesis2 if necessary (in /tmp !)

unset VERBOSE
if ("$1" == "-v") then
  # echo verbose
  set VERBOSE
else if ("$1" == "-q") then
  # echo quiet
  unset VERBOSE
endif

set topdir = $CGROOT/hardware/generator_z/top

echo ""
echo ""
echo "${0:t} WARNING $0:t is deprecated/unnecessary; you should not have to call it"
echo "${0:t} WARNING $0:t is deprecated/unnecessary; you should not have to call it"
echo "${0:t} WARNING $0:t is deprecated/unnecessary; you should not have to call it"
echo ""
echo "Instead do:"
echo "  export USE_VERILATOR_HACKS=TRUE"
echo "  cd $topdir; ./build_cgra.sh"
echo "  [optional] $topdir/bin/show_cgra_info.csh"
echo ""
echo ""

# The whole point of this script is to use verilator...right?
setenv USE_VERILATOR_HACKS "TRUE"
unset echo

cd $topdir
  if (-e ./genesis_clean.cmd) ./genesis_clean.cmd
  ./build_cgra.sh || exit -1
  if ($?VERBOSE) ./bin/show_cgra_info.csh







# source $CGROOT/bin/genesis2_setup.csh
# if ($?VERBOSE) then
#   echo -n "generate.csh: "; which Genesis2.pl
# endif
# 
# ##############################################################################
# # Run the generator, but first clean up from prior runs.  Die if gen error.
# 
# set echo
# # The whole point of this script is to use verilator...right?
# setenv USE_VERILATOR_HACKS "TRUE"
# unset echo
# 
# 
# # cd hardware/generator_z/top
# cd $CGROOT/hardware/generator_z/top
#     if (-e ./genesis_clean.cmd) ./genesis_clean.cmd
# 
#     # NOTE THIS IS THE RUN.CSH IN HARDWARE/GENERATOR_Z
#     set run = run.csh
#     set path = (. $path)
#     
#     if ($?VERBOSE) then
#       echo "";
#       echo "generate.csh: Generator build_cgra.sh looks like this:"; 
#       cat build_cgra.sh \
#         | sed -n '/^Genesis/,/exit/p' \
#         | awk '{print "#   " $0}'
#       echo ""
#       build_cgra.sh -v || exit -1
# 
#       ####################################################################
#       # Use resulting top.v to print out information about what was built.
# 
#       $CGROOT/bin/find_cgra_info.csh genesis_verif/top.v || exit -1
#       echo
#     else
#       set logfile = /tmp/generate_log.$$
#       echo "Generator output to $logfile"
#       run.csh >& $logfile || exit -1
#     else
#     endif
# 
#     # New cgra_info is proof that something happened
#     # ls -l cgra_info.txt examples/*.txt
#     if ($?VERBOSE) ls -l cgra_info.txt
