`timescale 1ns / 1ps
//includes
`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"


//Modified on 5/1/24
//FIR filter

module top_fir(x_in0,rst,bit_clk,word_clk,y_out);
parameter k = 8;

	//input 	[`M-1:0]		x_in [k-1 : 0];
	//input 	[`M-1:0]		w_in [k-1 : 0];
	input 	[`M-1:0]		x_in0;
	
	
	input					rst,bit_clk,word_clk;
	
	output	[(2*`M)-1:0]	y_out;

	//datatypes

	`ifdef bit_8
		wire [10:0] partProduct0;
		wire [10:0] partProduct1;
		wire [10:0] partProduct2;
		wire [10:0] partProduct3;		
	`else
		wire [18:0] partProduct0;
		wire [18:0] partProduct1;
		wire [18:0] partProduct2;
		wire [18:0] partProduct3;
		wire [18:0] partProduct4;
		wire [18:0] partProduct5;
		wire [18:0] partProduct6;
		wire [18:0] partProduct7;	
	`endif
	
	
	
	 wire [`M-1:0]	w_in0,w_in1,w_in2,w_in3,w_in4,w_in5,w_in6,w_in7;
	
	 wire [31:0] 	pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;
	 wire [31:0] 	sum,carry;
	 
	 reg  [`M-1:0]  x_in,w_in;
	 reg  [31:0] 	P0,P9;
	 reg  [31:0] 	S_reg,C_reg;
     reg  [31:0] 	S_tot,C_tot;		//total sum and carry
	 reg  [2:0]  	tapCount;
	 
	 reg 	[`M-1:0]		x_in1,x_in2,x_in3,x_in4,x_in5,x_in6,x_in7;
	 
	//tap values
	assign w_in0 = 0;
	assign w_in1 = 0;
	assign w_in2 = 0;
	assign w_in3 = 0;
	assign w_in4 = 0;
	assign w_in5 = 0;
	assign w_in6 = 0;
	assign w_in7 = 0;
	
	
	//instantiation of MBE(pp_gen)
	`ifdef bit_8
		pp_gen pp_gen_inst(			.x_in(x_in),
									.w_in(w_in),
									.pp_row0(partProduct0),
									.pp_row1(partProduct1),
									.pp_row2(partProduct2),
									.pp_row3(partProduct3));
	`else
		pp_gen pp_gen_inst(			.x_in(x_in),
									.w_in(w_in),
									.pp_row0(partProduct0),
									.pp_row1(partProduct1),
									.pp_row2(partProduct2),
									.pp_row3(partProduct3),
									.pp_row4(partProduct4),
									.pp_row5(partProduct5),
									.pp_row6(partProduct6),
									.pp_row7(partProduct7));
	`endif
	
	
	
	//Assign value to x_in and w_in of pp_gen based on tapCount
	always @ (*) begin
		case(tapCount)
					3'b000: begin
								x_in <= x_in0;
								w_in <= w_in0;
							end
					3'b001: begin
								x_in <= x_in1;
								w_in <= w_in1;
							end
					3'b010: begin
								x_in <= x_in2;
								w_in <= w_in2;
							end
					3'b011: begin
								x_in <= x_in3;
								w_in <= w_in3;
							end
					3'b100: begin
								x_in <= x_in4;
								w_in <= w_in4;
							end
					3'b101: begin
								x_in <= x_in5;
								w_in <= w_in5;
							end
					3'b110: begin
								x_in <= x_in6;
								w_in <= w_in6;
							end
					3'b111: begin
								x_in <= x_in7;
								w_in <= w_in7;
							end	
					default:begin
								x_in <= `M'b0;
								w_in <= `M'b0;
							end
		endcase
	end
	
								  
	//Arrangement of all partial products							  
	assign pp1 = {13'b0,partProduct0};
	assign pp2 = {12'b0,partProduct1,1'b0};
	assign pp3 = {10'b0,partProduct2,3'b0};
	assign pp4 = {8'b0,partProduct3,5'b0};
	assign pp5 = {6'b0,partProduct4,7'b0};
	assign pp6 = {4'b0,partProduct5,9'b0};
	assign pp7 = {2'b0,partProduct6,11'b0};
	assign pp8 = {partProduct7,13'b0};
	
	
	//instantiation of compressor array
	compressor_array compressor_array_inst(
														  .P0(C_reg),
														  .P1(pp1),
														  .P2(pp2),
														  .P3(pp3),
														  .P4(pp4),
														  .P5(pp5),
														  .P6(pp6),
														  .P7(pp7),
														  .P8(pp8),
														  .P9(S_reg),
														  .S(sum),
														  .C(carry));
	
	
	
	//instantiation of x_in reg by giving each a clk delay
	always @ (posedge bit_clk) begin
		if(rst) begin
			x_in1 <= 16'b0;
			x_in2 <= 16'b0;
			x_in3 <= 16'b0;
			x_in4 <= 16'b0;
			x_in5 <= 16'b0;
			x_in6 <= 16'b0;
			x_in7 <= 16'b0;
			
		end
		else begin
			x_in1 <= x_in0;
			x_in2 <= x_in1;
			x_in3 <= x_in2;
			x_in4 <= x_in3;
			x_in5 <= x_in4;
			x_in6 <= x_in5;
			x_in7 <= x_in6;
			
		end
	end	
	
	
	//Sum and carry reg from compressor_array
	always @ (posedge bit_clk) begin
		if(rst) begin
			S_reg	  <= 32'b0;
			C_reg	  <= 32'b0;
		end
		else begin
			S_reg	  <= sum;
			C_reg	  <= carry;
			
		end
	end	
	
	//final sum and carry from sum and carry reg
	always @ (posedge word_clk) begin
		if(rst) begin
			S_tot <= 32'b0;
			C_tot <= 32'b0;
		end
		else begin
			C_tot <= C_reg;
			S_tot <= S_reg;			
		end
	end	
	
	//tap counter
	always @(posedge bit_clk)  begin
		if(rst)
			tapCount[2:0] <= 3'd0;
		else	
			tapCount[2:0] <= tapCount[2:0] + 1'd1;
	end
  
	
	
				   
	
endmodule
