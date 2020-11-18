package cgra_core;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/cgra_core.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/cgra_core.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/cgra_core.vp"
 #///////////////////////////////////////////////////////////////////
 #// CGRA TOP generator 
 #//
 #//////////////////////////////////////////////////////////////////
 use POSIX;
 #
 #### CHANGE THIS TO 1 TO CONNECT ALL GC SIGNALS FOR TAPEOUT @NIKHIL
 my $include_analog_block = parameter(NAME => 'include_analog_block', val => 0, Min => 0, Max => 1, Step => 1);

 my $mem_tile_height = parameter(
    doc => 'height of memtile relative to minimum grid height',
    name=>'mem_tile_height',
    val => 1,
    min=>1, max=>2, step=>1);

 my $include_GST = parameter(NAME => 'include_GST', val => 1, Min => 0, Max => 1, Step => 1);
 my @sides = ('N','S','E','W');

 #########################################
 #// Generator Configuration Start 
 ######################################### 
 #
 # Specify the CGRA grid size as 8x8,16x16, or 64x64. You can generate additional sizes by modifying
 # the IO_count and basic_block_repeat_* variables below.
 # my $grid_size = "8x8";
 # my $grid_size ="48x48";
 # my $grid_size = "64x64";
 my $grid_size = "16x16";

 # For IOs
 # <number of bits> <number of bits> <number of bits> <number of bits>
 # There are four die sides 0,1,2,3 = E,S,W,N that can host IOs. Each token in the string
 # above specifies IO count on a side, starting from the right side and going clockwise eg:
 # "10 11 12 13" implies 10 IOs on the right side, 11 IOs on the bottom, and so on. Each IO
 # will generate a 1-bit IO tile on the specified side. The generator will greedily form
 # groups of 16 1-bit IOs to create a 16-bit bus. The 16-bit bus feeds to/from the
 # MSB IO tile of the group. IO tiles are of size 1x1. IO tiles occupy separate rows 
 # (or columns) on the CGRA fabric. Any unused space on the IO row is filled with empty
 # tiles. Empty tiles do not contain any resources or even wires. IOs are numbered
 # clockwise starting from MSB i.e bit 15 will be at the top on the right side,
 # rightmost on the bottom side and so on.
 my @IO_count = qw(16 16 16 16); # Default is 16x16
 if ($grid_size == "8x8")   { @IO_count = qw(8 8 8 8); }
 if ($grid_size == "16x16") { @IO_count = qw(16 16 16 16); }
 if ($grid_size == "48x48") { @IO_count = qw(32 32 32 32); }
 if ($grid_size == "64x64") { @IO_count = qw(64 64 64 64); }
 my $num_ios_per_group = 16;
 my $num_io_groups_per_side = 
    parameter(name => 'num_io_groups_per_side', val => 1, min => 1, step => 1);
 #
 # Specify, in form of a AxB grid, the basic tile pattern that repeats. Each
 # grid node represents a unit tile (1x1) on the CGRA fabric. Assign a tile
 # type to each node. Tile types are listed above. If the width or height of
 # a tile type is more than 1x1 (eg: memory), pad the the tile type in the 
 # grid with Xes (eg: if mem tile width is 2, the tile will be instantiated
 # in the grid as 'mem X'. If tile height is 2, the node in the row below the
 # tile node will be X). Multiple spaces are treated as a single space. Do
 # not include IO tiles in the basic block.
 #
 my $basic_block  = "pe pe pe mem\n";
    $basic_block .= "pe pe pe X  ";
 
 if ($mem_tile_height == 1) {
    $basic_block  = "pe pe pe mem\n";
    $basic_block .= "pe pe pe mem  ";
 }
  
 # Number of times the basic block repeats in the horizontal direction.
 #
 my $basic_block_repeat_x = 8;
 #
 # Number of times the basic block repeats in the vertical direction
 #
 my $basic_block_repeat_y = 16;
 #
 if ($grid_size == "8x8")   { $basic_block_repeat_x =  2; $basic_block_repeat_y =  4; }
 if ($grid_size == "64x64") { $basic_block_repeat_x = 16; $basic_block_repeat_y = 32; }
 if ($grid_size == "16x16") { $basic_block_repeat_x =  4; $basic_block_repeat_y = 8; }
 if ($grid_size == "48x48") { $basic_block_repeat_x = 12; $basic_block_repeat_y = 24; }
 $basic_block_repeat_x = 4; $basic_block_repeat_y = 8;
 #
 #
 # Specify the bus configuration below. 
 # This parm lets you set width, number, and segment length of buses.  
 # eg: <BUS_NAME>:<number of bits>b#<seg1_length>_<seg1_register_after_hops>:
 #     <seg2_length>_<seg2_register_after_hops>:...
 #
 # my $bus_config = "BUS16:16b#1_4:1_4:1_4:1_4:1_4 BUS1:1b#1_4:1_4:1_4:1_4:1_4";
 # if ($ENV{'CGRA_GEN_ALL_REG'}==1) {
 #   $bus_config = "BUS16:16b#1_1:1_1:1_1:1_1:1_1 BUS1:1b#1_1:1_1:1_1:1_1:1_1";
 # }
 # SR 09/2018: Changed default to "everything registered"
 # In future, change this using approved means (xml config), *not* environment variable!!
 my $bus_config = "BUS16:16b#1_1:1_1:1_1:1_1:1_1 BUS1:1b#1_1:1_1:1_1:1_1:1_1";
 
 
 # specify the number of global signals available for each pe/mem tile
 my $global_signal_count = 4;
 #
 # IMP: ensure cb_connections length is equal to (num of tracks defined in bus_config)*2 + num of global signals
 #      eg: for 5 wires and 4 global signals, set cb_connections = "11111111111111" i.e. 5*2 + 4 = 14
 #      '1' bits to enable muxing of all wires passing through the CB. Unpredictable behavior will result if this
 #      is not done correctly.
 #
 my $cb_connections = "11111111111111";
 #
 ###########################################
 # Restricted variables. Do not change.
 ###########################################
 my $all_segments_for_all_tiles = 1;
 my $sides = 4;
 my $sb_fs = "10000#10000#10000";
 ###########################################
 ###########################################
 #
 # Specify all tiles used in the CGRA, and their configuration parameters below. The configuration parameters will be passed 
 # by the top level generator to the tile generators automatically (no modifications to the top level generator are needed when
 # paramaters are added/removed/edited from the list of a tile's parameters). Some parameters like type, tile_width, tile_height
 # are used by the top level generator and must be defined for all tiles. These wont be passed to the tile genrators.
 # For a list and for details about a tile generator's parameters, refer to the generator's .vp file. The parameters are usually
 # defined at the top of the .vp file.
 #
 my $tile_config;
 $tile_config->{ 'pe' } = {
       type => 'pe_tile_new',
       tile_height => 1,
       tile_width => 1,
       sides => $sides,
       is_bidi => 0,
       bus_config => $bus_config,
       cb_connections => $cb_connections,
       global_signal_count => $global_signal_count,
       has_constant => 0,
       reg_inputs => 1,
       reg_out => 0, 
       use_add => 1,
       use_cntr => 1,
       use_bool => 1,
       use_shift => 1,
       use_div => 0,
       mult_mode => 1,
       is_msb => 0,
       en_double => 0,
       lut_inps => 3,
       sb_fs => $sb_fs,
       all_segments_for_all_tiles => $all_segments_for_all_tiles
 };
 $tile_config->{ 'mem' } = {
       type => 'memory_tile',
       tile_height => $mem_tile_height,
       tile_width => 1,
       gen_mem_for_busname => 'BUS16',
       control_busname => 'BUS1',
       ddepth => 1024,
       bus_config => $bus_config,
       cb_connections => $cb_connections,
       global_signal_count => $global_signal_count,
       sb_fs => $sb_fs
 };
 $tile_config->{ 'io1' } = {
       type => 'io1bit',
       tile_height => 1,
       tile_width => 1,
       pad_name => 'none',  # E.g. 'pad_S0_T0' = MSB on E side
       bit_pos => -1,       # E.g. 0 for LSB within group, 15 for MSB
 };
 $tile_config->{ 'io16' } = {
       type => 'io16bit',
       tile_height => 1,
       tile_width => 1,
 };
 $tile_config->{ 'empty' } = {
       type => 'empty',
       tile_height => 1,
       tile_width => 1,
 };
 
 #####################################################
 # Done Generator Configuration
 #####################################################
 
 #####################################################
 # OR every read_data output from tile
 #####################################################
