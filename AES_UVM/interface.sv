// interface signals - connect the DUT to the testbench 
interface AES_cipher_intf(input logic clk);
  // Control Signals  
  logic rst;
  logic start;
  logic cipher_done;
  logic KeyExpansion_done;
  logic [5:0] clk1;
  
  // Data signals
  logic [127:0]  plain_text;
  logic [127:0]  inti_key;
  logic [127:0]  cipher_text;
  
  // clocking block for driver 
  clocking drv_cb @(posedge clk);
    output rst,start,plain_text,inti_key;
    input cipher_done,cipher_text,clk1;
  endclocking
  
  //clocking block for monitor
  clocking mon_cb @(posedge clk);
    input rst, start, plain_text, inti_key;
    input cipher_done,cipher_text,clk1;
  endclocking 
  
  //modport for driver
  modport driver (clocking drv_cb, input clk);
  
  // modport for monitor 
  modport monitor (clocking mon_cb, input clk);
    
  // Assertions
  // Assert that cipher_done is asserted within a reasonable timeframe after start
  property aes_complete_p;
    @(posedge clk) 
    $rose(start) |-> ##[1:200] $rose(cipher_done);
  endproperty
    
    assert property(aes_complete_p)
    else $error("AES cipher didn't complete within expected time");
      
  // Reset checker - ensures that cipher_done goes low during reset
  property reset_clears_done_p;
    @(posedge clk)
    $rose(rst) |-> ##1 (cipher_done == 1'b0);
  endproperty
  
  assert property(reset_clears_done_p)
    else $error("cipher_done not cleared by reset");
 
  //key_expansion_reset_check  
  property key_expansion_reset_check;
    @(posedge clk) rst |-> (KeyExpansion_done == 1'b0);
  endproperty
    
  assert property (key_expansion_reset_check);

      
endinterface 