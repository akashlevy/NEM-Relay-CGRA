// http://rattus-pubis.blogspot.com/2011/02/experimenting-with-verilator-counter.html
// 
// 20 February, 2011
// 
// Experimenting with Verilator (counter)
// 
/* commments
// Verilator is a open source Verilog HDL simulator. It is very fast
// since it translates Verilog code into optimized C++. But it as also
// quiet different from other Verilog simulators like Icarus Verilog and
// commercial ones, it only supports synthesizable RTL language
// constructs.
// 
// This are my first successful Verilator experiments. I was looking for
// a counter example, but was not able to find one, so I decided to write
// one myself and publish it. The instructions are for Ubuntu.
// 
// First write a verilog RTL counter. This example has two registers, one
// running at clock posedge, the other on negedge. I just wished to check
// if using both clock edges still qualifies as synthesizable RTL.
*/

module counter #(
  parameter WIDTH = 8
)(
  // system signals
  input  wire             clk,
  input  wire             rst,
  // counter signas
  input  wire             cen,  // counter enable
  input  wire             wen,  // write enable
  input  wire [WIDTH-1:0] dat,  // input data
  output reg  [WIDTH-1:0] o_p,  // output value (posedge counter)
  output reg  [WIDTH-1:0] o_n   // output value (negedge counter)
);


always @ (posedge clk, posedge rst)
if (rst) o_p <= {WIDTH{1'b0}};
else     o_p <= wen ? dat : o_p + {{WIDTH-1{1'b0}}, cen};


always @ (negedge clk, posedge rst)
if (rst) o_n <= {WIDTH{1'b0}};
else     o_n <= wen ? dat : o_n + {{WIDTH-1{1'b0}}, cen};


endmodule
