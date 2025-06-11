`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_intf.sv"
`include "mem_test.sv"

module mem_tb;
  reg clk,we;
  reg [3:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;
  
  
  always #5 clk =~clk;
  
  m_intf intf(clk);
  mem DUT(intf.clk,
          intf.addr,
          intf.data_in,
          intf.we,
          intf.data_out);
  
  always @(*) begin
    intf.m_m <= DUT.m_m;    
  end

  initial begin
    clk=1'b0;
    #1000 $stop;
  end
  
  initial begin
    uvm_config_db#(virtual m_intf)::set(uvm_root::get(),"*","vif",intf);
      $dumpfile("dump.vcd"); $dumpvars;
      
  end
  
  
  initial begin
    run_test("mem_test");
    
  end
  
endmodule
  