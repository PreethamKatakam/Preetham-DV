// Code your design here
module mem(clk, addr,  data_in, we, data_out);
  
  input clk,we;
  input [3:0] addr; //has 16 address locations
  input [7:0] data_in;
  output reg [7:0] data_out;
  
  reg [7:0]m_m[15:0]; //16x8 memory
  
  always @(posedge clk) begin
    
    if(we) begin
      m_m[addr] <= data_in;
    end
    
    else begin
      data_out <= m_m[addr];
    end
    
  end
  
endmodule