
class apb_test4 extends uvm_test;
`uvm_component_utils(apb_test4)
apb_env env;
apb_seq seq;

function new(string name="apb_test4",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=apb_env::type_id::create("env",this);
seq=apb_seq::type_id::create("seq",this);
set_config_string("env.a1.seqr","cfg","WR_RD");
set_config_string("env.a1.seqr","data_type","increment");
set_config_string("env.a1.seqr","addr_type","decrement");
endfunction

task run_phase(uvm_phase phase);
begin
phase.raise_objection(this,"start of test");
seq.start(env.a1.seqr);
#20;
phase.drop_objection(this,"end of test");
end
endtask
endclass
