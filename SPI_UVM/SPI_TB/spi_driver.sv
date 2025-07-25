class spi_driver extends uvm_driver#(spi_seq_item);

  	virtual spi_interface vif;
//spi_seq_item req;
	`uvm_component_utils(spi_driver)
  
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if (!uvm_config_db#(virtual spi_interface) :: get(this, "", "vif", vif))
        `uvm_fatal(get_type_name(),"Virtual interface not set")
      
	endfunction
        virtual task run_phase(uvm_phase phase);
      forever begin 
		seq_item_port.get_next_item(req);
        vif.rst <= 1;
        
        
        @(posedge vif.clk);
       // `uvm_info(get_type_name(),$sformatf(" cs1_n = %0b, cs2_n = %0b, data_m = %0b, data_s1 = %0b,data_s2 = %0b",req.cs1_n,req.cs2_n,req.data_m,req.data_s1,req.data_s2),UVM_LOW)
       
        vif.data_m <= req.data_m;
        vif.data_s1 <= req.data_s1;
        vif.data_s2 <= req.data_s2;
        vif.cs1_n <= req.cs1_n;
        vif.cs2_n <= req.cs2_n;
        #20
        vif.rst <=0;
        //`uvm_info(get_type_name(),$sformatf("data_m = %0b, data_s = %0b, cs1_n = %0b, cs2_n = %0b",req.data_m,req.data_s,req.cs1_n,req.cs2_n),UVM_LOW)
        
        
        
        #180
        //repeat(8) @(posedge vif.clk);
//           vif.rst <= 1;     
//         #20

		seq_item_port.item_done();
        //  HAVE TO MENTION DELAYY *************
        end
   endtask
endclass 
