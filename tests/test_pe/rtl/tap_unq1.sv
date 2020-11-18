//
//--------------------------------------------------------------------------------
//          THIS FILE WAS AUTOMATICALLY GENERATED BY THE GENESIS2 ENGINE        
//  FOR MORE INFORMATION: OFER SHACHAM (CHIP GENESIS INC / STANFORD VLSI GROUP)
//    !! THIS VERSION OF GENESIS2 IS NOT FOR ANY COMMERCIAL USE !!
//     FOR COMMERCIAL LICENSE CONTACT SHACHAM@ALUMNI.STANFORD.EDU
//--------------------------------------------------------------------------------
//
//  
//	-----------------------------------------------
//	|            Genesis Release Info             |
//	|  $Change: 11879 $ --- $Date: 2013/06/11 $   |
//	-----------------------------------------------
//	
//
//  Source file: /Users/akashlevy/OneDrive - Levylab/Documents/Research/CGRAGenerator/hardware/generator_z/jtag/Template/src/digital/tap.svp
//  Source template: tap
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter SPECIAL_INSTRUCTIONS 	= Data structure of type ARRAY
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Command Line input (priority=4):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From XML input (priority=3):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Config File input (priority=2):
//
// ---------------- End Pre-Generation Pramameters Status Report ----------------

/* *****************************************************************************
 * File: template.vp
 * Author: Ofer Shacham
 * 
 * Description:
 * This module is a wrapper for the Synopsys Design-Ware tap. It implements
 * the IEEE Standard 1149.1
 * See DW here: $SYNOPSYS/dw/sim_ver/DW_tap.v
 * 
 * 
 * REQUIRED GENESIS PARAMETERS:
 * ----------------------------
 * 
 * 
 * Inputs:
 * -------
 * 
 * Outputs:
 * -------- 
 * 
 * Change bar:
 * -----------
 * Date          Author   Description
 * Mar 30, 2010  shacham  init version  --  
 * May 20, 2014  jingpu   cumulative fixes, compatible with async active low reset flops
 * Feb 20, 2014, ajcars   change back to async active high reset flops 
 * ****************************************************************************/

// ACTUAL GENESIS2 PARAMETERIZATIONS
// Width (_GENESIS2_DECLARATION_PRIORITY_) = 5
//
// SPECIAL_INSTRUCTIONS (_GENESIS2_INHERITANCE_PRIORITY_) = 
//	[ { code=>8, name=>sc_cfg_data },
//	  { code=>9, name=>sc_cfg_inst },
//	  { code=>10, name=>sc_cfg_addr }
//	]
//
// IDCODE (_GENESIS2_DECLARATION_PRIORITY_) = 1
//

// This module implements the following JTAG commands (a '+' marks a user defiend instruction):
// IDCODE 5'd1
// BYPASS 5'd31 (all ones)
// EXTEST 5'd0
// SAMPLE 5'd2
// + sc_cfg_data 5'd8
// + sc_cfg_inst 5'd9
// + sc_cfg_addr 5'd10

