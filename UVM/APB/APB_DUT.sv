`include"APB_DESIGN.sv"
module APB_dut(apb_if .dut inf);
apb_design_n uut(.pclk(inf.pclk),.prst(inf.prst),.pen(inf.pen),.psel(inf.psel),.pready(inf.pready),
.pwrite(inf.pwrite),.pwdata(inf.pwdata),.paddr(inf.paddr),.prdata(inf.prdata));

endmodule 

