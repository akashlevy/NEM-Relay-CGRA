package jtag;
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
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/jtag.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/jtag.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/jtag.svp"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '/* *****************************************************************************';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * File: template.vp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Author: Ofer Shacham';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Description:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * This module is the top of the actual design.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * REQUIRED GENESIS PARAMETERS:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ----------------------------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * * IO_LIST -  List of main design IOs. For each IO you must specify:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * name';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * width';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * direction - allowed directions are \'in\'/\'out\'';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * bsr - put IO on boundary scan? (yes/no)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * pad - pad type (analog or anl/digital or dig)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *   * orientation - Orientation of the IO pad. allowed values are {left, right, ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *		     top, bottom}';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * SYSCLK_CFG_BUS_WIDTH (48) -  Bus width for system clocked configuration entities';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * SYSCLK_CFG_ADDR_WIDTH (18) - Address width for system clocked configuration entities';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * TESTCLK_CFG_BUS_WIDTH (32) - Bus width for test clocked configuration entities';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * TESTCLK_CFG_ADDR_WIDTH (12) - Address width for test clocked configuration entities';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Inputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * -------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Main design inputs, plus  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * inputs that regard the boundary scan and pads control';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Outputs:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * --------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Main design outputs, plus ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * outputs that regard the boundary scan and pads control';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Change bar:';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * -----------';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Date          Author   Description';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * Mar 28, 2010  shacham  init version  --  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * May 18, 2010  shacham  Added orientation feild to IO parameter list';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * May 24, 2010  shacham  Pulled config bus parameters to top level';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *			  Added cfg_ifc as the proper way to implement config';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *			  bus uniformity amongst modules.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *			  Made declaration of IO params into a force_param to';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' *			  make it immutable';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' * ****************************************************************************/';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// ACTUAL GENESIS2 PARAMETERIZATIONS';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 # Now, let's decide upon the parameters of the configuration bus:
 my $sc_cfg_bus_width =  $self->define_param(SYSCLK_CFG_BUS_WIDTH => 32);
 my $sc_cfg_addr_width =  $self->define_param(SYSCLK_CFG_ADDR_WIDTH => 32);
 my $sc_cfg_op_width = $self->define_param(SYSCLK_CFG_OPCODE_WIDTH => 5);
 my $IDCODE = $self->define_param(IDCODE => 1);
 my $io_list = $self->force_param(IO_LIST => 
		[	
			{name => 'trst_n',	width => 1,  direction => 'in',  bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'tck',		width => 1,  direction => 'in',  bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'tms',		width => 1,  direction => 'in',  bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'tdi',		width => 1,  direction => 'in',  bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'tdo',		width => 1,  direction => 'out', bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'config_data_from_gc',	width => $sc_cfg_bus_width,  direction => 'in', bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'config_data_to_gc',	width => $sc_cfg_bus_width,  direction => 'out', bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'config_addr_to_gc',	width => $sc_cfg_addr_width,  direction => 'out', bsr => 'no',  pad => 'digital', orientation => 'right'},
			{name => 'config_op_to_gc', width => $sc_cfg_op_width, direction => 'out', bsr => 'no', pad => 'digital', orientation => 'right'}
		]);
 my $num_ios = scalar(@{$io_list});

