
module freq_div (clk,rst,
  d,q1,q2);
  input      clk,rst;
  input     d;
  output     q1,q2; //FF outputs
 // output     p;
  
  reg      q1,q2;
  initial q1 = 1'b0;
  initial q2 = 1'b0;
  
  //assign p=!q;
  always @(posedge clk)
  begin
	q1 <= !q1;
  end
  always @(posedge q1)
  begin
	q2 <= !q2;
  end
   
endmodule



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
