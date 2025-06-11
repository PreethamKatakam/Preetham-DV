`include "seq_item1.sv";
`include "seq_item2.sv";
class mem_seq extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(mem_seq)
  
  
  function new(string name="mem_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat (40) begin
      //`uvm_info(get_type_name(),$sformatf("Inside Sequence"),UVM_LOW);
     
      //Normal Method
//       req = mem_seq_item::type_id::create("req");
//       wait_for_grant();
//       assert(req.randomize());
//       send_request(req);
//       wait_for_item_done();
      ////      get_response(rsp); //to use this, we need to put a rsp in the driver code , else is unnecessary
      
      //or instead of these 6 steps, just do
      //`uvm_do(req);
     
      //This is for using multiple sequence item
      seq_item1 s1;
      seq_item2 s2;
      `uvm_do(s1);
      //`uvm_do(s2);
      
      //or use start and finish item
//       req = mem_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize());
//       finish_item(req);
    end
    
  endtask
  
  
endclass