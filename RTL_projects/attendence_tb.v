module attendence_tb;

  reg clk;
  reg rst;
  reg entry,exit;
  //reg d;
  wire [5:0]class_count;
 // wire [5:0]exit_c;
 // wire [5:0]tot;
  wire bulb;
  
  
  attendence attendence_inst(.clk(clk), .rst(rst), .entry(entry), .exit(exit), .class_count(class_count),
           .bulb(bulb));
          
  always #5 clk = ~clk;
  
  
  
  
  initial begin
    rst =1'b0;
	clk =1'b0;
	entry  =1'b0;
	exit =1'b0;
	//d  =1'b0;
	end
	
//rst
	initial	begin
    	
	#7 rst =1'b1;
	#10 rst =1'b0;
	
	end
	
	//entry
	
	initial begin
	#15  entry =1'b1;
	#80  entry =1'b0;
	#20  entry =1'b1;
	#60  entry =1'b0;
	
	end
	
	//exit
	
	initial begin
	#30 exit =1'b1;
	#85 exit =1'b0;
	
	#400 $stop;
  end
  

endmodule