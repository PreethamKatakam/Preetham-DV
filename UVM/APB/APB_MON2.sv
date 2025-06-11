class apb_mon2 extends uvm_monitor;
`uvm_component_utils(apb_mon2)
apb_seq_item pkt;
virtual apb_if intf;

uvm_analysis_port #(apb_seq_item)item_collected_port1;

function new(string name="apb_mon2",uvm_component parent);
super.new(name,parent);
item_collected_port1=new("item_collected_port1",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_db#(virtual apb_if)::get(this," ","intf",intf);
endfunction

task run_phase(uvm_phase phase);
pkt=apb_seq_item::type_id::create("pkt");
forever
begin
@(posedge intf.pclk)
pkt.pready<=intf.pready;
pkt.prdata<=intf.prdata;
`uvm_info("MON2",$sformatf("pready=%p,prdata=%p",pkt.pready,pkt.prdata),UVM_NONE);
item_collected_port1.write(pkt);
end
endtask
endclass

