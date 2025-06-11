
module up_down (clk,rst,
  up,dwn,q);
  input      clk,rst;
  input		 up,dwn;
 // input      d[3:0];
  output reg [3:0]q; //FF outputs
  
  //reg        q[3:0];
  
  //initial q = 1'b0;
  
  always @(posedge clk)
  begin
  if(rst)
    q[3:0] <= 4'd0;
  else if(up & !dwn)
	q[3:0] <= q[3:0] + 4'd1;
  else if(dwn & !up) 
	q[3:0] <= q[3:0] - 4'd1;
  else if(up & dwn) 
	q[3:0] <= q[3:0] - 4'd1;	
  else
    q[3:0] <= q[3:0];
  end
   
endmodule