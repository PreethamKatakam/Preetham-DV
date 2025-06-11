//Modified on 6/1/24
//10:2 compressor array


module compressor_array(P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,S,C);

 input	[31:0] P0,P1,P2,P3,P4,P5,P6,P7,P8,P9;
 output	[31:0] S;
 output	[31:0] C;
 // wire  [31:0] Ci0;
 // wire  [31:0] Ci1;
 // wire  [31:0] Ci2;
 // wire  [31:0] Ci3;
 // wire  [31:0] Ci4;
 
 wire  [32:0] Co0;
 wire  [32:0] Co1;
 wire  [32:0] Co2;
 wire  [32:0] Co3;
 wire  [32:0] Co4;
 
 
 wire	comp4_2op;			//compressor 4:2 output
 wire	comp7_2op;			//compressor 7:2 output
 
 
 
 
 
 
 
 //##################### compress10_2_array ######################/
 
 //compressor for 0		
 compress10_2 compress10_2_inst0(
								  // .X1(P0[0]),
								  // .X2(P1[0]),
								  // .X3(P2[0]),
								  // .X4(P3[0]),
								  // .X5(P4[0]),
								  // .X6(P5[0]),
								  // .X7(P6[0]),
								  // .X8(P7[0]),
								  // .X9(P8[0]),
								  // .X10(P9[0]),
								  .X1(P0[0]),
								  .X2(P8[0]),
								  .X3(P7[0]),
								  .X4(P6[0]),
								  .X5(P5[0]),
								  .X6(P4[0]),
								  .X7(P3[0]),
								  .X8(P2[0]),
								  .X9(P1[0]),
								  .X10(P9[0]),
								  .Ci0(1'b0),
								  .Ci1(1'b0),
								  .Ci2(1'b0),
								  .Ci3(1'b0),
								  .Ci4(1'b0),
								  .S(S[0]),
								  .C(C[0]),
								  .Co0(Co0[0]),
								  .Co1(Co1[0]),
								  .Co2(Co2[0]),
								  .Co3(Co3[0]),
								  .Co4(Co4[0]),
								  .count(0));
 
 genvar i;
 generate
 begin
 	for(i=1; i<=31; i=i+1) begin 
		//compressor for 1 to 31
		compress10_2 compress10_2_inst_1_32(
								  // .X1(P0[i]),
								  // .X2(P1[i]),
								  // .X3(P2[i]),
								  // .X4(P3[i]),
								  // .X5(P4[i]),
								  // .X6(P5[i]),
								  // .X7(P6[i]),
								  // .X8(P7[i]),
								  // .X9(P8[i]),
								  // .X10(P9[i]),
								  .X1(P0[i]),
								  .X2(P8[i]),
								  .X3(P7[i]),
								  .X4(P6[i]),
								  .X5(P5[i]),
								  .X6(P4[i]),
								  .X7(P3[i]),
								  .X8(P2[i]),
								  .X9(P1[i]),
								  .X10(P9[i]),
								  .Ci0(Co0[i-1]),
								  .Ci1(Co1[i-1]),
								  .Ci2(Co2[i-1]),
								  .Ci3(Co3[i-1]),
								  .Ci4(Co4[i-1]),
								  .S(S[i]),
								  .C(C[i]),
								  .Co0(Co0[i]),
								  .Co1(Co1[i]),
								  .Co2(Co2[i]),
								  .Co3(Co3[i]),
								  .Co4(Co4[i]),
								  .count(i));
								  
		
	end
 end	
 endgenerate
 
endmodule
 