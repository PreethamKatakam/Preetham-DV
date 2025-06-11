module dff4_TB;

  reg clk;
  reg rst;
  reg d;
  wire q;
  
  
  dff4 dff4_inst(.clk(clk), .rst(rst),
          .d(d), .q(q), .p(p));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
    rst =1'b0;
	clk =1'b0;
	d  =1'b0;
	end
	

	initial	begin
    // #20 rst =1'b1;
	// #10 rst =1'b0; d =1'b1;
	// #8  d =1'b0;
	// #30 rst =1'b1;
	// #10 rst =1'b0;
	
	// #7 rst =1'b1;
	// #10 rst =1'b0;
	// #15  d =1'b1;
	// #40  d =1'b0;
	// #30 rst =1'b1;
	// #10 rst =1'b0;
	
	#7 rst =1'b1;
	#10 rst =1'b0;
	#15  d =1'b1;
	#40  d =1'b0;
	#15  d =1'b1;
	#40  d =1'b0;
	#15  d =1'b1;
	#40  d =1'b0;
	
	
	#100 $stop;
  end
  

endmodule