`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class aes_agent extends uvm_agent;
  aes_driver    drv;
  aes_monitor   mon;
  aes_sequencer seqr;

  `uvm_component_utils(aes_agent)

  function new(string name = "aes_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = aes_sequencer::type_id::create("seqr", this);
    drv  = aes_driver::type_id::create("drv", this);
    mon  = aes_monitor::type_id::create("mon", this);
  endfunction

  // connect phase 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass