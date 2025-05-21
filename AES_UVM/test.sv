`include "environment.sv"

class aes_test extends uvm_test;
  aes_env env;

  `uvm_component_utils(aes_test)

  function new(string name = "aes_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = aes_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    aes_base_sequence seq;

    phase.raise_objection(this);
    seq = aes_base_sequence::type_id::create("seq");
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
endclass
