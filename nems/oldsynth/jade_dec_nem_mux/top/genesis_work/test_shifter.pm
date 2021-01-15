package test_shifter;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_shifter.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_shifter.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_shifter.svp"
my $en_double = parameter(Name=>'en_double', val=> 1, List=>[1, 0], doc=>'1 - 32b supported, 0 - No 32b support');
my $is_msb    = parameter(Name=>'is_msb', val=> 0, List=>[1, 0], doc=>'1 - MSB in 32b mode, 0 - LSB result');

my $en_opt   = parameter(Name=>'en_opt', val=> 1, List=>[1, 0], doc=>'Use shifter area optimization?');
my $en_trick = parameter(Name=>'en_trick', val=> 0, List=>[1, 0], doc=>'Shiter sharing trick in double presition');

if($en_trick & $en_double) {
 my $dummy0 = generate_base('test_simple_shift', 'dummy0');
}

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  #(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter DataWidth = 16,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  parameter B_MSB = $clog2(DataWidth)-1+'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $en_double; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  is_signed,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  double_mode,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input                  dir_left,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input signed [DataWidth-1:0] a,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if($en_double) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input signed [DataWidth-1:0] a_shift,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input [B_MSB:0]       b,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output logic [DataWidth-1:0] res';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] lshift_val;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'logic [DataWidth-1:0] rshift_val;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
if($en_opt == 0) {
  if($en_double & $is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (double, msb)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign lshift_val = {a, (a_shift & {DataWidth{double_mode}}) } << b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = is_signed ? a >>> b) : (a >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  } elsif($en_double & ($is_msb==0)) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (double, !msb)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign lshift_val = a << b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = is_signed ? ({(a_shift & {DataWidth{double_mode}}, a}) >>> b)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                         : ({(a_shift & {DataWidth{double_mode}}), a} >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (!double)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign lshift_val = a << b;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = is_signed ? (a >>> b) : (a >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  }
} elsif($en_double & $en_trick) {
  if($is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (double, trick), msb';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [B_MSB-1:0] reverse_shift_by;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic             nc_reverse_shift_by_msb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign {nc_reverse_shift_by_msb, reverse_shift_by} = 5\'h16 - b[B_MSB-1:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [DataWidth-1:0] rsh_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     r_shifter  #(.DataWidth(DataWidth)) RSH (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .a   (dir_left ? a_shift : a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .b   (dir_left ? reverse_shift_by : b[B_MSB-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .res (rsh_res)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [DataWidth-1:0] lsh_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     l_shifter  #(.DataWidth(DataWidth)) LSH (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .a   (b[B_MSB] ? a_shift : a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .b   (b[B_MSB-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .res (lsh_res)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign lshift_val = (b[B_MSB] | ~double_mode | (~|b[B_MSB-1:0])) ? lsh_res : (lsh_res | rsh_res);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = rsh_res & {DataWidth{~b[B_MSB]}};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (double, trick, (!msb))';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [DataWidth-1:0] rsh_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     r_shifter  #(.DataWidth(DataWidth)) RSH (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .a   (b[B_MSB] ? a_shift : a),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .b   (b[B_MSB-1:0]),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .res (rsh_res)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [B_MSB-1:0] reverse_shift_by;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic             nc_reverse_shift_by_msb;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign {nc_reverse_shift_by_msb, reverse_shift_by} = 5\'h16 - b[B_MSB-1:0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [DataWidth-1:0] lsh_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     l_shifter  #(.DataWidth(DataWidth)) LSH (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .a   (dir_left ? a : a_shift),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .b   (dir_left ? b[B_MSB-1:0]: reverse_shift_by),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       .res (lsh_res)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign lshift_val = lsh_res & {DataWidth{~b[B_MSB]}};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = (b[B_MSB] | ~double_mode | (~|b[B_MSB-1:0])) ? rsh_res : (rsh_res | lsh_res);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  }
} elsif($en_double) {
  if($is_msb) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, double, msb';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic signed [2*DataWidth-1:0] shift_inp;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [2*DataWidth-1:0] shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [2*DataWidth-1:0] a_reverse;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign shift_inp = dir_left ? a_reverse : {{DataWidth{1\'b0}},a};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign shift_res = (is_signed & !dir_left) ? shift_inp >>> b[B_MSB:0] : (shift_inp >> b[B_MSB:0]);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = shift_res[DataWidth-1:0];//(a >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     genvar g_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     generate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       for(g_i = 0; g_i < DataWidth; g_i++) begin: GEN_L_SHIFT';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign a_reverse[g_i]            = a[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign a_reverse[DataWidth+g_i]  = double_mode & a_shift[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign lshift_val[g_i] = shift_res[2*DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     endgenerate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  } else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     // !opt, (!double, !msb)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic signed [2*DataWidth-1:0] shift_inp;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [2*DataWidth-1:0] shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     logic [2*DataWidth-1:0] a_reverse;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign shift_inp = dir_left ? a_reverse : {{DataWidth{1\'b0}},a};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign shift_res  = (is_signed & !dir_left) ? shift_inp >>> b[B_MSB:0] : (shift_inp >> b[B_MSB:0]);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     assign rshift_val = shift_res[DataWidth-1:0];//(a >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     genvar g_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     generate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       for(g_i = 0; g_i < DataWidth; g_i++) begin: GEN_L_SHIFT';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign a_reverse[g_i]            = double_mode & a_shift[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign a_reverse[DataWidth+g_i]  = a[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '         assign lshift_val[g_i] = shift_res[2*DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     endgenerate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  }
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // opt';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic signed [DataWidth-1:0] shift_inp;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic [DataWidth-1:0] shift_res;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic [DataWidth-1:0] a_reverse;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign shift_inp = dir_left ? a_reverse : a;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign shift_res =  (is_signed & !dir_left)  ? (shift_inp >>> b): (shift_inp >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign rshift_val = shift_res; //(a >> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   genvar g_i;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   generate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     for(g_i = 0; g_i < DataWidth; g_i++) begin: GEN_L_SHIFT';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       assign a_reverse[g_i]  = a[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       assign lshift_val[g_i] = shift_res[DataWidth-1-g_i];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   endgenerate';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
my $break_rshift = 0;
if ($break_rshift) {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Break right-shift to test Lenny\'s unit-tests';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // (note harris also breaks if we do ">>" instead of ">>>"';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign res = dir_left ? lshift_val: (shift_inp >>> b);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
} else {
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign res = dir_left ? lshift_val: rshift_val;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
}
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_shifter.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