module tap_unq1
  (
   // Specific usefule states
   output logic test_logic_reset, // TAP FSM in Test Logic Reset (time to reset data register)

   // Required commands by the IEEE Standard 1149.1 for a synchronous boundary scan register
   // Note to all: INTEST is optional part of the standard but we'll put it in anyway.
   // Note to me: In bsr cells, connect both update clk and capture clk to tck.
   output logic bsr_extest, // Test Sellect Data Reg: EXTEST
   output logic bsr_intest, // Test Sellect Data Reg: INTEST
   output logic bsr_sample, // Test Sellect Data Reg: SAMPLE
   output logic bsr_capture_en, // required by bsr cells
   output logic bsr_shift_dr, // required by bsr cells	  
   output logic bsr_update_en, // required by bsr cells
   input 	bsr_tdo, // data from the boundary scan register
  
   // Special registers
   output logic sc_cfg_data_capture_dr, // Test Sellect Data Reg: sc_cfg_data
   output logic sc_cfg_data_shift_dr, // Test Sellect Data Reg: sc_cfg_data
   output logic sc_cfg_data_update_dr, // Test Sellect Data Reg: sc_cfg_data
   output logic sc_cfg_inst_capture_dr, // Test Sellect Data Reg: sc_cfg_inst
   output logic sc_cfg_inst_shift_dr, // Test Sellect Data Reg: sc_cfg_inst
   output logic sc_cfg_inst_update_dr, // Test Sellect Data Reg: sc_cfg_inst
   output logic sc_cfg_addr_capture_dr, // Test Sellect Data Reg: sc_cfg_addr
   output logic sc_cfg_addr_shift_dr, // Test Sellect Data Reg: sc_cfg_addr
   output logic sc_cfg_addr_update_dr, // Test Sellect Data Reg: sc_cfg_addr

   // Special TDOs
   input 	sc_cfg_data_tdo, // serial data out from DATA register sc_cfg_data
   input 	sc_cfg_inst_tdo, // serial data out from DATA register sc_cfg_inst
   input 	sc_cfg_addr_tdo, // serial data out from DATA register sc_cfg_addr

   // the standard JTAG IOs
   input 	tms, // JTAG Test Mode Select
   input 	tck, // JTAG Test Clock
   input 	trst_n, // JTAG Test Reset
   input 	tdi, // JTAG Test Data Input
   output logic tdo, // JTAG Test Data Output
   output logic tdo_en	        // JTAG Test Data Output
   );

   

   logic 	muxed_tdo;
   logic [4:0] instruction;
   logic [15:0] 	tap_state;

   logic 		shift_dr; 
   logic 		sync_capture_en; // active low
   logic 		sync_update_dr;
   

   
   // First, let's instantiate a design-ware module for the tap
   // (From $SYNOPSYS/dw/sim_ver/DW_tap.v)
   // ==========================================================================
   //    Parameters:       Valid Values
   //    ==========        ============
   //    width             [2 to 32]
   //    id                [0 = not present, 1 = present]
   //    version           [0 to 15]
   //    part              [0 to 65535]
   //    man_num           [0 to 2047] ( not equal to 127 )
   //    sync_mode         Determines whether the bypass, device identification, and
   //			   instruction registers are synchronous with respect to tck
   //			   0 = asynchronous, 1 = synchronous
   //
   //
   //  Input Ports:    Size        Description
   //  ===========     ====        ===========
   //  tck              1 bit      Test clock
   //  trst_n           1 bit      Test reset, active low
   //  tms              1 bit      Test mode select
   //  tdi              1 bit      Test data in
   //  so               1 bit      Serial data from boundary scan
   //                                register and data registers
   //  bypass_sel       1 bit      Selects the bypass register
   //
   //  sentinel_val    width - 1   User-defined status bits
   //
   //  Output Ports    Size        Description
   //  ============    ====        ===========
   //  clock_dr         1 bit      Controls the boundary scan register
   //  shift_dr         1 bit      Controls the boundary scan register
   //  update_dr        1 bit      Controls the boundary scan register
   //  tdo              1 bit      Test data out
   //  tdo_en           1 bit      Enable for tdo output buffer
   //  tap_state       16 bit      Current state of the TAP
   //                              finite state machine
   //  extest           1 bit      EXTEST decoded instruction
   //  samp_load        1 bit      SAMPLE/PRELOAD decoded instruction
   //  instructions     width      Instruction register output
   //  sync_capture_en  1 bit	   Output Enable for synchronous capture, active low
   //  sync_update_dr   1 bit	   Output Enables updating new data in synchronous_mode,
   //				     active high

   //Signals not used in sync mode. Only included to supress warnings
   logic clock_dr, update_dr;

   DW_tap #(
	    // system verilog parameterization:
	    .width(5),
	    .id(1), // ID is not part of the standard, but really useful to make sure something is alive in the jtag domain.
	    .version(0),
	    .part(0),
	    .man_num(0),
	    .sync_mode(1) // we are always sync with respect to TCK (i.e., we rather use TCK than clock_dr)
	    ) tap (
		   // inputs
		   .tck(tck),
		   .trst_n(trst_n),
		   .tms(tms),
		   .tdi(tdi),
		   .so(muxed_tdo),
		   .bypass_sel(1'b0),
		   .sentinel_val(4'b0),
		   .test(1'b0),
		   
		   //outputs
		   .clock_dr(clock_dr/*not used in sync mode*/),
		   .shift_dr(shift_dr),
		   .update_dr(update_dr/*not used in sync mode*/),
		   .tdo(tdo),
		   .tdo_en(tdo_en),
		   .tap_state(tap_state),
		   .extest(bsr_extest),
		   .samp_load(bsr_sample),
		   .instructions(instruction),
		   .sync_capture_en(sync_capture_en),
		   .sync_update_dr(sync_update_dr)
		   );
   

   // mux the different TDO's into the tap, based on the instruction
   always_comb begin
      unique case(instruction)
	5'd3: muxed_tdo = bsr_tdo; // for INTEST
	5'd0: muxed_tdo = bsr_tdo; // for EXTEST
	5'd2: muxed_tdo = bsr_tdo; // for SAMPLE
	5'd8: muxed_tdo = sc_cfg_data_tdo; // serial data out from DATA register sc_cfg_data
	5'd9: muxed_tdo = sc_cfg_inst_tdo; // serial data out from DATA register sc_cfg_inst
	5'd10: muxed_tdo = sc_cfg_addr_tdo; // serial data out from DATA register sc_cfg_addr
	default : muxed_tdo = 1'b0;
      endcase // case(instruction)
   end // always_comb begin

   // Qualifiers for the various jtag stages
   // OS: unfortunatelly, this is hard coded based on the DW_tap documentation 
   //     and implementation. Not very robust though...
   assign test_logic_reset  = tap_state[0];
   logic  at_capture_dr;
   assign at_capture_dr = tap_state[3]; 
   logic  at_shift_dr;
   assign at_shift_dr = shift_dr;
   logic  at_update_dr;
   assign at_update_dr = sync_update_dr;
   
   // Output control signals per special instruction
   logic  at_sc_cfg_data;
   assign at_sc_cfg_data = (instruction==5'd8) ? 1'b1 : 1'b0;
   assign sc_cfg_data_capture_dr = at_sc_cfg_data & at_capture_dr;
   assign sc_cfg_data_shift_dr = at_sc_cfg_data & at_shift_dr;
   assign sc_cfg_data_update_dr = at_sc_cfg_data & at_update_dr;
   logic  at_sc_cfg_inst;
   assign at_sc_cfg_inst = (instruction==5'd9) ? 1'b1 : 1'b0;
   assign sc_cfg_inst_capture_dr = at_sc_cfg_inst & at_capture_dr;
   assign sc_cfg_inst_shift_dr = at_sc_cfg_inst & at_shift_dr;
   assign sc_cfg_inst_update_dr = at_sc_cfg_inst & at_update_dr;
   logic  at_sc_cfg_addr;
   assign at_sc_cfg_addr = (instruction==5'd10) ? 1'b1 : 1'b0;
   assign sc_cfg_addr_capture_dr = at_sc_cfg_addr & at_capture_dr;
   assign sc_cfg_addr_shift_dr = at_sc_cfg_addr & at_shift_dr;
   assign sc_cfg_addr_update_dr = at_sc_cfg_addr & at_update_dr;


   logic  bsr_update_dr; //I think this signal should in the port -- Jing
   
   // output signal for intest (optional in the standard but I think it's important)
   assign bsr_intest = (instruction==5'd3) ? 1'b1 : 1'b0;
   assign bsr_shift_dr = at_shift_dr & (bsr_intest | bsr_sample | bsr_extest);
   assign bsr_capture_en = sync_capture_en; 
   assign bsr_update_dr = at_update_dr & (bsr_intest | bsr_sample | bsr_extest);

endmodule // tap_unq1
