module cntr1_TB;

  reg clk;
  reg rst;
  reg [2:0]d;
  wire [2:0]q;
  
  
  cntr1 cntr1_inst(.clk(clk), .rst(rst),
          .d(d), .q(q));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
  //  rst =1'b0;
	clk =1'b0;
	d  =3'b0;
	end
	

	initial	begin
    	#100 $stop;
  end
  

endmodule