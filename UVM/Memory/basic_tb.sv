// Code your testbench here
// or browse Examples
module basic_tb;
  
  reg clk,we;
  reg [3:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;
  
  mem dut(clk,addr,data_in,we,data_out);
  
  
  always #5 clk = ~clk;
  
  initial begin
    clk	=1'b0;
    we	=1'b0;
    addr=4'b1101;
    data_in=8'b10010110;
    #23 we =1'b1;
    #100 $stop;
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
  end
  
  
  
endmodule