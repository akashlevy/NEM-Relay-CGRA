package reg_file;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/reg_file.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/reg_file.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/reg_file.svp"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/* *****************************************************************************';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * File: reg_file.vp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Description:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * This file is using Genesis2 to make a register file.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * A register file have a config bus input port, and a config bus output port. ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * The configuration request values are flopped and then handled:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * If cfgIn_op is a no-op, nothing happens.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * If cfgIn_op is a bypass op, the  cfgIn_* signals are passed to the ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      cfgOut_* ports.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * If cfgIn_op is a read/write op, and cfgIn_addr is with in the address';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      range, then the corresponding register is read/written. The values';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      are streamed to the cfgOut_* ports, except for cfgOut_op that becomes';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      a bypass-op.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      If cfgIn_addr is not in this reg_file address range, all the  cfgIn_* ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      signals are passed to the cfgOut_* ports. Someone else will answer...';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Note: All registers in the register file are write-able and readable by the';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      configuration bus (even though some may only have output ports or only';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *      input ports).';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * REQUIRED GENESIS PARAMETERS:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ----------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * RegList  - List of registers. Each element in the list is a hash that contains';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * Name - used for generating the enable and data output/input signals';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * Width - register width';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * Default - (optional) default value. Can be set later by XML input';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * IEO - I indicates this register connected to an input signal';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *            E indicates that the input is qualified by an enable ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *            O indicates that the output is connected to an output signal';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *            Valid options include: I, IE, O, IO, IEO';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * Comment - (optional) description of the register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   Example:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    my $reg_list = [      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *        {Name => \'regA\', Width => 5, Default => 17, IEO => \'ie\', Comment => \'this is a reg\'}, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *        {Name => \'regB\', Width => 10, Default => 27, IEO => \'o\'}, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *        {Name => \'regC\', Width => 15, IEO => \'ieo\'},';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *        {Name => \'regD\', Width => 13, Default => 4, IEO => \'i\'}';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *                   ];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * BaseAddr - Base address for this module ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * CfgOpcodes - Interpretation of the opcode. Must contain the following feilds:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * nop - value of cfgIn_op for a no-op (default is 0)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * read - value of cfgIn_op for a read operation (default is 1)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * write - value of cfgIn_op for a write operation (default is 2)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * bypass - value of cfgIn_op for bypassing the control signals (default is 3)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * CfgBusPtr - An instance of the reg_file_ifc (used as reference)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Inputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * -------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Clk';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * cfgIn - Incomming config request';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * foreach REG in REG_LIST (but depending on the IEO flag):';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *  * <REG.name>_en - enable signal for the register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *  * <REG.name>_d - data input for the register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Outputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * --------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * cfgOut - Outgoing reply for config request cfgIn';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * foreach REG in REG_LIST (but depending on the IEO flag):';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *  * <REG.name>_q - data output for the register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * NOTE: registers with input from the design may become resource contention';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *       if both their private enable and their by-address enable signals are raised.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *       Priority is always given to data from the cfg bus!';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ****************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # Perl Libraries
 use POSIX qw(ceil);


print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// ACTUAL GENESIS2 PARAMETERIZATIONS';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $reg_list = parameter(Name=>'RegList', Val => [],
     Doc=>"Register List. Each register must have a \'Name\', \'Width\' and \'IEO\' fields. ".
 	     "Optional fields are \'Default\' and \'Comment\' ".
 	     "(IEO stands for Input/Enable/Output. Valid values are {I, IE, IO, O, IEO}");
 my $num_regs = scalar(@{$reg_list});
 $self->error("Empty list of registers in RegList") unless $num_regs;

 my $base_addr = parameter(Name=>'BaseAddr', Val=>0, Doc=>"Base address for this register file");
 my $cfg_ops = $self->define_param('CfgOpcodes' => {nop=>0, read=>1, write=>2, bypass=>3});
 my $ifc_ref = parameter(Name=>'CfgBusPtr', Val=>undef, Doc=>"Pointer to the bus interface object");
 $self->error("Missing parameter: CfgBusPtr") unless (defined $ifc_ref);

 # Extract paramteres from the interdace
 my $cfg_bus_width = $ifc_ref->get_param('DataWidth');
 my $cfg_addr_width = $ifc_ref->get_param('AddrWidth');
 my $cfg_op_width = $ifc_ref->get_param('OpcodeWidth');


