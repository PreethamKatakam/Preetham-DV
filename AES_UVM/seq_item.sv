class aes_sequence_item extends uvm_sequence_item;
  // Input data fields
  rand bit [127:0] plain_text;
  rand bit [127:0] inti_key;
  rand bit         rst;
  bit              start;

  // Output data fields (from DUT)
  bit [127:0]      cipher_text;
  bit              cipher_done;
  bit [5:0]        clk1;

  // Utility and Field macros
  `uvm_object_utils_begin(aes_sequence_item)
    `uvm_field_int(plain_text, UVM_ALL_ON)
    `uvm_field_int(inti_key, UVM_ALL_ON)
  	`uvm_field_int(rst, UVM_ALL_ON)
    `uvm_field_int(start, UVM_ALL_ON)
    `uvm_field_int(cipher_text, UVM_ALL_ON)
    `uvm_field_int(cipher_done, UVM_ALL_ON)
    `uvm_field_int(clk1, UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "aes_sequence_item");
    super.new(name);
  endfunction
	
  //constraint 
  constraint c1 { plain_text inside {128'h00112233445566778899aabbccddeeff,128'h3243f6a8885a308d313198a2e0370734,128'haa218b56ee5ebeacdd6ecebf26e63c06,128'hb692cf0b643dbdf1be9bc5006830b3fe,128'h4c9c1e66f771f0762c3f868e534df256,128'hfa636a2825b339c940668a3157244d17,128'h6385b79ffc538df997be478e7547d691,128'h36339d50f9b539269f2c092dc4406d23,128'hc81677bc9b7ac93b25027992b0261996,128'hc62fe109f75eedc3cc79395d84f9cf5d};}
  
  constraint c2 {
    if(plain_text == 128'h00112233445566778899aabbccddeeff)
      inti_key == 128'h000102030405060708090a0b0c0d0e0f;
  
    else if(plain_text == 128'h3243f6a8885a308d313198a2e0370734)
    inti_key == 128'h2b7e151628aed2a6abf7158809cf4f3c;
    
    else if(plain_text == 128'haa218b56ee5ebeacdd6ecebf26e63c06)
      inti_key == 128'h627bceb9999d5aaac945ecf423f56da5;
        
    else if(plain_text == 128'hb692cf0b643dbdf1be9bc5006830b3fe)
	  inti_key == 128'h4915598f55e5d7a0daca94fa1f0a63f7;

    else if(plain_text == 128'h4c9c1e66f771f0762c3f868e534df256)
		inti_key == 128'hb6ff744ed2c2c9bf6c590cbf0469bf41;

    else if(plain_text == 128'hfa636a2825b339c940668a3157244d17)
		inti_key == 128'h2dfb02343f6d12dd09337ec75b36e3f0; 

    else if(plain_text == 128'h6385b79ffc538df997be478e7547d691)
		inti_key == 128'h47f7f7bc95353e03f96c32bcfd058dfd;

    else if(plain_text == 128'h36339d50f9b539269f2c092dc4406d23)
		inti_key == 128'hf4bcd45432e554d075f1d6c51dd03b3c;

    else if(plain_text == 128'hc81677bc9b7ac93b25027992b0261996)
		inti_key == 128'he847f56514dadde23f77b64fe7f7d490;
    
    else if(plain_text == 128'hc62fe109f75eedc3cc79395d84f9cf5d) 
		inti_key == 128'hb415f8016858552e4bb6124c5f998a4c;
  }
  
  // Method to convert sequence item to string for debug
  virtual function string convert2string();
    return $sformatf(
      "plain_text=0x%32h, inti_key=0x%32h, rst=%0d, start=%0d, cipher_text=0x%32h, cipher_done=%0d, clk1=%0d",plain_text, inti_key, rst, start, cipher_text, cipher_done, clk1
    );
  endfunction

endclass


