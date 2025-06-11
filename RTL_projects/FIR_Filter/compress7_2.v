//Modified on 4/1/24
//7:2 compressor


module compress7_2(X1,X2,X3,X4,X5,X6,X7,Ci1,Ci2,S,C,Co1,Co2);

 input	X1;
 input	X2;
 input	X3;
 input	X4;
 input	X5;
 input	X6;
 input	X7;
 input	Ci1;				//carry input
 input	Ci2;				//carry input
 
 output	S;
 output	C;
 output	Co1;				//carry output
 output	Co2;				//carry output
 
 wire m1,m2,m3,m4;
 // wire 	p,q,r; 
 // assign p	= X1 ^ X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7;
 // assign q	= (X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7) ? X1 : (X2 ^ X3 ^ X4);
 // assign r	= (X2 ^ X3) ? X4 : X3;  
 // assign S	= p ^ Ci1 ^ Ci2;
 // assign C	= (p ^ Ci2) ? Ci1 : p;
 // assign Co1	= (r ^ ((X5 ^ X6) ? X7 : X5)) ? r : q;
 // assign Co2	= q ^ r ^ ((X5 ^ X6) ? X7 : X5);
 
 
 assign S	= X1 ^ X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7 ^ Ci1 ^ Ci2;
 assign C	= (X1 ^ X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7 ^ Ci2) ? Ci1 : X1 ^ X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7;
 assign m1	= (X2 ^ X3) ? X4 : X3;
 assign m2	= (X5 ^ X6) ? X7 : X5;
 assign m3	= m1 ^ m2;
 assign m4 	= (X2 ^ X3 ^ X4 ^ X5 ^ X6 ^ X7) ? X1 : X2 ^ X3 ^ X4;
 assign Co2	= m3 ? m4 : m1;
 assign Co1 = m3 ^ m4;
 
endmodule

