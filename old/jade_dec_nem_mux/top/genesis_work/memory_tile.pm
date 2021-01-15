package memory_tile;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_tile/memory_tile.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_tile/memory_tile.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_tile/memory_tile.vp"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '///////////////////////////////////////////////////////////////////';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// CGRA memory tile generator with SBs CBs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//////////////////////////////////////////////////////////////////';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 use POSIX;
 #global
 my $bus_config = parameter(Name=>'bus_config', val=> "BUS16:16b#1_4:1_4:1_4:1_4:1_4 BUS1:1b#1_4:1_4:1_4:1_4:1_4", doc=>'buses used at global level.');
 my $all_segments_for_all_tiles =  parameter(Name=>'all_segments_for_all_tiles', val=> "1", doc=>'stagger or overlap segments');
 my $global_signal_count = parameter(Name=>'global_signal_count', val=> "4", doc=>'number of global signals supported');
 # for memory 
 my $gen_mem_for_busname  = parameter(Name=>'gen_mem_for_busname', val=> "BUS16", doc=>'generate mem for a particular bus width. only one name must be specified.');
 my $control_busname  = parameter(Name=>'control_busname', val=> "BUS1", doc=>'bus to propagate ren, wen, valid, and almost_full control signals. only one name must be specified.');
 my $ddepth   = parameter(Name=>'ddepth', val=> 512, doc=>'number of words in the memory');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # for sb
 my $sides = parameter(Name=>'sides', val=> 4, doc=>'number of edges for a SB'); 
 my $feedthrough_outputs = parameter(Name=>'feedthrough_outputs', val=> "11100", doc=>'active low binary vector specifying into what tracks can the memory output be injected. Set the bit corresponding to a track to **0** to enable it to carry the injected value. length = number_tracks. MSB = track0. affects only the bus for which memory is being generated, other buses are always completely feedthrough.');
 my $registered_outputs = parameter(Name=>'registered_outputs', val=> "00011", doc=>'binary vector specifying which of the non-feedthrough outputs above can be registered. set bit to 1 for registering. feedthrough tracks are not registered');
 my $is_bidi = parameter(Name=>'is_bidi', val=> 0, doc=>'1 if SB pins are bidi. TBD.');
 my $sb_fs = parameter(Name=>'sb_fs', val=> "10000#10000#10000", doc=>'binary vector for modifying fanin of sb muxes');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # for cb
 #ankitan - add more for virtualization
 my $cb_connections = parameter(Name=>'cb_connections', val=> "1111111111", doc=>'binary vector to specify tracks muxed by cb input to memory.length = num_tracks*2');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # for layout 
 my $mem_tile_height = parameter(Name=>'mem_tile_height', val=> 2, doc=>'multiple of cgra row height to use as mem_tile height');
 
 # If parent (i.e. top.vp) has a memheight def, that overrides local
   my $parent = $self->get_parent();
   if ($parent->exists_param('mem_tile_height')) {
      $mem_tile_height = $parent->get_param('mem_tile_height');
   }
   print "// Using mem_tile_height=$mem_tile_height\n";


 ###########################################################################
 #ankitan - Virtualization sel
 my $SHIFT_REG_LEN  = parameter(Name=>'SHIFT_REG_LEN',
                               Val=> 0, Min=>0, Step=>1, Max=>16,
                               Doc=>"Total number of shift registers");
 my $USE_SHIFT_REG = ($SHIFT_REG_LEN > 0);
 ############################################################################
 my @cb_connections_arr = split('',$cb_connections);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my %bus_width_hash = ();
 my %bus_segment_hash = ();
 my %bus_num_tracks_hash = ();
 foreach my $bus (split(' ', $bus_config)) {
   my $track_count=0;
   if ($bus=~m/(BUS\S+):(\S+)b#(\S+)/) {
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
my $filename = "TILE".$self->mname();
open(TILEINFO, ">$filename") or die "Couldn't open file $filename, $!";
 my $tile_info_hash;
 my $rename_hash;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'clk_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_write,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_read,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $row=0; $row < $mem_tile_height; $row++) {
   for my $bus (sort keys %bus_num_tracks_hash) {
     my $num_tracks = $bus_num_tracks_hash { $bus };
     for(my $i=0; $i<$sides; $i++) {
       for(my $j=0; $j<$num_tracks; $j++) {
# NB: Change the following for the case of sides>4
         if ($i==0||$i==2||($i==3&&$row==0)||($i==1 && $row==$mem_tile_height-1)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         }
       }
     }
   }
 }
   for (my $i=0; $i<$global_signal_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'gin_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'gout,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'chain_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'chain_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'chain_valid_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'chain_wen_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'tile_id,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input chain_wen_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output chain_valid_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for (my $row=0; $row < $mem_tile_height; $row++) {
   for my $bus (sort keys %bus_num_tracks_hash) {
     my $num_tracks = $bus_num_tracks_hash { $bus };
     my $bus_width = $bus_width_hash { $bus };
     for(my $i=0; $i<$sides; $i++) {
       for(my $j=0; $j<$num_tracks; $j++) {
# NB: Change the following for the case of sides>4
         if ($i==0||$i==2||($i==3&&$row==0)||($i==1 && $row==$mem_tile_height-1)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         }
       }
     }
   }
 }
   for (my $i=0; $i<$global_signal_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input gin_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg gout;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width_hash { $gen_mem_for_busname } - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] chain_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width_hash { $gen_mem_for_busname } - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] chain_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [15:0] tile_id;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_read;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input config_write;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg [31:0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $global_signal_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${bus_config}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${all_segments_for_all_tiles}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${gen_mem_for_busname}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${control_busname}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${ddepth}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${sides}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${feedthrough_outputs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${registered_outputs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${is_bidi}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${sb_fs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${cb_connections}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${mem_tile_height}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//  wire clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire cg_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire clk_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Generate config enables
 #
 ##############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $intra_tile_addr = 0;
 for my $bus (sort keys %bus_num_tracks_hash) {
   for(my $row=0; $row<$mem_tile_height; $row++,$intra_tile_addr++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg config_en_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       config_en_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')&&config_write) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $tile_info_hash->{ "sb_".$row."_".$bus } = {
       address => $intra_tile_addr
     };
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg config_en_mem;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       config_en_mem = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')&&config_write) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_mem = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_mem = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $tile_info_hash->{ 'mem' } = {
       address => $intra_tile_addr,
       data_bus => $gen_mem_for_busname,
       control_bus => $control_busname
     };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 #4 256 word SRAMs (so we can use the 8 bit register address)
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg [3:0] config_en_sram;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for(my $i = 0; $i < 4; $i++){
$intra_tile_addr++; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if(reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      config_en_sram['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') && (config_read | config_write)) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_sram['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_sram['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # 4 feature addresses for SRAM
     $tile_info_hash->{ "sram_$i" } = {
       address => $intra_tile_addr
     };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
$intra_tile_addr++;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg config_en_linebuf;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       config_en_linebuf = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')&&config_write) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_linebuf = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_linebuf = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
	$tile_info_hash->{ "linebuf" } ={
	  address => $intra_tile_addr
	};
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##
 ## global out signal
 ##
 
  $intra_tile_addr+=1;
  my $gout_output_count = 3; 
  my $number_of_gout_select_bits_needed = int(ceil(log($gout_output_count)/log(2)));
 
   $tile_info_hash->{ 'gout' } = {
     address => $intra_tile_addr,
     mux_map => ""
   };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_gout_select_bits_needed - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] gout_sel;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk_in or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       gout_sel = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_gout_select_bits_needed; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')&&config_write) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         gout_sel  = config_data['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_gout_select_bits_needed - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $bus_width = $bus_width_hash { $gen_mem_for_busname };
  #ankitan
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] rdata;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  if($USE_SHIFT_REG) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] rdata_core;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire valid;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire almost_full;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire almost_empty;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Create Intra Tile Wires For SBs
 #
 ##############################################
 for my $bus (sort keys %bus_num_tracks_hash) {
   my $num_tracks = $bus_num_tracks_hash { $bus };
   my $bus_width = $bus_width_hash { $bus };
   for (my $row=0; $row < $mem_tile_height; $row++) {
     for(my $i=0; $i<$sides; $i++) {
       for(my $j=0; $j<$num_tracks; $j++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
     }
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Instantiate CBs
 #
 ##############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $num_tracks_wide = $bus_num_tracks_hash { $gen_mem_for_busname };
 my $cb_wide = generate('cb', 'cb', width=>16, num_tracks=>($num_tracks_wide*2), has_constant=>0, feedthrough_outputs=>$cb_connections);  
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $num_tracks_1b = $bus_num_tracks_hash{ $control_busname };
 my $cb_1b = generate('cb', 'cb_ctl', width=>1, num_tracks=>(($num_tracks_1b*2)+$global_signal_count), has_constant=>0, feedthrough_outputs=>$cb_connections);
 my $cb_cg = generate('cb', 'cb1b_cg', width=>1, num_tracks=>(($num_tracks_1b*2)+$global_signal_count), has_constant=>0, feedthrough_outputs=>$cb_connections);
 ##############################################
 #ankitan - START
 my @mem_inputs;
 if ($USE_SHIFT_REG==0) {
  @mem_inputs = ("BUS16#wdata","BUS16#waddr","BUS16#raddr","BUS1#ren","BUS1#wen");
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($USE_SHIFT_REG) {
  @mem_inputs = ("BUS16#wdata","BUS16#waddr","BUS16#raddr","BUS1#ren","BUS1#wen", "BUS16#sel");
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # my @mem_inputs = ("BUS16#wdata","BUS16#waddr","BUS16#raddr","BUS1#ren","BUS1#wen");
 # ankitan - END
 ##############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my @mem_inputs = ("BUS16#wdata","BUS16#addr","BUS1#ren","BUS1#wen","BUS1#flush");
 my @non_mem_inputs = ("BUS1#cg_en");
 my $input_count=0;
 my $num_tracks;
 my $cb;

 #######

foreach my $mem_input (@mem_inputs, @non_mem_inputs) {
 ##
 ## Generate config enables for the input CB
 ##
 $intra_tile_addr+=1;
 $mem_input =~ m/(\S*)#(\S*)/;
 my $mem_input_bus = $1;
 my $mem_input_name = $2;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg config_en_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       config_en_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       if ((config_addr[15:0]==tile_id)&&(config_addr[23:16]==8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $intra_tile_addr; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')&&config_write) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         config_en_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire [31:0] read_data_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $tile_info_hash->{ 'cb_'.$mem_input_name } = {
   address => $intra_tile_addr
 };
 ##
 ## Instantiate the CB
 ##
 my $xside=2; 
# if ($input_count % 2 == 0) {
#  $xside = 2;
# } else {
#  $xside = 1;
# }
 if ($mem_input_bus eq "BUS16") {
   $cb = clone($cb_wide,'cb_'.$mem_input_name);
    $num_tracks=$num_tracks_wide;
 } elsif ($mem_input_name eq "cg_en") {
   $cb = clone($cb_cg,'cb_'.$mem_input_name);
   $num_tracks=$num_tracks_1b;
 } else {
   $cb = clone($cb_1b,'cb_'.$mem_input_name);
   $num_tracks=$num_tracks_1b;
 }
 if ($mem_input_bus eq "BUS16") {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire [15:0] '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    } elsif ($mem_input_name eq "cg_en") {} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cb->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk(clk_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .out('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $k=0;
   for(my $j=0; $j<$num_tracks*2; $j++, $k++) {
     my $dirn;
     my $track = $k % $num_tracks;
     if ($j < $num_tracks) {
       $dirn="in";
     } else {
       $dirn="out";
     }
     if (@cb_connections_arr[$j]==1) {
       if ($mem_input_bus eq "BUS16") {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $k; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${dirn}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_0_BUS16_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${xside}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${track}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         $rename_hash->{ 'cb_'.$mem_input_name }{"in_${k}"} = "${dirn}_0_BUS16_S${xside}_T${track}";
       } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $k; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${dirn}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_0_BUS1_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${xside}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${track}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
         $rename_hash->{ 'cb_'.$mem_input_name }{"in_${k}"} = "${dirn}_0_BUS1_S${xside}_T${track}";
       }
     }
   }
   if ($mem_input_bus eq "BUS1") {
     for (my $i=0; $i<$global_signal_count; $i++, $k++){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $k; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(gin_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${i}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       $rename_hash->{ 'cb_'.$mem_input_name }{"in_${k}"} = "gin_${i}";
     }
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_en(config_en_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .read_data(read_data_cb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_input_name; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $tile_info_hash->{ 'cb_'.$mem_input_name }{'bus'} = $mem_input_bus;
 $tile_info_hash->{ 'cb_'.$mem_input_name }{'mname'} = $cb->mname();
 $rename_hash->{ 'cb_'.$mem_input_name }{'out'} = $mem_input_name;
 $input_count = $input_count+1;
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign clk_en = ~cg_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Instantiate SBs
 #
 ##############################################
 my %sb_hash = ();
 for my $bus (sort keys %bus_num_tracks_hash) {
   my $num_tracks = $bus_num_tracks_hash { $bus };
   my $bus_width = $bus_width_hash { $bus };
   my $ft = '0' x $num_tracks;
   my $reg = '1' x $num_tracks;
   if ($bus eq $gen_mem_for_busname) {
     $sb_hash{ $bus } = generate('sb', 'sb1', width => $bus_width, num_tracks => $num_tracks, sides => $sides, feedthrough_outputs=>$ft, registered_outputs=>$reg, pe_output_count=>1, is_bidi=>$is_bidi);
   } else { 
     $sb_hash{ $bus } = generate('sb', 'sb2', width => $bus_width, num_tracks => $num_tracks, sides => $sides, feedthrough_outputs=>$ft, registered_outputs=>$reg, pe_output_count=>3, is_bidi=>$is_bidi);
   }
 }
 for (my $row=0; $row < $mem_tile_height; $row++) {
   for my $bus (sort keys %bus_num_tracks_hash) {
     my $num_tracks = $bus_num_tracks_hash { $bus };
     my $sb_obj = clone($sb_hash{ $bus }, 'sb_inst_bus'.$bus.'_row'.$row);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';    ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sb_obj->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk(clk_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .clk_en(clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if ($bus eq $gen_mem_for_busname) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pe_output_0(rdata),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } elsif ($bus eq $control_busname) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pe_output_0(valid),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pe_output_1(almost_full),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .pe_output_2(almost_empty),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
     for(my $i=0; $i<$sides; $i++) {
       for(my $j=0; $j<$num_tracks; $j++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .config_en(config_en_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    .read_data(read_data_sb_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $tile_info_hash->{ "sb_".$row."_".$bus }{'bus'} = $bus;
     $tile_info_hash->{ "sb_".$row."_".$bus }{'mname'} = $sb_obj->mname();
     $tile_info_hash->{ "sb_".$row."_".$bus }{'row'} = $row;
     if ($bus eq $gen_mem_for_busname) {
       $rename_hash->{ "sb_".$row."_".$bus }{'pe_output_0'} = 'rdata';
     } elsif ($bus eq $control_busname) {
       $rename_hash->{ "sb_".$row."_".$bus }{'pe_output_0'} = 'valid';
       $rename_hash->{ "sb_".$row."_".$bus }{'pe_output_1'} = 'almost_full';
       $rename_hash->{ "sb_".$row."_".$bus }{'pe_output_2'} = 'almost_empty';
     }
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Connect SB wires to IO or each other
 #
 ##############################################
 for my $bus (sort keys %bus_num_tracks_hash) {
   my $num_tracks = $bus_num_tracks_hash { $bus };
   my $bus_width = $bus_width_hash { $bus };
   for (my $row=0; $row < $mem_tile_height; $row++) {
     for(my $i=0; $i<$sides; $i++) {
       for(my $j=0; $j<$num_tracks; $j++) {
#        NB: Change following code for the case of sides!=4
         if ($i==0||$i==2) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           $rename_hash->{ "sb_".$row."_".$bus }{"out_${i}_${j}"} = "out_${row}_${bus}_S${i}_T${j}";
           $rename_hash->{ "sb_".$row."_".$bus }{"in_${i}_${j}"}  =  "in_${row}_${bus}_S${i}_T${j}"; 
         } else {
           if ($i==1) {
             if ($row == ($mem_tile_height-1)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
               $rename_hash->{ "sb_".$row."_".$bus }{"out_${i}_${j}"} = "out_${row}_${bus}_S${i}_T${j}";
               $rename_hash->{ "sb_".$row."_".$bus }{"in_${i}_${j}"}  =  "in_${row}_${bus}_S${i}_T${j}"; 
             } else {
               my $opposite_side = $i + int($sides*0.5);
               if ($opposite_side > ($sides-1)) {$opposite_side -= $sides;}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row+1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row+1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
               $rename_hash->{ "sb_".$row."_".$bus }{"out_${i}_${j}"} =  "sb_wire_in_".(${row}+1)."_${bus}_S${opposite_side}_T${j}";
               $rename_hash->{ "sb_".$row."_".$bus }{"in_${i}_${j}"}  = "sb_wire_out_".(${row}+1)."_${bus}_S${opposite_side}_T${j}";
             }
           }
           if ($i==3) {
             if ($row == 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = sb_wire_out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      assign  sb_wire_in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $row; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bus; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
           $rename_hash->{ "sb_".$row."_".$bus }{"out_${i}_${j}"} = "out_${row}_${bus}_S${i}_T${j}";
           $rename_hash->{ "sb_".$row."_".$bus }{"in_${i}_${j}"}  =  "in_${row}_${bus}_S${i}_T${j}";
             } else {
               $rename_hash->{ "sb_".$row."_".$bus }{"out_${i}_${j}"} = "sb_wire_out_${row}_${bus}_S${i}_T${j}";
               $rename_hash->{ "sb_".$row."_".$bus }{"in_${i}_${j}"}  =  "sb_wire_in_${row}_${bus}_S${i}_T${j}";
             }
           }
         }
       }
     }
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ######################################################
 ## global out signal
 ######################################################
 
   my @bit1_outputs = qw(1'b0 valid almost_full almost_empty);
   my $count = 0;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (gout_sel)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    foreach my $mem_output (@bit1_outputs) {
      if ($count==0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      default: gout = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_output; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_gout_select_bits_needed; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': gout = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_output; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      $mem_output=~s/1'b//;
      my $str = "      <src sel='${count}'>$mem_output</src>\n";
      $tile_info_hash->{ 'gout' }{ 'mux_map' } .= $str;
      $count = $count + 1;
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 

 #####################################
 ## clock_gating
 #####################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //assign clk = clk_in & clk_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Instantiate memory
 #
 ##############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $width = $bus_width_hash { $gen_mem_for_busname };
   my $mem_core = generate('memory_core', 'memory_core', dwidth=>$width, ddepth=>$ddepth);
   $tile_info_hash->{'mem'}{'mname'} = $mem_core->mname();
   $tile_info_hash->{'mem'}{'width'} = $width;
   $tile_info_hash->{'mem'}{'depth'} = $ddepth;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_mem;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_sram;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire [31:0] read_data_linebuf;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mem_core->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_in(clk_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk_en(clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .reset(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .flush(flush),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_addr(config_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_data(config_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_read(config_read),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_write(config_write),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_en(config_en_mem),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_en_sram(config_en_sram),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .config_en_linebuf(config_en_linebuf),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_in(wdata),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
        if($USE_SHIFT_REG==0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_out(rdata), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
       if($USE_SHIFT_REG) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_out(rdata_core), //ankitan';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .addr_in(addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .wen_in(wen),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .ren_in(ren),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .valid_out(valid),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_in(chain_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_out(chain_out),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_wen_in(chain_wen_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .chain_valid_out(chain_valid_out),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .almost_full(almost_full),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .almost_empty(almost_empty),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read_data(read_data_mem),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read_data_sram(read_data_sram),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .read_data_linebuf(read_data_linebuf)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 # ankitan - START
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 ##############################################
 #
 # Instantiate shift register
 #
 ##############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($USE_SHIFT_REG) {
   my $DataWidth       = parameter(Name=>'DataWidth', val=> 16, doc=>'Data Width');
   my $u_mem_shift_reg = generate('mem_shift_reg', 'mem_shift_reg', SHIFT_REG_LEN=>$SHIFT_REG_LEN, DataWidth=>$width);
#  $tile_info_hash->{'mem_sr'}{'mname'} = $u_mem_shift_reg->mname();
#  $tile_info_hash->{'mem_sr'}{'SHIFT_REG_LEN'} = $SHIFT_REG_LEN;
#  $tile_info_hash->{'mem_sr'}{'DataWidth'} = $width;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $u_mem_shift_reg->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .clk(clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      //.clk_en(clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .rst_n(reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_in(rdata_core),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_out_sel(sel),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .shift(ren),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .data_out(rdata)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 # ankitan - END
 ############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           if (config_read && (config_addr[15:0]==tile_id)) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                   case (config_addr[23:16])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
                foreach my $key (sort { $tile_info_hash->{$a}{'address'} cmp $tile_info_hash->{$b}{'address'} } keys(%$tile_info_hash))  {
	          if($key eq 'sram_0' or $key eq 'sram_1' or  $key eq 'sram_2' or  $key eq 'sram_3'){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                        \'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_info_hash->{$key}->{'address'}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' : read_data = read_data_sram;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
                  }
	          elsif($key ne 'gout') {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                        \'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_info_hash->{$key}->{'address'}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' : read_data = read_data_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $key; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
                      } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                        \'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tile_info_hash->{$key}->{'address'}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' : read_data = gout_sel;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
                          }
                        }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                             default : read_data = \'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                           endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                       end ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                       else';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                               read_data = \'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
#######################################################################
## Generate tile connectivity, and pe info 
##
#######################################################################
foreach my $feature (sort keys %$tile_info_hash)  {
  my $value = $tile_info_hash->{$feature};
################### MEMs
  if ($feature=~m/mem/) {
    print TILEINFO "    <mem feature_address='$value->{'address'}' data_bus='$value->{'data_bus'}' control_bus='$value->{'control_bus'}'>\n";
    my $filename = "MEM".$value->{'mname'};
    open (INP, "<$filename") or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      print TILEINFO $line;
    }
    close INP;
    print TILEINFO "    </mem>\n"
  }
################### CBs
  if ($feature=~m/cb/) {
    print TILEINFO "    <cb feature_address='$value->{'address'}' bus='$value->{'bus'}'>\n";
    my $filename = "CB".$value->{'mname'};
    open (INP, "<$filename") or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      foreach my $find (keys %{$rename_hash->{$feature}}) {
         my $replace = ${$rename_hash->{$feature}}{$find};
#        print TILEINFO "$find###$replace###$line"\n";
         $line=~s/>$find</>$replace</g;
         $line=~s/='$find'>/='$replace'>/g;
      }
      print TILEINFO $line;
    }
    close INP;
    print TILEINFO "    </cb>\n"
  }
################### SBs
  if ($feature=~m/sb/) {
    print TILEINFO "    <sb feature_address='$value->{'address'}' bus='$value->{'bus'}' row='$value->{'row'}'>\n";
    my $filename = "SB".$value->{'mname'};
    open (INP, "<$filename") or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      foreach my $find (keys %{$rename_hash->{$feature}}) {
         my $replace = ${$rename_hash->{$feature}}{$find};
#        print TILEINFO "$find###$replace###$line"\n";
         $line=~s/>$find</>$replace</g;
         $line=~s/'$find'/'$replace'/g;
      }
      print TILEINFO $line;
    }
    close INP;
    print TILEINFO "    </sb>\n"
  }
################### Global signal out
  if ($feature=~m/gout/) {
    print TILEINFO "    <gout feature_address='$value->{'address'}'>\n";
    foreach my $param_name (sort keys %$value) {
      my $param_value = $value->{$param_name};
      if ($param_name!~m/address/) {
        print TILEINFO "$param_value";
      }
    }
    print TILEINFO "    </gout>\n"
  }
################### SRAMs
  if ($feature=~m/sram/) {
    print TILEINFO "    <sram feature_address='$value->{'address'}'>\n";
    foreach my $param_name (sort keys %$value) {
      my $param_value = $value->{$param_name};
      if ($param_name!~m/address/) {
        print TILEINFO "$param_value";
      }
    }
    print TILEINFO "    </sram>\n"
  }
################### LineBuffers
  if ($feature=~m/linebuf/) {
    print TILEINFO "    <linebuf feature_address='$value->{'address'}'>\n";
    foreach my $param_name (sort keys %$value) {
      my $param_value = $value->{$param_name};
      if ($param_name!~m/address/) {
        print TILEINFO "$param_value";
      }
    }
    print TILEINFO "    </linebuf>\n"
  }

 #End of TILEINFO loop
}
close TILEINFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_tile/memory_tile.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
