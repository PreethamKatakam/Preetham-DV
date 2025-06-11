class mem_seq_item extends uvm_sequence_item;
  
  randc bit [3:0] addr;
  rand bit we;
  rand bit [7:0] data_in;
  
  bit [7:0] data_out;
  
  static int count=16;
  
  `uvm_object_utils_begin(mem_seq_item)
  	`uvm_field_int(addr,UVM_ALL_ON)
  	`uvm_field_int(we,UVM_ALL_ON)
  	`uvm_field_int(data_in,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name ="mem_seq_item");
    super.new(name);    
  endfunction
  
//   constraint c1{if(count <= 0)
//   				{
//   				we == 0;
//                 }
//     			else we ==1;
//                }
  
//   function void post_randomize();
//     count = count-1;
//   endfunction
  
  
endclass