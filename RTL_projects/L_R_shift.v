
module L_R_shift (clk,rst,cntl,
  d,q);
  input      clk,rst,cntl;
  input     d;
  output     [2:0]q; //FF outputs
 // output     p;
  
  reg        [2:0]q;
  initial q[2:0] = 3'b0;
  
  always @(posedge clk)
  begin
  if(!cntl) begin
	q[2] <= d;
	q[1] <= q[2];
	q[0] <= q[1];
	end
  else if(cntl) begin
	q[2] <= q[1];
	q[1] <= q[0];
	q[0] <= d;
	end
  end
   
endmodule