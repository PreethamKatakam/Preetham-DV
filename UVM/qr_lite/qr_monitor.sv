class qr_monitor extends uvm_monitor;
  `uvm_component_utils(qr_monitor)
  
  virtual qr_intf vif;
  qr_seq_item req;
  uvm_analysis_port#(qr_seq_item) ap;
  
  function new(string name , uvm_component parent);
    super.new(name, parent);
    ap = new("ap",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual qr_intf) :: get(this,"","vif",vif))
      `uvm_fatal("No VIF","Virtual interface not conneted");    
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("MONITOR","In monitor",UVM_LOW)
    forever begin
      #1ns;
      
      
    //  ap.write(req);
    end    
  endtask
  
  
endclass