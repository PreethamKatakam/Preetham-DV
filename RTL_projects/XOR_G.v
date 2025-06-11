module XOR_G (A,B,Y);

input A,B;
output Y;

wire w1 ,w2;

assign w1= A & (!B) ;
assign w2= (!A) & B ;

assign Y= w1 | w2;

endmodule