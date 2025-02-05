// Code your testbench here
// or browse Examples
// Code your design here
module tb();
  reg	[31:0]Rou_In[3:0];
  reg 	clk,rst,en;
  reg	[31:0]Rou_Out[3:0];
  
  router r1 (Rou_In,clk,rst,en,Rou_Out);
  
  always #5 clk =~clk;
  
  initial begin
   
  //  $monitor("count =%d ,out_rand[0] = %d,out_rand[1] = %d,out_rand[2] = %d,out_rand[3] = %d",r1.count,r1.out_rand[0],r1.out_rand[1],r1.out_rand[2],r1.out_rand[3]);
    clk = 1'b0;
    rst	=1'b0;
    Rou_In[0]=46;
    Rou_In[1]=57;
    Rou_In[2]=68;
    Rou_In[3]=79;
    
    #5 rst=1'b1;
    #5 rst=1'b0;
    #1000 $stop;
  end
  
  initial begin
    en =1'b0;
    #100 en=1'b1;
    #300 en=1'b0;
    #100 en=1'b1;
    
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
  end
  
endmodule