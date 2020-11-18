package test_pe_comp_dual;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp_dual.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp_dual.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp_dual.svp"
 my $use_add   = parameter(Name=>'use_add', val=> 2, List=>[2, 1, 0], doc=>'0 - no adders, 1 - simple ADDs, 2 - SAD');
 my $use_cntr  = parameter(Name=>'use_cntr', val=> 1, List=>[1, 0],  doc=>'0 - no counter mode, 1 - enable counter mode');
 my $use_bool  = parameter(Name=>'use_bool', Val=>1, List=>[1, 0], Doc=>"0 - no booleans, 1 - simple gates");
 my $use_shift = parameter(Name=>'use_shift', val=> 1, List=>[1, 0], doc=>'Use shift operations');
 my $mult_mode = parameter(Name=>'mult_mode', val=> 2, List=>[2, 1, 0], doc=>'Use MAD(2) or MULT(1) or None(0)');
 my $use_div   = parameter(Name=>'use_div', val=> 1, List=>[1, 0],  doc=>'0 - no divide, 1 - enable iterrative divide');

 my $debug = $self->parameter(name=>'debug', val=> 0, List=>[1, 0], doc=>'Generate extra code for debug');

 my $use_sad  = $use_add > 1;

 my $use_c_input = ($use_sad > 0 || $mult_mode > 1);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  #(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter DataWidth = 16';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [15:0]                 inp_code [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [15:0]                 op_code [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]       op_a [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]       op_b [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]       op_c [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                        op_d_p [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [DataWidth-1:0]       cntr_next [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output                       cntr_en [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [2*DataWidth-1:0]     mult_res [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output [DataWidth-1:0]       res [1:0],';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output                       res_p [1:0]';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $comp_lsb     = generate('test_pe_comp', 'alu_lsb', is_msb => 0,
                            use_add => $use_add, use_cntr => $use_cntr,
                            use_bool => $use_bool, use_shift => $use_shift,
                            mult_mode => $mult_mode, use_div => $use_div,
                            debug => '1');
 my $comp_msb = generate('test_pe_comp', 'alu_msb', is_msb => 1,
                            use_add => $use_add, use_cntr => $use_cntr,
                            use_bool => $use_bool, use_shift => $use_shift,
                            mult_mode => $mult_mode, use_div => $use_div,
                            debug => '1');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_div > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] div_msb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] div_lsb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] carry_chain;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic       cmpr_eq_chain;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $comp_lsb->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $comp_lsb->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .inp_code   (inp_code[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_code    (op_code[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data0       (op_a[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a_shift (op_a[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data1       (op_b[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data2       (op_c[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .bit0     (op_d_p[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p_msb   (res_p[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .carry_out   (carry_chain),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cmpr_eq_out (cmpr_eq_chain),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cntr_next (cntr_next[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cntr_en   (cntr_en[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_div > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_ci    (div_msb),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_co    (div_lsb),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mult_res  (mult_res[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res       (res[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p     (res_p[0])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $comp_msb->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $comp_msb->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .inp_code    (inp_code[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_code     (op_code[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data0        (op_a[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a_shift  (op_a[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data1        (op_b[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data2        (op_c[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .bit0      (op_d_p[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .carry_in   (carry_chain),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cmpr_eq_in (cmpr_eq_chain),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cntr_next   (cntr_next[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cntr_en     (cntr_en[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_div > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_low_msb (op_a[0][DataWidth-1:DataWidth-2]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_ci      (div_lsb),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_co      (div_msb),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mult_res    (mult_res[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res         (res[1]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p       (res_p[1])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp_dual.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
