package io16bit;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Exporter;
use FileHandle;
use Env; # Make environment variables available


use Genesis2::Manager 1.00;
use Genesis2::UniqueModule 1.00;

@ISA = qw(Exporter Genesis2::UniqueModule);
@EXPORT = qw();
@EXPORT_OK = qw();
$VERSION = '1.0';
sub get_SrcSuffix {Genesis2::UniqueModule::private_to_me(); return ".vp";};
sub get_OutfileSuffix {Genesis2::UniqueModule::private_to_me(); return ".v"};
############################### Module Starts Here ###########################


  sub to_verilog{ 
      # START PRE-GENERATED TO_VERILOG PREFIX CODE >>>
      my $self = shift;
      
      print STDERR "$self->{BaseModuleName}->to_verilog: Start user code\n" 
	  if $self->{Debug} & 8;
      # <<< END PRE-GENERATED TO_VERILOG PREFIX CODE
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io16bit/io16bit.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io16bit/io16bit.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io16bit/io16bit.vp"
 use POSIX;
 my $io_group = parameter(Name=>'io_group', val=> -1, doc=>'specifies the IO group the IO belongs to');
 my $side = parameter(Name=>'side', val=> 0, doc=>'specifies the side (0=right/1=bottom/2=left/3=top) of the pad on which fabric wires exist ');
 my $width = parameter(Name=>'width', val=> 16, doc=>'bus width');
 my $num_tracks = 5;
 # FIXME THIS (num_tracks) SHOULD NOT BE HARD-CODED HERE!!!
 # FIXME (cont.) SEE top.vp for how io1bit does it, look for '<input'
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
my $filename = "TILE".$self->mname();
open(TILEINFO, ">$filename") or die "Couldn't open file $filename, $!";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'p2f_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'p2f_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'f2p_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'f2p_out';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${side}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${width}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${io_group}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign p2f_out = p2f_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign f2p_out = f2p_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # Bitstream writer must set direction bits of all 1bit IO tiles in the IO group
 # to set direction for a 16 bit IO tile. Hardware wont do it.
 # For PNR puposes, the opration is identical for both 1 bit and 16 bit IO tiles.
 # PNR sets the direction tag below for 16 bit and 1 bit IO tiles.
print TILEINFO "  <io_group>$io_group</io_group>\n";
print TILEINFO "  <tri feature_address='0' reg_address='0' bith='0' bitl='0'>\n";
print TILEINFO "    <direction sel='0'>in</direction>\n";
print TILEINFO "    <direction sel='1'>out</direction>\n";
print TILEINFO "  </tri>\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
#print TILEINFO "        <direction in='0' out='1'>0</direction>\n";
print TILEINFO "  <input>in_16BIT_S${side}_T0</input>\n";
for(my $track = 0; $track < $num_tracks; $track++) {
	print TILEINFO "  <output>out_16BIT_S${side}_T$track</output>\n";
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
close TILEINFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io16bit/io16bit.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
