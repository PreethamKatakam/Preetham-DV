class apb_seq extends uvm_sequence#(apb_seq_item);

apb_seq_item pkt;

bit [7:0]pwdata;
bit [7:0]paddr;
int i,j;
int num_txns;
logic [7:0]user_data[8]='{6,10,8,7,12,15,54,11};
logic [7:0]user_addr[8]='{67,90,8,54,99,43,6,12};
logic [7:0]constant_data=40;
string data_type;
string addr_type;
string cfg;
`uvm_declare_p_sequencer(apb_seqr)

`uvm_object_utils_begin(apb_seq)
	`uvm_field_string(cfg,UVM_DEFAULT)
	`uvm_field_string(data_type,UVM_DEFAULT)
	`uvm_field_string(addr_type,UVM_DEFAULT)
`uvm_object_utils_end

function new(string name="apb_seq");
super.new(name);
i=0;
j=0;
num_txns=20;
endfunction

virtual task body();
pkt=apb_seq_item::type_id::create("pkt");



void'(p_sequencer.get_config_string("cfg",cfg));
void'(p_sequencer.get_config_string("data_type",data_type));
void'(p_sequencer.get_config_string("addr_type",addr_type));

case(cfg)
"WR_RD" :repeat(num_txns)
	begin
    	start_item(pkt);
	pkt.pwdata=cal_pwdata(data_type);
	pkt.paddr=cal_paddr(addr_type);
	pkt.pwrite=1;
	pkt.psel=0;
	pkt.pen=0;
	finish_item(pkt);
	#10
	start_item(pkt);
	pkt.pwrite=1;
	pkt.psel=1;
	pkt.pen=0;
	finish_item(pkt);
	#10;
	start_item(pkt);
	pkt.psel=1;
	pkt.pen=1;
	finish_item(pkt);
	#10
	start_item(pkt);
	pkt.pwrite=0;
	finish_item(pkt);
	end
"WR" :repeat(num_txns)
	begin
    start_item(pkt);
	pkt.pwdata=cal_pwdata(data_type);
	pkt.paddr=cal_paddr(addr_type);
	pkt.pwrite=1;
	pkt.psel=1;
	pkt.pen=0;
	finish_item(pkt);
	#10
	start_item(pkt);
	pkt.psel=1;
	pkt.pen=1;
	finish_item(pkt);
	end
"RD" :	repeat(num_txns)
	begin
	start_item(pkt);
	pkt.paddr=cal_paddr(addr_type);
	pkt.psel=1;
	pkt.pen=0;
	finish_item(pkt);
	#10
	start_item(pkt);
	pkt.psel=1;
	pkt.pen=1;
	pkt.pwrite=0;
	finish_item(pkt);
	end
endcase
endtask

virtual function bit [7:0] cal_pwdata(string data_type);
begin
case(data_type)
"random":begin pwdata=$random();return pwdata;end
"constant_data":begin pwdata=constant_data;return pwdata;end
"increment":begin return pwdata++;end
"decrement":begin return pwdata--;end
"userpattern":begin pwdata=user_data[i++];return pwdata;end
endcase
end
endfunction
virtual function bit [7:0] cal_paddr(string addr_type);
begin
case(addr_type)
"random":begin paddr=$random();return paddr;end
"constant_data":begin paddr=constant_data;return paddr;end
"increment":begin return paddr++;end
"decrement":begin return paddr--;end
"userpattern":begin paddr=user_addr[j++];return paddr;end
endcase
end
endfunction
endclass

