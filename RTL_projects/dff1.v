
module dff1 (clk,
  d1,q1,op);
  input      clk;
  input      d1;//,d2; //FF inputs
  output     q1; //FF outputs
  output     op;    //OR gate output

  reg        q1;
  wire p;
  assign p = q1;
  assign op = d1 | p;

  always @(posedge clk)
  begin
    q1 <= d1;	  
  end
   
endmodule