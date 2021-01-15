package test_pe;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe.svp"
 my $reg_inputs = parameter(Name=>'reg_inputs', val=> 1, List=>[1, 0], doc=>'Add register on the inputs');
 my $reg_out    = parameter(Name=>'reg_out', val=> 0, List=>[1, 0], doc=>'Add register on the outputs');

 my $use_add   = parameter(Name=>'use_add', val=> 2, List=>[2, 1, 0], doc=>'0 - no adders, 1 - simple ADDs, 2 - SAD');
 my $use_cntr  = parameter(Name=>'use_cntr', val=> 1, List=>[1, 0],  doc=>'0 - no counter mode, 1 - enable counter mode');
 my $use_bool  = parameter(Name=>'use_bool', Val=> 1, List=>[1, 0], Doc=>"0 - no booleans, 1 - simple gates");
 my $use_shift = parameter(Name=>'use_shift', val=> 1, List=>[1, 0], doc=>'Use shift operations');
 my $mult_mode = parameter(Name=>'mult_mode', val=> 2, List=>[2, 1, 0], doc=>'Use MAD(2) or MULT(1) or None(0)');
 my $use_div   = parameter(Name=>'use_div', val=> 0, List=>[1, 0],  doc=>'0 - no divide, 1 - enable iterrative divide');
 my $is_msb    = parameter(Name=>'is_msb', val=> 0, List=>[1, 0], doc=>'1 - MSB in 32b mode, 0 - LSB result');
 my $en_double = parameter(Name=>'en_double', val=> 0, List=>[1, 0], doc=>'1 - 32b supported, 0 - No 32b support');

 my $en_opt   = parameter(Name=>'en_opt', val=> 1, List=>[1, 0], doc=>'Use shifter area optimization?');
 my $en_trick = parameter(Name=>'en_trick', val=> 0, List=>[1, 0], doc=>'Shiter sharing trick in double presition');

 my $use_abs     = parameter(Name=>'use_abs', val=> 1, List=>[1, 0],  doc=>'0 - no ABS, 1 - enable ABS');
 my $use_max_min = parameter(Name=>'use_max_min', val=> 1, List=>[1, 0],  doc=>'0 - no max/min, 1 - enable max/min');
 my $use_relu    = parameter(Name=>'use_relu', val=> 0, List=>[1, 0],  doc=>'0 - no relu, 1 - enable relu');

 my $get_carry = parameter(Name=>'get_carry', val=> 1, List=>[1, 0], doc=>'1 - output carry, 0 - No carry');

 my $debug = $self->parameter(name=>'debug', val=> 0, List=>[1, 0], doc=>'Generate extra code for debug');

 my $use_flip  = $self->parameter(name=>'use_flip', val=> 0, List=>[1, 0], doc=>'Add option to flip inputs?');

 my $use_acc  = $self->parameter(name=>'use_acc', val=> 1, List=>[1, 0], doc=>'Enable accumulation?');

 my $en_ovfl = parameter(Name=>'en_ovfl', val=> 1, List=>[1, 0], doc=>'Enable overflow signals?');

 my $en_debug = parameter(Name=>'en_debug', val=> 1, List=>[1, 0], doc=>'Enable debuging registers?');


 my $lut_inps  = parameter(Name=>'lut_inps',
                               Val=> 3, Min=>0, Step=>1, Max=>16,
                               Doc=>"0 - no LUT, 1-16 - uses LUTs with that number of inputs");


 my $use_lut  = ($lut_inps > 1);

 my $use_c_input = ($use_add > 1) or ($mult_mode > 1) or ($lut_inps > 3);

 my $reg_cnt  = parameter(Name=>'reg_cnt',
                               Val=> 1, Min=>1, Step=>1, Max=>16,
                               Doc=>"Total number of registers");

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $use_reg_file = ($reg_cnt > 1);

 my $filename = "PE".$self->mname();
 open(PEINFO, ">$filename") or die "Couldn't open file $filename, $!";
 my $pe_info_hash;
 my $opcode_alu_bitl = 0;
 my $opcode_alu_bith = 5;
 my $opcode_signed_bitl = 6;
 my $opcode_signed_bith = 6;
 my $opcode_flip_bitl = 8;
 my $opcode_flip_bith = 8;
 my $opcode_acc_en_bitl = 9;
 my $opcode_acc_en_bith = 9;
 my $opcode_irq_en_bitl = 10;
 my $opcode_irq_en_bith = 11;
 my $opcode_flag_sel_bitl = 12;
 my $opcode_flag_sel_bith = 15;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $rename_hash;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/*';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'use_add   = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add  ; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'mult_mode = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $mult_mode; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'lut_inps  = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $lut_inps ; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'use_abs     = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_abs    ; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'use_max_min = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_max_min; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'use_relu    = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_relu   ; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '*/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  #(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter DataWidth = 16';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut || $reg_inputs || $reg_out) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                rst_n,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                clk_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut || $reg_inputs) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input         [31:0] cfg_d,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input         [7:0]  cfg_a,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                cfg_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [15:0]                  op_code,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]        data0,//op_a_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]        op_a_shift,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]        data1,//op_b_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input  [DataWidth-1:0]        data2,//op_c_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         bit0,//op_d_p_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         bit1,//op_e_p_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         bit2,//op_f_p_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $use_add > 0) {
   if($is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]       carry_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         cmpr_eq_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                         res_p_msb,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]      carry_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output                        cmpr_eq_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
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
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [DataWidth-1:0]  res,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [2*DataWidth-1:0] mult_res,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($en_debug) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   irq,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic                   res_p,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [31:0]  read_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_a_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_b_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_c;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic  [DataWidth-1:0]        op_c_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_d_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_d_p_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_e_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_e_p_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_f_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                         op_f_p_reg;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] comp_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 comp_res_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if(($use_add > 0) & ($get_carry & !($en_double & !$is_msb))) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]             carry_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($reg_inputs) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] inp_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] op_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_ff @(posedge clk or negedge rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  if(~rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    inp_code <= \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    op_code  <= \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end else if(cfg_en && (&cfg_a)) begin // (&cfg_a) means cfg_a == 8\'hFF';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    inp_code <= cfg_d[31:16];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    op_code  <= cfg_d[15:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] nc_inp_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign nc_inp_code = inp_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [15:0] nc_op_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign nc_op_code = op_code;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $op_a_r = generate_base('test_opt_reg', 'test_opt_reg_a');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_a_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_a_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (cfg_en && (cfg_a == 8\'hF0)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (cfg_d[DataWidth-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (data0),//op_a_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data   (op_a_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_a' } = {
   address => '0xff',
   out => 'a',
   bitl => 16,
   bith => 17,
   mname => $op_a_r->mname()
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '4_init_a' } = {
   address => '0xf0',
   out => 'a',
   bitl => 0,
   bith => 15,
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $op_b_r = generate_base('test_opt_reg_file', 'test_opt_reg_file', "reg_cnt"=>$reg_cnt);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic                 op_b_ld;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] op_b_val;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_acc) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic en_acc;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign en_acc = op_code['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_acc_en_bith; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_acc_en_bitl; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  logic cntr_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //logic [DataWidth-1:0] cntr_next;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 

my $b_en_acc = '';
my $b_acc_rst = '';

if ($use_cntr) {
  $b_en_acc = 'cntr_en';
  $b_acc_rst = '(cntr_en & comp_res_p)';
}

if ($use_acc) {
  if ($use_cntr) {
    $b_en_acc  = $b_en_acc  . '|';
    $b_acc_rst = $b_acc_rst . '|';
  }

  $b_en_acc  = $b_en_acc  . 'en_acc';
  $b_acc_rst = $b_acc_rst . '(en_acc & op_d_p)';
}

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr | $use_acc) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign op_b_ld  = (cfg_en && (cfg_a == 8\'hF1)) | (clk_en & ('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b_en_acc; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign op_b_val = (cfg_en && (cfg_a == 8\'hF1)) ?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                    cfg_d[DataWidth-1:0] :';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                    ('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $b_acc_rst; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ? {DataWidth{1\'b0}}: comp_res);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign op_b_ld  = cfg_en && (cfg_a == 8\'hF1);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  assign op_b_val = cfg_d[DataWidth-1:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_b_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_b_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (op_b_ld),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (op_b_val),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_reg_file) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_d        (cfg_d[DataWidth-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_a        (cfg_a[7:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_en       (cfg_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[4:2]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (data1),//op_b_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_b),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data   (op_b_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_b' } = {
   address => '0xff',
   out => 'b',
   bitl => 18,
   bith => 20,
   mname => $op_b_r->mname()
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 #TODO Change initialization address for register file
 #TODO I just removed initialization part of cgra_info.txt
 $pe_info_hash->{ '4_init_b' } = {
   address => '0xf1',
   out => 'b',
   bitl => 0,
   bith => 15,
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
   my $op_c_r = clone($op_a_r, 'test_opt_reg_c');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_c_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_c_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (cfg_en && (cfg_a == 8\'hF2)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (cfg_d[DataWidth-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[6:5]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (data2),//op_c_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_c),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data        (op_c_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_c' } = {
   address => '0xff',
   out => 'c',
   bitl => 21,
   bith => 22,
   mname => $op_c_r->mname()
 };
 $pe_info_hash->{ '4_init_c' } = {
   address => '0xf2',
   out => 'c',
   bitl => 0,
   bith => 15,
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
my $op_d_r = clone($op_a_r, 'test_opt_reg_d');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_d_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(1)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_d_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (cfg_en && (cfg_a == 8\'hF3)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (cfg_d[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[9:8]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (bit0),//op_d_p_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_d_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data        (op_d_p_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_d' } = {
   address => '0xff',
   out => 'd',
   bitl => 24,
   bith => 25,
   mname => $op_d_r->mname()
 };
 $pe_info_hash->{ '4_init_d' } = {
   address => '0xf3',
   out => 'd',
   bitl => 0,
   bith => 0,
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut && ( $lut_inps == 3)) {
my $op_e_r = clone($op_a_r, 'test_opt_reg_e');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_e_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(1)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_e_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (cfg_en && (cfg_a == 8\'hF4)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (cfg_d[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[11:10]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (bit1),//op_e_p_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_e_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data        (op_e_p_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_e' } = {
   address => '0xff',
   out => 'e',
   bitl => 26,
   bith => 27,
   mname => $op_e_r->mname()
 };
 $pe_info_hash->{ '4_init_e' } = {
   address => '0xf4',
   out => 'e',
   bitl => 0,
   bith => 0,
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
my $op_f_r = clone($op_a_r, 'test_opt_reg_f');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_f_r->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(1)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $op_f_r->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk        (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .clk_en     (clk_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .rst_n      (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .load       (cfg_en && (cfg_a == 8\'hF5)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .val        (cfg_d[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mode       (inp_code[13:12]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in    (bit2),//op_f_p_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res        (op_f_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .reg_data        (op_f_p_reg)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '3_reg_f' } = {
   address => '0xff',
   out => 'f',
   bitl => 28,
   bith => 29,
   mname => $op_f_r->mname()
 };
 $pe_info_hash->{ '4_init_f' } = {
   address => '0xf5',
   out => 'f',
   bitl => 0,
   bith => 0,
 };
 }
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign op_a = data0;//op_a_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign op_b = data1;//op_b_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign op_c = data2;//op_c_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign op_d_p = bit0;//op_d_p_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($use_flip){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic flip_inputs;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign flip_inputs = op_code['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_flip_bitl; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_flip_bith; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']; // WARNING:: \'Flip\' is not supported for \'double\' mode';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic V;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $pe_comp = generate('test_pe_comp', 'test_pe_comp', "use_bool"=>$use_bool, "use_add"=>$use_add,
                         "use_cntr" => $use_cntr, "use_shift"=>$use_shift, "mult_mode"=>$mult_mode,
                         "use_div" => $use_div, "is_msb"=>$is_msb, "en_double"=>$en_double,
                         "use_relu" => $use_relu, "en_opt"=>$en_opt, "en_trick"=>$en_trick,
                         "use_abs"=>$use_abs, "use_max_min"=>$use_max_min,
                         "get_carry" => $get_carry, "en_ovfl" => $en_ovfl,
                         "debug"=>$debug);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $pe_comp->instantiate(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_code (op_code[7:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_flip) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a     (flip_inputs ? op_b : op_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_b     (flip_inputs ? op_a : op_b),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a     (op_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_b     (op_b),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($en_double & $use_shift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a_shift (op_a_shift),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
 if($use_c_input) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_c     (op_c),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_d_p   (op_d_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $use_add > 0) {
   if($is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .carry_in    (carry_in  ),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cmpr_eq_in  (cmpr_eq_in),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p_msb   (res_p_msb  ),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cmpr_eq_out (cmpr_eq_out),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
 }
 if(($use_add > 0) & ($get_carry | ($en_double & !$is_msb))) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .carry_out   (carry_out  ),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_div) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_oper    (div_oper),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   if(!$is_msb & !$en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p_msb   (res_p_msb  ),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
   if(!$is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .div_co      (div_co),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   }
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_cntr) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cntr_en  (cntr_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  //.cntr_next(cntr_next),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res      (comp_res),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double & $mult_mode > 0) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .mult_res (mult_res),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 if($en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .ovfl     (V),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res_p    (comp_res_p)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '1_comp' } = {
   address => '0xff',
   bitl => $opcode_alu_bitl,
   bith => $opcode_alu_bith,
   mname => $pe_comp->mname()
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $pe_info_hash->{ '1_opcode' }->{'1_signed'} = {
   address => '0xff',
   bitl => $opcode_signed_bitl, 
   bith => $opcode_signed_bith
 };
 if ($use_flip){
 $pe_info_hash->{ '1_opcode' }->{'2_flip'} = {
   address => '0xff',
   bitl => $opcode_flip_bitl, 
   bith => $opcode_flip_bith 
 };
 }
 if ($use_acc){
 $pe_info_hash->{ '1_opcode' }->{'3_acc_en'} = {
   address => '0xff',
   bitl => $opcode_acc_en_bitl,
   bith => $opcode_acc_en_bith,
 };
 }
 if ($en_debug){
 $pe_info_hash->{ '1_opcode' }->{'4_irq_en'} = {
   address => '0xff',
   bitl => $opcode_irq_en_bitl,
   bith => $opcode_irq_en_bith,
 };
 }
 $pe_info_hash->{ '1_opcode' }->{'5_flag_sel'} = {
   address => '0xff',
   bitl => $opcode_flag_sel_bitl, 
   bith => $opcode_flag_sel_bith,
 };
 $pe_info_hash->{ '2_predicate' } = {
   address => '0xff',
   bitl => $opcode_flag_sel_bitl,
   bith => $opcode_flag_sel_bith
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $res_flag_hash;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic result_flag;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic res_lut;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($get_carry) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic Z;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic N;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic C;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 	  if(!$en_ovfl) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic V;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign V = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
	    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic [3:0] flag_sel;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign flag_sel = op_code['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_flag_sel_bith; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_flag_sel_bitl; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign C = carry_out['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $use_add -1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign Z = ~|comp_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign N = comp_res[DataWidth-1];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_EQ = 4\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_NE = 4\'h1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_CS = 4\'h2;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_CC = 4\'h3;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_MI = 4\'h4;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_PL = 4\'h5;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_VS = 4\'h6;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_VC = 4\'h7;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_HI = 4\'h8;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_LS = 4\'h9;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_GE = 4\'hA;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_LT = 4\'hB;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_GT = 4\'hC;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_LE = 4\'hD;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $res_flag_hash->{'PE_FLAG_EQ'} = {
    sel => "0x0",
    equ => 'Z'
 };
 $res_flag_hash->{'PE_FLAG_NE'} = {
    sel => "0x1",
    equ => '~Z'
 };
 $res_flag_hash->{'PE_FLAG_CS'} = {
    sel => "0x2",
    equ => 'C'
 };
 $res_flag_hash->{'PE_FLAG_CC'} = {
    sel => "0x3",
    equ => '~C'
 };
 $res_flag_hash->{'PE_FLAG_MI'} = {
    sel => "0x4",
    equ => 'N'
 };
 $res_flag_hash->{'PE_FLAG_PL'} = {
    sel => "0x5",
    equ => '~N'
 };
 $res_flag_hash->{'PE_FLAG_VS'} = {
    sel => "0x6",
    equ => 'V'
 };
 $res_flag_hash->{'PE_FLAG_VC'} = {
    sel => "0x7",
    equ => '~V'
 };
 $res_flag_hash->{'PE_FLAG_HI'} = {
    sel => "0x8",
    equ => 'C and ~Z'
 };
 $res_flag_hash->{'PE_FLAG_LS'} = {
    sel => "0x9",
    equ => '~C or Z'
 };
 $res_flag_hash->{'PE_FLAG_GE'} = {
    sel => "0xa",
    equ => 'N==V'
 };
 $res_flag_hash->{'PE_FLAG_LT'} = {
    sel => "0xb",
    equ => 'N!=V'
 };
 $res_flag_hash->{'PE_FLAG_GT'} = {
    sel => "0xc",
    equ => '~Z and (N==V)'
 };
 $res_flag_hash->{'PE_FLAG_LE'} = {
    sel => "0xd",
    equ => 'Z or (N!=V)'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_LUT = 4\'hE;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $res_flag_hash->{'PE_FLAG_LUT'} = {
    sel => "0xe",
    equ => 'lut code'
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    localparam PE_FLAG_PE  = 4\'hF;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $res_flag_hash->{'PE_FLAG_PE'} = {
    sel => "0xf",
    equ => 'comp_res_p'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        case (flag_sel)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_EQ  : result_flag = Z;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_NE  : result_flag = ~Z;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_CS  : result_flag = C;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_CC  : result_flag = ~C;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_MI  : result_flag = N;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_PL  : result_flag = ~N;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_VS  : result_flag = V;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_VC  : result_flag = ~V;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_HI  : result_flag = C & ~Z;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_LS  : result_flag = ~C | Z;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_GE  : result_flag = (N == V);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_LT  : result_flag = (N != V);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_GT  : result_flag = ~Z & (N == V);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_LE  : result_flag = Z | (N != V);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_LUT : result_flag = res_lut;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            PE_FLAG_PE  : result_flag = comp_res_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '            default     : result_flag = comp_res_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    //assign result_flag = |({Z,N, C, comp_res_p} & flag_mask);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign result_flag = comp_res_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($use_lut) {
#logic res_lut;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $lut           = generate_base('test_lut', 'test_lut', "lut_inps"=>$lut_inps);
 my $lut_extra_inp = $lut->get_param('lut_inps') > 2;
 my $lut_c_inp     = "";
 my $c_in_slice    = ($lut->get_param('lut_inps') == 3) ? "[0]" : "[".($lut_inps-3).":0]";
 if( $lut->get_param('lut_inps') == 3) {
    $lut_c_inp     = "op_f_p";
 } elsif($use_c_input) {
    $lut_c_inp     = "op_c".$c_in_slice;
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    logic [31:0] read_data_lut;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $lut->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(1)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $lut->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_clk  (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_rst_n(rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_d    (cfg_d),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_a    (cfg_a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_en   (cfg_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_a_in  (op_d_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_b_in  (op_e_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($lut_extra_inp){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .op_c_in  ('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $lut_c_inp; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .res      (res_lut),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .read_data (read_data_lut)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 	 if(!$get_carry) {
 $res_flag_hash->{'COMP_FLAG'} = {
    sel => "0x0",
    equ => 'comp_res_p'
 };
 $res_flag_hash->{'LUT_FLAG'} = {
    sel => "0x1",
    equ => 'res_lut'
 };
	 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
 my $res_w = 'comp_res';

 if($use_cntr & $use_acc) {
  $res_w = '(cntr_en | en_acc) ? op_b : comp_res';
 } elsif($use_cntr) {
  $res_w = '(cntr_en) ? op_b : comp_res';
 } elsif($use_acc) {
  $res_w = '(en_acc) ? op_b : comp_res';
 }

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($reg_out) {
 	 if(!$get_carry && $use_lut) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign res_p_w = op_code[12] ? res_lut : result_flag;//comp_res_p;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign res_p_w = result_flag;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_ff @(posedge clk or negedge rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  if(~rst_n) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    res   <= 16\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    res_p <= 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    res   <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $res_w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    res_p <= res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    assign res   = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $res_w; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 	 if(!$get_carry && $use_lut) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = op_code[12] ? res_lut : result_flag;//comp_res_p';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p = res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p_w = result_flag;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        res_p = res_p_w;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_debug) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic irq_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic irq_bit;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [31:0] read_data_debug_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $debug_d = generate_base('test_debug_reg', 'test_debug_data');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $debug_d->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(DataWidth)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $debug_d->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_clk   (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_rst_n (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_d     (cfg_d[DataWidth-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_en    (cfg_en && (cfg_a == 8\'hE0)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in   (res),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .debug_irq (irq_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .read_data (read_data_debug_data)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [31:0] read_data_debug_bit;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $debug_b = clone($debug_d, 'test_debug_bit');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $debug_b->mname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' #(.DataWidth(1)) '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $debug_b->iname(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_clk   (clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_rst_n (rst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_d     (cfg_d[0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .cfg_en    (cfg_en && (cfg_a == 8\'hE1)),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .data_in   (res_p),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .debug_irq (irq_bit),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  .read_data (read_data_debug_bit)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [1:0] irq_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign irq_en = op_code['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_irq_en_bith; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' :'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $opcode_irq_en_bitl; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'assign irq = |({irq_data,irq_bit} & irq_en);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $rename_hash = {
   wire_a => 'data0',
   wire_b => 'data1',
   wire_c => 'data2',
   wire_d => 'bit0',
   wire_e => 'bit1',
   wire_f => 'bit2'
 };
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
###################################################
# Read Data Mux
###################################################
 $pe_info_hash->{ '5_read' } = {
   out => 'read_data'
 };
 my $read_data_hash;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($reg_inputs) {
 $read_data_hash->{'op_code'} = {
   src => 'FF',
   data => '{inp_code, op_code}',
   name => 'op_code'
 };
 $read_data_hash->{'op_a'} = {
   src => 'F0',
   data => 'op_a_reg',
   name => 'reg_a'
 };
 $read_data_hash->{'op_b'} = {
   src => 'F1',
   data => 'op_b_reg',
   name => 'reg_b'
 };
 if($use_reg_file) {
 for (my $i = 1, my $j=0; $i < $reg_cnt; $i++, $j++) {
 $read_data_hash->{"op_regfile${i}"} = {
   src => "D${j}",
   data => 'op_b_reg',
   name => "regfile[${i}]"
 };
 }
 }
 if($use_c_input) {
 $read_data_hash->{'op_c'} = {
   src => 'F2',
   data => 'op_c_reg',
   name => 'reg_c'
 };
 }
 $read_data_hash->{'op_d'} = {
   src => 'F3',
   data => 'op_d_p_reg',
   name => 'reg_d'
 };
 if($use_lut && ($lut_inps == 3)) {
 $read_data_hash->{'op_e'} = {
   src => 'F4',
   data => 'op_e_p_reg',
   name => 'reg_e'
 };
 $read_data_hash->{'op_f'} = {
   src => 'F5',
   data => 'op_f_p_reg',
   name => 'reg_f'
 };
 }
 }
 if($use_lut) {
 $read_data_hash->{'lut'} = {
   src => '00',
   data => 'read_data_lut',
   name => 'lut'
 };
 }
 if($reg_out) {
 $read_data_hash->{'res'} = {
   src => 'C0',
   data => 'res',
   name => 'pe_out_res'
 };
 $read_data_hash->{'res_p'} = {
   src => 'C1',
   data => 'res_p',
   name => 'pe_out_res_p'
 };
 }
 if($en_debug) {
 $read_data_hash->{'debug_data'} = {
   src => 'E0',
   data => 'read_data_debug_data',
   name => 'debug_data'
 };
 $read_data_hash->{'debug_bit'} = {
   src => 'E1',
   data => 'read_data_debug_bit',
   name => 'debug_bit'
 };
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    case (cfg_a)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 foreach my $key (sort { $read_data_hash->{$a}{'src'} cmp $read_data_hash->{$b}{'src'} } keys(%$read_data_hash))  {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        8\'h'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $read_data_hash->{$key}->{'src'}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' : read_data = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $read_data_hash->{$key}->{'data'}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        default : read_data = \'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    endcase';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
#######################################################################
## Generate pe info
##
#######################################################################
foreach my $feature (sort keys %$pe_info_hash)  {
  my $value = $pe_info_hash->{$feature};
################### PEs
  if ($feature=~m/1_comp/) {
    print PEINFO "        <opcode reg_address='$value->{'address'}' bith='$value->{'bith'}' bitl='$value->{'bitl'}'>\n";
    my $filename = "PECOMP".$value->{'mname'};
    open (INP, "<$filename") or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      print PEINFO $line;
    }
    close INP;
    print PEINFO "        </opcode>\n"
  }
################### Opcodes
  if ($feature=~m/1_opcode/) {
    foreach my $opcode_name (sort keys %$value)  {
    my $op = $value->{$opcode_name};
    print PEINFO "        <opcode reg_address='$op->{'address'}' bith='$op->{'bith'}' bitl='$op->{'bitl'}'>";
    $opcode_name =~ s/^.{2}//s;
    print PEINFO "$opcode_name";
    print PEINFO "</opcode>\n"
    }
  }
################### Predicate
  if ($feature=~m/2_predicate/) {
    print PEINFO "        <mux reg_address='$value->{'address'}' snk='res_p' bith='$value->{'bith'}' bitl='$value->{'bitl'}'>\n";
    foreach my $flag (sort { $res_flag_hash->{$a}{'sel'} cmp $res_flag_hash->{$b}{'sel'} } keys(%$res_flag_hash))  {
       my $flag_value = $res_flag_hash->{$flag};
       print PEINFO "            <src sel='$flag_value->{'sel'}'>$flag_value->{'equ'}</src>\n";
    }
    print PEINFO "        </mux>\n"
  }
################### REGs
  if ($feature=~m/3_reg/) {
    print PEINFO "        <mux reg_address='$value->{'address'}' snk='op_$value->{'out'}' bith='$value->{'bith'}' bitl='$value->{'bitl'}'>\n";
    my $filename = "REGMODE".$value->{'mname'};
    open (INP, "<$filename") or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      $line=~s/OUTNAME/$value->{'out'}/g;
      foreach my $find (keys %{$rename_hash}) {
         my $replace = ${$rename_hash}{$find};
         $line=~s/>$find</>$replace</g;
         $line=~s/'$find'/'$replace'/g;
      }
      print PEINFO $line;
    }
    close INP;
    print PEINFO "        </mux>\n";

 if($use_reg_file) {
    my $filename = "REGFILE".$value->{'mname'};
    if (open (INP, "<$filename")) { # or die "Couldn't open file $filename, $!";
    while (<INP>) {
      my $line = $_;
      $line=~s/OUTNAME/$value->{'out'}/g;
      foreach my $find (keys %{$rename_hash}) {
         my $replace = ${$rename_hash}{$find};
         $line=~s/>$find</>$replace</g;
         $line=~s/'$find'/'$replace'/g;
      }
      print PEINFO $line;
    }
    }
    close INP;
  }
  }
# if ($feature=~m/4_init/) {
#   print PEINFO "        <reg reg_address='$value->{'address'}' bith='$value->{'bith'}' bitl='$value->{'bitl'}'>reg_$value->{'out'}</reg>\n";
# }
################### Read Data
  if ($feature=~m/5_rea/) {
    print PEINFO "        <mux snk='$value->{'out'}'>\n";
    foreach my $key (sort { $read_data_hash->{$a}{'src'} cmp $read_data_hash->{$b}{'src'} } keys(%$read_data_hash))  {
       print PEINFO "            <src sel='$read_data_hash->{$key}->{'src'}'>$read_data_hash->{$key}->{'name'}</src>\n";
    }
    print PEINFO "        </mux>\n"
  }
}
close PEINFO;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
