
module rand_cntr (clk,rst,
  d,q);
  input      clk,rst;
  input    wire [2:0]d;
  output     [2:0]q; //FF outputs
 // output     p;
  
  reg        [2:0]q;
  initial q[2:0] = 3'b0;
  wire [2:0]d1;
  assign d1[2]=	!q[2];
  assign d1[1]=	q[1] ^ q[2];
  assign d1[0]=	q[1] & !q[2];
  
  always @(posedge clk)
  begin
	q[2] <= d1[2];//!q[2];
	q[1] <= d1[1];//q[1] ^ q[2];
	q[0] <= d1[0];//q[1] & !q[2];
	
  end
   
endmodule