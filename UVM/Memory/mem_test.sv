`include "mem_env.sv"

class mem_test extends uvm_test;
  `uvm_component_utils(mem_test)
  
  mem_env env;
  mem_seq seq;
  
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=mem_env::type_id::create("env",this);
    seq=mem_seq::type_id::create("seq",this);
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,50);
    
  endtask
    
  
  
endclass