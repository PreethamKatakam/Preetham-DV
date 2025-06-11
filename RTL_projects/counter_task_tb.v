module counter_task_tb();

reg rst,clk;
reg load1,load2;

wire count1,count2;

counter_task counter_task_init(.rst(rst),
								.clk(clk),
								.load1(load1),
								.load2(load2),
								.count1(count1),
								.count2(count2));
								
	always #5 clk = ~clk;
	
	initial begin
    rst =1'b0;
	clk =1'b0;
	load1  =1'b0;
	load2  =1'b0;
	end
	

	initial	begin
    	
	#7 rst =1'b1;
	#10 rst =1'b0;
	
	#15 load1 = 1'b1;
	#20 load2 = 1'b1;
	
	end
	
	endmodule
		