my $read_data_pe = '';
my $read_data_global = '';
my $read_data_memory = '';
my $read_data_io1bit = '';
 #####################################################
 #Populate bus track hash
 #####################################################
 my %bus_width_hash = ();
 my %bus_segment_hash = ();
 my %bus_registered_outputs_hash = ();
 my %bus_num_tracks_hash = ();
 foreach my $bus (split(' ', $bus_config)) {
   if ($bus=~m/(BUS\S+):(\S+)b#(\S+)/) {
     my $track_count=0;
     my $bus_name = $1;
     $bus_width_hash{ $bus_name } = $2;
     $bus_segment_hash{ $bus_name } = $3;
     foreach my $seg_info (split(':',$bus_segment_hash{ $bus_name })) {
       $seg_info =~ m/(\S+)_(\S+)/;
       my $segment_length = $1;
       if ($all_segments_for_all_tiles==1) {
         $track_count += $segment_length;
       } else {
         $track_count += 1;
       }
     }
     $bus_num_tracks_hash{ $bus_name } = $track_count;
   }
 }
 #####################################################
 #Setup basic tile pattern
 #####################################################
   $basic_block=~s/[ ]+/ /g;
   my @rows=split /\n/, $basic_block;
   my $h_index = 0;
   my %basic_block_hash = ();
   my $basic_block_width = 0;
   my $basic_block_height = scalar @rows;
   foreach my $r (@rows) {
     my $w_index = 0;
     my @cols=split /\s/, $r;
     $basic_block_width = scalar @cols;
     foreach my $node (@cols) {
       my $key = "${w_index}_${h_index}";
       $basic_block_hash{ $key } = $node;
       $w_index += 1;
     }
     $h_index += 1;
   }
 #####################################################
 #Initialize cgra grid
 #####################################################
 my %tile_grid;
 # CGRA grid width = (block_width * blocks_repeat_x) + 2 IO cols on left + 2 IO cols on right
 my $cgra_grid_width = ($basic_block_width * $basic_block_repeat_x) + 2;
 #
 my $cgra_grid_height = ($basic_block_height * $basic_block_repeat_y) + 2;
 # 
 # Default all cgra grid nodes to empty tile
 for (my $w=0; $w<$cgra_grid_width; $w++) {
   for (my $h=0; $h<$cgra_grid_height; $h++) {
     my $cgra_key = "${w}_${h}";
     $tile_grid{$cgra_key} = 'empty'; 
   }
 }

 # Instantiate nonIO part of the grid using basic block
 for (my $w=1; $w<($cgra_grid_width-1); $w++) {
   for (my $h=1; $h<($cgra_grid_height-1); $h++) {
     my $wa = $w-1; my $ha = $h-1;
     my $cgra_key = "${w}_${h}";
     my $basic_block_key = ($wa % $basic_block_width) . "_" . ($ha % $basic_block_height); 
     $tile_grid{$cgra_key} = $basic_block_hash{$basic_block_key};
   }
 }
 #####################################################
 #Print cgra grid as comments in the verilog file
 #####################################################

 # Header
 my $grid_prefix = "//CGRA  ";
 printf($grid_prefix);
 printf('   ');
 for (my $row=0; $row<$cgra_grid_width; $row++) {
   printf(' %02X', $row);
 }
 print "\n";

 # Body
 for (my $h=0; $h<$cgra_grid_height; $h++) {
   printf($grid_prefix);
   printf(' %02X', $h);
   for (my $w=0; $w<$cgra_grid_width; $w++) {
     # 
     # New stuff: row, col coded in tile address e.g. 0x030A means "row 3, col 10"
     my ($row,$col) = ($h,$w);
     my $tile_count = ($row << 8) + $col;
 
     my $key = "${w}_${h}";
     my $type = $tile_grid{$key};
     # (pe,mem,io1,io16) => (pe,me,io,IO)
     my $t = 'I'; if ($type ne 'io16') { $t = substr($type, 0, 1); }
     my $tile_count_hex = sprintf("0x%X", $tile_count);

     if (($type ne "X") && ($type ne "empty")) {
       printf("%2s ", ${t}, ${tile_count});
     } else {
       printf " ..";
     }

     # FIXME NOTE this is important, it sets a global that is used later (%tile_grid) :(
     if (($type ne "X") && ($type ne "empty")) {
       $tile_grid{"${key}_addr"} = $tile_count;
     }
   }
   print "\n";
 }
 print "\n";
 
 #####################################################
 #Create verilog
 #####################################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// -------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// PLACEHOLDERS FOR VERILATOR PORT WIRES';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT0';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT1';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT2';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT3';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT4';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT5';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT6';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT7';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// VERILATOR_PORT8';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// -------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_read,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  config_write,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($include_analog_block) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//PORTS FOR ANALOG BLOCK';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_cki,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_ckib,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_frefp,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_frefn,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_cki_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_ckib_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_frefp_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ext_frefn_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  clk_ext_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  aux_div_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  fout_div_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  fref_off_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ffeed_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  frefp_out_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  frefn_out_jm,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  mdllout_pad,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  lf_out';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  stall,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
