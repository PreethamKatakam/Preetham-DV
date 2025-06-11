`include "uvm_macros.svh"
import uvm_pkg::*;

`include "qr_intf.sv"
`include "qr_base_test.sv"
module qr_tb;
  
  reg clk;
  reg rst;
  
  always #5 clk = ~clk;
  
  qr_intf qr_if(.clk(clk));
  
  qr_lite dut(.clk(qr_if.clk),
              .rst_b(qr_if.rst_b),
              .accept_s(qr_if.accept_s),
              .data_s(qr_if.data_s),
              .final_s(qr_if.final_s),
              .create_b(qr_if.create_b),
              .qr(qr_if.qr)
             );
  
  initial begin
    clk=0;
   // rst=0;
    //#40
    //rst=1;
    
    #1000 $stop;
  end
  initial begin
    uvm_config_db#(virtual qr_intf)::set(uvm_root::get(),"*","vif",qr_if);
    $dumpfile("dump.vcd"); $dumpvars;
  end
  initial begin
  	run_test("qr_base_test");
  end
endmodule

