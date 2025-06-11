//Modified on 4/1/24
//4:2 compressor


module compress4_2(X1,X2,X3,X4,Ci,S,C,Co);

 input	X1;
 input	X2;
 input	X3;
 input	X4;
 input	Ci;				//carry input
 
 output	S;
 output	C;
 output	Co;				//carry output
 
 assign C  = (X1 ^ X2 ^ X3 ^ X4) ? Ci : X4;
 assign S  = X1 ^ X2 ^ X3 ^ X4 ^ Ci;
 assign Co = (X1 ^ X2) ? X3 : X1;
 
endmodule
 