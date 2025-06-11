module L_R_shift_TB;

  reg clk;
  reg rst,cntl;
  reg d;
  wire [2:0]q;
  
  
  L_R_shift L_R_shift_inst(.clk(clk), .rst(rst), .cntl(cntl),
          .d(d), .q(q));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
  //  rst =1'b0;
	clk =1'b0;
	d  =1'b1;
	cntl=1'b0;
	end
	

	initial	begin
		#20 cntl=1'b1;
		#17 d =1'b1;
		#5 cntl=1'b0;
		#2 d=1'b0;
    	#100 $stop;
  end
  

endmodule