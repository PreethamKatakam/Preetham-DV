interface m_intf(input logic clk);
  
  logic we;
  logic [3:0] addr; //has 16 address loactions
  logic [7:0] data_in;
  logic [7:0] data_out;
  
  logic [7:0]m_m[15:0]; //16x8 memory
  
  
  clocking drv_ck @ (posedge clk);
	output we,addr,data_in;
	input data_out;
endclocking
  
  clocking mon_ck @ (posedge clk);
	input we,addr,data_in;
	input data_out;
endclocking
  
endinterface