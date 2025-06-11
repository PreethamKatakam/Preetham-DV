module freq_div_TB;

  reg clk;
  reg rst;
  reg d;
  wire q1,q2;
  
  
  freq_div freq_div_inst(.clk(clk), .rst(rst),
          .d(d), .q1(q1), .q2(q2));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
 	clk =1'b0;
	d  =1'b0;
	end
	

	initial	begin
    #100 $stop;
  end
  

endmodule