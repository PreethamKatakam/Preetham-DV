
module samp_ckt (clk, rst,
  d1,q1,q2,op);
  input      clk;
  input      rst;
  input      d1;//,d2; //FF inputs
  output     q1,q2; //FF outputs
  output     op;    //OR gate output

  reg        q1,q2;
  wire p,r;
  assign p = q1;
  assign r = q2;
  assign d2 = q1;
  assign op = p | r;

  always @(posedge clk or posedge rst)
  begin
    if (rst) begin
      // Initial values when rst is high
      q1 <= 1'b0;
	  q2 <= 1'b0;
    end 
	else begin
      q1 <= d1;
	  q2 <= d2;
    end
  end
endmodule