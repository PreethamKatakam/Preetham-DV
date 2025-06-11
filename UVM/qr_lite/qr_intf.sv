interface qr_intf(input logic clk);
  logic      rst_b;
  logic      accept_s;	
  logic		 [3:0] data_s;	
  logic		 final_s;		
  logic		 create_b;		
  logic		 [10:0] qr; 
  
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output accept_s;
	output	data_s;
	output	final_s;
	output	create_b;
	input	qr;
    
  endclocking
  
  
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input 	accept_s;
	input	data_s;
	input	final_s;
	input	create_b;
	input	qr;
    
  endclocking
  
  
  
  modport DR(clocking driver_cb, input clk);
  modport MON(clocking monitor_cb, input clk);
    
endinterface