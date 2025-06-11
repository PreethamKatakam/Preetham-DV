// Code your testbench here
// or browse Examples

//within operator

module sva9;
  bit clk, en, req,valid;
  
  always #2 clk = ~clk;
  
 sequence seq;
 // @(posedge clk) $rose (en) ##0
   // (en throughout ##2 (req && valid)) [*5];
   valid [*5] within (($rose req) ##1 req[*6]);
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
    
    en = 0;
    req = 0;
    valid = 0;
    
    #1 en = 1;
    #4 en = 0;
    #4 en = 1;
    #4 en = 0;
    #8 en = 1;
    #4 en = 0;
  // #30;
    #20; $finish;
  end
    
    initial begin
       #17 req = 1;
      #4 req = 0;
      #4 req = 1;    
    end
    
    initial begin
      #9 valid = 1;
      #8 valid = 0;
      #4 valid = 1;
      #4 valid = 0;
   
    end
    
endmodule