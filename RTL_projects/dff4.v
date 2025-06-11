
module dff4 (clk,rst,
  d,q,p);
  input      clk,rst;
  input      d;
  output     q; //FF outputs
  output     p;
  
  reg        q;
  wire p;
  assign p = !q & d;
  
  initial q = 1'b0;
  
  always @(posedge clk)
  begin
  if(rst)
    q <= 1'b0;
  else
	q <= d;
  end
   
endmodule