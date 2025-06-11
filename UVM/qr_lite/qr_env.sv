`include "qr_sb.sv"
`include "qr_agent.sv"

class qr_env extends uvm_env;
  
  `uvm_component_utils(qr_env);
  
  qr_agent agent;
  qr_sb sb;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = qr_agent::type_id::create("agent",this);
    sb = qr_sb::type_id::create("sb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.ap.connect(sb.ap_imp);
  endfunction
  
  
  
endclass