interface rou_if(input logic clk,rst);
  
  logic en;
  logic [31:0] Rou_In[3:0];//0, Rou_In1, Rou_In2, Rou_In3;
  logic [31:0] Rou_Out[3:0];//, Rou_Out1, Rou_Out2, Rou_Out3;
  
  
  logic [1:0] out_rand0;
  logic [1:0] out_rand1;
  logic [1:0] out_rand2;
  logic [1:0] out_rand3;
  
  
  clocking driver_cb@(posedge clk);
    default input #1 output #1;
    
    output en;
    output Rou_In;
    input Rou_Out;    
  endclocking
  
  
  clocking monitor_cb@(posedge clk);
    default input #1 output #1;
    
    input en;
    input Rou_In;
    input Rou_Out;    
  endclocking
  
  modport DRIVER(clocking driver_cb, input clk, rst);
  
  modport MONITOR(clocking monitor_cb, input clk, rst);
    
    
endinterface