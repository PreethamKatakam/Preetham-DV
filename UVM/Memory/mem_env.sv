`include "mem_agent.sv"
`include "mem_sb.sv"
class mem_env extends uvm_env;
  `uvm_component_utils(mem_env)
  
  
  mem_agent agent;
  mem_sb	sb;
  
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = mem_agent::type_id::create("agent",this);
    sb= mem_sb::type_id::create("sb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agent.mon.item_col_port.connect(sb.item_col_export);
    
  endfunction
  
  
  
  
endclass