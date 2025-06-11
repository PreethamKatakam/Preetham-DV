module dff2_TB;

  reg clk;
  reg rst;
  reg d1;
  wire q1;
  
  
  dff2 dff2_inst(.clk(clk), .rst(rst),
          .d1(d1), .q1(q1));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
    rst =1'b0;
	clk =1'b0;
	d1  =1'b0;
	end
	

	initial	begin
    #2 rst =1'b1;
	#8 d1 =1'b1;
	#7 rst =1'b0;
	#10 d1 =1'b0;
	
	#30 $stop;
  end
  

endmodule