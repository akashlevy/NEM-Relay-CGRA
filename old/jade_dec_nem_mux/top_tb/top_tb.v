`define NULL 0

module tb();

/////////////////////////////////////////////////////////
//
// Wires and Regs
//
/////////////////////////////////////////////////////////

reg clk;
reg [3:0] reset_count;
  
wire reset;

reg [15:0] pe_output_0;
reg [15:0] in_0_0;
reg [15:0] in_0_1;
reg [15:0] in_1_0;
reg [15:0] in_1_1;

integer    config_data_file;
reg [31:0] config_addr_i;
reg [31:0] config_data_i;
reg [31:0] config_addr;
reg [31:0] config_data;
reg tile_config_done;
/////////////////////////////////////////////////////////
//
// Initials
//
/////////////////////////////////////////////////////////

initial begin
  clk<=1'b1;
  reset_count<=4'd0;
end

initial begin
  config_addr_i <= 0;
  config_data_i <= 0;
  config_addr <= 0;
  config_data <= 0;
  tile_config_done <= 0;
end

initial begin
  config_data_file = $fopen("tile_config.dat", "r");
  if (config_data_file == `NULL) begin
    $display("config_data_file handle was NULL");
    $finish;
  end
end
/////////////////////////////////////////////////////////
//
// Clock and reset
//
/////////////////////////////////////////////////////////
    
    always #0.625 clk <= ~clk;
    
    always @(posedge clk) begin
      if (!(&reset_count)) begin 
        reset_count <= reset_count + 1;
      end
    end
    
    assign reset = !reset_count[3];
    
/////////////////////////////////////////////////////////
//
// Tile configuration
//
/////////////////////////////////////////////////////////

    always @(posedge clk) begin
      if (!reset) begin
        $fscanf(config_data_file, "%h %h", config_addr_i,config_data_i); 
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
      in_0_0 <= $random;
      in_0_1 <= $random;
      in_1_0 <= $random;
      in_1_1 <= $random;
    end

/////////////////////////////////////////////////////////
//
// Monitor
//
/////////////////////////////////////////////////////////

    always @(posedge clk) begin
       if (tile_config_done==1'b1) begin
         $display ("%h + %h + %h + %h = %h (%h)", in_0_0, in_0_1, in_1_0, in_1_1, dut.wire_0_1_BUS16_S0_T4 ,in_0_0+in_0_1+in_1_0+in_1_1);
         if (dut.wire_0_1_BUS16_S0_T4!=(in_0_0+in_0_1+in_1_0+in_1_1)) begin
           $display("Error!");
           $finish();
         end
       end
    end

/////////////////////////////////////////////////////////
//
// DUT instantiation
//
/////////////////////////////////////////////////////////

    top dut (
    .clk(clk),
    .reset(reset),
    .wire_0_m1_BUS16_S0_T0(in_0_0),
    .wire_m1_0_BUS16_S1_T0(in_0_1),
    .wire_1_m1_BUS16_S0_T2(in_1_0),
    .wire_4_0_BUS16_S3_T2(in_1_1),
    .config_addr(config_addr),
    .config_data(config_data)
    );
    
endmodule

