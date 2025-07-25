interface spi_interface(input logic clk);
	
	// master signals 
	logic rst; //bit
	logic cs1_n; //bit
	logic cs2_n; 
	logic [7:0] data_m;
  	logic [7:0] data_s;
    logic [7:0] data_s1;
  	logic [7:0] data_s2;
  
  
	//MASTER SIGNALS
   	logic mosi;
  	logic miso;
  logic [7:0] int_mosi_m;
 
  logic  [7:0] int_miso_m; // data from salve(data_s)
  
  //SLAVE SIGNALS
	logic miso1;
   logic miso2;
  logic  [7:0] int_mosi_s1; //// data from master(data_m)
  logic  [7:0] int_mosi_s2;
  logic  [7:0] int_miso_s1; ///   data from slave
  logic  [7:0] int_miso_s2;
  
  logic [3:0] cnt;
  logic en;
// //====	clocking block & MODPORTS  ====//
  
// 	clocking driver_cb @(posedge clk);
// 	     output rst,cs1_n,cs2_n,data_m,data_s,mosi,miso,clk_o,cs1_n_out,cs2_n_out;
// 	endclocking 

// 	clocking monitor_cb @(posedge clk);
// 		input rst,cs1_n,cs2_n,data_m,data_s,mosi,miso,clk_o,cs1_n_out,cs2_n_out;
// 	endclocking

// 	modport driver (clocking driver_cb, input logic clk);
// 	modport monitor (clocking monitor_cb, input logic clk);

// //====	clocking block & MODPORTS  ====//

  
  
// 	//	// assertions  
 //After CS whether the data transferring particular slave or not  ==  working
sequence cs1_data;
  //@(cnt==9) 
  (cs1_n == 0)  ##0 (data_m == int_mosi_s1 && data_s1 == int_miso_m);
endsequence
    
sequence cs2_data;
 // @(cnt==9)  
  (cs2_n == 0) ##0 (data_m == int_mosi_s2 && data_s2 == int_miso_m);
endsequence
  
  property cs_data_tx;
    //disable iff(rst)
    (cs1_data or cs2_data);
endproperty

  assert property (@(cnt==9) cs_data_tx)
  `uvm_info("Interface", "CORRECT cs_data_tx -> 1", UVM_LOW)
  
 else
  
   `uvm_error("Interface", "DATA NOT cs_data_tx -> 1");

  
//Check single CS IS ACTIVE at a time or not == working
property cs_active;
  (cs1_n ==0 || cs2_n == 0) ##0  ($stable(cs1_n) throughout en) or ($stable(cs2_n) throughout en);
endproperty
  
  assert property(@(posedge clk) cs_active)
    `uvm_info("Interface", "CORRECT slave -> 2", UVM_LOW) 
 else 
   `uvm_error("Interface", "slave not selected -> 2");
    
      
      
//Full duplex data transferring  == working
sequence cs1;
  (cs1_n ==0) ##0 (data_m == int_mosi_s1 && data_s1 == int_miso_m);
endsequence
    
sequence cs2;
  (cs2_n == 0) ##0 (data_m == int_mosi_s2 && data_s2 == int_miso_m);
endsequence

property dt;
  (cs1 or cs2);
endproperty
    
    assert property(@(cnt ==9) dt)
     `uvm_info("Interface", "full duplex tx -> 3", UVM_LOW)  
 else
   `uvm_error("Interface", "full duplex data NOT tx -> 3");

      
      
// Based on cnt if en is high or not
      assert property(@(cnt ==9) ##0  $fell(en))
      `uvm_info("interface","EN  working -> 4",UVM_LOW)
    else
      `uvm_error("Interface", "EN NOT WORKING BASED ON COUNT  -> 4"); 
 
  
  
  
  
//For every clk MISO MOSI sampled / shift or not(check same intl reg)      
  assert property(@(posedge clk && (cs1_n ==0 || cs2_n == 0) ) ##0 (int_mosi_m) != $past(int_mosi_m))
      `uvm_info("INTERFACE","MOSI sampled  -> 5",UVM_LOW)
    else
        `uvm_error("INTERFACE", "MOSI NOT sampled  -> 5")
  
      
      
      
//	When one slave selected other should drive Z
sequence cs11;
  (cs1_n == 0) ##0 (int_miso_s2 == 1'b0);
endsequence
    
sequence cs22;
  (cs2_n == 0)##0(int_miso_s1 == 1'b0);
endsequence

property dty;
  cs11 or cs22;
endproperty
    
    assert property(@(posedge clk) dty)
        `uvm_info("INTERFACE","one slave selected other should drive Z -> 6",UVM_LOW)
    else
        `uvm_error("INTERFACE","one slave selected other NOT drive Z -> 6")      
     
      
//When both CS selected/deselected then it drives Z or not
property slaves_selected;
  (cs1_n ==0 && cs2_n == 0) |-> 
  (int_mosi_s1 == 8'b0 && int_mosi_s2 == 8'b0);
endproperty

assert property (@(posedge clk) slaves_selected)
  `uvm_info("interface"," Z driven -> 7",UVM_LOW)
    else
      `uvm_error("interface","2 slave not selected Z not driven  -> 7")
  
endinterface	

