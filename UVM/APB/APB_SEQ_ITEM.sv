class apb_seq_item extends uvm_sequence_item;
`uvm_object_utils(apb_seq_item)

randc bit [7:0]pwdata;
randc bit [7:0]paddr;
bit psel,pen;
bit pwrite;
bit pready;
bit [7:0]prdata;
function new(string name="apb_seq_item");
super.new(name);
endfunction
endclass

