`timescale 1ns / 1ps
//includes
`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"

//`define 8_bit
//`define 16_bit
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Praveen Bohra
// Create Date:    11:22:49 12/12/2023 
// Design Name: 
// Module Name:    pp_gen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Generates m/2 partial Products.
// Dependencies: 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`ifdef bit_8
module pp_gen(x_in,w_in,pp_row0,pp_row1,pp_row2,pp_row3);
`else
module pp_gen(x_in,w_in,pp_row0,pp_row1,pp_row2,pp_row3,pp_row4,pp_row5,pp_row6,pp_row7);
`endif


//Port Declaration

input 	[`M-1:0]	x_in,w_in;

//output 	[19:0]	pp_row0,pp_row1,pp_row2,pp_row3,pp_row4,pp_row5,pp_row6,pp_row7;
`ifdef bit_8
	output 	[10:0]	pp_row0,pp_row1,pp_row2,pp_row3;
`else
	output 	[18:0]	pp_row0,pp_row1,pp_row2,pp_row3,pp_row4,pp_row5,pp_row6,pp_row7;
`endif

// Data Type
wire [(`M/2)-1:0] neg,one,two,tau,es;
wire [(`M/2)-2:0] c;

wire 	   na	[(`M/2)-1:0][`M:0];	
wire       pp   [(`M/2)-1:0][`M:1];

//Code Starts
//##################### neg ######################/
assign neg[0] = w_in[1];
genvar i;
generate
begin
	for(i=1; i<=(`M/2)-1; i=i+1) begin
		assign neg[i] = (w_in[2*i + 1] & ((!w_in[2*i]) | (!w_in[2*i-1])));
	end	
end	
endgenerate

//##################### one ######################/
assign one[0] = w_in[0];
genvar j;
generate
begin
	for(j=1; j<=(`M/2)-1; j=j+1) begin
		assign one[j] = (w_in[2*j] ^ w_in[2*j - 1]);
	end
end	
endgenerate

//##################### two ######################/
assign two[0] = w_in[1] & (!w_in[0]);
genvar k;
generate
begin
	for(k=1; k<=(`M/2)-1; k=k+1) begin
		assign two[k] = ((!w_in[2*k + 1]) & w_in[2*k] & w_in[2*k - 1]) |
						(w_in[2*k + 1] & (!w_in[2*k]) & (!w_in[2*k - 1]));
	end	
end	
endgenerate
//##################### na(ij) ######################/
genvar l,m;
generate
begin
	for(l=0; l<=(`M/2)-1; l=l+1) begin
		for(m=0; m<=`M-1; m=m+1) begin
			assign na[l][m] = !(x_in[m] ^ w_in[2*l + 1]);
		end
	end	
end	
endgenerate	
genvar o;
generate
begin
	for(o=0; o<=(`M/2)-1; o=o+1) begin
		assign na[o][`M] = na[o][`M-1];
	end	
end	
endgenerate	
//##################### p(ij) ######################/	
genvar p,q;
generate
begin
	for(p=0; p<=(`M/2)-1; p=p+1) begin
		for(q=1; q<=`M; q=q+1) begin
			assign pp[p][q] = !((na[p][q-1] | (!two[p])) & (na[p][q] | (!one[p])));
		end
	end	
end	
endgenerate	
//##################### tau ######################/
genvar r;
generate
begin
	for(r=0; r<=(`M/2)-1; r=r+1) begin
		assign tau[r] = one[r] & x_in[0];
	end	
end	
endgenerate
//##################### c ######################/
genvar s;
generate
begin
	for(s=0; s<=(`M/2)-2; s=s+1) begin
		assign c[s] = neg[s] & ((!one[s]) | (!x_in[0]));
	end	
end	
endgenerate
//##################### Ebar ######################/
assign ebar = (x_in[0] & w_in[`M-1]) ? x_in[1] : (!x_in[1]);
//##################### t1 ######################/
assign t1 = !(((!one[(`M/2)-1]) | ebar) & ((!two[(`M/2)-1]) | (!x_in[0])));
//##################### dbar ######################/	
assign dbar = !((!((!w_in[`M-1]) | x_in[0])) & !((w_in[`M-3] | x_in[1]) & (w_in[`M-2] | x_in[1]) & (w_in[`M-2] | w_in[`M-3])));
//##################### es ######################/
genvar u;
generate
begin
	for(u=0; u<=(`M/2)-1; u=u+1) begin
		assign es[u] = pp[u][`M];
	end	
end	
endgenerate
//##################### alpha ######################/
assign alpha2 = !(es[0] & dbar);
assign alpha1 =  (es[0] & dbar);
assign alpha0 = !(es[0] ^ dbar);
//##################### partial Products ######################/
`ifdef bit_8
	assign pp_row0 = {alpha2,alpha1,alpha0,pp[0][7],pp[0][6],pp[0][5],pp[0][4],pp[0][3],pp[0][2],pp[0][1],tau[0]};
	//assign pp_row0 = {alpha2,alpha1,alpha0,pp[0][0:1],tau[0]};
	assign pp_row1 = {1'b1,(!es[1]),pp[1][7],pp[1][6],pp[1][5],pp[1][4],pp[1][3],pp[1][2],pp[1][1],tau[1],c[0]};
	assign pp_row2 = {1'b1,(!es[2]),pp[2][7],pp[2][6],pp[2][5],pp[2][4],pp[2][3],pp[2][2],pp[2][1],tau[2],c[1]};
	assign pp_row3 = {1'b1,(!es[3]),pp[3][7],pp[3][6],pp[3][5],pp[3][4],pp[3][3],pp[3][2],t1,tau[3],c[2]};				  
`else
	assign pp_row0 = {alpha2,alpha1,alpha0,pp[0][15],pp[0][14],pp[0][13],pp[0][12],pp[0][11],pp[0][10],pp[0][9],pp[0][8],pp[0][7],pp[0][6],pp[0][5],pp[0][4],pp[0][3],pp[0][2],pp[0][1],tau[0]};
	assign pp_row1 = {1'b1,(!es[1]),pp[1][15],pp[1][14],pp[1][13],pp[1][12],pp[1][11],pp[1][10],pp[1][9],pp[1][8],pp[1][7],pp[1][6],pp[1][5],pp[1][4],pp[1][3],pp[1][2],pp[1][1],tau[1],c[0]};
	assign pp_row2 = {1'b1,(!es[2]),pp[2][15],pp[2][14],pp[2][13],pp[2][12],pp[2][11],pp[2][10],pp[2][9],pp[2][8],pp[2][7],pp[2][6],pp[2][5],pp[2][4],pp[2][3],pp[2][2],pp[2][1],tau[2],c[1]};
	assign pp_row3 = {1'b1,(!es[3]),pp[3][15],pp[3][14],pp[3][13],pp[3][12],pp[3][11],pp[3][10],pp[3][9],pp[3][8],pp[3][7],pp[3][6],pp[3][5],pp[3][4],pp[3][3],pp[3][2],pp[3][1],tau[3],c[2]};
	assign pp_row4 = {1'b1,(!es[4]),pp[4][15],pp[4][14],pp[4][13],pp[4][12],pp[4][11],pp[4][10],pp[4][9],pp[4][8],pp[4][7],pp[4][6],pp[4][5],pp[4][4],pp[4][3],pp[4][2],pp[4][1],tau[4],c[3]};
	assign pp_row5 = {1'b1,(!es[5]),pp[5][15],pp[5][14],pp[5][13],pp[5][12],pp[5][11],pp[5][10],pp[5][9],pp[5][8],pp[5][7],pp[5][6],pp[5][5],pp[5][4],pp[5][3],pp[5][2],pp[5][1],tau[5],c[4]};
	assign pp_row6 = {1'b1,(!es[6]),pp[6][15],pp[6][14],pp[6][13],pp[6][12],pp[6][11],pp[6][10],pp[6][9],pp[6][8],pp[6][7],pp[6][6],pp[6][5],pp[6][4],pp[6][3],pp[6][2],pp[6][1],tau[6],c[5]};
	assign pp_row7 = {1'b1,(!es[7]),pp[7][15],pp[7][14],pp[7][13],pp[7][12],pp[7][11],pp[7][10],pp[7][9],pp[7][8],pp[7][7],pp[7][6],pp[7][5],pp[7][4],pp[7][3],pp[7][2],t1,tau[7],c[6]};			  
`endif
				  
endmodule // pp_gen