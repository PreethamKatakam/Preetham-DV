
module samp_ckt_1 (clk,
  d1,q1,q2,q3,q4,op);
  input      clk;
  input      d1;//,d2; //FF inputs
  output     q1,q2,q3,q4; //FF outputs
  output     op;    //OR gate output

  reg        q1,q2,q3,q4;
  wire p,q,r,s;
  assign p = q1;
  assign q = q2;
  assign r = q3;
  assign s = q4;
  assign d2 = q1;
  assign d3 = q2;
  assign d4 = q3;
  assign op = r | s;

  always @(posedge clk)
  begin
    q1 <= d1;	  
  end
  
  always @(posedge clk)  
  begin
	q2 <= d2;
  end
  
  always @(posedge clk)  
  begin
	q3 <= d3;
  end
  
  always @(posedge clk)  
  begin
	q4 <= d4;
  end
  
  
endmodule