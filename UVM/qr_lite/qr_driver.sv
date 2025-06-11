class qr_driver extends uvm_driver#(qr_seq_item);
  
  `uvm_component_utils(qr_driver)
  
  virtual qr_intf vif;
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual qr_intf) :: get(this,"","vif",vif))
      `uvm_fatal("No VIF"," Virtual intf not connected");    
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("DRIVER","In driver",UVM_LOW)
    
    forever begin
      `uvm_info("DRIVER","In driver -1",UVM_LOW);
    
      seq_item_port.get_next_item(req);
      
      fork
      	begin
          vif.rst_b 	= 1'b1;
	  	  vif.accept_s	= 1'b0;
	  	  vif.data_s	= 4'd0;
	  	  vif.create_b	= 1'b0;		
      	  repeat (2) @ (posedge vif.clk);
		  vif.rst_b     = 1'b0;      
      	end
        
        begin
			#25 vif.data_s = req.data_s;
			#20 vif.accept_s =1'b1;
			#20 vif.accept_s =1'b0;
        end
        
        begin
			#100 vif.final_s =1'b1;
	
		end
	
		//create_b
		begin
			#120 vif.create_b =1'b1;
			#120 vif.create_b =1'b0;		
		end
        
      join
      
	
      
      seq_item_port.item_done();
      
    end  
    
  endtask
endclass