package sb;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/sb/sb.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/sb/sb.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/sb/sb.vp"
 use POSIX;
 my $width  = parameter(Name=>'width', val=> 16, doc=>'Bus width for SB');
 my $num_tracks = parameter(Name=>'num_tracks', val=> 10, doc=>'number of tracks per side for SB. half of these are inputs for unidirectional SB'); 
 my $sides = parameter(Name=>'sides', val=> 4, doc=>'number of edges for a SB, 4 for a sqarish SB'); 
 my $feedthrough_outputs = parameter(Name=>'feedthrough_outputs', val=> "11000", doc=>'binary vector for feedthrough output config. Affects all sides. MSB corresponds to output 0 eg: 00000010 means output 7 is feedthrough. Length in bits = 0.5*num_tracks.');
 my $registered_outputs = parameter(Name=>'registered_outputs', val=> "00110", doc=>'binary vector for registered output config. Affects all sides. MSB corresponds to output 0. Registering feedthrough outputs is ignored.');
 my $pe_output_count = parameter(Name=>'pe_output_count', val=> 1, doc=>'Number of PE outputs to be muxed into outgoing driven tracks');
 my $is_bidi = parameter(Name=>'is_bidi', val=> 0, doc=>'1 if SB pins are bidi. TBD.');
 my $sb_fs = parameter(Name=>'sb_fs', val=> "10000#10000#10000", doc=>'binary vector for modifying fanin of sb muxes');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $number_of_outputs = $num_tracks;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
