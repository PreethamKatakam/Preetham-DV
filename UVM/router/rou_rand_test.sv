class rou_rand_test extends rou_test;
  `uvm_component_utils(rou_rand_test)
  
  rou_seq seq;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=rou_seq::type_id::create("seq",this);
  endfunction
  
  //run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,50);
    
  endtask
endclass