`include "uvm_macros.svh"
import uvm_pkg::*;

`include "APB_SEQ_ITEM.sv"
`include "APB_SEQR.sv"
`include "APB_SEQ.sv"
`include "APB_DRV.sv"
`include "APB_MON1.sv"
`include "APB_MON2.sv"
`include "APB_AGENT1.sv"
`include "APB_AGENT2.sv"
`include "APB_SB.sv"
`include "APB_ENV.sv"
`include "APB_TEST.sv"
`include "APB_TEST1.sv"
`include "APB_TEST2.sv"
`include "APB_TEST3.sv"
`include "APB_TEST4.sv"
`include "APB_TEST5.sv"
`include "APB_TEST6.sv"
`include "APB_TEST7.sv"
`include "APB_TEST8.sv"
`include "APB_TEST9.sv"
`include "APB_TEST10.sv"
    
`include "APB_DUT.sv"
`include "APB_IF.sv"
`include "APB_DESIGN.sv"
`include"APB_ASSERTION.sv"

module apb_top;
bit pclk,prst;

apb_if intf(pclk,prst);
APB_dut dut(intf);
bind apb_design_n apb_asser aa(.pclk(pclk),
                               .prst(prst),
                               .pwrite(pwrite),
                               .paddr(paddr),
                               .pwdata(pwdata),
                               .psel(psel),
                               .pen(pen),
                               .pready(pready),
                               .prdata(prdata));

initial begin
prst=1;
#10;
prst=0;
end

initial begin
pclk=1'b0;
forever #5 pclk=~pclk;
end

initial begin
uvm_config_db#(virtual apb_if)::set(uvm_root::get(),"*","intf",intf);
run_test("apb_test2");//WR_RD,incr,decr
end
endmodule

