package test_lut;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_lut.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_lut.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_lut.svp"
 my $lut_inps = parameter(Name=>'lut_inps',
                               Val=>2, Min=>2, Step=>1, Max=>16,
                               Doc=>"Number of inputs to a LUT");

my $c_in_decl = ($lut_inps > 3) ? "[".($lut_inps-3).":0]" : "     ";

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  #(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter DataWidth = 16';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  cfg_clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  cfg_rst_n,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [31:0]          cfg_d,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [7:0]           cfg_a,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  cfg_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0] op_a_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0] op_b_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($lut_inps > 2) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $c_in_decl; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        op_c_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [31:0] read_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [DataWidth-1:0] res';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'genvar ggg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'generate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  for (ggg = 0; ggg < DataWidth; ggg = ggg +1) begin : GEN_LUT';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 2**$lut_inps-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] lut;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if(~cfg_rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        lut   <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 2**$lut_inps; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if(cfg_en && (cfg_a == $unsigned(ggg/4)) ) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $cfg_index = 2**$lut_inps;
 if ($cfg_index > 32) {$cfg_index = 32;}
 if((2**$lut_inps) > 32) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        lut   <= {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } (2**$lut_inps)/32; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '{cfg_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_index-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': 0]}};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        lut   <= cfg_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_index-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': 0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($lut_inps > 2) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign res[ggg] = lut[{op_c_in, op_b_in[ggg], op_a_in[ggg]}];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign res[ggg] = lut[{op_b_in[ggg], op_a_in[ggg]}];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign read_data = {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 32-(2**$lut_inps); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'b0, lut};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endgenerate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_lut.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
