 class apb_drv extends uvm_driver #(apb_seq_item);
`uvm_component_utils(apb_drv)

virtual apb_if intf;
apb_seq_item pkt;
function new(string name="apb_drv",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_db#(virtual apb_if)::get(this,"*","intf",intf);
endfunction

task run_phase(uvm_phase phase);
pkt=apb_seq_item::type_id::create("pkt");
forever
#10
begin
seq_item_port.get_next_item(pkt);

intf.pwdata<=pkt.pwdata;
intf.paddr<=pkt.paddr;
intf.pwrite<=pkt.pwrite;
intf.psel<=pkt.psel;
intf.pen<=pkt.pen;
//intf.prdata = pkt.prdata;// changed it
//#10
//intf.psel=1;
//intf.pen=1;

seq_item_port.item_done();
end
endtask
endclass

