class mem_seqr extends uvm_sequencer#(mem_seq_item);
  
  `uvm_component_utils(mem_seqr)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);    
  endfunction  
endclass