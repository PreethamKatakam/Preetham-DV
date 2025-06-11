class rou_seqr extends uvm_sequencer#(rou_seq_item);

  `uvm_component_utils(rou_seqr)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
endclass