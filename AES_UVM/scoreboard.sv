class aes_scoreboard extends uvm_scoreboard;
  virtual AES_cipher_intf vif;
  `uvm_component_utils(aes_scoreboard)
    uvm_analysis_imp #(aes_sequence_item, aes_scoreboard) item_collected_export;
  
  // Associative array to store test vectors
  bit [127:0] test_vectors[bit [255:0]];
  bit match;
  int num_matches;
  int num_mismatches;
  
  covergroup aes_cov_input;
    //covergroup aes_cov with function sample(bit plain_text, bit inti_key);
    cp_plain_text : coverpoint vif.plain_text {
      
      bins specific_test_vectors[] = {
        128'h00112233445566778899aabbccddeeff,
        128'h3243f6a8885a308d313198a2e0370734,
        128'haa218b56ee5ebeacdd6ecebf26e63c06,
        128'hb692cf0b643dbdf1be9bc5006830b3fe,
        128'h4c9c1e66f771f0762c3f868e534df256,
        128'hfa636a2825b339c940668a3157244d17,
        128'h6385b79ffc538df997be478e7547d691,
        128'h36339d50f9b539269f2c092dc4406d23,
        128'hc81677bc9b7ac93b25027992b0261996,
        128'hc62fe109f75eedc3cc79395d84f9cf5d
      };
    }

    cp_key : coverpoint vif.inti_key {
      
      bins specific_keys[] = {
        128'h000102030405060708090a0b0c0d0e0f,
        128'h2b7e151628aed2a6abf7158809cf4f3c,
        128'h627bceb9999d5aaac945ecf423f56da5,
        128'h4915598f55e5d7a0daca94fa1f0a63f7,
        128'hb6ff744ed2c2c9bf6c590cbf0469bf41,
        128'h2dfb02343f6d12dd09337ec75b36e3f0,
        128'h47f7f7bc95353e03f96c32bcfd058dfd,
        128'hf4bcd45432e554d075f1d6c51dd03b3c,
        128'he847f56514dadde23f77b64fe7f7d490,
        128'hb415f8016858552e4bb6124c5f998a4c
      };
    }

    cp_cipher_text: coverpoint vif.cipher_text {
      
      bins expected_outputs[] = {
        128'h69c4e0d86a7b0430d8cdb78070b4c55a,
        128'h3925841d02dc09fbdc118597196a0b32,
        128'h4beba7ad306c050b8941149a44e4f291,
        128'hb26f6cdefcac7328a8541233d8e807c7,
        128'h2ed0061e08730985af01eec63a083fee,
        128'hdaa1fb04b3d0c0bc583f695f1f0a20fc,
        128'h69540bd3a33a1fd026f860ed82110387,
        128'ha2bf0a3b076352a1003a3b9fb08a9c0b,
        128'h6e58ec664b370478f8e97c010c405aee,
        128'hd9a84b00c16f8b108c7f45afc2833e92
      };
    }
    
    cp_reset: coverpoint vif.rst {
      bins reset_values = {0,1};
    }
    
    pt_key_cross: cross cp_plain_text, cp_key, cp_cipher_text,cp_reset {
      bins valid_combinations = binsof(cp_plain_text.specific_test_vectors) && 
      binsof(cp_key.specific_keys) && 
      binsof(cp_cipher_text.expected_outputs) && binsof(cp_reset.reset_values);
    }
  endgroup
  
  function new(string name = "aes_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
    aes_cov_input = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual AES_cipher_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Virtual Interface not Connected")
    
    // Initialize test vectors in the associative array
    // Key is concatenated {plain_text, inti_key}
    
    // Test case 1 
    test_vectors[{128'h00112233445566778899aabbccddeeff, 128'h000102030405060708090a0b0c0d0e0f}] = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    
    // Test case 2 
    test_vectors[{128'h3243f6a8885a308d313198a2e0370734, 128'h2b7e151628aed2a6abf7158809cf4f3c}] = 128'h3925841d02dc09fbdc118597196a0b32;
    
    // Test case 3
    test_vectors[{128'haa218b56ee5ebeacdd6ecebf26e63c06, 128'h627bceb9999d5aaac945ecf423f56da5}] = 128'h4beba7ad306c050b8941149a44e4f291;
    
    // Test case 4 
    test_vectors[{128'hb692cf0b643dbdf1be9bc5006830b3fe, 128'h4915598f55e5d7a0daca94fa1f0a63f7}] = 128'hb26f6cdefcac7328a8541233d8e807c7;
    
    // Test case 5 
    test_vectors[{128'h4c9c1e66f771f0762c3f868e534df256, 128'hb6ff744ed2c2c9bf6c590cbf0469bf41}] = 128'h2ed0061e08730985af01eec63a083fee;
    
    // Test case 6
    test_vectors[{128'hfa636a2825b339c940668a3157244d17, 128'h2dfb02343f6d12dd09337ec75b36e3f0}] = 128'hdaa1fb04b3d0c0bc583f695f1f0a20fc;
    
    // Test case 7 
    test_vectors[{128'h6385b79ffc538df997be478e7547d691, 128'h47f7f7bc95353e03f96c32bcfd058dfd}] = 128'h69540bd3a33a1fd026f860ed82110387;
    
    // Test case 8  
    test_vectors[{128'h36339d50f9b539269f2c092dc4406d23, 128'hf4bcd45432e554d075f1d6c51dd03b3c}] = 128'ha2bf0a3b076352a1003a3b9fb08a9c0b;
    
    // Test case 9 
    test_vectors[{128'hc81677bc9b7ac93b25027992b0261996, 128'he847f56514dadde23f77b64fe7f7d490}] = 128'h6e58ec664b370478f8e97c010c405aee;
    
    // Test case 10 
    test_vectors[{128'hc62fe109f75eedc3cc79395d84f9cf5d, 128'hb415f8016858552e4bb6124c5f998a4c}] = 128'hd9a84b00c16f8b108c7f45afc2833e92;
    
    num_matches = 0;
    num_mismatches = 0;
  endfunction
  
  virtual function void write(aes_sequence_item tr);
    bit [255:0] test_key;
    bit [127:0] expected_cipher;
    
    // Log the input data
    `uvm_info("SCOREBOARD", $sformatf("Received transaction: plain_text = %h, inti_key = %h", tr.plain_text, tr.inti_key), UVM_MEDIUM)
    
    // Create the key for the associative array lookup
    test_key = {tr.plain_text, tr.inti_key};
    
    // Check if the test vector exists in our database
    if(test_vectors.exists(test_key)) begin
      expected_cipher = test_vectors[test_key];
      
      // Only check if cipher operation is complete
      if(tr.cipher_done) begin
        match = (expected_cipher == tr.cipher_text);
        if(match) begin
          `uvm_info("SCOREBOARD", $sformatf("PASS: DUT cipher = %h, Expected = %h", tr.cipher_text, expected_cipher), UVM_LOW)
          num_matches++;
        end
        else begin
          `uvm_error("SCOREBOARD", $sformatf("FAIL: DUT cipher = %h, Expected = %h", tr.cipher_text, expected_cipher))
          num_mismatches++;
        end
      end
    end
    else begin
      `uvm_error("AES_SCOREBOARD", $sformatf("Unknown test vector: Plain_text=%h, inti_Key=%h", tr.plain_text, tr.inti_key))
    end
   aes_cov_input.sample();
   
  endfunction
  
  // report phase 
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCOREBOARD", $sformatf("Scoreboard completed - Total Matches: %0d, Total Mismatches: %0d", 
                                      num_matches, num_mismatches), UVM_LOW)
    
    if(num_mismatches == 0 && num_matches > 0)
      `uvm_info("SCOREBOARD", "TEST PASSED - All vectors matched expected results", UVM_LOW)
    else
      `uvm_info("SCOREBOARD", "TEST FAILED - Some vectors did not match expected results", UVM_LOW)
  
     // Print message
  `uvm_info("COVERAGE", "Functional coverage collected. Use $coverage or simulator GUI to view report.", UVM_NONE)
      
      $display("---------------------------------------");
    $display("Overall Coverage:  %0.2f%%", $get_coverage());
    $display("Coverage of covergroup 'aes_cov': %0.2f%%", aes_cov_input.get_coverage());
    $display("---------------------------------------");
    $display("Coverage of coverpoint 'cp_plain_text' = %0f", aes_cov_input.cp_plain_text.get_coverage());
    $display("Coverage of coverpoint 'cp_key' = %0f", aes_cov_input.cp_key.get_coverage());
    $display("Coverage of coverpoint 'cp_cipher_text' = %0f", aes_cov_input.cp_cipher_text.get_coverage());
    $display("Coverage of coverpoint 'cp_reset' = %0f", aes_cov_input.cp_reset.get_coverage());
    $display("---------------------------------------");
      endfunction
endclass