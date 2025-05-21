class aes_base_sequence extends uvm_sequence#(aes_sequence_item);
	// Utility macros
	`uvm_object_utils(aes_base_sequence)
	
	// Constructor
	function new(string name = "aes_base_sequence");
	super.new(name);
	endfunction
	
	virtual task body();
	`uvm_info(get_type_name(),$sformatf("Generate the random sequences"),UVM_LOW);
	
      repeat(50)begin
      // `uvm_do(req)
		
      req = aes_sequence_item:: type_id :: create ("req");
      start_item(req);
        assert(req.randomize());
		finish_item(req);
		end
	endtask
endclass