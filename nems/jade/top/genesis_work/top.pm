package top;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/top.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/top.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/top.vp"
 # Experimenting with globals
 our @CGRA_INFO;
 our $CONNECT_INFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// New Top level that contains CGRA_core module and IO pad_ring module';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 #TOP LEVEL PARAMS
 my $num_io_groups_per_side = parameter(name=>'num_io_groups_per_side', val=>1, min=>1, step=>1);
 #Other values
 my $num_ios_per_group = 16;
 my @sides = ('N','S','E','W');
 my $connect_GC = parameter(name=>'connect_GC', val=>0, min=>0, max=>1, step=>1);
 my $config_addr_width = parameter(name=>'config_addr_width', val=>32, min=>1, step=>1);
 my $config_data_width = parameter(name=>'config_data_width', val=>32, min=>1, step=>1);
 my $num_stall_domains = parameter(name=>'num_stall_domains', val=>4, min=>1, step=>1);
 
 # my $tristate_supported = parameter(name=>'tristate_supported', val=>0, list=>[0,1]);
 my $tristate_supported = 1;
 if (exists $ENV{"TRISTATE_UNAVAILABLE"}) { $tristate_supported = 0; }
 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //pads_{side}_{group_num_within_side} [bit number within group]';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i<$num_io_groups_per_side; $i++) {
   if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  inout ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pads_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
 if ($connect_GC == 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_data_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_addr_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tck_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tms_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input trst_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input tdi_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output tdo_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset_pad';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($connect_GC == 1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_data_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_addr_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire tck;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire tdi;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire tms;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire trst_n;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire config_read;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire config_write;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data_core;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_data_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] read_data_pads;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_stall_domains-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] stall;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign read_data = read_data_core | read_data_pads;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $global_controller_obj = generate("global_controller", "global_controller");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $global_controller_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_in(clk_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .reset_in(reset_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($connect_GC == 1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_out(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .reset_out(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_addr_out(config_addr_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_data_out(config_data_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_data_in(read_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdi(tdi),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdo(tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tms(tms),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tck(tck),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .trst_n(trst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .cgra_stalled(stall),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read(config_read)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($connect_GC == 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign clk = clk_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign reset = reset_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign config_write = 1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 my $jtag_ifc_path = parameter(NAME => 'IFC', VAL => $global_controller_obj -> get_param('IFC'), DOC => "Path to JTAG interface for JTAGDriver");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $cgra_core_obj = generate_base("cgra_core","core", num_io_groups_per_side => $num_io_groups_per_side);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cgra_core_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_addr(config_addr_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_data(config_data_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .stall(stall),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .read_data(read_data_core)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $pad_ring_obj = generate_base("pad_ring", "pads",
   num_groups_per_side => $num_io_groups_per_side);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $pad_ring_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($tristate_supported) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out(pads_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_out),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_data(config_data_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_addr(config_addr_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .read_data(read_data_pads),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk_pad(clk_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset_pad(reset_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tck_pad(tck_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tdi_pad(tdi_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tms_pad(tms_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .trst_n_pad(trst_n_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tdo_pad(tdo_pad),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk(clk_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset(reset_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tck(tck),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tdi(tdi),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tms(tms),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .trst_n(trst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .tdo(tdo)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if (0) {
open(INFO, ">>cgra_info.txt") or die "Couldn't open file cgra_info.txt, $!";
 for my $side (1,2,3,4) {
    my $fname = "TILEio_group_unq$side";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    // $fname';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    open(INP, "<$fname") or die "Couldn't open file $fname, $!";
    while (<INP>) { print INFO $_; }
    close INP;
 }
 print INFO "</CGRA>\n";
 close INFO;
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 open(INFO2, ">cgra_info.xml") or die "Couldn't open file cgra_info.xml, $!";
 print INFO2 "<CGRA>\n";
 print INFO2 $top::CONNECT_INFO;
 for my $i (0 .. $#top::CGRA_INFO) {
     # print INFO2 "----\n" . @top::CGRA_INFO[$i] . "\n";
     # print INFO2 sprintf("\n0x%04X\n", $i);
     print INFO2 @top::CGRA_INFO[$i];
     # FIXME/TODO if no info, emit an empty tile
 }
 print INFO2 "</CGRA>\n";
 close INFO2;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if (0) {
 open(INFO2, ">cgra_info.xml") or die "Couldn't open file cgra_info.xml, $!";
 print INFO2 "<CGRA>\n";
 
 # First sixteen tiles are IO
 for my $i (0 .. 15) {
     print INFO2 @top::CGRA_INFO[$i];
 }
 my ($n_begin,$e_begin,$s_begin,$w_begin) = (0,16,32,48);
 # Then sixteen rows of main grid bounded by IO
 for my $a (0 .. 15) {
    my $i;
    for my $b (0..17) {
       if ($b == 0) { $i = $a + $w_begin; }           # west side pads
       elsif ($b == 17) { $i = $a + $e_begin; }       # east side pads
       else { $i = (4*16) + (16*$a) + ($b-1); } # pe/mem tiles
       print INFO2 @top::CGRA_INFO[$i];
    }
 }
 # Final sixteen tiles are IO (south side pads)
 for my $i ($s_begin .. ($s_begin+15)) {
     print INFO2 @top::CGRA_INFO[$i];
 }
 # Remaining tiles (gst)
 for my $i ((4*16+16*16) .. $#top::CGRA_INFO) {
     print INFO2 @top::CGRA_INFO[$i];
 }
 
 print INFO2 "</CGRA>\n";
 close INFO2;
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/top.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
