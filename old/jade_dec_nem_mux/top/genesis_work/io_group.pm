package io_group;
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
sub get_SrcSuffix {Genesis2::UniqueModule::private_to_me(); return ".svp";};
sub get_OutfileSuffix {Genesis2::UniqueModule::private_to_me(); return ".sv"};
############################### Module Starts Here ###########################


  sub to_verilog{ 
      # START PRE-GENERATED TO_VERILOG PREFIX CODE >>>
      my $self = shift;
      
      print STDERR "$self->{BaseModuleName}->to_verilog: Start user code\n" 
	  if $self->{Debug} & 8;
      # <<< END PRE-GENERATED TO_VERILOG PREFIX CODE
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/io_group.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/io_group.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/io_group.svp"
 use POSIX;

 my $side = parameter(Name=>'side', value=>'N', 
   Doc=>"Which side of the chip are we on?", list=>['N','S','E','W']);
 my $group_num = parameter(Name=>'group_num', value=>0, min=>0, step=>1);
 my $num_ios = parameter(Name=>'num_ios', value=>16,min=>1,step=>1);
 my $config_addr_width = parameter(Name=>'config_addr_width', val=>32, min=>1, step=>1);
 my $config_data_width = parameter(Name=>'config_data_width', val=>32, min=>1, step=>1);
 
 # my $tristate_supported = parameter(name=>'tristate_supported', val=>0, list=>[0,1]);
 my $tristate_supported = 1;
 if (exists $ENV{"TRISTATE_UNAVAILABLE"}) { $tristate_supported = 0; }
 
 # This is to convert the direction to a side number that the rest of CGRAGenerator uses
 my %side_to_side_num = ('N',3,  'S',1,  'E',0,  'W',2);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// io group '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $group_num; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_read,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_write,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_wide,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_1bit,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data_tile ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # Given IO number (0..16n) on side N, S, E or W, return row, col of io tile
 sub io_row_col {
   # parms
   # Note num_ios = num_ios_per_group e.g. 16
   my ($i, $side, $num_ios, $group_num) = @_;
   my ($row,$col) = (-1,-1);
   my $group_offset = ($num_ios * $group_num);
 
   if    ($side eq "N") { $row = 0 }                                # 0
   elsif ($side eq "E") { $row = $group_offset + ($num_ios - $i) }  # 16:1, 32:17, ...
   elsif ($side eq "W") { $row = $group_offset + (1 + $i) }         # 1:16, 17:32, ...
   elsif ($side eq "S") { $row = 1 + $num_ios }                     # 17

   if    ($side eq "N") { $col = $group_offset + ($num_ios - $i) }  # 16:1, 32:17, ...
   elsif ($side eq "E") { $col = 1 + $num_ios; }                    # 17
   elsif ($side eq "W") { $col = 0; }                               # 0
   elsif ($side eq "S") { $col = $group_offset + (1 + $i) }         # 1..16

   return ($row,$col);
 }
 sub print_io_collateral {
   my ($i, $id, $hex_id, $row, $col, $group_num, $side, $side_num) = @_;
   my $bitnum = ($i % 16);
   my $tracknum = 0; # Input track (used to interleave; now it's always 0).
   my $portside = ($side_num + 2) % 4;
 
   my @collateral = (
 "  <tile type='io1bit' tile_addr='$hex_id' row='$row' col='$col' ".
 "name='pads_${side}_${group_num}'>",
 "    <io_bit>$bitnum</io_bit>",
 "    <io_group>$group_num</io_group>",
 "    <tri feature_address='0' reg_address='0' bitl='0' bith='0'>",
 "        <direction sel='0'>in</direction>  <!--input-->",
 "        <direction sel='1'>out</direction> <!--output-->",
 "    </tri>",
 "    <mux feature_address='0' reg_address='0' bitl='1' bith='1'>",
 "        <src sel='0'>16</src> <!-- 16 bit mode -->",
 "        <src sel='1'>1</src>  <!--  1 bit mode -->",
 "    </mux>",
 "",
 "    <!-- input goes from pad to ALL tracks -->",
 "    <p2f_1bit>out_1BIT_S${portside}_T0</p2f_1bit>",
 "    <p2f_1bit>out_1BIT_S${portside}_T1</p2f_1bit>",
 "    <p2f_1bit>out_1BIT_S${portside}_T2</p2f_1bit>",
 "    <p2f_1bit>out_1BIT_S${portside}_T3</p2f_1bit>",
 "    <p2f_1bit>out_1BIT_S${portside}_T4</p2f_1bit>",
 "",
 "    <!-- output only comes from track 0 -->",
 "    <f2p_1bit>in_1BIT_S${portside}_T${tracknum}</f2p_1bit>");

 # Add 16-bit info if io1bit tile is LSB
   if ($i == 15) {
     push @collateral, (
 "",
 "    <!-- 16bit IO same exc. BUS16 instead of BUS1 -->",
 "    <p2f_wide>out_16BIT_S${portside}_T0</p2f_wide>",
 "    <p2f_wide>out_16BIT_S${portside}_T1</p2f_wide>",
 "    <p2f_wide>out_16BIT_S${portside}_T2</p2f_wide>",
 "    <p2f_wide>out_16BIT_S${portside}_T3</p2f_wide>",
 "    <p2f_wide>out_16BIT_S${portside}_T4</p2f_wide>",
 "    <f2p_wide>in_16BIT_S${portside}_T${tracknum}</f2p_wide>",
 "");
   }
   push @collateral,
 "  </tile>\n";
 
   # Print collateral as a comment in the verilog why not
   print "// ".join("\n// ", @collateral);

   # Print collateral as a string in the top-level CGRA_INFO array
   @top::CGRA_INFO[$id] = join("\n", @collateral);

   # no we don't do this no more (right?)
   # my $filename = "TILE".$self->mname();
   # open(TILEINFO, ">>$filename") or die "Couldn't open file $filename, $!";
   # print TILEINFO join("\n", @collateral);
   # close TILEINFO;
 }

 # Count *DOWN* from 15 to 0 (little endian)
 for (my $i=($num_ios-1); $i >=0; $i--) {

   # <tile type='io1bit' tile_addr='0x2' row='0' col='2' tracks='BUS1:1 BUS16:0' name='pad_S0_T0'>
   my ($row,$col) = io_row_col($i, $side, $num_ios, $group_num);

   my $id = ($row<<8) + $col;
   my $hex_id = sprintf("0x%04X", $id);
   
   my $io1bit_obj = generate("io1bit", "io1bit_${hex_id}", 
     side=>$side_to_side_num{$side}, io_group=>$group_num);

   # Need verilog-formatted hex id e.g. "0x0110" => "16'h0110"
   my $vhex_id = sprintf("16'h%04X", $id);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io1bit_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (     // '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $group_num; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(pads['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad_in(pads_in['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad_out(pads_out['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .read_data(read_data_tile['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .f2p_16(f2p_wide['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .f2p_1(f2p_1bit['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(p2f['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .tile_id('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $vhex_id; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   # $io1bit_obj = clone($io1bit_obj, "io1bit_@{[$i+1]}");
 
   my $side_num = $side_to_side_num{$side};
   print_io_collateral($i, $id, $hex_id, $row, $col, $group_num, $side, $side_num);
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// SV equivalent: assign read_data = read_data_tile.or();';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  read_data = 0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  for (integer i=0; i < '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '; i++)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    read_data = read_data | read_data_tile[i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/io_group.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
