`include "agent.sv"
`include "scoreboard.sv"

class aes_env extends uvm_env;
  aes_agent       agent;
  aes_scoreboard  scoreboard;

  `uvm_component_utils(aes_env)

  function new(string name = "aes_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent      = aes_agent::type_id::create("agent", this);
    scoreboard = aes_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.mon_ap.connect(scoreboard.item_collected_export);
  endfunction
endclass
