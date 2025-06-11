// Code your testbench here
// or browse Examples

//not operator

module sva11;
  bit clk, req1, req2,ack1,ack2;
  
  always #2 clk = ~clk;
  
property prop;
  @(posedge clk) (req1 || req2) |-> 
  if(req1)
    (##1 ack1)
  else
   (##2 ack2);
endproperty

  assert property (prop) $info("passed at %0t",$time);
    else
      $display("Failed at %0t",$time);
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    req1 = 0;
    req2 = 0;
    ack1 = 0;
    ack2 = 0;
    
    #1 req1 = 1;
    #4 req1 = 0;
    #4 req1 = 1;
    #4 req1 = 0;
    #8 req1 = 1;
    #4 req1 = 0;
  // #30;
    #20; $finish;
  end
    
    initial begin
       #17 req2 = 1;
      #4 req2 = 0;
      #4 req2 = 1;    
    end
    
    initial begin
      #9 ack1 = 1;
      #8 ack1 = 0;
      #4 ack1 = 1;
      #4 ack1 = 0;
   
    end
    
endmodule