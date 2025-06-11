module COMP_2B(A,B,L_AB,EQ_AB,G_AB);

input [1:0] A,B;
output L_AB,EQ_AB,G_AB;

assign EQ_AB = !(A[0]^B[0]) & !(A[1]^B[1]);
assign G_AB  = (A[1] & !B[1]) | (A[0] & !B[1] & !B[0]) | (A[1] & A[0] & !B[0]);
assign L_AB  = (!A[1] & B[1]) | (!A[0] & B[1] & B[0]) | (!A[1] & !A[0] & B[0]);

endmodule