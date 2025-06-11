class mem_mon extends uvm_monitor;
  `uvm_component_utils(mem_mon)
  
  virtual m_intf vif;
  mem_seq_item trans;
  uvm_analysis_port#(mem_seq_item) item_col_port;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    trans=new();
    item_col_port=new("item_col_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual m_intf) :: get(this,"","vif",vif))
      `uvm_fatal("No Vif","Virtual Interface not Connected");  
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name,$sformatf("%p",trans),UVM_LOW);
      
    forever begin
      //`uvm_info(get_type_name(),$sformatf("Inside Monitor"),UVM_LOW);
      @(posedge vif.clk);
      trans.we = vif.we;
      trans.addr = vif.addr;
      
      if(trans.we) begin
      	trans.data_in = vif.data_in;         
      end
      else begin
        trans.data_out = vif.data_out;        
      end
      
      item_col_port.write(trans);
    end
  endtask
  
  
  
endclass