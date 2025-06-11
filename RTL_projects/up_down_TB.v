module up_down_TB;

  reg clk;
  reg rst;
  reg up,dwn;
  //reg d;
  wire [3:0]q;
  
  
  up_down up_down_inst(.clk(clk), .rst(rst), .up(up), .dwn(dwn),
           .q(q));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
    rst =1'b0;
	clk =1'b0;
	up  =1'b0;
	dwn =1'b0;
	//d  =1'b0;
	end
	

	initial	begin
    	
	#7 rst =1'b1;
	#10 rst =1'b0;
	#15  up =1'b1;
	#100  up =1'b0;
	#30 dwn =1'b1;
	#85 dwn =1'b0;
	#15  up =1'b1;
	#30 dwn =1'b1;
	#20  up =1'b0;
	
	
	#30 $stop;
  end
  

endmodule