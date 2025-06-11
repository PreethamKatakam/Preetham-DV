// Code your testbench here
// or browse Examples

//intersect operator

module sva6;
  bit clk, a1, a2,a3,a4,a5;
  
  always #2 clk = ~clk;
  
  sequence seq;
    (a1 ##[1:4] a2) intersect (a3 ##1 a4 ##2 a5);
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
    
    a1 = 0;
    a2 = 0;
    a3 = 0;
    a4 = 0;
    a5 = 0;
    
    #1 a1 = 1;
    #4 a1 = 0;
    #4 a1 = 1;
    #4 a1 = 0;
    #8 a1 = 1;
    #4 a1 = 0;
  // #30;
    #20; $finish;
  end
    
    initial begin
       #17 a2 = 1;
      #4 a2 = 0;
      #4 a2 = 1;    
    end
    
    initial begin
      #9 a3 = 1;
      #8 a3 = 0;
      #4 a3 = 1;
      #4 a3 = 0;
   
    end
   
    initial begin
       #13 a4 = 1;
      #8 a4 = 0;
      #4 a4 = 1;
    
    end
    
    initial begin
      
       #9 a5 = 1;
      #8 a5 = 0;
      #16 a5 = 1;
     
    end
    
endmodule