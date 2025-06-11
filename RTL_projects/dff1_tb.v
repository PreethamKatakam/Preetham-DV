module dff1_TB;

  reg clk;
  reg d1;
  wire q1;
  wire op;
  
  dff1 dff1_inst(.clk(clk),
          .d1(d1), .q1(q1), .op(op));
          
  always #5 clk = ~clk;
  
  initial begin
	clk =1'b0;
	d1  =1'b0;
	end
	

	initial	begin
	#10 d1 =1'b1;
	#17 d1 =1'b0;
	
	#50 $finish;
  end
  

endmodule