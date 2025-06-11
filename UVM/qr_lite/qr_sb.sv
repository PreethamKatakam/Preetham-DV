class qr_sb extends uvm_scoreboard;
  
  `uvm_component_utils(qr_sb)
  
  qr_seq_item trans[$];
  uvm_analysis_imp#(qr_seq_item,qr_sb) ap_imp;
  
  virtual qr_intf vif;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    ap_imp = new("qr_sb",this);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(qr_seq_item tr);
    
  endfunction
  
  
  task run_phase(uvm_phase phase);
    `uvm_info("Scoreboard","Inside Write SB",UVM_LOW);
  endtask
    
endclass