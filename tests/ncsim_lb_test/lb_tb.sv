

module lb_tb ();
	reg clk;
	reg clk_en;
	reg reset;
	reg [15:0] data_in;
	reg [15:0] data_out;
	reg [31:0] i;
	reg startup;
	reg [31:0] config_addr;
	reg [31:0] config_data;
	reg config_read;
	reg config_write;
	reg config_en;
	reg [3:0] config_en_sram;
	reg flush;
	reg wen_in;		
	memory_core_unq1 mem_core (
		.clk_in(clk),
		.clk_en(clk_en),
		.reset(reset),
		.config_en(config_en),
		.config_en_sram(config_en_sram),
		.config_read(config_read),
		.config_write(config_write),
		.config_addr(config_addr),
		.config_data(config_data),
		.data_in(data_in),
		.data_out(data_out),
		.wen_in(wen_in),
		.ren_in(0),
		.valid_out(valid_out),
		.chain_in(0),
		.flush(flush)
	);

	initial begin
		clk = 0;
		clk_en = 1;
		flush = 0;
		config_en = 0;
		config_en_sram = 0;
		config_read = 0;
		config_write = 0;
		reset = 1;
		config_addr = 0;
		flush = 0;
		data_in = 0;
		startup = 0;
		repeat(3)@ (posedge clk);
		reset = 0;
		@ (posedge clk);
		config_en = 1;
		config_addr = 0;
		config_data = {16'b0,13'd15,1'b1,2'b0};
		@ (posedge clk);
		config_en = 0;
		@ (posedge clk);
		startup = 1;
		//Flush the lb after 40 cycles
		repeat(40)@ (posedge clk);
		flush = 1;
		repeat(3)@ (posedge clk);
		flush = 0;
		repeat(40) @ (negedge clk);
		#1
		//clk_en = 0;
		repeat(5) @ (negedge clk);
		//config_en_sram = 4'b1;
		//config_read = 1;
		//config_addr = {8'b111,24'b0};
		repeat(5) @ (negedge clk);
		//config_read = 0;
		//config_en_sram = 0;
		repeat(5) @ (negedge clk);
		#1
		clk_en = 1;
	end
	always begin
		#5
		clk = ~clk;
	end
	always @ (posedge clk) begin
		if(startup) begin
			i = i+1;
			//wen_in = (i < 15) || (i > 20 && i < 40) || (i > 45);
			wen_in = $urandom_range(1,0);
			if( wen_in == 1 && i>1)
				data_in = data_in + 1;
		end
		else begin
			i = 0;
			data_in = 1;
			wen_in = 0;
		end
	end
endmodule
