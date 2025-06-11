// Code your tb here
//TB
class a;
  rand bit [1:0] out_r [4];
  
  constraint c1 {unique{out_r};}
  
endclass


module tb();
  reg	[31:0]Rou_In[3:0];
  reg 	clk,rst;
  reg	[3:0] out_rand[3:0];
  reg [9:0]count;	
  
  wire	[31:0]Rou_Out[3:0];
  a a1;
  always #5 clk =~clk;
  
  
  always @(posedge clk) begin
    if(rst)
      count <= 1'b0;
    else
      count <= count+1;
  end
  
  always @(posedge clk) begin
    if(count%4 == 0) begin
      a1 = new();
      a1.randomize();
      out_rand[0] <= a1.out_r[0];
      out_rand[1] <= a1.out_r[1];
      out_rand[2] <= a1.out_r[2];
      out_rand[3] <= a1.out_r[3];
      $display("ola out_rand[0] = %d,out_rand[1] = %d,out_rand[2] = %d,out_rand[3] = %d",out_rand[0],out_rand[1],out_rand[2],out_rand[3]);
    end
  end 
  
  initial begin
    $monitor("coun =%d ,out_rand[0] = %d,out_rand[1] = %d,out_rand[2] = %d,out_rand[3] = %d",count,out_rand[0],out_rand[1],out_rand[2],out_rand[3]);
    clk = 1'b0;
    count = 0;
    #2000 $stop;
  end
  
  
  
  
  
  
  
  
  
  //Design
  // Code your testbench here
// or browse Examples

module router (Rou_In,clk,out_rand,Rou_Out);
  input 		[31:0]Rou_In[3:0];
  input 		 clk;
  input 		[1:0] out_rand[3:0];
  output	reg [31:0]Rou_Out[3:0];
  
  
  
  always @(posedge clk) begin
    //if(count%4 == 0) begin
      Rou_Out[0] <= Rou_In[out_rand[0]];
      Rou_Out[1] <= Rou_In[out_rand[1]];
      Rou_Out[2] <= Rou_In[out_rand[2]];
      Rou_Out[3] <= Rou_In[out_rand[3]];
    //end
  end 
  
endmodule
  
endmodule