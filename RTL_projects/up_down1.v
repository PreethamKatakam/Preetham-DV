
module up_down1 (clk,rst,
  up_dn,q);
  input      clk,rst;
  input		 up_dn;
 // input      d[3:0];
  output reg [2:0]q; //FF outputs
  
  //reg        q[3:0];
  
  //initial q = 1'b0;
  
  always @(posedge clk)
  begin
  if(rst)
    q[2:0] <= 3'd0;
  else if(up_dn)	
	q[2:0] <= q[2:0] + 1'd1;
  else if(!up_dn) 
	q[2:0] <= q[2:0] - 1'd1;
  end
   
endmodule