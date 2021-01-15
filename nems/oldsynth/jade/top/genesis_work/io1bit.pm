package io1bit;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io1bit/io1bit.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io1bit/io1bit.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io1bit/io1bit.vp"
 use POSIX;
 my $io_group = parameter(Name=>'io_group', val=> -1, doc=>'specifies the IO group the IO belongs to');
 my $side = parameter(Name=>'side', val=> 0, doc=>'specifies the side (0=right/1=bottom/2=left/3=top) of the pad on which fabric wires exist ');

 # my $tristate_supported = parameter(name=>'tristate_supported', val=>0, list=>[0,1]);
 my $tristate_supported = 1;
 if (exists $ENV{"TRISTATE_UNAVAILABLE"}) { $tristate_supported = 0; }
 
my $filename = "TILE".$self->mname();
open(TILEINFO, ">$filename") or die "Couldn't open file $filename, $!";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  clk, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate available: one pad per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate unavailable: two pads per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  pad_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  pad_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  p2f,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  f2p_16,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  f2p_1,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_write,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_read,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  tile_id,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_off UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate available: one pad per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout  pad;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate unavailable: two pads per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  pad_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output pad_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output p2f;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input f2p_16;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input f2p_1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_read;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_write;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [15:0] tile_id;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg [31:0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_on UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${side}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${io_group}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   # Bits [31:24] are for switch box, [23:0] for connection box.
   # So we have to let the linter know (verilator 'lint_off' directives above) or it complains:
   # %Warning-UNUSED: .../cb_unq1.v:73: Bits of signal are not used: config_addr[23:0]
   # FIXME someday? Maybe shouldn't bring in all 32 bits if we're not going to use them?  Then turn off directives!
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg config_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       config_en = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if (config_write&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d0)) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg io_bit;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg out_bus;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       io_bit  <= 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       out_bus <= 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if (config_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         io_bit  <= config_data[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         out_bus <= config_data[1];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (config_read&&(config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d0)) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      read_data = {30\'h0, out_bus, io_bit}; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      read_data = \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate available: one pad per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign pad     = (io_bit==1\'b1)? ((out_bus==1\'b0)? f2p_16 : f2p_1):1\'bz;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign p2f     = pad;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // tristate unavailable: two pads per IO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign pad_out = (io_bit==1\'b1)? ((out_bus==1\'b0)? f2p_16 : f2p_1) : 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign p2f     = (io_bit==1\'b1)?            1\'b0                   : pad_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print TILEINFO "    <io_group>$io_group</io_group>\n";
print TILEINFO "    <tri feature_address='0' reg_address='0' bitl='0' bith='0'>\n";
print TILEINFO "        <direction sel='0'>in</direction>  <!--input-->\n";
print TILEINFO "        <direction sel='1'>out</direction> <!--output-->\n";
print TILEINFO "    </tri>\n";
print TILEINFO "    <mux feature_address='0' reg_address='0' bitl='1' bith='1'>\n";
print TILEINFO "        <src sel='0'>16</src> <!-- 16 bit mode -->\n";
print TILEINFO "        <src sel='1'>1</src>  <!--  1 bit mode -->\n";
print TILEINFO "    </mux>\n";
close TILEINFO;
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/io1bit/io1bit.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
