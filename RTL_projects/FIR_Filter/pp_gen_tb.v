module pp_gen_tb();

	`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"


	reg [`M-1:0]x;
	reg [`M-1:0]w;
	
	reg clk;
	reg check;
	
	wire [(2*`M)-1:0] local_prod;	//
	wire [(2*`M)-1:0] prod_out;
	


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
		//wire [31:0] prod_out;
	
	`endif


	// wire		[11:0]  sum_2;
	// wire		[11:0]  carry_2;
		

	//wire[15:0] prod_out;
	//wire[15:0] final_prod;


	`ifdef bit_8
		pp_gen pp_gen_inst(			.x_in(x),
									.w_in(w),
									.pp_row0(partProduct0),
									.pp_row1(partProduct1),
									.pp_row2(partProduct2),
									.pp_row3(partProduct3));
	`else
		pp_gen pp_gen_inst(			.x_in(x),
									.w_in(w),
									.pp_row0(partProduct0),
									.pp_row1(partProduct1),
									.pp_row2(partProduct2),
									.pp_row3(partProduct3),
									.pp_row4(partProduct4),
									.pp_row5(partProduct5),
									.pp_row6(partProduct6),
									.pp_row7(partProduct7));
	`endif

	`ifdef bit_8							
		assign prod_out = {partProduct3,5'b0} + {partProduct2,3'b0} + {partProduct1,1'b0} + {partProduct0};
	`else
		assign prod_out = {partProduct7,13'b0} + {partProduct6,11'b0} + {partProduct5,9'b0} + {partProduct4,7'b0} + {partProduct3,5'b0} + {partProduct2,3'b0} + {partProduct1,1'b0} + {partProduct0};
	`endif
	
	
	assign local_prod	=	x * w;
	
	always #5 clk = ~clk;

	
	initial begin
		clk =1'b0;
		$display(" M     =%b\t",`M);
		
		x =16'd20;
		w =16'd44;
		// #5
		// $display(" x =%d(%b)\t",x,x);
		// $display(" w =%d(%b)\t",w,w);
		
		// $display(" a =%b%b%b\t",pp_gen_inst.alpha2,pp_gen_inst.alpha1,pp_gen_inst.alpha0);
		// $display(" dbar =%b\t",pp_gen_inst.dbar);
		// $display(" es[0] =%b\t",pp_gen_inst.es[0]);
		
		// $display(" partProduct0 =     %b\t",partProduct0);
		// $display(" partProduct1 =    %b\t",partProduct1);
		// $display(" partProduct2 =  %b\t",partProduct2);
		// $display(" partProduct3 =%b\t",partProduct3);
		// $display(" prod_out     =%b\t",prod_out);
		
		
		// #5
		// $display(" prod_out     =%b\t",prod_out);
		// $display(" prod_out =%0d\t",prod_out);
		// $display(" final_prod     =%b\t",final_prod);
		// $display(" final_prod =%0d\t",final_prod);
		
		// #10
		// x =16'd2;
		// w =16'd23;
		
		// #5
		// $display(" prod_out     =%b\t",prod_out);
		// $display(" prod_out =%0d\t",prod_out);
		// $display(" final_prod     =%b\t",final_prod);
		// $display(" final_prod =%0d\t",final_prod);
		
		
		#5000 $stop;
	end
	
	// always @(posedge clk) begin
		// x <= x + 1'b1;
	// end
	
	initial	begin
		repeat(50)@(posedge clk)	begin
		x = $urandom_range(0,1000);//$random ; 
		w = $urandom_range(0,1000);//$random ; 
		
		$display(" x =%d(%b)\t",x,x);
		$display(" w =%d(%b)\t",w,w);
		
		
		$display(" partProduct0 =     %b\t",partProduct0);
		$display(" partProduct1 =    %b\t",partProduct1);
		$display(" partProduct2 =  %b\t",partProduct2);
		$display(" partProduct3 =%b\t",partProduct3);
		$display(" prod_out     =%b\t",prod_out);
		
		end
		#10 $finish;
	end

	
	always @(posedge clk) begin
		if( local_prod == prod_out) 
			check <= 1'b1;
		else
			check <= 1'b0;
	end
	
	
  
	

	
endmodule
  // x = 20(00010100)	
// # w = 44(00101100)	    
// #  partProduct0 =     10000000000	
// #  partProduct1 =    11000000000	
// #  partProduct2 =  11000101000	
// #  partProduct3 =11000101000	
				// =0000010001110000
			   // g=0000001101110000
			   
			   
			   
 // partProduct0 =     10000000000	
 // partProduct1 =    10111010100	
 // partProduct2 =  10111010101	
 // partProduct3 =11000101001	
 // prod_out     =0000001101110000	
 // prod_out =880	
				 