package cb;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/cb/cb.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/cb/cb.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/cb/cb.vp"
 use POSIX;
 my $width  = parameter(Name=>'width', val=> 16, doc=>'Bus width for CB');
 my $num_tracks = parameter(Name=>'num_tracks', val=> 10, doc=>'num of tracks for CB'); 
 my $feedthrough_outputs = parameter(Name=>'feedthrough_outputs', val=> "1111101111", doc=>'binary vector for specifying tracks that are muxed. MSB corresponds to track 0 eg: 1011 means tracks 0, 2, 3 are muxed to produce output for PE. Length in bits = num_tracks.');
 my $has_constant = parameter(Name=>'has_constant', val=> 1, doc=>'set to 1 if the CB has a register to supply a constant '); 
 my $default_value = parameter(Name=>'default_value', val=> 0, doc=>'set default cb output value on reset. has_constant should be 1 to enable this feature'); 
 my @feedthrough = split('',$feedthrough_outputs);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'clk, reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for(my $i=0; $i<$num_tracks; $i++) {
  if ($feedthrough[($i%$num_tracks)]==1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'config_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  config_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   # Bits [31:24] are for switch box, [23:0] for connection box.
   # So we have to let the linter know (verilator directives below) or it complains:
   # %Warning-UNUSED: .../cb_unq1.v:73: Bits of signal are not used: config_addr[23:0]
   # FIXME Owner please confirm that this is correct and delete this FIXME line (but keep the rest)
   # FIXME someday? Maybe shouldn't bring in all 32 bits if we're not going to use them?
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_off UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [31:0] config_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_on UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${default_value}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${width}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${num_tracks}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${feedthrough_outputs}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${has_constant}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for(my $i=0; $i<$num_tracks; $i++) {
   if ($feedthrough[$i%$num_tracks]==1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg [31:0] read_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # ############################################
 # Setup register for CB mux configuration
 # ############################################
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $feedthrough_count=$num_tracks;
 for(my $i=0; $i< scalar @feedthrough; $i++) { $feedthrough_count -= $feedthrough[$i] }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $mux_sel_bit_count = int(ceil(log($num_tracks - $feedthrough_count + $has_constant)/log(2)));
 my $constant_bit_count = $has_constant * $width;
 my $config_bit_count = $mux_sel_bit_count + $constant_bit_count;
 my $config_reg_width = int(ceil($config_bit_count/32.0)*32);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_off UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $config_reg_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] config_cb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  /* verilator lint_on UNUSED */';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $config_addrs_needed = int(ceil($config_bit_count / 32.0));
   my $reset_val = $num_tracks - $feedthrough_count + $has_constant - 1;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if ($constant_bit_count>0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        config_cb <= {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $constant_bit_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${default_value}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ','; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reset_val; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        config_cb <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reset_val; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (config_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         case (config_addr[31:24])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $j=0; $j<$config_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '           8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': config_cb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j+1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] <= config_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (config_addr[31:24])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   for (my $j=0; $j<$config_addrs_needed; $j=$j+1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      8\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': read_data = config_cb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($j+1)*32-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $j*32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      default: read_data = \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # ###############################################
 # Setup input mux
 # ###############################################
my $filename = "CB".$self->mname();
open(CBINFO, ">$filename") or die "Couldn't open file $filename, $!";
print CBINFO "        <sel_width>$mux_sel_bit_count</sel_width>\n";
#print CBINFO "        <has_constant>$has_constant</has_constant>\n";
print CBINFO "        <default>$reset_val</default>\n";
print CBINFO "        <mux snk='out'>\n";
 my $sel=0;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (config_cb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 for(my $i=0; $i<$num_tracks; $i++) {
   if ($feedthrough[$i%$num_tracks]==1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sel; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': out = in_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $i; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     print CBINFO "          <src sel='$sel'>in_$i</src>\n";
     $sel++;
   }
 }
   if ($has_constant==1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        default: out = config_cb['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count+$constant_bit_count-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mux_sel_bit_count; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     $sel++;
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        default: out = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print CBINFO "        </mux>\n";
close CBINFO;
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/cb/cb.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
