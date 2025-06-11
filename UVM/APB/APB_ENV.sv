class apb_env extends uvm_env;
`uvm_component_utils(apb_env)
apb_agent1 a1;
apb_agent2 a2;
apb_sb sb;
function new(string name="apb_env",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
a1=apb_agent1::type_id::create("a1",this);
a2=apb_agent2::type_id::create("a2",this);
sb=apb_sb::type_id::create("sb",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a1.mon1.item_collected_port.connect(sb.ip_fifo.analysis_export);
a2.mon2.item_collected_port1.connect(sb.op_fifo.analysis_export);
endfunction
endclass

