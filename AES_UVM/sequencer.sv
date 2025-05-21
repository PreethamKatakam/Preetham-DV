class aes_sequencer extends uvm_sequencer #(aes_sequence_item);
  // Utility macros
  `uvm_component_utils(aes_sequencer)
  
  // Constructor
  function new(string name = "aes_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase - Configure sequencer parameters
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
endclass
