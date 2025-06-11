`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Praveen Bohra
// Create Date:    11:22:49 09/01/2024 
// Design Name: 
// Module Name:    tb_compress4_2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Test Bench AMM(Addtive Multiplier module)
// Dependencies: 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tb_compress4_2;

wire  [5:1] X; 
wire        C,Cout,S;
wire [1:0] carry;
reg         reset;

// Instantiate the majority Logic full adder module
compress4_2 COMP_4_2(
					 .X1		(X[1]),
					 .X2		(X[2]),
					 .X3		(X[3]),
					 .X4		(X[4]),
					 .Ci		(X[5]),
					 .S			(S),
					 .C			(C),
					 .Co		(Cout)
					 );

// Clock generation (for testbench purposes)
reg clk = 0;
always #5 clk = ~clk;

reg [4:0] count = 0;
always @(posedge clk)
begin
	if(reset)
		count <= 0;
	else
	count <= count + 1;
end

assign X  = count[4:0]; 

wire [2:0] result,golden_result;
assign carry[1:0] = C + Cout;
assign result[2:0]        = {carry,S};
assign golden_result[2:0] = X[1] + X[2] + X[3] + X[4] + X[5]  ;

// Calculating Diffrence
reg [2:0] difference; 
always @(*)
begin
  if (result > golden_result)
    difference     = result - golden_result;
  else  
    difference     = golden_result - result;
end      

// Testbench stimulus
integer f,g,h;
initial begin
	reset = 1'b1;
	repeat (1) @ (posedge clk);
	reset = 1'b0;
	
    f = $fopen("../SIMULATION/result/AMM_output.txt");
    g = $fopen("../SIMULATION/result/AMM_golden.txt");
    h = $fopen("../SIMULATION/result/AMM_diffrence.txt");
	  
repeat (32) @ (posedge clk) begin
	  $fwrite(f," %0d \n",$unsigned(result));
      $fwrite(g," %0d \n",$unsigned(golden_result));
      $fwrite(h," %0d \n",$unsigned(difference));
end

$fclose(f);  
$fclose(g);
$fclose(h);

#10 $stop;
end

endmodule //tb_compress4_2