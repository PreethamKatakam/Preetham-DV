//Modified on 4/1/24
//3:2 compressor


module compress3_2(X1,X2,X3,S,C);

 input	X1;
 input	X2;
 input	X3;
 output	S;
 output	C;
 
 
 assign S = X1 ^ X2 ^ X3;
 assign C = (X1 ^ X2) ? X3 : X1;
 
endmodule
 