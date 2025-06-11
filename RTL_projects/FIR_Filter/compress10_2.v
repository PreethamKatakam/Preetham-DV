//Modified on 4/1/24
//10:2 compressor


module compress10_2(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,Ci0,Ci1,Ci2,Ci3,Ci4,count,S,C,Co0,Co1,Co2,Co3,Co4);

 input	X1;
 input	X2;
 input	X3;
 input	X4;
 input	X5;
 input	X6;
 input	X7;
 input	X8;
 input	X9;
 input	X10;
 input	Ci0;				//carry input
 input	Ci1;				//carry input
 input	Ci2;				//carry input
 input	Ci3;				//carry input
 input	Ci4;				//carry input
 input  [6:0]count;
 
 
 output	S;
 output	C;
 output	Co0;				//carry output
 output	Co1;				//carry output
 output	Co2;				//carry output
 output	Co3;				//carry output
 output	Co4;				//carry output
 
 
 wire	comp4_2op;			//compressor 4:2 output
 wire	comp7_2op;			//compressor 7:2 output
 
 compress4_2 compress4_2_inst(.X1(X8),
							  .X2(X9),
							  .X3(X10),
							  .X4(Ci2),
							  .Ci(Ci3),
							  .S(comp4_2op),
							  .C(Co4),
							  .Co(Co3));


 compress7_2 compress7_2_inst(.X1(X1),
							  .X2(X2),
							  .X3(X3),
							  .X4(X4),
							  .X5(X5),
							  .X6(X6),
							  .X7(X7),
							  .Ci1(Ci0),
							  .Ci2(Ci1),
							  .S(comp7_2op),
							  .C(Co2),
							  .Co1(Co1),
							  .Co2(Co0));
							  
 compress3_2 compress3_2_inst(.X1(comp4_2op),
							  .X2(comp7_2op),
							  .X3(Ci4),
							  .S(S),
							  .C(C));
							  
							  
		always @(*) begin
			//$display("count=%d",count);
			$display("P[%d]=%b %b, S=%b , C=%b , Co=%b",count,{Ci4,Ci3,Ci2,Ci1,Ci0},{X1,X2,X3,X4,X5,X6,X7,X8,X9,X10},S,C,{Co4,Co3,Co2,Co1,Co0});
			// $display("P0=%b",X1);
			// $display("P1=%b",X2);
			// $display("P2=%b",X3);
			// $display("P3=%b",X4);
			// $display("P4=%b",X5);
			// $display("P5=%b",X6);
			// $display("P6=%b",X7);
			// $display("P7=%b",X8);
			// $display("P8=%b",X9);
			// $display("P9=%b",X10);
			// $display("Ci0=%b",Ci0);
			// $display("Ci1=%b",Ci1);
			// $display("Ci2=%b",Ci2);
			// $display("Ci3=%b",Ci3);
			// $display("Ci4=%b",Ci4);
			// $display("S=%b",S);
			// $display("C=%b",C);
			// $display("Co0=%b",Co0);
			// $display("Co1=%b",Co1);
			// $display("Co2=%b",Co2);
			// $display("Co3=%b",Co3);
			// $display("Co4=%b",Co4);
			// $display("");
		
		end

 
endmodule
 