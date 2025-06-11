
module cntr (clk,rst,
  d,q);
  input      clk,rst;
  input     [1:0]d;
  output     [1:0]q; //FF outputs
 // output     p;
  
  reg        [1:0]q;
  initial q = 1'b0;
  
  always @(posedge clk)
  begin
	q[1:0] <= q[1:0]+1'b1;
  end
   
endmodule