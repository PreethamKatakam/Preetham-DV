// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "rou_base_test.sv"
`include "rou_rand_test.sv"

module top_tb;
  bit clk;
  bit rst;
  
  always #5 clk = ~clk;
  rou_if intf(clk,rst);
  router DUT (intf.Rou_In,
              intf.clk,
              intf.rst,
              intf.en,
              intf.Rou_Out);
  
  
  initial begin
    clk = 1'b0;
    rst = 1'b1;
    #25 rst = 1'b0;
  end
  
  always @( *) begin
    intf.out_rand0 = DUT.out_rand[0];
    intf.out_rand1 = DUT.out_rand[1];
    intf.out_rand2 = DUT.out_rand[2];
    intf.out_rand3 = DUT.out_rand[3];
    //$display("%d",DUT.index);
  end
  initial begin
    uvm_config_db#(virtual rou_if) :: set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  
  initial begin
    run_test("rou_rand_test");
  end
  
endmodule