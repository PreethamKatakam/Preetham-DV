`include "qr_seq_item.sv"
`include "qr_seq.sv"
`include "qr_env.sv"

class qr_base_test extends uvm_test;
  `uvm_component_utils(qr_base_test)
  
  qr_env env;
  qr_seq seq;
  function new(string name, uvm_component parent);
    super.new(name,parent);
   // seq=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = qr_env::type_id::create("env",this);
    seq = qr_seq::type_id::create("seq",this);
    
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    //#10;
    phase.drop_objection(this);
  endtask
endclass