# Verify correctness of register parameters:
 my $cnt = 0;
 foreach my $reg (@{$reg_list}){
   $self->error("Register $cnt is missing it's Name!") 
      unless defined $reg->{Name};
   $self->error("Register $reg->{Name} (reg $cnt) is missing it's width!") 
      unless defined $reg->{Width};
   $self->error("Register $reg->{Name} (reg $cnt) is wider than the config bus!") 
      unless $reg->{Width} <= $cfg_bus_width;
   $self->error("Register $reg->{Name} (reg $cnt) is missing it's IEO!") 
      unless defined $reg->{IEO};
   $self->error("Register $reg->{Name} (reg $cnt) has an invalid IEO flag -->$reg->{IEO}<--!".
               "(allowed values: I, IE, O, IO, IEO)") 
      unless ($reg->{IEO} =~ m/^(i|ie|o|io|ieo)$/i);
   $cnt++;
 } # end of "foreach my $reg..."

# Verify correctness of opcode parameters:
 $self->error("CfgOpcodes must define values for all of {nop, read, write, bypass} opcodes")
      if (!defined $cfg_ops->{nop} || !defined $cfg_ops->{read} || 
          !defined $cfg_ops->{write} || !defined $cfg_ops->{bypass});
 my $nop = $cfg_ops->{nop};
 my $rdop = $cfg_ops->{read};
 my $wrop = $cfg_ops->{write};
 my $bypassop = $cfg_ops->{bypass};
 $self->error("CFG_OPCODES values don't fit within CFG_OPCODE_WIDTH bits")
      if (($nop > 2**$cfg_op_width-1) || ($rdop > 2**$cfg_op_width-1) || 
          ($wrop > 2**$cfg_op_width-1) || ($bypassop > 2**$cfg_op_width-1));


 my $num_req_addr_bits = ceil(log($num_regs)/log(2));
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// Fix for reg files with single registers';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 if ($num_req_addr_bits == 0) {
    $num_req_addr_bits = 1;
 }
 my $num_not_used_lsbs = ceil(log($cfg_bus_width/8)/log(2));
 my $usable_addr_range = ($num_req_addr_bits+$num_not_used_lsbs-1).":".$num_not_used_lsbs;
 my $base_addr_range = ($cfg_addr_width-1).":".($num_req_addr_bits+$num_not_used_lsbs);
 my $base_addr_width = $cfg_addr_width - ($num_req_addr_bits+$num_not_used_lsbs);
 my $base_addr_trunc = $base_addr / 2**($num_req_addr_bits+$num_not_used_lsbs);
 my $base_addr_hex = sprintf("%d\'h%x", $base_addr_width, $base_addr_trunc);

