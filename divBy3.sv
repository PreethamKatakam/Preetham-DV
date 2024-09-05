module a;
  reg clk,clk1;
  reg q3;
  reg [1:0] cnt;
  always #50 clk = ~clk;
 // always #50 clk1 = ~clk1;
  
  initial begin
    #25
    clk1=1'b0;
  while(1)
    #50
    if(!clk1)
      clk1 = 1;
    else
      clk1=0;
  end
  
  
  initial begin
    clk=1'b0;
    q=1'b0;
    cnt =2'b11;
  end
  
  assign q3=!cnt[0];
  
  always @(posedge clk or posedge clk1) begin
    if(cnt==1)
      cnt <= 0;
    else
    	cnt <= cnt+1;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #2000 $stop;
  end
endmodule
