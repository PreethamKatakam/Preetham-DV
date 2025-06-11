// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples

//not operator

module sva19;
  bit a_clk,reset, req1, req2,ack,en;
  
  always #5 a_clk = ~a_clk;
  
  sequence seq1;
    @(posedge a_clk) en ##1 req1 ##0 req2;
endsequence

sequence seq2;
  @(posedge a_clk) reset ##2 seq1.ended;// ##1 ack;
endsequence
  
  assert property (seq1) $info("passed at %0t",$time);
    else
      $display("Failed at %0t",$time);
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    req1 = 0;
    req2 = 0;
    ack = 0;
    en = 0;
    reset = 0;
    
    #79 req1 = 1;
    #20 req1 = 0;
    
    // #30;
    #100; $finish;
  end
    
    initial begin
      #74 en=1;
      #20 en=0;
    end
    
    initial begin
      #39 reset = 1;
      
      #10 reset = 0;
    end
    
    initial begin
       #78 req2 = 1;
      #20 req2=0;
      end
    
    initial begin
      #95 ack = 1;
      #20 ack = 0;
      
    end
    
    
    
endmodule