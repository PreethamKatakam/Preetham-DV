`include "rou_seq_item.sv"
`include "rou_seq.sv"
`include "rou_seqr.sv"
`include "rou_driver.sv"
`include "rou_mon.sv"

class rou_agent extends uvm_agent;
  rou_driver drv;
  rou_mon monitor;
  rou_seqr seqr;
  
  `uvm_component_utils(rou_agent)
  
  function new(string name="rou_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //build_phase
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor=rou_mon::type_id::create("monitor",this);
    
    if(get_is_active() == UVM_ACTIVE) begin
      drv=rou_driver::type_id::create("drv",this);
      seqr=rou_seqr::type_id::create("seqr",this);
    end
    
  endfunction
  
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end    
  endfunction
  
  
endclass
