`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "test.sv"
`include "design.sv"

module aes_tb;
  
  // Clock generation
  bit clk;
  bit rst;
  initial begin
    clk = 0;
    
  end
  
  always #5 clk = ~clk;
  
  // Interface instantiation
  AES_cipher_intf aes_intf(clk);
  
  // DUT instantiation
  AES_cipher dut (
    .rst(aes_intf.rst),
    .clk(aes_intf.clk),
    .start(aes_intf.start),
    .plain_text(aes_intf.plain_text),
    .inti_key(aes_intf.inti_key),
    .cipher_done(aes_intf.cipher_done),
    .cipher_text(aes_intf.cipher_text),
    .clk1(aes_intf.clk1)
  );
  always @(*) begin
  	aes_intf.KeyExpansion_done <= dut.keyExpansion_done;
  end
  // UVM test start
  initial begin
    // Configure virtual interface in database
    uvm_config_db#(virtual AES_cipher_intf)::set(uvm_root :: get(), "*", "vif", aes_intf);
  end
  
  
  
  initial begin
    // Start the test
    run_test("aes_test");
  end
  
  // Dump VCD for debug
  initial begin
    $dumpfile("aes_tb.vcd");
    $dumpvars(0, aes_tb);
  end
endmodule