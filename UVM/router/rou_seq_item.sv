class rou_seq_item extends uvm_sequence_item;

  
  rand bit [31:0] Rou_In0, Rou_In1, Rou_In2, Rou_In3 ;
  rand bit en;
  bit rst;
  bit [31:0] Rou_Out0, Rou_Out1, Rou_Out2, Rou_Out3;
  bit [1:0] out_rand0,out_rand1,out_rand2,out_rand3;
	
  
  `uvm_object_utils_begin(rou_seq_item)
  	`uvm_field_int(Rou_In0,UVM_ALL_ON)
  	`uvm_field_int(Rou_In1,UVM_ALL_ON)
  	`uvm_field_int(Rou_In2,UVM_ALL_ON)
  	`uvm_field_int(Rou_In3,UVM_ALL_ON)
  	`uvm_field_int(en,UVM_ALL_ON)
  	`uvm_field_int(rst,UVM_ALL_ON)
  	`uvm_field_int(Rou_Out0,UVM_ALL_ON)
  	`uvm_field_int(Rou_Out1,UVM_ALL_ON)
  	`uvm_field_int(Rou_Out2,UVM_ALL_ON)
  	`uvm_field_int(Rou_Out3,UVM_ALL_ON)    
  	`uvm_field_int(out_rand0,UVM_ALL_ON)
  	`uvm_field_int(out_rand1,UVM_ALL_ON)
  	`uvm_field_int(out_rand2,UVM_ALL_ON)
  	`uvm_field_int(out_rand3,UVM_ALL_ON)    
  `uvm_object_utils_end
  
  function new(string name="rou_seq_item");
    super.new(name);
  endfunction
  
  constraint c1{en == 1;
                Rou_In0 inside {[0:9999]};
                Rou_In1 inside {[0:9999]};
                Rou_In2 inside {[0:9999]};
                Rou_In3 inside {[0:9999]};}
   
  
endclass