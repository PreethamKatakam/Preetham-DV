// Code your testbench here
// or browse Examples
module sva2;
  bit clk, req1, req2;
  
  always #2 clk = ~clk;
  
  sequence seq;
    req1 && req2;
  endsequence
  
  property prop;
    @(posedge clk) seq;
  endproperty
  
  logical_exp: assert property(prop)
    $display("passed at %t",$time);
    else
      $display("Failed at %t",$time);
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    req1 = 0;
    req2 = 0;
    #1;
    #4 req1 = 1;
    req2 = 1;
    #6 req1 = 0;
    #6 req2 = 0;
    #10 req1 = 1;
    #20 req2 = 1;
    #20; $finish;
  end
endmodule