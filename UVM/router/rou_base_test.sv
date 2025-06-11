`include "rou_env.sv"

class rou_test extends uvm_test;
  `uvm_component_utils(rou_test)
  
  rou_env env;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=rou_env::type_id::create("env",this);
  endfunction
  
  //
  virtual function void end_of_elaboration();
    print();
  endfunction
endclass