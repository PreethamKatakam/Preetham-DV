`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Praveen Bohra
// Create Date:    11:22:49 09/01/2024 
// Design Name: 
// Module Name:    tb_compress3_2 
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
module tb_compress3_2;

//ompress3_2(X1,X2,X3,S,C);
wire  [3:1] X; 
wire        C,S;
reg         reset;

// Instantiate the majority Logic full adder module
compress3_2 COMP_3_2(
					 .X1		(X[1]),
					 .X2		(X[2]),
					 .X3		(X[3]),
					 .S			(S),
					 .C			(C)
					 );

// Clock generation (for testbench purposes)
reg clk = 0;
always #5 clk = ~clk;

reg [2:0] count = 0;
always @(posedge clk)
begin
	if(reset)
		count <= 0;
	else
	count <= count + 1;
end

assign X  = count[2:0]; 

wire [1:0] result,golden_result;
assign result[1:0]        = {C,S};
assign golden_result[1:0] = X[1] + X[2] + X[3] ;

// Calculating Diffrence
reg [1:0] difference; 
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
	  
repeat (8) @ (posedge clk) begin
	  $fwrite(f," %0d \n",$unsigned(result));
      $fwrite(g," %0d \n",$unsigned(golden_result));
      $fwrite(h," %0d \n",$unsigned(difference));
end

$fclose(f);  
$fclose(g);
$fclose(h);

#10 $stop;
end

endmodule //tb_compress3_2 