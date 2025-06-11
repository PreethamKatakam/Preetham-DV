//`include mem_seq_item.sv
class seq_item2 extends mem_seq_item;
  
  `uvm_object_utils(seq_item2)
  
  function new(string name ="seq_item2");
    super.new(name);    
  endfunction
  
  constraint c1{data_in inside {[100:200]};}  
  
endclass