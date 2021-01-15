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
//	|  $Change: 11904 $ --- $Date: 2013/08/03 $   |
//	-----------------------------------------------
//	
//
//  Source file: /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_cmpr.svp
//  Source template: test_cmpr
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
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

module  test_cmpr(
  input  a_msb,
  input  b_msb,
  input  diff_msb,
  input  is_signed,
  input  eq,

  output lte,
  output gte
);

logic lte_signed;
logic lte_unsigned;
logic gte_signed;
logic gte_unsigned;

assign lte_unsigned = (~(a_msb ^ b_msb) & diff_msb) |
                      (~a_msb & b_msb) |
                      eq;
assign lte_signed   = (~(a_msb ^ b_msb) & diff_msb) |
                      (a_msb & ~b_msb) |
                      eq;

assign gte_unsigned = (~(a_msb ^ b_msb) & ~diff_msb) |
                      (a_msb & ~b_msb);

assign gte_signed   = (~(a_msb ^ b_msb) & ~diff_msb) |
                      (~a_msb & b_msb);

assign lte = is_signed ? lte_signed : lte_unsigned;
assign gte = is_signed ? gte_signed : gte_unsigned;

endmodule
