`include "qr_seqr.sv"
`include "qr_driver.sv"
`include "qr_monitor.sv"
class qr_agent extends uvm_agent;
  
  
  `uvm_component_utils(qr_agent)
  
  qr_seqr seqr;
  qr_driver drv;
  qr_monitor mon;
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = qr_seqr::type_id::create("seqr",this);
    drv = qr_driver::type_id::create("drv",this);
    mon = qr_monitor::type_id::create("mon",this);
    
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    //super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass