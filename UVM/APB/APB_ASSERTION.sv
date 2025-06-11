
module apb_asser(pclk,prst,pwrite,paddr,pwdata,psel,pen,pready,prdata);
input pclk,prst,pwrite;
input pen,psel,pready;
input [7:0]pwdata,prdata,paddr;

property reset;
@(posedge pclk)
prst|->##1 prdata==8'b0;
endproperty
rst_check:assert property(reset);

property write_data1;
@(posedge pclk)disable iff(prst)
pwrite|->!$isunknown(pwdata);
endproperty
data_check1:assert property(write_data1);

property write_data2;
@(posedge pclk)disable iff(prst)
(pwrite&&pen&&psel)|->!$isunknown(pwdata);
endproperty
data_check2:assert property(write_data2);

property read_data;
@(posedge pclk)disable iff(prst)
(!pwrite&&pen&&psel)|->!$isunknown(prdata);
endproperty
read_check:assert property(read_data);

property setup;
@(posedge pclk)
psel|->!pen|->!pready;
endproperty
setup_check:assert property(setup);


property access;
@(posedge pclk)
psel|->pen|->pready;
endproperty
access_check:assert property(access);
endmodule


