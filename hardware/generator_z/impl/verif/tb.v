`timescale 1ns/1ps
module tb();
/////////////////////////////////////////////////////////
//
// Clock and reset
//
/////////////////////////////////////////////////////////
    reg clk;
    reg [3:0] reset_count;
    reg [19:0] count;

    reg [15:0] d0;
    reg [15:0] d1;
    reg [15:0] d2;
    reg [15:0] d3;
    reg ren;
    reg wen;
    wire [15:0] dout;
    wire [15:0] cout;
    wire valid;
    wire af;
        
    wire reset;
    
    initial begin
      clk<=1'b1;
      reset_count<=4'd0;
      count<=0;
      wen<=0;
      ren<=0;
    end
    
    always #0.625 clk <= ~clk;
    
    always @(posedge clk) begin
      if (!(&reset_count)) begin 
        reset_count <= reset_count + 1;
      end
      count <= count + 1;
    end
    
    assign reset = !reset_count[3];
    
/////////////////////////////////////////////////////////
//
// Tile configuration
//
/////////////////////////////////////////////////////////

    integer    config_data_file    ; // file handler
    reg [31:0] config_addr_i;
    reg [31:0] config_data_i;
    reg [31:0] config_addr;
    reg [31:0] config_data;
    reg tile_config_done;

    initial begin
      config_addr_i <= 0;
      config_data_i <= 0;
      config_addr <= 0;
      config_data <= 0;
      tile_config_done <= 0;
    end
    `define NULL 0
    
    initial begin
      config_data_file = $fopen("tile_config.dat", "r");
      if (config_data_file == `NULL) begin
        $display("config_data_file handle was NULL");
        $finish;
      end
    end
    always @(posedge clk) begin
      if (!reset) begin
        $fscanf(config_data_file, "%h %h\n", config_addr_i,config_data_i); 
        if (!$feof(config_data_file)) begin
          config_addr <= config_addr_i;
          config_data <= config_data_i;
        end else begin
          tile_config_done <= 1'b1;
        end
      end
    end
/////////////////////////////////////////////////////////
//
// Data generation 
//
/////////////////////////////////////////////////////////

always @(posedge clk) begin
  d0 <= $random;
  d1 <= $random;
  d2 <= $random;
  d3 <= $random;
end


always @(posedge clk) begin
  if ((count==20'd100)||(count==20'd612)||(count==20'd620)||(count==20'd1132)||(count==20'd1135)||(count==20'd1647)) begin
    wen<=~wen;
  end
end

always @(posedge clk) begin
  if (count==20'd110) begin
    ren<=~ren;
  end else if (count==20'd621) begin
    ren<=~ren;
  end
end

/////////////////////////////////////////////////////////
//
// DUT instantiation
//
/////////////////////////////////////////////////////////

top dut(

.clk_in(clk),
.config_addr_in(config_addr),
.config_data_in(config_data),
.reset_in(reset)
);

endmodule