my $filename = "SB".$self->mname();
open(SBINFO, ">$filename") or die "Couldn't open file $filename, $!";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'clk, clk_en, reset, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for(my $i=0; $i<$pe_output_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'pe_output_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 for(my $i=0; $i<$sides; $i++) {
  for(my $j=0; $j<$number_of_outputs; $j++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 #config for sb {register output config bits, driven outputs config bits}
 #              {config_addr_n, ..... , config_addr_1, config_addr_0}
 #these bits are split into 32 bit chunks and programmed into SB config reg
 #config addr 0 (LSB) corresponds to the 32 bit chunk configuring driven outputs
 #config addresses increase for 32 bit chunks till the register output config bits 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  clk_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  config_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // FIXME';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // Bits [31:24] are for switch box, [23:0] for connection box.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // So bits  [23:0] go unused in this module.  Until this is fixed,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // we have to let the linter know (verilator directives below) or it complains:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  // %Warning-UNUSED: .../sb_unq1.v:115: Bits of signal are not used: config_addr[23:0]';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_off UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_on UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $i=0; $i<$pe_output_count; $i++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] pe_output_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for(my $i=0; $i<$sides; $i++) {
    for(my $j=0; $j<$number_of_outputs; $j++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg [31:0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${width}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${num_tracks}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${feedthrough_outputs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${sides}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${registered_outputs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${pe_output_count}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${is_bidi}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${sb_fs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # #################################################
 # Setup register for SB mux configuration
 # #################################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my @feedthrough = split('',$feedthrough_outputs);
 my @registered  = split('',$registered_outputs);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $feedthrough_count=0;
 for(my $i=0; $i< scalar @feedthrough; $i++) { $feedthrough_count += $feedthrough[$i] }
 my $registered_count=0;
 for(my $i=0; $i< scalar @registered; $i++) { $registered_count += $registered[$i] }
 my $number_of_driven_outputs_per_side = $number_of_outputs - $feedthrough_count;
 my $number_of_config_bits_per_driven_output = int(ceil(log(($sides - 1) + $pe_output_count)/log(2)));
 my $config_bit_count = $number_of_driven_outputs_per_side * $number_of_config_bits_per_driven_output * $sides;
    $config_bit_count += ($registered_count * $sides);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($config_bit_count>0) { 
     my $config_reg_width = int(ceil($config_bit_count/32.0)*32);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_reg_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_sb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $config_addrs_needed = int(ceil($config_bit_count / 32.0));
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   # 12/2017 Nikhil changed default to pe_output to avoid loops (note the tilde)
   # config_sb <= ~(`$config_reg_width`'d0);
   #
   # 12/2017 SR changed default so that pe_output is selected AND registers are off
   # Want regs initialized to zero, everything else to 1 e.g. 64'h0000,00FF,FFFF,FFFF
   #   my $mask = sprintf("%016X", 2**$nonreg_bits - 1);
   #   config_sb <= `$config_reg_width`'h`$mask`;
   #
   # SR 5/2018
   # Note perl has insufficient precision to calculate 2**n when n is large!
   # It does not err, just silently gives the wrong answer :(
   # Better: in verilog e.g. {16{1'b1}} = 0xFFFF
    my   $nreg_bits = $registered_count * $sides;
    my $nonreg_bits = $config_bit_count - $nreg_bits;
    my $mux_default = ($nonreg_bits <= 40) ? 1 : 0;
    my $reg_default = 0; 
    {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // SR/NB 12/2017';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // Initialize registers to "unregistered" (leading zeroes);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // initialize routes to pe_out_res (ones) (in the case of PEs)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      //';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // SR 5/2018 NOTE/BEWARE/FIXME! sb module also used in memtiles, which';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // have no pe_res_out, so default behavior (below) may be unexpected!!!';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // (Memtile defaults are rdata and/or almost_empty, maybe.)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      //';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // SR 5/2018 Hacky \'fix\' for above problem:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // For mem-control-bit switchboxes, use all zeroes as the default.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // This does not really fix the problem maybe, but it propagates';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // the previously-working solution ish.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   #
   # SR 5/2018
   # This is the hacky way how I tell whether sb targets mem-control-bits
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      if ($nonreg_bits <= 40) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      config_sb <= {{'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($config_reg_width-$nonreg_bits); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '{1\'b0}},{'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $nonreg_bits; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '{1\'b1}}}; // for routing normal wire tracks';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      config_sb <= {{'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($config_reg_width-$nonreg_bits); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '{1\'b0}},{'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $nonreg_bits; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '{1\'b0}}}; // for mem-control-bit wiring';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (config_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         case (config_addr[31:24])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $j=0; $j<$config_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': config_sb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j+1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] <= config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           default: ;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # ############################################
 # Setup register for SB register load configuration
 # ############################################
    $config_bit_count = ($registered_count * $sides);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     my $config_reg_width = int(ceil($config_bit_count/32.0)*32);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_reg_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_ungate;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $config_ungate_addrs_needed = int(ceil($config_bit_count / 32.0));
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      config_ungate <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_reg_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (config_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         case (config_addr[31:24])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $j=$config_addrs_needed; $j<$config_addrs_needed + $config_ungate_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': config_ungate['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j - $config_addrs_needed +1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j - $config_addrs_needed)*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] <= config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           default: ;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # ###############################################
 # Setup all outputs (feedthrough/non-feedthrough)
 # ###############################################
print SBINFO "        <sel_width>$number_of_config_bits_per_driven_output</sel_width>\n";
 for(my $i=0; $i<$sides; $i++) {
 my $registered_config_bit_count = 0;
 my $driven_config_bit_count = 0;
  for(my $j=0; $j<$number_of_outputs; $j++) {
     if ($feedthrough[$j]==1) {
     print SBINFO "        <ft snk='out_${i}_${j}'>\n";
       my $opposite_side = $i + int($sides*0.5);
       if ($opposite_side > ($sides-1)) {$opposite_side -= $sides;}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opposite_side; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     print SBINFO "          <src>in_${opposite_side}_${j}</src>\n";
     print SBINFO "        </ft>\n";
     } else {
         my $config_bit_r = ($number_of_driven_outputs_per_side * $number_of_config_bits_per_driven_output * $sides) + ($registered_count * $i) + $registered_config_bit_count;
         my $config_ungate_r = ($registered_count * $i) + $registered_config_bit_count;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
        my $config_bit_l = ($number_of_driven_outputs_per_side * $number_of_config_bits_per_driven_output * $i) + ($number_of_config_bits_per_driven_output * $driven_config_bit_count);
        $driven_config_bit_count++;
        my $config_bit_h =  $config_bit_l + $number_of_config_bits_per_driven_output-1;
 #        print SBINFO "        <mux snk='out_${i}_${j}'  bith='$config_bit_h' bitl='$config_bit_l' configr='$config_bit_r'>\n";
         print SBINFO "        <mux snk='out_${i}_${j}' reg_address='@{[floor($config_bit_h/$config_reg_width)]}' ";
         print SBINFO "bith='$config_bit_h' bitl='$config_bit_l' default='@{[($mux_default==1) ? (2 ** ($config_bit_h-$config_bit_l+1) - 1) : 0]}'>\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (config_sb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_bit_h; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_bit_l; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
        my $sel = 0;
        for(my $k=0; $k<$sides; $k++) {
          if ($k == $i) {next;}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_config_bits_per_driven_output; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sel; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $k; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
          print SBINFO "          <src sel='$sel'>in_${k}_${j}</src>\n";
          $sel++;
        }
        for(my $k=0; $k<$pe_output_count; $k++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $number_of_config_bits_per_driven_output; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sel; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i = pe_output_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $k; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
          print SBINFO "          <src sel='$sel'>pe_output_${k}</src>\n";
          $sel++;
        }
       print SBINFO "        </mux>\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        default: out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i = 0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 
       if ($registered[$j]==1) {
  my $bithl_reg = $config_bit_r % $config_reg_width;
  print SBINFO "        <reg src='out_${i}_${j}' reg_address='@{[floor($config_bit_r/$config_reg_width)]}' "; 
  print SBINFO "bith='$bithl_reg' bitl='$bithl_reg' default='$reg_default' />\n";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_id1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_le;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_le = clk_en | (config_ungate['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_ungate_r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_le)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_id1 <= out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
        $registered_config_bit_count++;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = config_sb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_bit_r; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']?out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_id1:out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' = out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
     }
  }
 }
 close SBINFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $count = 0;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @ (*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (config_addr[31:24])    ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $j=0; $j<$config_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': read_data = config_sb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j+1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   $count++;
   }
   for (my $j=0; $j<$config_ungate_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': read_data = config_ungate['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j+1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j)*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   $count++;
   }
 for(my $i=0; $i<$sides; $i++) {
   for(my $j=0; $j<$number_of_outputs; $j++) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' : read_data = out_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_id1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $count++;
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        default : read_data = \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# generate corresponding testbench
# my $tb = generate_base('tb_sb', 'tb_sb',  width => $width,  num_tracks => $num_tracks,  sides => $sides,  feedthrough_outputs => $feedthrough_outputs,  registered_outputs => $registered_outputs,  pe_output_count => $pe_output_count,  is_bidi => $is_bidi, number_of_outputs =>  $number_of_outputs); 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# generate corresponding place and route scripts
# my $pnr = generate_base('sb_pnr', 'sb_pnr');
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/sb/sb.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
