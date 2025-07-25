// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;


`include "package.sv"

module spi_tb;
  
  bit clk;


   always #10 clk = ~clk;
  
   spi_interface intf(clk);
   spi_wrapper dut(.clk(intf.clk),
                   .rst(intf.rst),
                   .cs1_n(intf.cs1_n),
                   .cs2_n(intf.cs2_n),
                   .data_m(intf.data_m),
                   .data_s1(intf.data_s1),
                   .data_s2(intf.data_s2));
  
  
 
  // master signals
  assign intf.mosi= dut.master.mosi;
  assign intf.int_miso_m=dut.master.int_miso_m;
  assign intf.int_mosi_m=dut.master.int_mosi_m;
  assign intf.cnt=dut.master.cnt;
  assign intf.en=dut.master.en;
  //slave signals
  assign intf.miso1 = dut.slave1.miso;
  assign intf.int_mosi_s1=dut.slave1.int_mosi_s;
  assign intf.int_miso_s1=dut.slave1.int_miso_s;
  //slave2
    assign intf.miso2 = dut.slave2.miso;                
	assign intf.int_mosi_s2=dut.slave2.int_mosi_s; 
    assign intf.int_miso_s2=dut.slave2.int_miso_s;
    
                   
                   
  initial begin
    uvm_config_db#(virtual spi_interface)::set(null,"*","vif",intf);
    run_test("spi_test");
  
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule
