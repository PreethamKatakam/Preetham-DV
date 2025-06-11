class mem_drv extends uvm_driver#(mem_seq_item);
  
  virtual m_intf vif;
  
  
  `uvm_component_utils(mem_drv)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);    
  endfunction
  
  function void  build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual m_intf) :: get(this,"","vif",vif))
      `uvm_fatal("No Vif","Virtual Interface not Connected");
  endfunction
    
    task run_phase(uvm_phase phase);
      forever begin
        `uvm_info(get_type_name(),$sformatf("Inside Driver"),UVM_LOW);
        seq_item_port.get_next_item(req);
        //`uvm_info(get_type_name(),$sformatf("data_in :%0d",req.data_in),UVM_LOW);
        
        vif.we <= req.we;
        
        @(posedge vif.clk);
        if(vif.we) begin
          vif.data_in <= req.data_in;
          vif.addr	  <= req.addr;
          `uvm_info(get_type_name(),$sformatf("data_in[%d] :%0h",req.addr,req.data_in),UVM_LOW);    
        end
        else begin
          vif.addr	  <= req.addr;
        end
        
        seq_item_port.item_done();        
      end
      
    endtask
  
  
  
endclass