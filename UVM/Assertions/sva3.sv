// Code your testbench here
// or browse Examples
module sva3;
  bit clk, req1, req2, en;
  
  always #2 clk = ~clk;
  
  sequence seq(en);
    (req1 | req2) & en;
  endsequence
  
  property prop(en);
    @(posedge clk) seq(en);
  endproperty
  
  logical_exp: assert property(prop(en))
    $display("Passed at %t, ((req1|req2)&en) = %b",$time,((req1|req2)&en));
    else
      $display("Failed at %t, ((req1|req2)&en) = %b",$time,((req1|req2)&en));
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    req1 = 0;
    req2 = 0;
    
    #1;
    
    #4 req1 = 1;
    #4 req2 = 1;
    #6 req1 = 0;
    #6 req2 = 0;
    en = 1;
    #10 req1 = 1;
    #20 req2 = 1;
    #20; $finish;
  end
endmodule