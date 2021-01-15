package test_pe_comp;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp.svp"
 my $use_add   = parameter(Name=>'use_add', val=> 1, List=>[2, 1, 0], doc=>'0 - no adders, 1 - simple ADDs, 2 - SAD');
 my $use_cntr  = parameter(Name=>'use_cntr', val=> 1, List=>[1, 0],  doc=>'0 - no counter mode, 1 - enable counter mode');
 my $use_bool  = parameter(Name=>'use_bool', Val=> 1, List=>[1, 0], Doc=>"0 - no booleans, 1 - simple gates");
 my $use_shift = parameter(Name=>'use_shift', val=> 1, List=>[1, 0], doc=>'Use shift operations');
 my $mult_mode = parameter(Name=>'mult_mode', val=> 2, List=>[2, 1, 0], doc=>'Use MAD(2) or MULT(1) or None(0)');
 my $use_div   = parameter(Name=>'use_div', val=> 0, List=>[1, 0],  doc=>'0 - no divide, 1 - enable iterrative divide');

 my $use_abs     = parameter(Name=>'use_abs', val=> 1, List=>[1, 0],  doc=>'0 - no ABS, 1 - enable ABS');
 my $use_max_min = parameter(Name=>'use_max_min', val=> 1, List=>[1, 0],  doc=>'0 - no max/min, 1 - enable max/min');
 my $use_relu    = parameter(Name=>'use_relu', val=> 1, List=>[1, 0],  doc=>'0 - no relu, 1 - enable relu');
 my $use_float    = parameter(Name=>'use_float', val=> 0, List=>[1, 0],  doc=>'0 - no fp support, 1 - support fadd, fmul');

 my $en_opt   = parameter(Name=>'en_opt', val=> 1, List=>[1, 0], doc=>'Use shifter area optimization?');
 my $en_trick = parameter(Name=>'en_trick', val=> 0, List=>[1, 0], doc=>'Shiter sharing trick in double presition');

 my $en_ovfl = parameter(Name=>'en_ovfl', val=> 1, List=>[1, 0], doc=>'Enable overflow signals?');


 my $is_msb    = parameter(Name=>'is_msb', val=> 0, List=>[1, 0], doc=>'1 - MSB in 32b mode, 0 - LSB result');
 my $en_double = parameter(Name=>'en_double', val=> 0, List=>[1, 0], doc=>'1 - 32b supported, 0 - No 32b support');

 my $get_carry = parameter(Name=>'get_carry', val=> 1, List=>[1, 0], doc=>'1 - output carry, 0 - No carry');

 my $debug     = $self->parameter(name=>'debug', val=> 0, List=>[1, 0], doc=>'Generate extra code for debug');

 my $use_sad   = $use_add > 1;

 my $use_c_input = ($use_sad > 0) or ($mult_mode > 1);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/*';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '$use_add  = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add ; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '*/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $filename = "PECOMP".$self->mname();
 open(COMPINFO, ">$filename") or die "Couldn't open file $filename, $!";
 my $pecomp_info_hash;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  #(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter DataWidth = 16';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [7:0]                    op_code,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]         op_a,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]         op_a_shift,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]         op_b,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]         op_c,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                          op_d_p,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 0) {
   if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]              carry_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         cmpr_eq_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } elsif($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                          res_p_msb,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   cmpr_eq_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
 if(($use_add > 0) & ($get_carry | ($en_double & !$is_msb))) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]             carry_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //output logic [DataWidth-1:0]   cntr_next,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   cntr_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_div) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input        [DataWidth-1:0]   div_oper,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if(!$is_msb & !$en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                          res_p_msb,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
   if(!$is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [DataWidth-1:0]   div_co,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [DataWidth-1:0]   res,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [2*DataWidth-1:0] mult_res,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   ovfl,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   res_p';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam DATA_MSB      = DataWidth - 1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_ADD_OP     = 6\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'add' } = {
   opcode => '00',
   result => 'op_a+op_b+op_d',
   predicate => '(op_a+op_b+op_d) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_SUB_OP     = 6\'h1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'sub' } = {
   opcode => '01',
   result => 'op_a+~op_b+1',
   predicate => '(op_a+~op_b+1) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_abs) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_ABS_OP     = 6\'h3;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'abs' } = {
   opcode => '03',
   result => '(op_a lt 0)?(0-op_a):op_a',
   predicate => 'op_a[15]'
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_GTE_MAX_OP = 6\'h4;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'gte_max' } = {
   opcode => '04',
   result => '(op_a gte op_b)?op_a:op_b',
   predicate => 'op_a gte op_b'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_LTE_MIN_OP = 6\'h5;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'lte_min' } = {
   opcode => '05',
   result => '(op_a lte op_b)?op_a:op_b',
   predicate => 'op_a lte op_b'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_SEL_OP     = 6\'h8;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'sel' } = {
   opcode => '08',
   result => 'op_d?op_a:op_b',
   predicate => '(op_a+op_b) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_shift > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_RSHFT_OP   = 6\'hF;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'rshft' } = {
   opcode => '0f',
   result => 'op_a rshft op_b[3:0]',
   predicate => '(op_a+op_b) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_LSHFT_OP   = 6\'h11;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'lshft' } = {
   opcode => '11',
   result => 'op_a lshft op_b[3:0]',
   predicate => '(op_a+op_b) gte 2^16'
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_MULT_0_OP  = 6\'hB;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'mult_0' } = {
   opcode => '0b',
   result => '(op_a*op_b)[15:0]',
   predicate => '(op_a*op_b+op_c) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_MULT_1_OP  = 6\'hC;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'mult_1' } = {
   opcode => '0c',
   result => '(op_a*op_b)[23:8]',
   predicate => '(op_a*op_b+op_c) gte 2^24'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_MULT_2_OP  = 6\'hD;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'mult_2' } = {
   opcode => '0d',
   result => '(op_a*op_b)[31:16]',
   predicate => '0'
 };
   if($use_relu){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_RELU       = 6\'hE;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'relu' } = {
   opcode => '0e',
   result => '(op_a lt 0)?(op_a*W)[31:16]:op_a',
   predicate => 'op_a[15]'
 };
   }
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_bool) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_OR_OP      = 6\'h12;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'or' } = {
   opcode => '12',
   result => 'op_a|op_b',
   predicate => '(op_a+op_b) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_AND_OP     = 6\'h13;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'and' } = {
   opcode => '13',
   result => 'op_a and op_b',
   predicate => '(op_a+op_b) gte 2^16'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_XOR_OP     = 6\'h14;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'xor' } = {
   opcode => '14',
   result => 'op_a^op_b',
   predicate => '(op_a+op_b) gte 2^16'
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_CNTR_OP    = 6\'h18;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'cntr' } = {
   opcode => '18',
   result => 'cnt[t]',
   predicate => 'tc=(op_b==tc_val)'
 };
 }
 if($use_div) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_DIV_OP     = 6\'h19;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'div' } = {
   opcode => '19',
   result => 'op_a/op_b',
   predicate => '(op_a+op_b) gte 2^16'
 };
 }
 if(($en_double==0) &$mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [2*DataWidth-1:0] mult_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_float) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_FLOAT_ADD     = 6\'h20;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'fadd' } = {
   opcode => '20',
   result => 'op_a + op_b',
   predicate => '0'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam PE_FLOAT_MULT     = 6\'h21;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pecomp_info_hash->{ 'fmul' } = {
   opcode => '21',
   result => 'op_a * op_b',
   predicate => '0'
 };
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [7:0]        nc_op_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign             nc_op_code = op_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DATA_MSB:0] res_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic              res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 is_signed;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//logic                 dual_mode;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 double_mode;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 


 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 cmpr_lte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 cmpr_gte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 cmpr_eq;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam NUM_ADDERS = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam ADD_MSB = NUM_ADDERS - 1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DATA_MSB:0]  add_a     [ADD_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DATA_MSB:0]  add_b     [ADD_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic               add_c_in  [ADD_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire  [DATA_MSB:0]  add_res   [ADD_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wire                add_c_out [ADD_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'genvar ggg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'generate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  for(ggg=0;ggg<NUM_ADDERS;ggg=ggg+1) begin : GEN_ADD';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $full_add = generate_base('test_full_add', 'full_add');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $full_add->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $full_add->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .a     (add_a[ggg]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .b     (add_b[ggg]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .c_in  (add_c_in[ggg]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//      .dual_mode (dual_mode),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .res   (add_res[ggg]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .c_out (add_c_out[ggg])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($get_carry | ($en_double & !$is_msb)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign carry_out[ggg] = add_c_out[ggg];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endgenerate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign cmpr_eq   =  ~|(op_a ^ op_b) & (~double_mode | cmpr_eq_in);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign cmpr_eq   =  ~|(op_a ^ op_b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $compare = generate_base('test_cmpr', 'cmpr');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $compare->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .a_msb     (op_a[DATA_MSB]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .b_msb     (op_b[DATA_MSB]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .diff_msb  (add_res[0][DATA_MSB]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .is_signed (is_signed),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .eq        (cmpr_eq),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .lte       (cmpr_lte),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .gte       (cmpr_gte)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 mult_c_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $mult = generate_base('test_mult_add', 'test_mult_add', "use_mad"=>($mult_mode-1));
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mult->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mult->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .is_signed (is_signed),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .a  (op_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .b  (op_b),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//  .dual_mode(dual_mode),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
if($mult_mode > 1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .c  (op_c),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res   (mult_res),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .c_out (mult_c_out)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($debug) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//Enumeration to help with waveforms during simulation';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'enum {';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'Add_Op, Sub_Op, Abs_Op, GteMax_Op, LteMin_Op, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'Sel_Op, Rshft_Op, Lshft_Op, Mult0_Op, Mult1_Op, Mult2_Op, Relu_Op, Or_Op,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'And_Op, Xor_Op, Cntr_Op, Div_Op, Fadd, Fmul, InvalidOp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '} pe_oper;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  case (op_code[5:0])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_ADD_OP     : pe_oper = Add_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_SUB_OP     : pe_oper = Sub_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_ABS_OP     : pe_oper = Abs_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_GTE_MAX_OP : pe_oper = GteMax_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_LTE_MIN_OP : pe_oper = LteMin_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_SEL_OP     : pe_oper = Sel_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_RSHFT_OP   : pe_oper = Rshft_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_LSHFT_OP   : pe_oper = Lshft_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_0_OP  : pe_oper = Mult0_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_1_OP  : pe_oper = Mult1_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_2_OP  : pe_oper = Mult2_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_relu) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_RELU       : pe_oper = Relu_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_OR_OP      : pe_oper = Or_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_AND_OP     : pe_oper = And_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_XOR_OP     : pe_oper = Xor_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_CNTR_OP    : pe_oper = Cntr_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_div) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_DIV_OP     : pe_oper = Div_Op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_float) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_FLOAT_ADD  : pe_oper = Fadd;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_FLOAT_MULT : pe_oper = Fmul;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    default       : pe_oper = InvalidOp;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign cntr_en = (op_code[5:0] == PE_CNTR_OP);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_shift > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DATA_MSB:0] shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   my $shft = generate('test_shifter', 'test_shifter', "en_double"=>$en_double, is_msb=>$is_msb, "en_opt"=>$en_opt, "en_trick"=>$en_trick);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $shft->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $shft->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .is_signed (is_signed),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .double_mode (double_mode),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .dir_left(op_code[5:0]==PE_LSHFT_OP),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .a  (op_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .a_shift (op_a_shift),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .b   (op_b[$clog2(DataWidth)-1+'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $en_double; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res (shift_res)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign is_signed   = op_code[6];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign double_mode = op_code[7];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//assign dual_mode   = op_code[8]; //Save the OP code bit for half precision support';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & !$is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign cmpr_eq_out = cmpr_eq;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if((($mult_mode > 0) & $use_relu) or (($use_add > 0) & $use_abs) ) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic diff_sign;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign diff_sign = add_res[0][DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } elsif($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign diff_sign = double_mode ? res_p_msb : add_res[0][DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign diff_sign = add_res[0][DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl & $use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'localparam DataMSB = DataWidth-1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [ADD_MSB:0] ovfl_add_signed;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign ovfl_add_signed[0] = (op_a[DataMSB] == op_b[DataMSB]) &';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                            (op_a[DataMSB] != add_res[0][DataMSB]);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($use_add > 1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign ovfl_add_signed[1] = (add_res[0][DataMSB] == op_c[DataMSB]) &';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                            (op_c[DataMSB] != add_res[1][DataMSB]);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  ovfl_sub_signed;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ovfl_sub_signed = ((op_a[DataMSB] != op_b[DataMSB]) & (op_a[DataMSB] != add_res[0][DataMSB]));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 1) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ovfl_sub_signed = ovfl_sub_signed | ovfl_add_signed[1];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($use_float > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] fadd_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] fmul_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [2:0] fmul_res_x;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  CW_fp_mult #(.sig_width(10), .exp_width(8), .ieee_compliance(0)) mul1 (.a({op_a,3\'d0}),.b({op_b,3\'d0}),.rnd(3\'d0),.z({fmul_res,fmul_res_x}),.status());';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  CW_fp_add #(.sig_width(7), .exp_width(8), .ieee_compliance(0)) add1 (.a(op_a),.b(op_b),.rnd(3\'d0),.z(fadd_res),.status());';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_comb begin : proc_alu';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_a[0] = op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_b[0] = op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_c_in[0] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_a[1] = add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_b[1] = op_c;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  add_c_in[1] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  res_w   = add_res[ADD_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  res_p_w = add_c_out[ADD_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  res_w   = \'hX;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  res_p_w = \'hX;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//  cntr_next   = add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_div & !$is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  div_co      = {DataWidth{1\'b0}};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ovfl = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  unique case (op_code[5:0])';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_float > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_FLOAT_ADD: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w  = fadd_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_FLOAT_MULT: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w  = fmul_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_add > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_ADD_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : op_d_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[1] = double_mode ? carry_in[1] : 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = op_d_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = add_c_out[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = add_c_out[0] | add_c_out[1];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ovfl        = (is_signed) ? (|ovfl_add_signed) : res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_SUB_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = ~op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[1] = double_mode ? carry_in[1] : 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ovfl        = (is_signed) ? ovfl_sub_signed : 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_abs) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_ABS_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = ~op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_a[1]    = diff_sign ? ~add_res[0]:add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[1] = double_mode ? carry_in[1] : diff_sign;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[1] = diff_sign;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ovfl        = (add_res[0][DATA_MSB] & (~|add_res[0][DATA_MSB-1:0])) |';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                      res_w[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = diff_sign;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_a[0]    = ~op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = 0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = op_a[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } elsif($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = double_mode ? res_p_msb : op_a[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = op_a[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
     }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w       = (diff_sign | !is_signed) ? op_a : add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ovfl        = res_w[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_GTE_MAX_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = ~op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = cmpr_gte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} elsif($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = double_mode ? res_p_msb : cmpr_gte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = cmpr_gte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_max_min) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w       = res_p_w ? op_a : op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_LTE_MIN_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = ~op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = double_mode ? carry_in[0] : 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = cmpr_lte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} elsif($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = double_mode ? res_p_msb : cmpr_lte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = cmpr_lte;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($use_max_min) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w       = res_p_w ? op_a : op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      PE_SEL_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = op_d_p ? op_a : op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_shift > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_RSHFT_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_LSHFT_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_0_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w   = mult_res[DATA_MSB:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = mult_c_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        if (is_signed) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '          ovfl = (op_a[DATA_MSB] == op_b[DATA_MSB]) ?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                                    mult_res[DATA_MSB] :';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                                    ~mult_res[DATA_MSB] & |{op_a, op_b};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '          ovfl = |mult_res[2*DataWidth-1:DataWidth];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_1_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w   = mult_res[3*DataWidth/2-1:DataWidth/2];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = mult_c_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        if (is_signed) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '          ovfl = (op_a[DATA_MSB] == op_b[DATA_MSB]) ?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                                    mult_res[DATA_MSB] :';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                                    ~mult_res[DATA_MSB] & |{op_a, op_b};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '          ovfl = |mult_res[2*DataWidth-1:3*DataWidth/2];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_MULT_2_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w   = mult_res[2*DataWidth-1:DataWidth];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = mult_c_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        ovfl = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if($use_relu) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_RELU: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w   = diff_sign ? mult_res[2*DataWidth-1:DataWidth] : op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = op_a[DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_bool) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_OR_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = op_a | op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_AND_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = op_a & op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_XOR_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w = op_a ^ op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_CNTR_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_a[0]    = op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_a[0]    = \'h1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_b[0]    = op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        add_c_in[0] = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        //res_w       = op_b; // Current counter value';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '	res_w       = add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        //cntr_next   = add_res[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_sad) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = ~|(op_b ^ op_c); // Done counting';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w     = ~|(op_b ^ op_a); // Done counting';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_div) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    PE_DIV_OP: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      add_a[0]    = div_oper;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      add_b[0]    = ~op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      add_c_in[0] = 1\'b1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      res_w       = ~add_res[0][DATA_MSB] ?  add_res[0] : div_oper;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      res_p_w     = add_res[0][DATA_MSB];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      div_co      = ~add_res[0][DATA_MSB] ? add_res[0] : div_oper;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      res_w       = {op_a[DataWidth-3:0], ~add_res[0][DATA_MSB] , ~res_p_msb} ;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    default: begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_w   = op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = op_d_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign res   = res_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign res_p = res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
#######################################################################
## Generate PECOMP info
##
#######################################################################
foreach my $operation (sort { $pecomp_info_hash->{$a}{'opcode'} cmp $pecomp_info_hash->{$b}{'opcode'} } keys(%$pecomp_info_hash))  {
  my $value = $pecomp_info_hash->{$operation};
  print COMPINFO "            <op sel='0x$value->{'opcode'}' name='$operation'>\n";
  print COMPINFO "                pe_out_res=$value->{'result'}\n";
  print COMPINFO "                comp_res_p=$value->{'predicate'}\n";
  print COMPINFO "            </op> \n";
}
close COMPINFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_comp.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
