// Code your testbench here
// or browse Examples
module sva4;
  bit clk, req1, req2;
  
  always #2 clk = ~clk;
  
  sequence seq;
    first_match(req1 ##[1:4] req2);
    //req1 ##[1:4] req2;
  endsequence
  
  property prop;
    @(posedge clk) seq;
  endproperty
  
  label_a: assert property(prop) $info("passed at %0t",$time);
    else
      $display("Failed at %0t",$time);
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    req1 = 0;
    req2 = 0;
    #1;
    #2 req1 = 1;
    #4 req2 = 1;
    #4 req1 = 0;
    #4 req2 = 0;
    #15 req1 = 0;
    #15 req2 = 0;

    #20; $finish;
  end
endmodule