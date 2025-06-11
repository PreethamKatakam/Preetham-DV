// Code your testbench here
// or browse Examples
module sva1;
  reg req1, req2;
  reg clk;
  always #2 clk = ~clk;
  
  sequence seq;
    req1 ##5 req2;
  endsequence
  
  property prop;
    @(posedge clk) seq;
  endproperty
  
  time_a: assert property(prop) 
    $display("Passed at %t",$time) ;
    else 
      $error("failed at %t",$time);
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk =0;
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