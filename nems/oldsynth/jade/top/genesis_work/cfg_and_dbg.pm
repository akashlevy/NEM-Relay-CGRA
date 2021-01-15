package cfg_and_dbg;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/cfg_and_dbg.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/cfg_and_dbg.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/cfg_and_dbg.svp"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/* *****************************************************************************';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * File: cfg_and_dbg.vp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Author: Ofer Shacham';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Description:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * This module is used as the top of the JTAG accessed logic. It contains the ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * tap as well as controllers for the boundary scan register and optionally';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * controllers for a reg-file chain which can be either on system clock or/and ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * on JTAG clock.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * The cfg and dbg module assumes that upon reads, the user knows that he/she';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * needs to wait for the data to arrive from the reg-file array, and would';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * add delay cycles as needed between loading the instruction and address to ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * reading the data. ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * REQUIRED GENESIS PARAMETERS:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ----------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * For the sys-clock domain ports';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * SC_CFG_IFC_REF - An instance of the cfg_ifc (used as reference)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * SC_CFG_BUS - on/off or yes/no switch for the system clock domain config bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * SC_CFG_OPCODES - Interpretation of the opcode. Must contain the following feilds:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * nop - value of cfg2rf_op for a no-op (default is 0)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * read - value of cfg2rf_op for a read operation (default is 1)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * write - value of cfg2rf_op for a write operation (default is 2)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * bypass - value of cfg2rf_op for bypassing the control signals (default is 3)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * For the tck domain ports';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * TC_CFG_IFC_REF - An instance of the cfg_ifc (used as reference)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * TC_CFG_BUS - on/off or yes/no switch for the jtag tck domain config bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * TC_CFG_OPCODES - Interpretation of the opcode. Must contain the following feilds:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * nop - value of cfg2rf_op for a no-op (default is 0)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * read - value of cfg2rf_op for a read operation (default is 1)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * write - value of cfg2rf_op for a write operation (default is 2)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *    * bypass - value of cfg2rf_op for bypassing the control signals (default is 3)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Inputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * -------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Outputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * --------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Change bar:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * -----------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Date          Author   Description';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Mar 28, 2010  shacham  init version  --  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * May 24, 2010  shacham  Replaced config bus signals and parameters with an ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *			  interface. ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Apr 18, 2012  shacham  clean up of names and genesis syntactic sugar';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * May 20, 2014  jingpu   fixed legacy verilog syntax and fix idcode';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ****************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// ACTUAL GENESIS2 PARAMETERIZATIONS';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # System clock config parameterization
 my $sc_cfg_bus = parameter(name=>'SC_CFG_BUS', val => 'off');
 my $sc_cfg_ifc_ref = $self->define_param(SC_CFG_IFC_REF => '');
 my $sc_cfg_ops = $self->define_param('SC_CFG_OPCODES' => {nop=>0, read=>1, write=>2, bypass=>3});
 my ($sc_cfg_req_ifc, $sc_cfg_rep_ifc, $sc_cfg_bus_width, $sc_cfg_addr_width, $sc_cfg_op_width);
 my ($sc_nop, $sc_rdop, $sc_wrop, $sc_bypassop);
 if ($sc_cfg_bus =~ /^(yes|on)$/i){
   $self->error("Missing reference system clock interface parameter: SC_CFG_IFC_REF") if ($sc_cfg_ifc_ref eq '');
   $sc_cfg_req_ifc = $self->clone_inst($sc_cfg_ifc_ref, 'sc_cfgReq');
   $sc_cfg_rep_ifc = $self->clone_inst($sc_cfg_ifc_ref, 'sc_cfgRep');
   $sc_cfg_bus_width = $sc_cfg_req_ifc->get_param('DataWidth');
   $sc_cfg_addr_width = $sc_cfg_req_ifc->get_param('AddrWidth');
   $sc_cfg_op_width = $sc_cfg_req_ifc->get_param('OpcodeWidth');

   # Verify correctness of opcode parameters:
   $self->error("Illegal value for parameter SC_CFG_BUS -->$sc_cfg_bus<--. (Allowed values are on/off)")
  	unless $sc_cfg_bus =~ m/^(on|yes|off|no)$/i;
   $self->error("SC_CFG_OPCODES must define values for all of {nop, read, write, bypass} opcodes")
  	if (!defined $sc_cfg_ops->{nop} || !defined $sc_cfg_ops->{read} || 
  	    !defined $sc_cfg_ops->{write} || !defined $sc_cfg_ops->{bypass});
   $sc_nop = $sc_cfg_ops->{nop};
   $sc_rdop = $sc_cfg_ops->{read};
   $sc_wrop = $sc_cfg_ops->{write};
   $sc_bypassop = $sc_cfg_ops->{bypass};
   $self->error("SC_CFG_OPCODES values don't fit within SC_CFG_IFC_REF.CFG_OPCODE_WIDTH bits")
  	if (($sc_nop > 2**$sc_cfg_op_width-1) || ($sc_rdop > 2**$sc_cfg_op_width-1) || 
  	    ($sc_wrop > 2**$sc_cfg_op_width-1) || ($sc_bypassop > 2**$sc_cfg_op_width-1));
 }

 

 # Test clock config parameterization
 my $tc_cfg_bus = $self->define_param(TC_CFG_BUS => 'off');
 my $tc_cfg_ifc_ref = $self->define_param(TC_CFG_IFC_REF => '');
 my $tc_cfg_ops = $self->define_param('TC_CFG_OPCODES' => {nop=>0, read=>1, write=>2, bypass=>3});
 my ($tc_cfg_req_ifc, $tc_cfg_rep_ifc, $tc_cfg_bus_width, $tc_cfg_addr_width, $tc_cfg_op_width);
 my ($tc_nop, $tc_rdop, $tc_wrop, $tc_bypassop);
 if ($tc_cfg_bus =~ /^(yes|on)$/i){
   $self->error("Missing reference test clock interface parameter: TC_CFG_IFC_REF") if ($tc_cfg_ifc_ref eq '');
   $tc_cfg_req_ifc = $self->clone_inst($tc_cfg_ifc_ref, 'tc_cfgReq');
   $tc_cfg_rep_ifc = $self->clone_inst($tc_cfg_ifc_ref, 'tc_cfgRep');
   $tc_cfg_bus_width = $tc_cfg_req_ifc->get_param('DataWidth');
   $tc_cfg_addr_width = $tc_cfg_req_ifc->get_param('AddrWidth');
   $tc_cfg_op_width = $tc_cfg_req_ifc->get_param('OpcodeWidth');

   # Verify correctness of opcode parameters:
   $self->error("Illegal value for parameter TC_CFG_BUS -->$tc_cfg_bus<--. (Allowed values are on/off)")
  	unless $tc_cfg_bus =~ m/^(on|yes|off|no)$/i;
   $self->error("TC_CFG_OPCODES must define values for all of {nop, read, write, bypass} opcodes")
  	if (!defined $tc_cfg_ops->{nop} || !defined $tc_cfg_ops->{read} || 
  	    !defined $tc_cfg_ops->{write} || !defined $tc_cfg_ops->{bypass});
   $tc_nop = $tc_cfg_ops->{nop};
   $tc_rdop = $tc_cfg_ops->{read};
   $tc_wrop = $tc_cfg_ops->{write};
   $tc_bypassop = $tc_cfg_ops->{bypass};
   $self->error("TC_CFG_OPCODES values don't fit within TC_CFG_IFC_REF.CFG_OPCODE_WIDTH bits")
  	if (($tc_nop > 2**$tc_cfg_op_width-1) || ($tc_rdop > 2**$tc_cfg_op_width-1) || 
  	    ($tc_wrop > 2**$tc_cfg_op_width-1) || ($tc_bypassop > 2**$tc_cfg_op_width-1));
 }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Signals for a system clked configuration bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($sc_cfg_bus =~ m/^(on|yes)$/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_req_ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgOut sc_cfgReq,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [31:0] sc_cfgReq_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [31:0] sc_cfgReq_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [4:0] sc_cfgReq_op,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_rep_ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgIn sc_cfgRep,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input [31:0] sc_cfgRep_addr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input [31:0] sc_cfgRep_data,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input [4:0] sc_cfgRep_op,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // system clock and reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input                                Clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input             	                Reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Signals for a jtag clked configuration bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($tc_cfg_bus =~ m/^(on|yes)$/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_req_ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgOut tc_cfgReq,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_rep_ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgIn tc_cfgRep,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '					   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic test_logic_reset,	// tap fsm in test_logic_reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Signals for the Boundary Scan Register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_tdi,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_sample,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_intest,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_extest,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_update_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_capture_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output 				logic bsr_shift_dr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input 				bsr_tdo,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    //Is global controller running on sys clk? or still on test clk?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input	 sys_clk_activated,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input        tms,          	// JTAG Test Mode Select';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input        tck,          	// JTAG Test Clock';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input        trst_n,         // JTAG Test Reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input        tdi,          	// JTAG Test Data Input';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output       logic  tdo,	      	// JTAG Test Data Output';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    output       logic  tdo_en	        // JTAG Test Data Output';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    # if there is no output test_logic_reset, we at least need an internal signal
    if ($tc_cfg_bus !~ m/^(on|yes)$/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // reset signal for jtag domain registers';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  test_logic_reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    # Make list of needed instructions from the tap:
    my $special_insts = [];
   
    # for the sys-clock config bus
    if ($sc_cfg_bus =~ m/on|yes/i){
   	push(@{$special_insts}, {name => 'sc_cfg_data', code => 0x8});
    	push(@{$special_insts}, {name => 'sc_cfg_inst', code => 0x9});
    	push(@{$special_insts}, {name => 'sc_cfg_addr', code => 0xa});
    }
   
    # for the jtag-clock config bus
    if ($tc_cfg_bus =~ m/on|yes/i){
    	push(@{$special_insts}, {name => 'tc_cfg_data', code => 0xc});
    	push(@{$special_insts}, {name => 'tc_cfg_inst', code => 0xd});
    	push(@{$special_insts}, {name => 'tc_cfg_addr', code => 0xe});
    }
   
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Signals comming from the tap for the special instructions';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // for the sys-clock config bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($sc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // sc_cfg_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_data_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_data_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_data_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_data_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // sc_cfg_inst				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_inst_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_inst_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_inst_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_inst_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // sc_cfg_addr				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_addr_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_addr_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_addr_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  sc_cfg_addr_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // for the jtag-clock config bus';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($tc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // tc_cfg_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_data_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_data_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_data_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_data_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // tc_cfg_inst				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_inst_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_inst_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_inst_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_inst_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // tc_cfg_addr				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_addr_capture_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_addr_shift_dr;			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_addr_update_dr;		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 	  tc_cfg_addr_tdo;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Instantiate the Test Access Port (TAP)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $tap = $self->unique_inst('tap', 'tap', SPECIAL_INSTRUCTIONS => $special_insts);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tap->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tap->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // JTAG signals';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tms(tms),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tck(tck),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .trst_n(trst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdi(tdi),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdo(tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdo_en(tdo_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       if ($sc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // sc_cfg_data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_data_capture_dr(sc_cfg_data_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_data_shift_dr(sc_cfg_data_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_data_update_dr(sc_cfg_data_update_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_data_tdo(sc_cfg_data_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // sc_cfg_inst				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_inst_capture_dr(sc_cfg_inst_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_inst_shift_dr(sc_cfg_inst_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_inst_update_dr(sc_cfg_inst_update_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_inst_tdo(sc_cfg_inst_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      						';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // sc_cfg_addr				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_addr_capture_dr(sc_cfg_addr_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_addr_shift_dr(sc_cfg_addr_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_addr_update_dr(sc_cfg_addr_update_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfg_addr_tdo(sc_cfg_addr_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      						';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       if ($tc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // tc_cfg_data				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_data_capture_dr(tc_cfg_data_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_data_shift_dr(tc_cfg_data_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_data_update_dr(tc_cfg_data_update_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_data_tdo(tc_cfg_data_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      						';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // tc_cfg_inst				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_inst_capture_dr(tc_cfg_inst_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_inst_shift_dr(tc_cfg_inst_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_inst_update_dr(tc_cfg_inst_update_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_inst_tdo(tc_cfg_inst_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      						';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // tc_cfg_addr				';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_addr_capture_dr(tc_cfg_addr_capture_dr),		';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_addr_shift_dr(tc_cfg_addr_shift_dr),			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_addr_update_dr(tc_cfg_addr_update_dr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tc_cfg_addr_tdo(tc_cfg_addr_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .test_logic_reset(test_logic_reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // BSR interface';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_extest(bsr_extest),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_intest(bsr_intest),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_sample(bsr_sample),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_capture_en(bsr_capture_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_shift_dr(bsr_shift_dr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_update_en(bsr_update_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_tdo(bsr_tdo)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($sc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   /************ Logic for controlling the system-clock config bus ************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Since this cfg interface is all on the system clock, life is more';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // interesting. We need to cross domains by qualifying the output signals.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // * Since outputs are only considered when the instruction is meanningful--';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //   we\'ll qualify the sc_cfgReq.op by creating a qualified update signal.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // * JTAG only samples the input after the read completed. We already';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assumed (see header) that the frequency of jtag ops is lower then it takes';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // to go through the chain of reg-files.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   /***************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the instuction';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $sc_inst_reg = $self->unique_inst('flop', 'sc_inst_reg', 
   					     Type => 'REFlop',
   					     Default => $sc_nop,
   					     Width => $sc_cfg_op_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_op_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sc_inst;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_inst_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_inst_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(sc_inst),	.din({tdi, sc_inst['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_op_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(sc_cfg_inst_shift_dr),      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Qualify the instruction';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic [3:0] inst_update_qual;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic       inst_update_qualified;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign inst_update_qualified = ((sys_clk_activated & inst_update_qual==4\'b1110) | (!sys_clk_activated & inst_update_qual[3]==1)) ? 1\'b1:1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $inst_update_reg = generate('flop', 'inst_update_reg', 
   					     Type => 'RFlop',
   					     Default => 0,
   					     Width => 4);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $inst_update_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $inst_update_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(inst_update_qual),	.din({sc_cfg_inst_update_dr, inst_update_qual[3:1]}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(Clk),	.Reset(Reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign transaction to the bus on update (pulse)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   sc_cfgReq_op = (inst_update_qualified) ? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						   sc_inst : '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_nop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign tdo with instruction always';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   sc_cfg_inst_tdo = sc_inst[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the address';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $sc_addr_reg = generate('flop', 'sc_addr_reg', 
   				  Type => 'REFlop',
   				  Default => 0,
   				  Width => $sc_cfg_addr_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_addr_reg->instantiate; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(sc_addr),	.din({tdi, sc_addr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(sc_cfg_addr_shift_dr),      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign bus / tdo with address (always)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     sc_cfgReq_addr = sc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     sc_cfg_addr_tdo = sc_addr[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // register for the received data until the jtag interface asks for it';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $sc_data_rd_reg = $self->unique_inst('flop', 'sc_data_rd_reg', 
   					     Type => 'REFlop',
   					     Default => 0,
   					     Width => $sc_cfg_bus_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sc_data_rd;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 			   sc_data_rd_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   sc_data_rd_en = (sc_cfgRep_op == '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_bypassop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						   1\'b1: 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_data_rd_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_data_rd_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(sc_data_rd),	.din(sc_cfgRep_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(Clk),	.en(sc_data_rd_en),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Reset(Reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $sc_data_reg = $self->unique_inst('flop', 'sc_data_reg', 
   					     Type => 'REFlop',
   					     Default => 0,
   					     Width => $sc_cfg_bus_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] sc_data_nxt;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     sc_data_nxt = (sc_cfg_data_capture_dr) ? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						    sc_data_rd : {tdi, sc_data['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_data_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_data_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(sc_data),	.din(sc_data_nxt),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(sc_cfg_data_shift_dr | sc_cfg_data_capture_dr),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign bus / tdo with data (always)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     sc_cfgReq_data = sc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign sc_cfg_data_tdo = sc_data[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    } # end of "if ($sc_cfg_bus =~ m/on|yes/i)..."
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   /***************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    if ($tc_cfg_bus =~ m/on|yes/i){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   /************ Logic for controlling the jtag-clock config bus **************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Since this cfg interface is all on the jtag clock, life is simple, and we ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // don\'t need to cross clock domains. Just need to tell the jtag register ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // what and when to sample.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   /***************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the instuction';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $tc_inst_reg = $self->unique_inst('flop', 'tc_inst_reg', 
   					     Type => 'REFlop',
   					     Default => $tc_nop,
   					     Width => $tc_cfg_op_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_op_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] tc_inst;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_inst_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_inst_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(tc_inst),	.din({tdi, tc_inst['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_op_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(tc_cfg_inst_shift_dr),      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign transaction to the bus on update (pulse)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   tc_cfgReq.op = (tc_cfg_inst_update_dr) ? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						   tc_inst : '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_nop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign tdo with instruction always';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   tc_cfg_inst_tdo = tc_inst[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the address';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $tc_addr_reg = $self->unique_inst('flop', 'tc_addr_reg', 
   					     Type => 'REFlop',
   					     Default => 0,
   					     Width => $tc_cfg_addr_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] tc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_addr_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_addr_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(tc_addr),	.din({tdi, tc_addr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_addr_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]}),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(tc_cfg_addr_shift_dr),      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign bus / tdo with address (always)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     tc_cfgReq.addr = tc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     tc_cfg_addr_tdo = tc_addr[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // register for the received data until the jtag interface asks for it';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $tc_data_rd_reg = $self->unique_inst('flop', 'tc_data_rd_reg', 
   					     Type => 'REFlop',
   					     Default => 0,
   					     Width => $tc_cfg_bus_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] tc_data_rd;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic 			   tc_data_rd_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			   tc_data_rd_en = (tc_cfgRep.op == '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_op_width; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_bypassop; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ')? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						   1\'b1: 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_data_rd_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_data_rd_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(tc_data_rd),	.din(tc_cfgRep.data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(tc_data_rd_en),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // shift in/out the data';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    my $tc_data_reg = $self->unique_inst('flop', 'tc_data_reg', 
   					     Type => 'REFlop',
   					     Default => 0,
   					     Width => $tc_cfg_bus_width);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] tc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] tc_data_nxt;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     tc_data_nxt = (tc_cfg_data_capture_dr) ? ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '						    tc_data_rd : {tdi, tc_data['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_cfg_bus_width-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':1]};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_data_reg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $tc_data_reg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (.dout(tc_data),	.din(tc_data_nxt),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(tck),	.en(tc_cfg_data_shift_dr | tc_cfg_data_capture_dr),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Reset(test_logic_reset));';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assign bus / tdo with data (always)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     tc_cfgReq.data = tc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign 			     tc_cfg_data_tdo = tc_data[0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //*******';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    } # end of "if ($tc_cfg_bus =~ m/on|yes/i)..."
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule // '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/cfg_and_dbg.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
