module top_fir_tb();

	`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"

	reg [`M-1:0]x_in;
	
	reg rst,bit_clk,word_clk;
	
	wire [`M-1:0]x_in_loc;
	wire [`M-1:0]w_in_loc;
	
	wire [(2*`M)-1:0] y_out;	
	
	
		wire [18:0] partProduct0;
		wire [18:0] partProduct1;
		wire [18:0] partProduct2;
		wire [18:0] partProduct3;
		wire [18:0] partProduct4;
		wire [18:0] partProduct5;
		wire [18:0] partProduct6;
		wire [18:0] partProduct7;
		
		wire [(2*`M)-1:0] prod_out;
		
		wire [31:0] 	S_reg,C_reg;
		wire [31:0] 	S_tot,C_tot;		//total sum and carry
		wire [32:0] 	S_tot1,C_tot1;		//total sum and carry
		wire [31:0]		total;
	 
	
		
	
	
	top_fir top_fir_inst(
						.x_in0(x_in),
						.rst(rst),
						.bit_clk(bit_clk),
						.word_clk(word_clk),
						.y_out(y_out));
	
	
	assign x_in_loc = top_fir_inst.x_in;					
	assign w_in_loc = top_fir_inst.w_in;					
						
	assign partProduct0 = top_fir_inst.partProduct0;
	assign partProduct1 = top_fir_inst.partProduct1;
	assign partProduct2 = top_fir_inst.partProduct2;
	assign partProduct3 = top_fir_inst.partProduct3;
	assign partProduct4 = top_fir_inst.partProduct4;
	assign partProduct5 = top_fir_inst.partProduct5;
	assign partProduct6 = top_fir_inst.partProduct6;
	assign partProduct7 = top_fir_inst.partProduct7;
	
	assign S_reg = top_fir_inst.S_reg;
	assign C_reg = top_fir_inst.C_reg;
	assign S_tot = top_fir_inst.S_tot;
	assign C_tot = top_fir_inst.C_tot;
	
	assign prod_out = {partProduct7,13'b0} + {partProduct6,11'b0} + {partProduct5,9'b0} + {partProduct4,7'b0} + {partProduct3,5'b0} + {partProduct2,3'b0} + {partProduct1,1'b0} + {partProduct0};
	
	// assign C_tot1 = {C_reg,1'b0};
	// assign S_tot1 = {1'b0,S_reg};
	assign C_tot1 = {C_reg,1'b0};
	assign S_tot1 = {S_reg};
	assign total = S_tot1 + C_tot1;

	always #5 bit_clk = ~bit_clk;
	
	always #40 word_clk = ~word_clk;//T(word_clk) = k* T(bit_clk)
	

	
	initial begin
		bit_clk  = 1'b1;
		word_clk = 1'b1;
		x_in	 = 16'd0;
		rst		 = 1'b0;
		#7
		rst		 = 1'b1;
		#14
		rst		 = 1'b0;
		
		$display("P0=%b",top_fir_inst.C_reg);
		$display("P1=%b",top_fir_inst.pp1);
		$display("P2=%b",top_fir_inst.pp2);
		$display("P3=%b",top_fir_inst.pp3);
		$display("P4=%b",top_fir_inst.pp4);
		$display("P5=%b",top_fir_inst.pp5);
		$display("P6=%b",top_fir_inst.pp6);
		$display("P7=%b",top_fir_inst.pp7);
		$display("P8=%b",top_fir_inst.pp8);
		$display("P9=%b",top_fir_inst.S_reg);
		#500 $stop;
	end 
	

	
endmodule