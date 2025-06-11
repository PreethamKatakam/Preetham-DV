
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