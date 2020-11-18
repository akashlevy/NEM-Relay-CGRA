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
//  Source file: /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pad_ring/io_group.svp
//  Source template: io_group
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter config_addr_width 	= 32
// Parameter side 	= N
// Parameter group_num 	= 0
// Parameter config_data_width 	= 32
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

// side (_GENESIS2_INHERITANCE_PRIORITY_) = N
//
// group_num (_GENESIS2_INHERITANCE_PRIORITY_) = 0
//
// num_ios (_GENESIS2_DECLARATION_PRIORITY_) = 16
//
// config_addr_width (_GENESIS2_INHERITANCE_PRIORITY_) = 32
//
// config_data_width (_GENESIS2_INHERITANCE_PRIORITY_) = 32
//

// io group 0

module io_group_unq1 (
  input clk,
  input reset,
  input [31:0] config_data,
  input [31:0] config_addr,
  input config_read,
  input config_write,
  input [15:0] f2p_wide,
  input [15:0] f2p_1bit,
  inout [15:0] pads,
  output [15:0] p2f,
  output reg [31:0] read_data
);

wire [31:0] read_data_tile [15:0];


io1bit_unq1  io1bit_0x0001 (     // N_0[15]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[15]),
  .read_data(read_data_tile[15]),
  .f2p_16(f2p_wide[15]),
  .f2p_1(f2p_1bit[15]),
  .p2f(p2f[15]),
  .tile_id(16'h0001)
);

//   <tile type='io1bit' tile_addr='0x0001' row='0' col='1' name='pads_N_0'>
//     <io_bit>15</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
// 
//     <!-- 16bit IO same exc. BUS16 instead of BUS1 -->
//     <p2f_wide>out_16BIT_S1_T0</p2f_wide>
//     <p2f_wide>out_16BIT_S1_T1</p2f_wide>
//     <p2f_wide>out_16BIT_S1_T2</p2f_wide>
//     <p2f_wide>out_16BIT_S1_T3</p2f_wide>
//     <p2f_wide>out_16BIT_S1_T4</p2f_wide>
//     <f2p_wide>in_16BIT_S1_T0</f2p_wide>
// 
//   </tile>

io1bit_unq1  io1bit_0x0002 (     // N_0[14]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[14]),
  .read_data(read_data_tile[14]),
  .f2p_16(f2p_wide[14]),
  .f2p_1(f2p_1bit[14]),
  .p2f(p2f[14]),
  .tile_id(16'h0002)
);

//   <tile type='io1bit' tile_addr='0x0002' row='0' col='2' name='pads_N_0'>
//     <io_bit>14</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0003 (     // N_0[13]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[13]),
  .read_data(read_data_tile[13]),
  .f2p_16(f2p_wide[13]),
  .f2p_1(f2p_1bit[13]),
  .p2f(p2f[13]),
  .tile_id(16'h0003)
);

//   <tile type='io1bit' tile_addr='0x0003' row='0' col='3' name='pads_N_0'>
//     <io_bit>13</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0004 (     // N_0[12]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[12]),
  .read_data(read_data_tile[12]),
  .f2p_16(f2p_wide[12]),
  .f2p_1(f2p_1bit[12]),
  .p2f(p2f[12]),
  .tile_id(16'h0004)
);

//   <tile type='io1bit' tile_addr='0x0004' row='0' col='4' name='pads_N_0'>
//     <io_bit>12</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0005 (     // N_0[11]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[11]),
  .read_data(read_data_tile[11]),
  .f2p_16(f2p_wide[11]),
  .f2p_1(f2p_1bit[11]),
  .p2f(p2f[11]),
  .tile_id(16'h0005)
);

//   <tile type='io1bit' tile_addr='0x0005' row='0' col='5' name='pads_N_0'>
//     <io_bit>11</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0006 (     // N_0[10]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[10]),
  .read_data(read_data_tile[10]),
  .f2p_16(f2p_wide[10]),
  .f2p_1(f2p_1bit[10]),
  .p2f(p2f[10]),
  .tile_id(16'h0006)
);

//   <tile type='io1bit' tile_addr='0x0006' row='0' col='6' name='pads_N_0'>
//     <io_bit>10</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0007 (     // N_0[9]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[9]),
  .read_data(read_data_tile[9]),
  .f2p_16(f2p_wide[9]),
  .f2p_1(f2p_1bit[9]),
  .p2f(p2f[9]),
  .tile_id(16'h0007)
);

//   <tile type='io1bit' tile_addr='0x0007' row='0' col='7' name='pads_N_0'>
//     <io_bit>9</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0008 (     // N_0[8]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[8]),
  .read_data(read_data_tile[8]),
  .f2p_16(f2p_wide[8]),
  .f2p_1(f2p_1bit[8]),
  .p2f(p2f[8]),
  .tile_id(16'h0008)
);

//   <tile type='io1bit' tile_addr='0x0008' row='0' col='8' name='pads_N_0'>
//     <io_bit>8</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0009 (     // N_0[7]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[7]),
  .read_data(read_data_tile[7]),
  .f2p_16(f2p_wide[7]),
  .f2p_1(f2p_1bit[7]),
  .p2f(p2f[7]),
  .tile_id(16'h0009)
);

//   <tile type='io1bit' tile_addr='0x0009' row='0' col='9' name='pads_N_0'>
//     <io_bit>7</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000A (     // N_0[6]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[6]),
  .read_data(read_data_tile[6]),
  .f2p_16(f2p_wide[6]),
  .f2p_1(f2p_1bit[6]),
  .p2f(p2f[6]),
  .tile_id(16'h000A)
);

//   <tile type='io1bit' tile_addr='0x000A' row='0' col='10' name='pads_N_0'>
//     <io_bit>6</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000B (     // N_0[5]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[5]),
  .read_data(read_data_tile[5]),
  .f2p_16(f2p_wide[5]),
  .f2p_1(f2p_1bit[5]),
  .p2f(p2f[5]),
  .tile_id(16'h000B)
);

//   <tile type='io1bit' tile_addr='0x000B' row='0' col='11' name='pads_N_0'>
//     <io_bit>5</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000C (     // N_0[4]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[4]),
  .read_data(read_data_tile[4]),
  .f2p_16(f2p_wide[4]),
  .f2p_1(f2p_1bit[4]),
  .p2f(p2f[4]),
  .tile_id(16'h000C)
);

//   <tile type='io1bit' tile_addr='0x000C' row='0' col='12' name='pads_N_0'>
//     <io_bit>4</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000D (     // N_0[3]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[3]),
  .read_data(read_data_tile[3]),
  .f2p_16(f2p_wide[3]),
  .f2p_1(f2p_1bit[3]),
  .p2f(p2f[3]),
  .tile_id(16'h000D)
);

//   <tile type='io1bit' tile_addr='0x000D' row='0' col='13' name='pads_N_0'>
//     <io_bit>3</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000E (     // N_0[2]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[2]),
  .read_data(read_data_tile[2]),
  .f2p_16(f2p_wide[2]),
  .f2p_1(f2p_1bit[2]),
  .p2f(p2f[2]),
  .tile_id(16'h000E)
);

//   <tile type='io1bit' tile_addr='0x000E' row='0' col='14' name='pads_N_0'>
//     <io_bit>2</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x000F (     // N_0[1]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[1]),
  .read_data(read_data_tile[1]),
  .f2p_16(f2p_wide[1]),
  .f2p_1(f2p_1bit[1]),
  .p2f(p2f[1]),
  .tile_id(16'h000F)
);

//   <tile type='io1bit' tile_addr='0x000F' row='0' col='15' name='pads_N_0'>
//     <io_bit>1</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

io1bit_unq1  io1bit_0x0010 (     // N_0[0]
  .clk(clk),
  .reset(reset),
  .config_data(config_data),
  .config_addr(config_addr),
  .config_read(config_read),
  .config_write(config_write),
  .pad(pads[0]),
  .read_data(read_data_tile[0]),
  .f2p_16(f2p_wide[0]),
  .f2p_1(f2p_1bit[0]),
  .p2f(p2f[0]),
  .tile_id(16'h0010)
);

//   <tile type='io1bit' tile_addr='0x0010' row='0' col='16' name='pads_N_0'>
//     <io_bit>0</io_bit>
//     <io_group>0</io_group>
//     <tri feature_address='0' reg_address='0' bitl='0' bith='0'>
//         <direction sel='0'>in</direction>  <!--input-->
//         <direction sel='1'>out</direction> <!--output-->
//     </tri>
//     <mux feature_address='0' reg_address='0' bitl='1' bith='1'>
//         <src sel='0'>16</src> <!-- 16 bit mode -->
//         <src sel='1'>1</src>  <!--  1 bit mode -->
//     </mux>
// 
//     <!-- input goes from pad to ALL tracks -->
//     <p2f_1bit>out_1BIT_S1_T0</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T1</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T2</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T3</p2f_1bit>
//     <p2f_1bit>out_1BIT_S1_T4</p2f_1bit>
// 
//     <!-- output only comes from track 0 -->
//     <f2p_1bit>in_1BIT_S1_T0</f2p_1bit>
//   </tile>

// SV equivalent: assign read_data = read_data_tile.or();
always @(*) begin
  read_data = 0;
  for (integer i=0; i < 16; i++)
    read_data = read_data | read_data_tile[i];
end

endmodule


