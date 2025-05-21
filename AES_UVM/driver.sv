class aes_driver extends uvm_driver#(aes_sequence_item);
  virtual AES_cipher_intf vif;

  `uvm_component_utils(aes_driver)

  function new(string name = "aes_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual AES_cipher_intf) :: get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Virtual interface not set")
  endfunction

// run phase 
   task run_phase(uvm_phase phase);
    forever begin
      
     // `uvm_info(get_type_name(),$sformatf("inside driver run phase"),UVM_LOW)
      
      seq_item_port.get_next_item(req);
      
      // Reset the DUT first
      @(posedge vif.clk);
      vif.start      <= 0;
      vif.rst        <= 1;
      
      // Hold reset for a few cycles to ensure DUT is fully reset
      repeat(3) @(posedge vif.clk);
      
      // Release reset
      vif.rst        <= 0;
      
      // Wait a few cycles after reset before sending new inputs
      repeat(2) @(posedge vif.clk);
      
      // Apply new inputs
      vif.plain_text <= req.plain_text;
      vif.inti_key   <= req.inti_key;
      
      @(posedge vif.clk);
      `uvm_info(get_type_name(),$sformatf("plain_text:%0h , inti_key:%0h",req.plain_text,req.inti_key),UVM_LOW)
      
      // Assert start signal
      vif.start <= 1;
      
      // Wait for cipher_done to be asserted
      wait(vif.cipher_done == 1);
      
      // Hold start for a few more cycles to ensure DUT registers the completion
      repeat(2) @(posedge vif.clk);
      
      // Deassert start signal
      vif.start <= 0;
      
      // Wait a few cycles before moving to next item
      repeat(5) @(posedge vif.clk);
      
      seq_item_port.item_done();
    end
  endtask
endclass