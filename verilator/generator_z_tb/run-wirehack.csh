#!/bin/csh -f

# Helper for run.csh; hacks wirenames into top.v for verilator i/o.
# Example: $0
#     -inwires  'wire_0_m1_BUS16_S0_T0 wire_m1_0_BUS16_S1_T0 wire_1_m1_BUS16_S0_T2 wire_4_0_BUS16_S3_T2'
#     -outwires 'wire_1_2_BUS16_S3_T0'
#     -vtop     '../../hardware/generator_z/top/genesis_verif/top.v'

while ($#argv)
  switch ("$1")

    case -vtop:
      set vtop = "$2"; shift; breaksw

    case -inwires:
      set inwires = "$2"; shift; breaksw

    case -outwires:
      set outwires = "$2"; shift; breaksw

    default:
      echo "ERROR Unknown switch '$1'"; exit -1
  endsw
  shift;
end

# Don't do it if it's already done!
unset already_done
egrep 'wire.*VERILATOR_PORT' $vtop > /dev/null && set already_done
if ($?already_done) then
  echo 'WARNING: wirehack appears to already be done, will not do again.'
  exit 0
endif

set tmpdir = /tmp/wirehack$$; mkdir $tmpdir
cp $vtop $tmpdir/top.v.orig

set DBG
echo difffff

# UH OH what if wire already exists as a port!!?
# Ans: delete port info and continue as before
foreach port ($inwires $outwires)
  egrep input'.*'$port $vtop > /dev/null && set OHNO
  if ($?OHNO) then
    echo "OHNO!  '$port' already defined!"

    # DELETE input port and declaration
    #    "wire_m1_1_BUS16_S1_T0,"                  (in module paren parms)
    #    "  input [15:0] wire_m1_1_BUS16_S1_T0;"
    # 
    # BUT NOT connection
    #    "      .in_BUS16_S3_T0(wire_m1_1_BUS16_S1_T0),"
    # 
    sed "/${port}[^)]*"'$/d' $vtop > $tmpdir/tmp$$
    mv $tmpdir/tmp$$ $vtop;
    if ($?DBG) diff $tmpdir/top.v.orig $vtop | sed 's/  */ /g' | sed 's/^/    /'
    if ($?DBG) echo "------------------------------------------------------"


  endif
end

# // VERILATOR_PORT1,2,3...
# Build ports for verilator input and output signals
set i = 0; echo "  Adding ports for verilator inputs and outputs..."
foreach port ($inwires $outwires)
  sed "s|\(// VERILATOR_PORT$i\)|$port,               \1|" $vtop > $tmpdir/tmp$$
  echo "    $port..."; mv $tmpdir/tmp$$ $vtop; @ i = $i + 1
end
echo
if ($?DBG) diff $tmpdir/top.v.orig $vtop | sed 's/  */ /g' | sed 's/^/    /'
if ($?DBG) echo "------------------------------------------------------"
#     < // VERILATOR_PORT0
#     < // VERILATOR_PORT1
#     ---
#     > wire_1_0_BUS16_S1_T1, // VERILATOR_PORT0
#     > wire_m1_1_BUS16_S1_T0, // VERILATOR_PORT1

# // VERILATOR_IN1,2,3...
# Declare verilator input signals...
set i = 0; echo "  Adding verilator input declarations..."
foreach wirename ($inwires)
  sed "s|\(// VERILATOR_IN$i\)|input  [15:0] $wirename; \1|" $vtop > $tmpdir/tmp$$
  echo "    $wirename..."; mv $tmpdir/tmp$$ $vtop; @ i = $i + 1
end
echo
if ($?DBG) diff $tmpdir/top.v.orig $vtop | sed 's/  */ /g' | sed 's/^/    /'
if ($?DBG) echo "------------------------------------------------------"



# // VERILATOR_OUT1,2,3...
# Declare verilator output signals...
set i = 0; echo "  Adding verilator output declarations..."
foreach wirename ($outwires)
  sed "s|\(// VERILATOR_OUT$i\)|output [15:0]  $wirename; \1|" $vtop > $tmpdir/tmp$$
  echo "    $wirename..."; mv $tmpdir/tmp$$ $vtop; @ i = $i + 1
end
echo
# diff $tmpdir/top.v.orig $vtop | sed 's/  */ /g' | sed 's/^/    /'

# Disconnect "input" wires from internal net (and route to ports instead)
echo "  Disconnecting input wires from internal net..."
foreach inwire ($inwires)
  (egrep "out.*$inwire" $vtop > /dev/null)\
    || echo "    Wire not found in internal net of top.v"

  # sed "s/\(.*[.]out.*\)$inwire/\1/" $vtop > $tmpdir/tmp$$
  # oops new io tiles do this kind of assignment:
  #    .p2f_out(wire_2_1_BUS16_S0_T0),
  # instead of prev
  #    .out_BUS16_S2_T0(wire_2_1_BUS16_S0_T0),
  # Does it work to just remove the dot?
  sed "s/\(.*out.*\)$inwire/\1/" $vtop > $tmpdir/tmp$$

  # diff $vtop $tmpdir/tmp$$ | egrep '^[<>]' | sed 's/  */ /g' | sed 's/^/    /'
  echo "    $inwire..."; mv $tmpdir/tmp$$ $vtop
end
echo

# Show what we did
echo Changes to top.v:  ; echo
  diff $tmpdir/top.v.orig $vtop | sed 's/  */ /g' | sed 's/^/    /' > $tmpdir/tmp$$

  cat $tmpdir/tmp$$ | egrep '^ *<' | egrep 'PORT'; echo "    ---"
  cat $tmpdir/tmp$$ | egrep '^ *>' | egrep 'PORT'; echo; echo

  cat $tmpdir/tmp$$ | egrep '^ *<' | egrep 'IN|OUT'; echo "    ---"
  cat $tmpdir/tmp$$ | egrep '^ *>' | egrep 'IN|OUT'; echo; echo

  cat $tmpdir/tmp$$ | egrep '^ *<' | egrep -v 'VERILATOR'; echo "    ---"
  cat $tmpdir/tmp$$ | egrep '^ *>' | egrep -v 'VERILATOR'; echo; echo



# Suggestion for how to see all changes in context...
echo To see all changes in context, try:
echo "  diff --side-by-side -W 100 $tmpdir/top.v.orig $vtop | less"
echo

# Clean up
/bin/rm -rf $tmpdir
