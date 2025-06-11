module compress10_2_tb();

`include "D:/VLSI Project/RTL codes/FIR Filter/RTL/define.vh"

 // reg	X1;
 // reg	X2;
 // reg	X3;
 // reg	X4;
 // reg	X5;
 // reg	X6;
 // reg	X7;
 // reg	X8;
 // reg	X9;
 // reg	X10;
 // reg	Ci0;				//carry reg
 // reg	Ci1;				//carry reg
 // reg	Ci2;				//carry reg
 // reg	Ci3;				//carry reg
 // reg	Ci4;				//carry reg
 
 wire	[15:1] X;
 //reg	[4:0] Ci;
 
 wire	S;
 wire	C;
 wire	Co0;				//carry wire
 wire	Co1;				//carry wire
 wire	Co2;				//carry wire
 wire	Co3;				//carry wire
 wire	Co4;				//carry wire
 
 wire [1:0] carry;
wire [2:0] carry1;
wire [2:0] carry2;
reg         reset;

 
 
 compress10_2 compress10_2_inst(.X1(X[1]),
							  .X2(X[2]),
							  .X3(X[3]),
							  .X4(X[4]),
							  .X5(X[5]),
							  .X6(X[6]),
							  .X7(X[7]),
							  .X8(X[8]),
							  .X9(X[9]),
							  .X10(X[10]),
							  .Ci0(X[11]),
							  .Ci1(X[12]),
							  .Ci2(X[13]),
							  .Ci3(X[14]),
							  .Ci4(X[15]),
							  .S(S),
							  .C(C),
							  .Co0(Co0),
							  .Co1(Co1),
							  .Co2(Co2),
							  .Co3(Co3),
							  .Co4(Co4));
							  			
	
// Clock generation (for testbench purposes)
reg clk = 0;
always #5 clk = ~clk;

reg [14:0] count = 0;
always @(posedge clk)
begin
	if(reset)
		count <= 0;
	else
	count <= count + 1;
end

assign X  = count[14:0]; 

wire [3:0] result,golden_result;

assign carry [1:0]  = Co3+Co4+C;
assign carry1[2:0]  = {Co0,1'b0}+Co2+Co1; 
assign carry2[2:0]  = carry1+carry; 
assign result[3:0]={carry2,S};
assign golden_result[3:0] = X[1] + X[2] + X[3] + X[4] + X[5] + X[6] + X[7] + X[8] + X[9] + X[10] + X[11] + X[12] + X[13] + X[14] + X[15]  ;

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
integer f,g,h,l;
initial begin
	reset = 1'b1;
	repeat (1) @ (posedge clk);
	reset = 1'b0;
	
    f = $fopen("../SIMULATION/result/AMM_output.txt");
    g = $fopen("../SIMULATION/result/AMM_golden.txt");
    h = $fopen("../SIMULATION/result/AMM_diffrence.txt");
    l = $fopen("../SIMULATION/result/AMM_ip_op.txt");
	  
repeat (33536) @ (posedge clk) begin
	  $fwrite(f," %0d \n",$unsigned(result));
      $fwrite(g," %0d \n",$unsigned(golden_result));
      $fwrite(h," %0d \n",$unsigned(difference));
      $fwrite(l," %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t \n",$unsigned(X),Co0,Co1,Co2,Co3,Co4,C,S);
end

$fclose(f);  
$fclose(g);
$fclose(h);

#10 $stop;
end
	
  
	

	
endmodule