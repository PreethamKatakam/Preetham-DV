module compressor_array_tb();

`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"

//P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,S,C 
 reg clk;
 
 reg 	[`M-1:0]x_in;
 reg 	[`M-1:0]w_in;
 
 wire	[18:0] 	PP0,PP1,PP2,PP3,PP4,PP5,PP6,PP7;
 reg	[31:0] 	P0,P1,P2,P3,P4,P5,P6,P7,P8,P9;
 wire	[31:0] 	S;
 wire	[31:0] 	C;
 
 //wire [32:0] 	S_tot1,C_tot1;		//total sum and carry
 wire [32:0]		total;
 wire [(2*`M):0]  	local_prod;	//
 wire [(2*`M):0] 	prod_out;
 
 reg PP_check;
 wire Comp_check;
 reg 	[5:0]  	fails; //checks the no. of times the checker is failing
 
 
 
 // pp_gen pp_gen_inst(			.x_in(x_in),
									// .w_in(w_in),
									// .pp_row0(PP0),
									// .pp_row1(PP1),
									// .pp_row2(PP2),
									// .pp_row3(PP3),
									// .pp_row4(PP4),
									// .pp_row5(PP5),
									// .pp_row6(PP6),
									// .pp_row7(PP7));
 
	// assign P0 = 32'd0;
	// assign P1 = {13'b0,PP0};
	// assign P2 = {12'b0,PP1,1'b0};
	// assign P3 = {10'b0,PP2,3'b0};
	// assign P4 = {8'b0,PP3,5'b0};
	// assign P5 = {6'b0,PP4,7'b0};
	// assign P6 = {4'b0,PP5,9'b0};
	// assign P7 = {2'b0,PP6,11'b0};
	// assign P8 = {PP7,13'b0};
	// assign P9 = 32'd0;
	
 compressor_array compressor_array_inst(
														  .P0(P0),//C_reg),
														  .P1(P1),
														  .P2(P2),
														  .P3(P3),
														  .P4(P4),
														  .P5(P5),
														  .P6(P6),
														  .P7(P7),
														  .P8(P8),
														  .P9(P9),//S_reg),
														  .S(S),
														  .C(C));
	
								  			
	
	// assign C_tot1 = {C,1'b0};
	// assign S_tot1 = {S};
	assign total = {C,1'd0} + S;
	assign local_prod	=	x_in * w_in;
	//assign Comp_check = (local_prod[31:0] == total[31:0]);
	assign Comp_check = (prod_out[31:0] == total[31:0]);
	
	assign prod_out = P0 + P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8 + P9;
	
	always #5 clk = ~clk;

	initial begin
	fails = 1'b0;
	clk =1'b0;
	
	#5	
	/*x_in = 16'd588;
	w_in = 16'd554;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	
	#5	
	x_in = 16'd554;
	w_in = 16'd588;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	
	#5	
	x_in = 16'd540;
	w_in = 16'd725;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");#5	
			
	x_in = 16'd725;
	w_in = 16'd540;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	#5	
	x_in = 16'd996;
	w_in = 16'd673;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	#5	
	x_in = 16'd673;
	w_in = 16'd996;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	#5	
	x_in = 16'd880;
	w_in = 16'd45;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	#5	
	x_in = 16'd45;
	w_in = 16'd880;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	#5	
	x_in = 16'd161;
	w_in = 16'd682;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");
	
	#5	
	x_in = 16'd682;
	w_in = 16'd161;
	 #5
			//$display("count=%d",count);
			$display("");
			$display("P0 =%b",P0);
			$display("P1 =%b",P1);
			$display("P2 =%b",P2);
			$display("P3 =%b",P3);
			$display("P4 =%b",P4);
			$display("P5 =%b",P5);
			$display("P6 =%b",P6);
			$display("P7 =%b",P7);
			$display("P8 =%b",P8);
			$display("P9 =%b",P9);
			$display("Ci0=");
			$display("Ci1=");
			$display("Ci2=");
			$display("Ci3=");
			$display("Ci4=");
			$display("S  =%b",S);
			$display("C  =%b",C);
			$display("Co0=");
			$display("Co1=");
			$display("Co2=");
			$display("Co3=");
			$display("Co4=");*/
	
	
	#5000 $stop;
	end
	
	// initial	begin
		// repeat(50)@(posedge clk)	begin
		// x_in = $urandom_range(0,800);//$random ; 
		// w_in = $urandom_range(0,800);//$random ; 
		
		
		// end
		// #1000 $stop;
	
	
	initial	begin
		repeat(50)@(posedge clk)	begin
		P0 = 32'b0;//$random ; 
		P1 = $random;//$random ; 
		P2 = $random;//$random ; 
		P3 = $random;//$random ; 
		P4 = $random;//$random ; 
		P5 = $random;//$random ; 
		P6 = $random;//$random ; 
		P7 = $random;//$random ; 
		P8 = $random;//$random ; 
		P9 = 32'b0;//$random ; 		
		end
		#1000 $stop;
	end
	
	// always @(*) begin
		// #2 x_in <= x_in + 1'b1;
	// end
	
	
	// always @(*) begin
		// #5
		// if( local_prod == total) 
			// check <= 1'b1;
		// else
			// check <= 1'b0;
	// end
	
	always @(posedge clk) begin
		if( local_prod[31:0] == prod_out[31:0]) 
			PP_check <= 1'b1;
		else
			PP_check <= 1'b0;
	end
	
	
	always @(posedge clk) begin
		if(!Comp_check)
			fails <= fails + 1'b1;
		else
			fails <= fails;
	end
	
	
	
	
  
	

	
endmodule