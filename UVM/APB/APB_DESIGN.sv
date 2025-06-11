module apb_design_n(pclk,prst,psel,pen,paddr,pwrite,pwdata,pready,prdata);
input pclk,prst,psel,pen,pwrite;
input [7:0]paddr,pwdata;
output pready;
output reg [7:0]prdata;
reg [7:0]mem[0:255];
parameter IDLE=2'b00;
parameter SETUP=2'b01;
parameter ACCESS=2'b10;
reg [1:0] state,next_state;
assign pready=(psel && pen);
always@(posedge pclk)
begin
	if(prst)
	begin
	prdata<=0;
	state<=IDLE;
	end
	else
	state<=next_state;
end
always@(*)
begin
case(state)
	IDLE:if(psel==1'b1 && pen==1'b0)
		next_state=SETUP;
		else
		next_state=IDLE;
	SETUP:if(psel==1'b1 && pen==1'b1)
		next_state=ACCESS;
		else if(psel==1'b1 && pen==1'b0)
		next_state=SETUP;
		else
		next_state=IDLE;
	ACCESS:if(psel==1'b1 && pen==1'b1) begin
		if(pwrite==1'b1) begin
		mem[paddr]<=pwdata;
		end
		else
		prdata<=mem[paddr];
		end
		else if(psel==1'b1 && pen==1'b0)
		next_state=SETUP;
		else
		next_state=IDLE;
endcase
end

endmodule

