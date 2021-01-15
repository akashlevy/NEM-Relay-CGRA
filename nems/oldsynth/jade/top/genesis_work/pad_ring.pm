package pad_ring;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/pad_ring.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/pad_ring.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/pad_ring.svp"
 use POSIX;
 my $num_ios_per_group = parameter(Name=>'num_ios_per_group', val=>16, min=>1, step=>1);
 my $num_groups_per_side = parameter(Name=>'num_groups_per_side', val=>1, min=>1, step=>1);
 my $config_addr_width = parameter(Name=>'config_addr_width', val=>32, min=>1, step =>1);
 my $config_data_width = parameter(Name=>'config_data_width', val=>32, min=>1, step =>1);
 
 # my $tristate_supported = parameter(name=>'tristate_supported', val=>0, list=>[0,1]);
 my $tristate_supported = 1;
 if (exists $ENV{"TRISTATE_UNAVAILABLE"}) { $tristate_supported = 0; }
 
 my $group = 0;
 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// This module contains all of the io1bit and io16bit tiles in the CGRA.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # I need this order for debugging; we can change it back later if you like...
 my @sides = ('N','E','S','W');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tck_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tms_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tdi_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input trst_n_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output tdo_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_read,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_write,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output tck,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output tdi,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output tms,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output trst_n,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tdo,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data_group ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($num_groups_per_side * 4)-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for my $side (@sides) {
   for (my $i = 0; $i<$num_groups_per_side; $i++) {
     my $io_group_obj = generate("io_group","io_side_${side}_gr_${i}",
       side => $side, 
       group_num           => $i,
       config_addr_width   => $config_addr_width,
       config_data_width   => $config_data_width
     );
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io_group_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .f2p_wide(f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .f2p_1bit(f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pads(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pads_in(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pads_out(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .read_data(read_data_group['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $group; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $group++;
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // System Verilog equivalent: assign read_data = read_data_group.or();';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  read_data = 0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  for (integer i=0; i < '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_groups_per_side * 4; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '; i++)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    read_data = read_data | read_data_group[i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Instantiate IO cells for non-configurable IOs (clk, reset, JTAG signals)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input clk pad ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $clk_input_obj = generate("fixed_io", "clk_input_cell", is_input=>1);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $clk_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(clk_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(clk)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input reset pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $reset_input_obj = clone($clk_input_obj, "reset_input_cell");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reset_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(reset_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(reset)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input tck pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $tck_input_obj = clone($clk_input_obj, "tck_input_cell");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tck_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(tck_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(tck)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input tdi pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $tdi_input_obj = clone($clk_input_obj, "tdi_input_cell");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tdi_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(tdi_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(tdi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input tms pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $tms_input_obj = clone($clk_input_obj, "tms_input_cell");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tms_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(tms_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(tms)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//input trst_n pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $trst_n_input_obj = clone($clk_input_obj, "trst_n_input_cell");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $trst_n_input_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(trst_n_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .p2f(trst_n)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//output tdo pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $tdo_output_obj = generate("fixed_io", "tdo_output_cell", is_input=>0);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tdo_output_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .pad(tdo_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .f2p(tdo)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/pad_ring.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
