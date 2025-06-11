
module attendence (clk,rst,
  entry,exit,class_count,bulb);
  input      clk,rst;
  input		 exit,entry;
  output reg [5:0] class_count; //FF outputs
  //output reg [5:0]exit_c; //FF outputs
  //output  [5:0]tot; //FF outputs  
  output reg bulb;
  
  //reg        q[3:0];
  
  //initial q = 1'b0;
  
  //difference
  //wire signed tot;
  //assign tot[5:0] = entry_c[5:0] - exit_c[5:0];
  
  //class_count
  always @(posedge clk)  begin
  if(rst) begin
    class_count[5:0] <= 6'd0;
	//bulb = 1'd0;
	end
  else if((class_count[5:0] == 6'd0) && exit)
	class_count[5:0] <= 6'd0;
  else if(entry & exit)
	class_count[5:0] <= class_count[5:0];
  else if(entry)
	class_count[5:0] <= class_count[5:0] + 1'd1;
  else if(exit)
	class_count[5:0] <= class_count[5:0] - 1'd1;
  end
  
  // //Exit
  // always @(posedge clk)
  // begin
  // if(rst)
    // exit_c[5:0] <= 6'd0;
  // else if(exit)
	// exit_c[5:0] <= exit_c[5:0] + 6'd1;
  // end
  
  //tot
  // always @(posedge clk)
  // begin
  // if(rst)
    // tot[5:0] <= 6'd0;
  // else
	// tot[5:0] <= entry_c[5:0] - exit_c[5:0];
  // end
  
  
  //bulb
 // always @(posedge clk)
 //initial
  always @(class_count)
  begin
  //if(rst)
    //bulb <= 6'd0;
  //else 
  if(class_count == 0)
	 bulb =  1'd0;
  else if(class_count > 0)
	 bulb =  1'd1;
  end
   
   
endmodule