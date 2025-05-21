class aes_monitor extends uvm_monitor;
  `uvm_component_utils(aes_monitor)
  uvm_analysis_port #(aes_sequence_item) mon_ap;
  
  aes_sequence_item tr;
  virtual AES_cipher_intf vif;
  bit transaction_in_progress;
  
  function new (string name = "aes_monitor", uvm_component parent = null);
    super.new(name,parent);
    tr = new();
    mon_ap = new("mon_ap",this);
    transaction_in_progress = 0;
  endfunction
  
  // build phase 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),$sformatf("inside monitor build phase"),UVM_LOW)
        
    if(!uvm_config_db #(virtual AES_cipher_intf)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"virtual interface not set on top level");
  endfunction
  
  // run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      //`uvm_info(get_type_name(),$sformatf("inside monitor run phase"),UVM_LOW)
       
      // Detect rising edge of cipher_done
      if(vif.cipher_done && !transaction_in_progress) begin
        transaction_in_progress = 1;
        
        tr = aes_sequence_item :: type_id :: create("tr");
        
        // Capture all signals
        tr.plain_text   = vif.plain_text;
        tr.inti_key     = vif.inti_key;
        tr.cipher_text  = vif.cipher_text;
        tr.cipher_done  = vif.cipher_done;
        
        `uvm_info(get_type_name(),$sformatf("plain_text:%0h , inti_key:%0h, cipher_text:%0h, cipher_done:%0h",
              tr.plain_text, tr.inti_key, tr.cipher_text, tr.cipher_done),UVM_LOW)
        
        mon_ap.write(tr);
        
        // Wait for cipher_done to be deasserted before capturing next transaction
        wait(vif.cipher_done == 0);
        transaction_in_progress = 0;
      end
    end
  endtask
endclass