# Verify correctness of IO parameters:
 my $cnt = 0;
 foreach my $io (@{$io_list}){
   $self->error("IO $cnt is missing it's name!") 
	unless defined $io->{name};
   $self->error("IO $io->{name} (IO\# $cnt) is missing its width!") 
	unless defined $io->{width};
   $self->error("IO $io->{name} (IO\# $cnt) has an illegal width -->$io->{width}<--!") 
	if ($io->{width} < 1);
   $self->error("IO $io->{name} (IO\# $cnt) is missing its direction!") 
	unless defined $io->{direction};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid direction -->$io->{direction}<--! ".
		   "(allowed values: in/out)") 
	unless ($io->{direction} =~ m/^(in|out)$/i);
   $self->error("IO $io->{name} (IO\# $cnt) does not specify whether it's on the boundary scan!") 
	unless defined $io->{bsr};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid bsr flag -->$io->{bsr}<--! ".
		   "(allowed values: yes/no)") 
	unless ($io->{bsr} =~ m/^(yes|no)$/i);
   $self->error("IO $io->{name} (IO\# $cnt) does not specify pad type (analog/digital)!") 
	unless defined $io->{pad};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid pad flag -->$io->{pad}<--! ".
		   "(allowed values: analog/digital)") 
	unless ($io->{pad} =~ m/^(anl|analog|dig)/i);
   $self->error("IO $io->{name} (IO\# $cnt) does not specify pad orientation (left, right, top, bottom)!") 
	unless defined $io->{orientation};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid pad orientation -->$io->{orientation}<--!".
		   "(allowed values: left, right, top, bottom)") 
	unless ($io->{orientation} =~ m/^(left|right|top|bottom)$/i);
   $cnt++;
 } # end of "foreach my $io..."


 # First we create an interface for this chip
 my $ifc = $self->unique_inst('template_ifc', 'ifc', IO_LIST => $io_list);

 # this would enable others to use this interface
 $self->define_param('IFC' => $ifc);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //  Config interfaces for system and test clock domainds';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
  my $sc_jtag2gc_ifc = $self->unique_inst('cfg_ifc', 'sc_jtag2gc_ifc',
 					      DataWidth => $sc_cfg_bus_width, 
 					      AddrWidth => $sc_cfg_addr_width,
 					      OpcodeWidth => $sc_cfg_op_width);
  my $sc_gc2jtag_ifc = $self->clone_inst($sc_jtag2gc_ifc, 'sc_gc2jtag_ifc');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $self->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // main IOs';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.des ifc,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [31:0] ifc_config_addr_to_gc,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [31:0] ifc_config_data_to_gc,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input [31:0] ifc_config_data_from_gc,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output [4:0]  ifc_config_op_to_gc,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 ifc_trst_n,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 ifc_tck,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 ifc_tms,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 ifc_tdi,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 ifc_tdo,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input 	 sys_clk_activated, //Is global controller on sys clk yet?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //Signals for boundary scan register';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_tdi,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_sample,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_intest,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_extest,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_update_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_capture_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_shift_dr,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   output 	 bsr_tdo';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Connect Forward the reset and clock inputs to the global controller';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '();';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [31:0] sc_jtag2gc_ifc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [31:0] sc_jtag2gc_ifc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [4:0] sc_jtag2gc_ifc_op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [31:0] sc_gc2jtag_ifc_data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [31:0] sc_gc2jtag_ifc_addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   wire [4:0] sc_gc2jtag_ifc_op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//The opcode is the upper 3 address bits to the gc';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign ifc_config_addr_to_gc = sc_jtag2gc_ifc_addr; //'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.addr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign ifc_config_data_to_gc = sc_jtag2gc_ifc_data; //'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.data;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign ifc_config_op_to_gc = sc_jtag2gc_ifc_op; //'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.op;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//   assign '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_gc2jtag_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.data = ifc.config_data_from_gc;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign sc_gc2jtag_ifc_data = ifc_config_data_from_gc;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign sc_gc2jtag_ifc_addr = 0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   assign sc_gc2jtag_ifc_op = 3;//Set to Bypass so that input data_rd reg is always enabled. Is this ok?';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
   
   
   
    # Create the JTAG to reg-files controller object
    my $cfg_dbg = $self->unique_inst('cfg_and_dbg', 'cfg_and_dbg',
   					SC_CFG_BUS => 'yes', 
   					TC_CFG_BUS => 'no', SC_CFG_IFC_REF => $sc_jtag2gc_ifc,
   					SC_CFG_OPCODES => {nop => 0, write => 1, read => 2, bypass => 3,                                                 
                                                    wr_A050 => 4, wr_to_TST => 5, rd_TST => 6,
    						       global_reset => 7, write_stall => 8,read_stall => 9, 
       					       adv_clk => 10, read_clk_domain => 11, switch_clk => 12,
   						       wr_rd_delay_reg => 13, rd_rd_delay_reg => 14, wr_delay_sel_reg => 15,
   						       rd_delay_sel_reg => 16} 
   					);
   
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   //These signals aren\'t used. Only included to avoid warnings.			';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   logic tdo_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // Instantiate the JTAG to reg-files controller';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_dbg->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $cfg_dbg->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // JTAG signals';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tms(ifc_tms),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tck(ifc_tck),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .trst_n(ifc_trst_n),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdi(ifc_tdi),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdo(ifc_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .tdo_en(tdo_en), ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // Boundary Scan Signals (not used in this design. Only connected to supress warnings)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_tdi(bsr_tdi),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_sample(bsr_sample),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_intest(bsr_intest),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_extest(bsr_extest),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_update_en(bsr_update_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_capture_en(bsr_capture_en),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_shift_dr(bsr_shift_dr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .bsr_tdo(bsr_tdo),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      // signals to the System-clocked global controller';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      //.sc_cfgReq('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_jtag2gc_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgOut),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgReq_addr(sc_jtag2gc_ifc_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgReq_data(sc_jtag2gc_ifc_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgReq_op(sc_jtag2gc_ifc_op),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//      .sc_cfgRep('; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $sc_gc2jtag_ifc->get_instance_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '.cfgIn),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgRep_addr(sc_gc2jtag_ifc_addr),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgRep_data(sc_gc2jtag_ifc_data),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sc_cfgRep_op(sc_gc2jtag_ifc_op),      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Reset(reset), //ifc.Reset),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .Clk(clk), //ifc.Clk),';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      .sys_clk_activated(sys_clk_activated)';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule // '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $self->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/jtag.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
