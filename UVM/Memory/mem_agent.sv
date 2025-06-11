`include "mem_seq_item.sv"
`include "mem_seq.sv"
`include "mem_seqr.sv"
`include "mem_drv.sv"
`include "mem_mon.sv"

class mem_agent extends uvm_agent;
  `uvm_component_utils(mem_agent)
  
  mem_seqr seqr;
  mem_drv drv;
  mem_mon mon;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = mem_mon::type_id::create("mon",this);
    drv = mem_drv::type_id::create("drv",this);
    seqr = mem_seqr::type_id::create("seqr",this);    
  endfunction
   
   function void connect_phase(uvm_phase phase);
     drv.seq_item_port.connect(seqr.seq_item_export);     
   endfunction
  
endclass