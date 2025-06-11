module samp_ckt_TB;

  reg clk;
  reg rst;
  reg d1,d2;
  wire q1,q2;
  wire op;
  
  samp_ckt samp_ckt_inst(.clk(clk), .rst(rst),
          .d1(d1), .q1(q1), .q2(q2), .op(op));
          
  always #5 clk = ~clk;
  
  initial begin
    rst =1'b1;
	clk =1'b0;
	d1  =1'b0;
	end
	

	initial	begin
    #2 rst =1'b0;
	#8 d1 =1'b1;
	#7 d1 =1'b0;
	#25 d1 =1'b1;
	#6 d1 =1'b0;
	
	#30 $stop;
  end
  

endmodule