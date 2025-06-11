module up_down1_TB;

  reg clk;
  reg rst;
  reg up_dn;
  //reg d;
  wire [3:0]q;
  
  
  up_down1 up_down1_inst(.clk(clk), .rst(rst), .up_dn(up_dn),
           .q(q));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
    rst =1'b0;
	clk =1'b0;
	up_dn  =1'b0;
	end
	

	initial	begin
    	
	#7 rst =1'b1;
	#10 rst =1'b0;
	#15  up_dn =1'b1;
	#100  up_dn =1'b0;
	#30 up_dn =1'b1;
	#85 up_dn =1'b0;
	#15  up_dn =1'b1;
	#30 up_dn =1'b1;
	#20  up_dn =1'b0;
	
	
	#30 $stop;
  end
  

endmodule