print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// =============================================================================';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//                  LIST OF REGISTERS IN THIS MODULE:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// =============================================================================';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// LEGEND: ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//      BaseAddr '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } sprintf("'h%x", $base_addr); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//      IEO:  I for input (register samples design)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//            O for output (register drives design)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//            IE for enabled input (register samples design if enable is high)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// REGISTERS';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 $cnt = 0;
 foreach my $reg (@{$reg_list}){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] IEO='; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{IEO}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' Offset='; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt<<$num_not_used_lsbs; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' -- '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Comment}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   $cnt++;
 } # end of "foreach my $reg..."
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// =============================================================================';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//                             MODULE:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// =============================================================================';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // inputs for the config interface';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $ifc_ref->mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgIn cfgIn, // incoming requests';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $ifc_ref->mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgOut cfgOut, // outgoing responds';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    foreach my $reg (@{$reg_list}){
      if ($reg->{IEO} =~ m/i/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    // inputs for register '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]       '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_d,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
      if ($reg->{IEO} =~ m/e/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input logic                        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }    
      if ($reg->{IEO} =~ m/i/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
    } # end of foreach ...
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //outputs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    foreach my $reg (@{$reg_list}){
      if ($reg->{IEO} =~ m/o/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    // outputs for register '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output logic['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]       '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_q,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                           ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }                   
    } # end of foreach ...
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Generic inputs ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input logic			       Clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input logic                        Reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // floping cfg inputs to produce delayed signals:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]       cfgIn_addr_del;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]        cfgIn_data_del;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_op_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]         cfgIn_op_del;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $flop_inst = generate('flop','cfgIn_floper', 
                                   'Width' => $cfg_addr_width+$cfg_bus_width+$cfg_op_width,
                                   'Type' => 'RFlop',
                                   'Default' => 0);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $flop_inst->instantiate; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' (.Clk(Clk), .Reset(Reset), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '			      .din({cfgIn.addr, cfgIn.data, cfgIn.op}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '			      .dout({cfgIn_addr_del, cfgIn_data_del, cfgIn_op_del}));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // internal wiring signals';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_regs-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]             onehot_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic                               addr_in_range;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_req_addr_bits-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]    cfgIn_addr_del_int; // internal (shorter) address signal';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_regs-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]             regs_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]        regs_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_regs-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]        regs_q['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_regs-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // make sure that the input address is in range';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign addr_in_range = (('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $base_addr_hex; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' == cfgIn_addr_del['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $base_addr_range; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']) &&';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                     (cfgIn_addr_del['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $usable_addr_range; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] < '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_req_addr_bits+1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_regs; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '))? 1\'b1: 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Pick the right bits of the address signal (if out of range default to zero)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign cfgIn_addr_del_int['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_req_addr_bits-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] = (addr_in_range)? cfgIn_addr_del['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $usable_addr_range; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']: '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $num_req_addr_bits; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // For config writes, there can be at most onehot enable signal';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   always_comb begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      onehot_en = 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      onehot_en[cfgIn_addr_del_int] = (cfgIn_op_del == '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $wrop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') && (addr_in_range == 1\'b1);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign the config output ports';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign cfgOut.data = (addr_in_range != 1\'b1) ? cfgIn_data_del : // if not in range, pass the signal to the next guy';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                  (cfgIn_op_del == '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $rdop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') ? regs_q[cfgIn_addr_del_int] : // if in range and this is a readop... read';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                  cfgIn_data_del;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign cfgOut.addr = cfgIn_addr_del;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign cfgOut.op = (addr_in_range != 1\'b1) ? cfgIn_op_del : // if not in range pass the signal to next guy';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                  (cfgIn_op_del != '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $nop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ') ? '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $bypassop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':      // if in range (and not a nop) mark as done (bypass)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $nop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';                              // else, it\'s just a nop.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Instantiate all the registers:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // ==============================';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    $cnt = 0;
    foreach my $reg (@{$reg_list}){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // register #'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' --- name:'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ', type:'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{IEO}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ', Width:'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      my %params = ();
      $params{'Type'} = 'REFlop'; # default flop type
      $params{'Width'} = $reg->{Width}; 
      $params{'Default'} = $reg->{Default} if exists $reg->{Default}; 
      $flop_inst = generate('flop',$reg->{Name}."_reg", %params);
   
      ## Pick the right enable signal based on parameters
      if ($reg->{IEO} =~ m/e/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // flop on input_en or on cfg writes';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_en | onehot_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }elsif ($reg->{IEO} =~ m/i/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // flop input with no qualifier';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = 1\'b1; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }else{
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // flop input only on cfg writes';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = onehot_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
   
      ## Pick the right data input based on parameters
      if ($reg->{IEO} !~ m/i/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // input only from cfg bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] = cfgIn_data_del['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }else{
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // give priority to cfg bus writes, otherwise input from module input';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] = (onehot_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '])?cfgIn_data_del['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '                                                                  '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
   
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $flop_inst->instantiate; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.Clk(Clk), .Reset(Reset), .en(regs_en['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .din(regs_d['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]), .dout(regs_q['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      if ($reg->{IEO} =~ m/o/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign value to the relevant output';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '_q['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] = regs_q['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
      if ($cfg_bus_width > $reg->{Width}){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // pad the config bus with zeros';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign regs_q['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cnt; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $reg->{Width}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '] = \'0; ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      $cnt++;
   } # end of foreach ...
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule: '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/reg_file.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
