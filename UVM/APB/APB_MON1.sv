class apb_mon1 extends uvm_monitor;
`uvm_component_utils(apb_mon1)
apb_seq_item pkt;
virtual apb_if intf;
bit[7:0] q[$];
uvm_analysis_port #(apb_seq_item)item_collected_port;//item_collected_port is user defined handle name of uvm_analysis_port

function new(string name="apb_mon1",uvm_component parent);
super.new(name,parent);
item_collected_port=new("item_collected_port",this);
endfunction 

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_db#(virtual apb_if)::get(this,"","intf",intf);// get
endfunction

task run_phase(uvm_phase phase);
pkt=apb_seq_item::type_id::create("pkt");
forever
begin

pkt.pwdata<=intf.pwdata;
pkt.paddr<=intf.paddr;
pkt.pwrite<=intf.pwrite;
@(posedge intf.pclk)
pkt.psel<=intf.psel;
pkt.pen<=intf.pen;

begin
#10
q.push_front(pkt.pwdata);
#20
if(pkt.pwrite==0)
begin
pkt.prdata=q.pop_front();
end
end
`uvm_info("MON1",$sformatf("pwdata=%p,paddr=%p,pwrite=%p",pkt.pwdata,pkt.paddr,pkt.pwrite),UVM_NONE);
item_collected_port.write(pkt);
//end
end
endtask
endclass

