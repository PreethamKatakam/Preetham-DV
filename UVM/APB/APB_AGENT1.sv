 class apb_agent1 extends uvm_agent;
`uvm_component_utils(apb_agent1)
apb_seqr seqr;
apb_drv drv;
apb_mon1 mon1;
virtual apb_if intf;

function new(string name="apb_agent1",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
seqr=apb_seqr::type_id::create("seqr",this);
drv=apb_drv::type_id::create("drv",this);
mon1=apb_mon1::type_id::create("mon1",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
drv.seq_item_port.connect(seqr.seq_item_export);//doubt
endfunction
endclass

