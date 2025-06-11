class qr_seq_item extends uvm_sequence_item;
  
  rand bit      rst_b;
  rand bit      accept_s;	
  rand bit		 [3:0] data_s;	
  rand bit		 final_s;		
  rand bit		 create_b;		
  bit		 [10:0] qr; 
  
  
  
  `uvm_object_utils_begin(qr_seq_item)
  	`uvm_field_int(rst_b,UVM_ALL_ON)
  	`uvm_field_int(accept_s,UVM_ALL_ON)
  	`uvm_field_int(data_s,UVM_ALL_ON)
  	`uvm_field_int(final_s,UVM_ALL_ON)
  	`uvm_field_int(create_b,UVM_ALL_ON)  
  `uvm_object_utils_end
  
  
  
  function new(string name="qr_seq_item");
    super.new(name);
  endfunction
  
  
endclass
    
    
  
  
  
  