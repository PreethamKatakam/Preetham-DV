`include "rou_agent.sv"
`include "rou_scoreboard.sv"

class rou_env extends uvm_env;
  rou_agent agent;
  rou_sb sb;
  
  `uvm_component_utils(rou_env)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = rou_agent::type_id::create("agent",this);
    sb = rou_sb::type_id::create("sb",this);
    
  endfunction
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    agent.monitor.item_collected_port.connect(sb.item_collected_export);
  endfunction
    
endclass
