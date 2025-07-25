// class spi_seq extends uvm_sequence#(spi_seq_item);
  
//   `uvm_object_utils(spi_seq)
//   `uvm_declare_p_sequencer(spi_seqr)
  
//   function new(string name = "spi_seq");
//     super.new(name);
//   endfunction
  
  
//   virtual task body();
//     `uvm_info(get_type_name(),$sformatf("Generate the random sequences"),UVM_LOW);
    
//     repeat(5)begin
      
//       req=spi_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize() with {
//         data_m inside {[8'h00:8'hFF]}; 
//         data_s1 == 8'hFF;
//         data_s2 == 8'hFF;
//       });
//       finish_item(req);
    
//       `uvm_info(get_type_name(),$sformatf("data_m =%0d | data_s1 = %0d | data_s2 = %0d",req.data_m,req.data_s1,req.data_s2);
//     end
                
//      repeat(5) begin
//        req=spi_seq_item::type_id::create("req");
//        start_item(req);
//        assert(req.randomize() with {
//          data_m == 8'h00;
//          data_s1 inside {[8'h00:8'hFF]};
//          data_s2 inside {[8'h00:8'hFF]};
//        });
//        finish_item(req);
//        `uvm_info(get_type_name(),$sformatf("data_m =%0d | data_s1 = %0d | data_s2 = %0d",req.data_m,req.data_s1,req.data_s2);
//      end
//    endtask
// endclass

//========== MAIN SEQ===============//


class spi_seq extends uvm_sequence#(spi_seq_item);

	`uvm_object_utils(spi_seq)

	function new(string name="spi_seq");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_info(get_type_name(),$sformatf("Generate the random sequences"),UVM_LOW);
      
		//spi_seq_item req;
      repeat(5)begin
      		req=spi_seq_item::type_id::create("req");
			start_item(req);
      		assert(req.randomize());
        	`uvm_info(get_type_name(),$sformatf("IN SEQUENCE"),UVM_LOW)
        	//req.convert2string();
			finish_item(req);
      end
    endtask
endclass
