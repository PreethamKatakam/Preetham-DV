
module cntr1 (clk,rst,
  d,q);
  input      clk,rst;
  input     [2:0]d;
  output     [2:0]q; //FF outputs
 // output     p;
  
  reg        [2:0]q;
  initial q[2:0] = 3'b0;
  
  always @(posedge clk)
  begin
  if(q[1] & q[0])
	q[1:0] <= 2'b0;
  else
	q[2:0] <= q[2:0] +1'b1;
  end
   
endmodule