open(INFO, ">cgra_info.txt") or die "Couldn't open file cgra_info.txt, $!";
print INFO "<CGRA>\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [3:0] stall;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_read;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_write;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [31:0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($include_analog_block) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //PADS FOR ANALOG BLOCK';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_cki;  // (+) cmos clock input (reference clock input)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_ckib; // (-) cmos clock input (reference clock input)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_frefp; // (+) low-swing clock input (reference clock input)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_frefn; // (-) low-swing clock input (reference clock input)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_cki_jm;  // (+) cmos clock input (reference clock input) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_ckib_jm; // (-) cmos clock input (reference clock input) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_frefp_jm; // (+) low-swing clock input (reference clock input) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ext_frefn_jm; // (-) low-swing clock input (reference clock input) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk_ext_in;       // external clock for aux osc (valid when aux_sel = 1)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output aux_div_pad;     // aux osc output for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output fout_div_pad;    // divided clock of fref for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output fref_off_pad;    // fref for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ffeed_pad;       // ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output frefp_out_jm;    // (+) frefp for off-chip phase adjustment';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output frefn_out_jm;    // (-) frefp for off-chip phase adjustment';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [3:0] mdllout_pad; // 4-phase MDLL outputs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire [19:0] jm_out;   // number of 1\'s in jitter measurement';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [12:0] lf_out;    // LF output (MSB 7bits for mtune, LSB 6bits for dithering)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // --------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // PLACEHOLDERS FOR VERILATOR INPUT WIRES';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // --------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_IN0';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_IN1';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_IN2';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_IN3';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_IN4';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // --------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//signals to/from pad frame';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for my $side (@sides) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_wide_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] f2p_1bit_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] p2f_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // ---------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // PLACEHOLDERS FOR VERILATOR OUTPUT WIRES';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // ---------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_OUT0';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_OUT1';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_OUT2';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_OUT3';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // VERILATOR_OUT4';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // ---------------------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ###################################################################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_pe;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_global;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_memory;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_io1bit;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($include_analog_block) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //Instantiate analog block';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  mdll_top mdll_top ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_cki(ext_cki),  // (+) cmos clock   . (reference clock   .)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_ckib(ext_ckib), // (-) cmos clock   . (reference clock   .)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_frefp(ext_frefp), // (+) low-swing clock   . (reference clock   .)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_frefn(ext_frefn), // (-) low-swing clock   . (reference clock   .)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_cki_jm(ext_cki_jm),  // (+) cmos clock   . (reference clock   .) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_ckib_jm(ext_ckib_jm), // (-) cmos clock   . (reference clock   .) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_frefp_jm(ext_frefp_jm), // (+) low-swing clock   . (reference clock   .) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_frefn_jm(ext_frefn_jm), // (-) low-swing clock   . (reference clock   .) (jitter measurement)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk_ext_in(clk_ext_in),       // external clock for aux osc (valid when aux_sel = 1)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ref_sel(analog_r0[4]),          // select reference clock   .s (\'1\': ext_cki(b)), \'0\': ext_frefp(n))';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset(analog_r0[3]),  // reset for isynth (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .rstb(analog_r0[2]), // reset for main osc (act Lo)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_inj(analog_r0[1]), // enable injection (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_osc(analog_r0[0]),   // enable main oscillator (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .sel_bb_in(analog_r1[3]),        // select clock source for BB control (\'1\': ), \'0\': )';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_ext_tune(analog_r1[2]),  // initizlize mtune externally (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .bypass_dcdl(analog_r1[1]), // bypass coarse tune (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .loop_sel(analog_r1[0]), // select loop algorithm (\'1\': BB), \'0\': TDC)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .aux_sel(analog_r2[10]),  // select auxilliary osc source (\'1\': ext_clk_in), \'0\': internal osc)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_aux(analog_r2[9]), // enable aux osc (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .aux_div(analog_r2[8]),  // divider aux osc by 2 (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ndiv_aux(analog_r2[7:5]),   // divider ratio of aux ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .aux_tune(analog_r2[4:0]), // aux osc frequency control';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ndiv(analog_r3[5:4]), // feedback divider control';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ndiv_fref(analog_r3[3:0]),  // divider ratio of fref';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .gain_ratio(analog_r4[5:4]), // gain control in LF';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .gain_ctrl(analog_r4[3:0]),  // gain control in LF';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ctune0(analog_r5[3:0]),  // ctune control   . for main osc cell 0';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ctune1(analog_r6[3:0]),  // ctune control   . for main osc cell 1';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ext_mtune(analog_r7[6:0]),  // external mtune (see en_ext_tune)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .m_str(analog_r8[2:0]),  // control driving strength of fine delay cell';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_dith(analog_r9[6:5]),  // enable dithering';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .dith_sel(analog_r9[4]),       // select dithering scheme (\'1\': PRS ), \'0\': DSM)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_dsm_lsb_dith(analog_r9[3]),  // use PRS in DSM dithering (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ndiv_fout(analog_r9[2:0]),  // divider ratio of fout (for generating dithering clock)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .bypass_retimer(analog_r10[5]),   // disable retimer (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .sel_ph(analog_r10[4:3]),     // select phase for retimer';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .dith_retime(analog_r10[2:0]),  // control dithering retiming point';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .bypass_bb(analog_r11[5]),        // disable offset control in BB loop (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .bypass_tdc(analog_r11[4]),       // disable offset control in TDC loop (act Hi)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .add_off(analog_r11[3:0]),      // offset delay control';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .en_jm(analog_r12[7]),    // enable jitter measurement';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ref_sel_jm(analog_r12[6]),       // select jitter measurement clock   .s (\'1\': ext_cki(b)_jm), \'0\': ext_frefp(n)_jm)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ncycle_jm(analog_r12[5:0]),  // run n cycles of fref to measure jitter';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .mdll_reserved(analog_r13),    // reserved   . register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .aux_div_pad(aux_div_pad),     // aux osc output for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .fout_div_pad(fout_div_pad),    // divided clock of fref for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .fref_off_pad(fref_off_pad),    // fref for monitoring purpose';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .ffeed_pad(ffeed_pad),       // ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .frefp_out_jm(frefp_out_jm),    // (+) frefp for off-chip phase adjustment';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .frefn_out_jm(frefn_out_jm),    // (-) frefp for off-chip phase adjustment';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .mdllout_pad(mdllout_pad), // 4-phase MDLL outputs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .jm_out(jm_out),   // number of 1\'s in jitter measurement';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .lf_out(lf_out)    // LF output (MSB 7bits for mtune, LSB 6bits for dithering)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//INSTANTIATE ANALOG BLOCK';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } #if ($include_analog_block)
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// FIXME Note there are LOTS of unused wires being created below!';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// FIXME I assume they will be hooked up to something eventually';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// FIXME when this module is ready to be part of a working testbench...?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// FIXME At which point the verilator directive(s) can be removed maybe...';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/* verilator lint_off UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#####################################################';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#Create wires';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#Naming: wire_<row>_<col>_<busname>_S<side_T<track>';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#Where : row,col = row,col of source tile';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#####################################################';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     for my $bus (sort keys %bus_num_tracks_hash) {
 for (my $h=0; $h<$cgra_grid_height; $h++) {
   for (my $w=0; $w<$cgra_grid_width; $w++) {
     my $key = "${w}_${h}";
     my $tile_type = $tile_grid{$key};
     my $tile_height = $tile_config->{ $tile_type }{ 'tile_height' };
       my $num_tracks = $bus_num_tracks_hash { $bus };
       my $bus_width = $bus_width_hash { $bus };
       for(my $s=0; $s<$sides; $s++) {
         for(my $t=0; $t<$num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
   }
 }
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $h=0; $h<$cgra_grid_height; $h++) {
   for (my $w=0; $w<$cgra_grid_width; $w++) {
     my $key = "${w}_${h}";
     my $tile_type = $tile_grid{$key};
     my $tile_height = $tile_config->{ $tile_type }{ 'tile_height' };
     if ($tile_type eq "mem") {
       my $data_bus = $tile_config->{ $tile_type }{ 'gen_mem_for_busname' };
       my $bus_width = $bus_width_hash { $data_bus };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] mem_chain_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire  mem_chain_valid_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
     if (($tile_type eq "mem") || ($tile_type eq "pe")) {
       for (my $i=0; $i<$global_signal_count; $i++) {
         if ((${w}%2==0) && (${h}%2==0)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      wire global_wire_h2l_1_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${w}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${h}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         }
       }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire global_wire_l2h_0_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${w}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${h}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/* verilator lint_on UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $tile_hash_ref;
 my $io1bit_num_tracks = $bus_num_tracks_hash{ 'BUS1' };
 my $io16bit_num_tracks = $bus_num_tracks_hash{ 'BUS16' };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// ASSIGN all signals to/from IO pads';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign wide f2p outputs (one tile -> all pads in a group)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   my ($rn,$cn) = ( 1                         , 1 + $i                    );
   my ($rw,$cw) = ( ($cgra_grid_height-2) - $i, 1                         );
   my ($rs,$cs) = ( ($cgra_grid_height-2)     , ($cgra_grid_width-2) - $i );
   my ($re,$ce) = ( 1 + $i                    , ($cgra_grid_width-2)      );
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_wide_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $rn; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cn; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S3_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_wide_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $re; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $ce; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S0_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_wide_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $rs; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cs; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S1_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_wide_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $rw; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cw; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S2_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 

   # Collateral for cgra_info
   # Want to add something like?
   # <io_connect_wide group='0' N='0x0101' W='0x1001' S='0x1010' E='0x0110'/>
   my $ntile = sprintf("0x%02X%02X", $rn, $cn);
   my $etile = sprintf("0x%02X%02X", $re, $ce);
   my $stile = sprintf("0x%02X%02X", $rs, $cs);
   my $wtile = sprintf("0x%02X%02X", $rw, $cw);
   my $collateral = 
     "<io_connect_wide group='$i' N='$ntile' E='$etile' S='$stile' W='$wtile'/>";
   $top::CONNECT_INFO .= "  $collateral\n";
   # Print collateral inline with verilog as a comment.
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $collateral; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign 1bit f2p outputs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 

 sub onebit_collateral {
   # unpack parms
   my ($group_num, $side, $mstile, $lstile) = @_;

   # build the collateral
   my $collateral = 
     sprintf("<io_connect_1bit group='%d' side='%s' msb='0x%04X' lsb='0x%04X'/>",
             $group_num, $side, $mstile, $lstile);

   # print to cgra_info.xml
   $top::CONNECT_INFO .= "  $collateral\n";

   # print inline with verilog code
   print "// $collateral\n"
 }

 my $onebit_groups = int($cgra_grid_height/$num_ios_per_group);

 # No
 # my $num_1bit_io_groups = 
 #   ($onebit_groups < $num_io_groups_per_side) ? $onebit_groups : $num_io_groups_per_side;

 # Yes
 my $num_1bit_io_groups = $onebit_groups;

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cgra_grid_height; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_ios_per_group; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $onebit_groups; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_1bit_io_groups; $i++) {
   my $offset = $i * $num_ios_per_group;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # Note collateral should look something like
 # side   msb    lsb
 # N_0   01,01  01,16
 # N_1   01,17  01,32
 # 
 # E_0   01,16  16,16
 # E_1   17,16  32,16
 # 
 # S_0   33,16  33,01
 # S_1   33,32  33,17
 # 
 # W_0   00,32  00,17
 # W_1   00,16  00,01

 # Formatted something like:
 # <io_connect_1bit group='0' side='N' msb='0x0101' lsb='0x0110'>

   my ($lsb,$msb) = (0, $num_ios_per_group-1);
   my ($lstile, $mstile);

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//North side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
     my ($r,$c) = (1, 1+$offset+$bit);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $c; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S3_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($b==$msb) { $mstile =  ($r<<8) + $c; }
     if ($b==$lsb) { $lstile =  ($r<<8) + $c; }
   }
   onebit_collateral($i, 'N', $mstile, $lstile);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//East side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
     my ($r,$c) = (1+$offset+$bit, $cgra_grid_width-2);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $c; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S0_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($b==$msb) { $mstile =  ($r<<8) + $c; }
     if ($b==$lsb) { $lstile =  ($r<<8) + $c; }
   }
   onebit_collateral($i, 'E', $mstile, $lstile);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//South side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $bit; # Count up 0->15
     my ($r,$c) = ($cgra_grid_height-2, 1+$offset+$bit);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $c; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S1_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($b==$msb) { $mstile =  ($r<<8) + $c; }
     if ($b==$lsb) { $lstile =  ($r<<8) + $c; }
   }
   onebit_collateral($i, 'S', $mstile, $lstile);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//West side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $bit; # Count up 0->15
     my ($r,$c) = (1+$offset+$bit, 1);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $c; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S2_T0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($b==$msb) { $mstile =  ($r<<8) + $c; }
     if ($b==$lsb) { $lstile =  ($r<<8) + $c; }
   }
   onebit_collateral($i, 'W', $mstile, $lstile);

 }

 my $unconnected_groups = $num_io_groups_per_side - $onebit_groups;
 for (my $i=$onebit_groups; $i < $num_io_groups_per_side; $i++) {
   my $offset = $i * $num_ios_per_group;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Unconnected onebit wires - north side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Unconnected onebit wires - east side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Unconnected onebit wires - south side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $bit; # Count up 0->15
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Unconnected onebit wires - west side';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
     my $b = $bit; # Count up 0->15
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign f2p_1bit_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }





print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign wide p2f inputs (all pads in a group -> a single tile): NORTH';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for (my $t=0; $t < $io16bit_num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_0_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S1_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign wide p2f inputs (all pads in a group -> a single tile): WEST';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for (my $t=0; $t < $io16bit_num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_height-2) - $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_0_BUS16_S0_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign wide p2f inputs (all pads in a group -> a single tile): SOUTH';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for (my $t=0; $t < $io16bit_num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_height-1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_width-2) - $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S3_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign wide p2f inputs (all pads in a group -> a single tile): EAST';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_io_groups_per_side; $i++) {
   for (my $t=0; $t < $io16bit_num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_width-1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS16_S2_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// assign 1 bit p2f inputs (each pad goes to a single tile)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $i=0; $i < $num_1bit_io_groups; $i++) {
   for (my $t=0; $t < $io1bit_num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//North side track '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     my $offset = $i * $num_ios_per_group;
     for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
       my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_0_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $offset + $bit; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S1_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_N_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//East side track '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
       my $b = $num_ios_per_group - $bit - 1; # Count down 15->0
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $offset + $bit; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_height-1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S2_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_E_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//South side track '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
       my $b = $bit; # Count up 0->15
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($cgra_grid_height-1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $offset + $bit; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_BUS1_S3_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_S_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//West side track '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     for(my $bit=0; $bit < $num_ios_per_group; $bit++) {
       my $b = $bit; # Count up 0->15
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 1 + $offset + $bit; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_0_BUS1_S0_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = p2f_W_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#####################################################';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#Instantiate components';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//#####################################################';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $h=0; $h<$cgra_grid_height; $h++) {
   for (my $w=0; $w<$cgra_grid_width; $w++) {
     my $key = "${w}_${h}";
     my $tile_type = $tile_grid{$key};
     my $tile_addr = $tile_grid{ "${key}_addr" };
     my $io_side = -1;
     my $io_count = -1;
     my $io_group = -1;
     my $io_gcount = 0;
     if (($tile_type eq "X")) {next;}
     if ($tile_type=~m/io/) {
       $io_side = $tile_grid{"${key}_side"};
       $io_count = $tile_grid{"${key}_count"};
       if ($io_side==0) {$io_gcount = $io_count + $IO_count[0] + $IO_count[1] + $IO_count[3];}
       if ($io_side==2) {$io_gcount = $io_count + $IO_count[3];}
       if ($io_side==3) {$io_gcount = $io_count + $IO_count[3] + $IO_count[0];}
       if ($io_side==1) {$io_gcount = $io_count + 0;}
       $io_group = int($io_gcount/16);
     }
     my $options = "";
     my $tile_addr_hex = sprintf("%04X", $tile_addr);
     my $tile_id = sprintf("%s_0x%s", $tile_type, $tile_addr_hex);
#Add PE specific parameters from the tile config to the generate command
#All paramters in the tile_config hash except type, tile_height/width are passed to the generator
     foreach my $f (keys %{$tile_config->{ $tile_type }}) {
       my $v = $tile_config->{ $tile_type }{ $f };
       # print "$f : $v\n";
       if (($f!~m/type/) && ($f!~m/tile_height/) && ($f!~m/tile_width/)) {
         $options .= " $f => \"$v\",";
       }
     }
     if ($tile_type eq "mem" || $tile_type eq "pe") { 
#Create feedthrough and registered output masks based on tile_x
       my $sb_feedthrough = "";
       my $sb_registered = "";
       my $tile_x = $w;
       while( my ($bus, $width) = each %bus_width_hash ) {
         $sb_feedthrough .= " $bus:";
         $sb_registered .= " $bus:";
         foreach my $seg_info (split(':', $bus_segment_hash{$bus})) {
           $seg_info=~m/(\S+)_(\S+)/;
           my $seg_len = $1;
           my $seg_reg = $2;
           my $count = 1;
           if ($all_segments_for_all_tiles==1) {
              $count = $seg_len;
           }
           for (my $s=0; $s<$count; $s++) {
             if (($tile_x%$seg_len)==$s) {
               $sb_feedthrough .= "0";
               my $track_reg_repeats_after = $seg_len*$seg_reg;
               if (($tile_x%$track_reg_repeats_after)==$s) {
                 $sb_registered .= "1";
               } else {
                 $sb_registered .= "0";
               }
             } else {
               $sb_feedthrough .= "1";
               $sb_registered .= "0";
             }
           }
         }
       }
       $sb_feedthrough =~ s/^\s+|\s+$//;
       $sb_registered =~ s/^\s+|\s+$//;
       $options .= "feedthrough_outputs => \"$sb_feedthrough\", registered_outputs => \"$sb_registered\",";
     } else {
       $options = "";
    }
#Create a tile_is composed of all options and see if such a tile has been generated before
#If not generated, generate it and add to a hash. Else, clone the existing tile
     $options =~ s/,$//;
     my $options_key = "${tile_type}_${options}";
     $options_key =~ s/\s/_/g;
     $options_key =~ s/=>/_/g;
     $options_key =~ s/\"/_/g;
     $options_key =~ s/:/_/g;
     $options_key =~ s/#/_/g;
     $options_key =~ s/,/_/g;
     my $inst_obj;
     if ($tile_type ne "empty") {
       if (not defined $tile_hash_ref->{$options_key}) {
         my $cmd = "\$tile_hash_ref->{'$options_key'} = generate('$tile_config->{ $tile_type }{ 'type' }', '$tile_id', $options);";
         eval $cmd;
         $inst_obj = $tile_hash_ref->{$options_key}; 
       } else {
         my $obj = $tile_hash_ref->{$options_key};
         $inst_obj = clone($obj, $tile_id);
       }
     }
    if ($tile_type eq "mem") {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire [31:0] read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $inst_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_in(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $row=0; $row < $tile_config->{ $tile_type }{ 'tile_height' }; $row++) {
     for my $bus (sort keys %bus_num_tracks_hash) {
       my $num_tracks = $bus_num_tracks_hash { $bus };
       my $bus_width = $bus_width_hash { $bus };
       for(my $s=0; $s<$sides; $s++) {
         for(my $t=0; $t<$num_tracks; $t++) {
# NB: Change the following for the case of sides > 4
           if ($s==0 || $s==2) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h+$row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
           if ($s==1 && $row==($tile_config->{ $tile_type }{ 'tile_height' }-1)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h+$row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
           if ($s==3 && $row==0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h+$row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
           my $opposite_side = $s + int($sides*0.5);
           if ($opposite_side > ($sides-1)) {$opposite_side -= $sides;}
           my $w_delta=0;
           my $h_delta=0;
#Modification needed to support different 'sides' options
           if ($sides==4) {
             if ($s==0) {$w_delta=1;}
             if ($s==1) {$h_delta=1;}
             if ($s==2) {$w_delta=-1;}
             if ($s==3) {$h_delta=-1;}
           }
           my $h_new = $h+$row+$h_delta;
           my $w_new = $w+$w_delta;
           if ($s==0 || $s==2) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
           if ($s==1 && $row==($tile_config->{ $tile_type }{ 'tile_height' }-1)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
           if ($s==3 && $row==0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           }
         }
       }
     }
   }
   my $h_new = $h+2;
   if ($h_new >= ($cgra_grid_height - 4)) {
   my $data_bus=$tile_config->{ $tile_type }{ 'gen_mem_for_busname' };
   my $width=$bus_width_hash { $data_bus };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_in('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_wen_in(1\'b0),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_in(mem_chain_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_wen_in(mem_chain_valid_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_out(mem_chain_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_valid_out(mem_chain_valid_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $i=0; $i<$global_signal_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .gin_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(global_wire_h2l_1_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${w}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${h}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .gout(global_wire_l2h_0_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${w}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${h}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tile_id(16\'h'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read_data(read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      if ($read_data_memory eq '') {
        $read_data_memory = "read_data_$tile_addr_hex";
      } else {
        $read_data_memory = $read_data_memory . " | read_data_$tile_addr_hex";
      }
    } elsif ($tile_type eq "pe") {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    wire [31:0] read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $inst_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_in(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     for my $bus (sort keys %bus_num_tracks_hash) {
       my $num_tracks = $bus_num_tracks_hash { $bus };
       my $bus_width = $bus_width_hash { $bus };
       for(my $s=0; $s<$sides; $s++) {
         for(my $t=0; $t<$num_tracks; $t++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       my $opposite_side = $s + int($sides*0.5);
       if ($opposite_side > ($sides-1)) {$opposite_side -= $sides;}
       my $w_delta=0;
       my $h_delta=0;
#Modification needed to support different 'sides' options
       if ($sides==4) {
         if ($s==0) {$w_delta=1;}
         if ($s==1) {$h_delta=1;}
         if ($s==2) {$w_delta=-1;}
         if ($s==3) {$h_delta=-1;}
       }
       my $h_new = $h+$h_delta;
       my $w_new = $w+$w_delta;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $s; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $h_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w_new; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_S'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_T'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $t; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         }
       }
     }
     for (my $i=0; $i<$global_signal_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .gin_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(global_wire_h2l_1_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${w}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${h}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .gout(global_wire_l2h_0_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${w}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${h}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tile_id(16\'h'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read_data(read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 

#Reminder I think we are HERE in the loop nest:
#for (my $h=0; $h<$cgra_grid_height; $h++) {
#  for (my $w=0; $w<$cgra_grid_width; $w++) {
#    } elsif ($tile_type eq "pe") {

       if ($read_data_pe eq '') {
         $read_data_pe = "read_data_$tile_addr_hex";
       } else {
         $read_data_pe = $read_data_pe . " | read_data_$tile_addr_hex";
       }
       #
       #
     } elsif ($tile_type eq "empty") {}
     #
#Reminder I think we are HERE in the loop nest:
#for (my $h=0; $h<$cgra_grid_height; $h++) {
#  for (my $w=0; $w<$cgra_grid_width; $w++) {
     ########################################################################
     # WRITE CGRA_INFO ######################################################
     ########################################################################
     #
     # # will it blend (I)? no it will not (yet) b/c inst_obj
     # }} # for w; for h
     # for (my $h=0; $h<$cgra_grid_height; $h++) {
     #   for (my $w=0; $w<$cgra_grid_width; $w++) {
     #     my $key = "${w}_${h}";
     #     my $tile_type = $tile_grid{$key};
     #     my $tile_addr = $tile_grid{ "${key}_addr" };
     #     my $tile_addr_hex = sprintf("%04X", $tile_addr);
     #
     # FIXME Note this could/should be a sub/func w/args
     # %tile_config, $bus $bus_num_tracks_hash{$bus}, bus_num_tracks_hash, $inst_obj...?
     #
     # cgra_info: io tile info gets written by io_group.svp
     # cgra_info: no longer emit empty tiles - oops no keyi wants them so we will keep
     # if (($tile_type ne "io1") && ($tile_type ne "empty")) {
     if ($tile_type eq "empty") {
       my $ta  = ($h << 8) + $w;
       my $tah = sprintf("0x%02X%02X", $h, $w);
       @top::CGRA_INFO[$ta] = 
         "  <tile type='$tile_type' tile_addr='$tah' row='$h' col='$w'></tile>\n";
     }
     elsif ($tile_type ne "io1") {
       my $ty = "$tile_config->{ $tile_type }{ 'type' }";
       my $ta = "0x$tile_addr_hex";
       my $tr = "";
       foreach my $bus (sort keys %bus_num_tracks_hash) {
         $tr = $tr . "$bus:$bus_num_tracks_hash{$bus} ";
       }
       # print INFO "  <tile type='$ty' tile_addr='$ta' row='$h' col='$w' tracks='$tr'>\n";
       # Note spurious tile info will get overwritten by io_group.svp
       @top::CGRA_INFO[$tile_addr] .= "  <tile type='$ty' tile_addr='$ta' row='$h' col='$w' tracks='$tr'>\n";
   
       # FIXME/TODO use internal data structure instead of file IO :(  )
       open (INP, "<TILE".$inst_obj->mname()) or die "Couldn't open file TILE$inst_obj->mname(), $!";
       while (<INP>) {
         print INFO $_;
         @top::CGRA_INFO[$tile_addr] .= $_;
       }
       close INP;
       # print INFO                     "  </tile>\n";
       @top::CGRA_INFO[$tile_addr] .= "  </tile>\n";
     } # all other tile types
   } # for w
 } # for h
 #
 #
 #
 if ($include_GST) {
   #####################################################
   # Create global wire merge and distribute structure
   #####################################################
   my $obj = generate("global_signal_tile", "gst", global_signal_count=>$global_signal_count);
   my %gst_hash_new;
   my %gst_hash_old = %tile_grid;  
   my $incr=1;
   my $height=$cgra_grid_height;
   my $width=$cgra_grid_width;
 
   # New stuff: gst numbers begin at 0x8000
   # FIXME this should probably be a top-level parm?
   my $new_tile_addr = 0x8000;
 
   my $last_tile_addr = 0;
   ####### tile ordering for connecting global signal tiles
   # 0   1
   # 3   2
   #######
   while (1) {
   ####### 
   ####### instantiate wires for each gst level 
   ####### 
     my %wire_hash = ();
     my $next_h=1;
     for (my $h=1; $h<($height/$incr); $h+=2) {
       my $next_w=1;
       for (my $w=1; $w<($width/$incr); $w+=2) {
         for (my $i=0; $i<4; $i++) {
           my $key = "global_wire_h2l_".($incr*2)."_${i}_".(int(floor((${next_w}-1)/2))+1)."_".(int(floor((${next_h}-1)/2))+1);
           $wire_hash{$key} = 1;
         } 
         my $key = "global_wire_l2h_${incr}_${next_w}_${next_h}";
         $wire_hash{$key} = 1;
         $next_w++;
       }
       $next_h++;
     }
     foreach my $w (sort keys(%wire_hash)) {
       if ($incr!=1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      wire '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
     }
   ####### 
   ####### instantiate all tiles for a gst level 
   ####### 
     my $next_h=1;
     for (my $h=1; $h<($height/$incr); $h+=2) {
       my $next_w=1;
       for (my $w=1; $w<($width/$incr); $w+=2) {
         my @keys;
         $keys[0] = (${w}+0)."_".(${h}+0);
         $keys[1] = (${w}+1)."_".(${h}+0);
         $keys[2] = (${w}+1)."_".(${h}+1);
         $keys[3] = (${w}+0)."_".(${h}+1);
         my $found=0;
         my $new_key = "${next_w}_${next_h}";
         $gst_hash_new{ ${new_key} } = "empty";
         for (my $i=0; $i<4; $i++) {
           my $key = $keys[$i];
           my $child_type = $gst_hash_old{ $key };
           if ($child_type eq "mem" || $child_type eq "pe" || $child_type eq "gst") {
             $found = 1;
           }
         }
         if ($found==1) {
           $gst_hash_new{ ${new_key} } = "gst";
           $gst_hash_new{ "${new_key}_addr" } = ${new_tile_addr};
           my $new_tile_addr_hex = sprintf("%X",$new_tile_addr);
           print INFO                         "  <tile type='gst' tile_addr='0x$new_tile_addr_hex'>\n";
           print INFO                         "    <controlled_tiles>\n";
           @top::CGRA_INFO[$new_tile_addr] .= "  <tile type='gst' tile_addr='0x$new_tile_addr_hex'>\n";
           @top::CGRA_INFO[$new_tile_addr] .= "    <controlled_tiles>\n";
           my $inst_obj = clone($obj, "gst_0x${new_tile_addr_hex}");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      wire [31:0] read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $inst_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .clk(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .tile_id(16\'h'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           for (my $i=0; $i<4; $i++) {
             my $child_key = $keys[$i];
             my $child_type = $gst_hash_old{ $child_key };
             my $child_addr = $gst_hash_old{ "${child_key}_addr" };
             my $child_addr_hex = sprintf("%X",$child_addr);
     if(($incr*2 >= $cgra_grid_width-4) or (($grid_size eq "48x48") and ($incr*2==32))) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gin_u_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(stall['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] | global_wire_l2h_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $incr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_key; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
     else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gin_u_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(global_wire_h2l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($incr*2); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${next_w}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (int(floor((${next_h}-1)/2))+1); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }     
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gout_l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(global_wire_h2l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $incr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_key; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
             if ($child_type eq "mem" || $child_type eq "pe" || $child_type eq "gst") {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gin_l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(global_wire_l2h_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (floor($incr/2)); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $child_key; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
               print INFO                         "      <tile>0x${child_addr_hex}</tile>\n";
               @top::CGRA_INFO[$new_tile_addr] .= "      <tile>0x${child_addr_hex}</tile>\n";
             } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//        .gout_l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//        .gin_u_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(1\'b0), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gin_l_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(1\'b0), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
             }
           }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .gout_u(global_wire_l2h_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $incr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_key; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        .read_data(read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $new_tile_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           $new_tile_addr++;
           print INFO                         "    </controlled_tiles>\n";
           @top::CGRA_INFO[$new_tile_addr] .= "    </controlled_tiles>\n";
           print INFO                         "  </tile>\n";
           @top::CGRA_INFO[$new_tile_addr] .= "  </tile>\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($read_data_global eq '') {
      $read_data_global = "read_data_$new_tile_addr_hex";
    } else {
      $read_data_global = $read_data_global . " | read_data_$new_tile_addr_hex";
    }
         }
         $next_w++;
       }
       $next_h++;
     }
     foreach my $key (keys %gst_hash_new) {
     }
     %gst_hash_old = %gst_hash_new;
     print INFO                         "####################GST level: $incr #################\n";
     @top::CGRA_INFO[$new_tile_addr] .= "####################GST level: $incr #################\n";
     if (($new_tile_addr - $last_tile_addr)==0 || ($incr >= 1024)) {last;}
     $last_tile_addr = $new_tile_addr;
     $incr*=2;
   }
 }
 # print INFO "</CGRA>\n";
 close INFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign read_data_pe = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $read_data_pe; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign read_data_memory = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $read_data_memory; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($include_GST) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign read_data_global = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $read_data_global; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign read_data = read_data_pe | read_data_memory | read_data_global;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/top/cgra_core.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
