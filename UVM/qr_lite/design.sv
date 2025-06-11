// Code your design here

module qr_lite (clk,
				rst_b,
				accept_s,
				data_s,
				final_s,
				create_b,
				qr);
  //inputs  
  input      clk,rst_b;
  input      accept_s;		//accept switch
  input		 [3:0] data_s;	//4 bit data switch
  input		 final_s;		//used for masking mode(0 => 00; 1 => 01 modes)
  input		 create_b;		//used for sending the data of internal_qr to output qr
  
  //outputs
  output reg [10:0] qr; //
  
  
  //Registers
  reg		 accept_reg;				//store accept_s value
  reg		 first_entry;				//Used to check 1st entry
  reg 		 count_match;                //matches counter
  reg        [10:0]internal_qr[10:0];	//store the qr data
  reg 		 [3:0] msg_cntr_1;			//compare with the msg_cntr
  reg		 [3:0] ms_count;			//stores the msg_cntr value
  reg		 [2:0] char_cnt;
  reg		 [3:0] op_cntr;				//counter to send 11x11 qr output
  reg		 mask_done;
  
  //wires
  wire		 accept;					//neg_edge detector for accept_s
  wire		 [2:0]digit_cnt; 			//message digits count
  wire 		 [3:0] msg_cntr;			//counter to get the 30 bit message {4 bits at a time} in 8 clk cycles // Gets value from ms_count
  wire		 [17:0] masked_bit1;		//stores 00 mask values
  wire		 [19:0] masked_bit2;		//stores 01 mask values

  
  
  
  //Detect accept up and down switching
  assign accept	= accept_reg & !accept_s;
  always @(posedge clk)  begin
  if(rst_b) begin
	accept_reg <= 1'b0;
	end
  else
	accept_reg <= accept_s;
  end	
  
  
  //Message counter
  always @(posedge clk)  begin
  if(rst_b) begin
	msg_cntr_1[3:0] <= 4'b0;
	end
  else if(accept)
	msg_cntr_1[3:0] <= msg_cntr_1[3:0] + 1'd1;
  //$display("msg_cntr_1=%b",msg_cntr_1);
	
  end
  
  
  //message counter based on no. of digits
  assign digit_cnt = char_cnt;
  always @(digit_cnt)  begin
	if(digit_cnt < 3'd3)
	 ms_count[3:0] = 4'd4;			//for digit count from 0 to 2 (excluding 1st entry count => 4-1)
	else if(digit_cnt < 3'd6)
	 ms_count[3:0] = 4'd6;			//for digit count from 3 to 5 (excluding 1st entry count => 6-1)
	else if(digit_cnt <= 3'd7)
	 ms_count[3:0] = 4'd8;			//for digit count from 6 to 7 (excluding 1st entry count => 8-1)
	//$display("ms_count=%b",ms_count);
	
  end
  assign msg_cntr = ms_count;
  
  
  
  //Memory reg
  always @(posedge clk)  begin
  if(rst_b) begin
	//initial mem value
    internal_qr[10] <= 11'b11111110101;
	internal_qr[9]  <= 11'b10000010000;
	internal_qr[8]  <= 11'b10111010000;
	internal_qr[7]  <= 11'b10111010000;
	internal_qr[6]  <= 11'b10111010000;
	internal_qr[5]  <= 11'b10000010000;
	internal_qr[4]  <= 11'b11111110000;
	internal_qr[3]  <= 11'b00000000000;
	internal_qr[2]  <= 11'b10000000000;
	internal_qr[1]  <= 11'b00000000011;
	internal_qr[0]  <= 11'b10000000000;
	
	//first_entry
	first_entry		<= 1'b1;	
	count_match		<= 1'b0;
	ms_count[3:0]   <= 4'd0;
	mask_done		<= 1'b0;
	
	end
  else if(accept && (msg_cntr[3:0] == 4'd0) && first_entry)	begin
	//$display("accept=%b,msg_cntr=%b,first_entry=%b",accept,msg_cntr,first_entry);
	$display("data=%b,internal_qr[2][1:0]=%b,internal_qr[3][1:0]=%b",data_s,internal_qr[2][1:0],internal_qr[3][1:0]);
	
  
	{ internal_qr[2][0],internal_qr[2][1],internal_qr[3][0] , internal_qr[3][1] }		<= data_s[3:0];
	//internal_qr[2] <= {10'b1000000000,data_s[3]};
	//internal_qr[2][1] <= data_s[2];
	//internal_qr[3][0] <= 1'b1;//data_s[1];
	//internal_qr[3][1] <= data_s[0];
	char_cnt[2:0] = data_s[3:1];
	first_entry	<= 1'b0;		//disabling 1st entry afer entering 1st 4 data switches
	$display("data=%b,internal_qr[2][1:0]=%b,internal_qr[3][1:0]=%b",data_s,internal_qr[2][1:0],internal_qr[3][1:0]);
	
		
	end
  else if((msg_cntr_1[3:0] == msg_cntr[3:0]) && (msg_cntr_1 != 4'd0) )	begin
  
	count_match			<= 1'b1; //Enabling only when msg_cntr and msg_cntr_1 are equal
		
	end
  else if(msg_cntr_1[3:0] == 4'd1 && !count_match)	begin
  
	{ internal_qr[4][0],internal_qr[4][1],internal_qr[5][0] , internal_qr[5][1] }			<= data_s[3:0];
	//$display("data=%b,internal_qr[2][1:0]=%b,internal_qr[3][1:0]=%b",data_s,internal_qr[2][1:0],internal_qr[3][1:0]);
	
		
	end
  else if(msg_cntr_1[3:0] == 4'd2 && !count_match)	begin
	
	{ internal_qr[6][0],internal_qr[6][1],internal_qr[7][0] , internal_qr[7][1] }			<= data_s[3:0];
		
	end
  else if(msg_cntr_1[3:0] == 4'd3 && !count_match)	begin
	
	{ internal_qr[8][0],internal_qr[8][1],internal_qr[9][0] , internal_qr[9][1] }			<= data_s[3:0];
		
	end
  else if(msg_cntr_1[3:0] == 4'd4 && !count_match)	begin
	
	{ internal_qr[0][2], internal_qr[1][2], internal_qr[0][3], internal_qr[1][3] }			<= data_s[3:0];
		
	end
  else if(msg_cntr_1[3:0] == 4'd5 && !count_match)	begin
	
	{ internal_qr[0][4], internal_qr[1][4], internal_qr[0][5], internal_qr[1][5] }			<= data_s[3:0];
		
	end
  else if(msg_cntr_1[3:0] == 4'd6 && !count_match)	begin
	
	{ internal_qr[0][6], internal_qr[1][6], internal_qr[0][7], internal_qr[1][7] }			<= data_s[3:0];
		
	end
  else if(msg_cntr_1[3:0] == 4'd7 && !count_match)	begin
	
	{ internal_qr[0][8], internal_qr[1][8] }												<= data_s[3:2];
		
	end
  end
  
  
  //When final_s is switching	
  always @(posedge clk)  begin
  
  //Applying Mask based on final_s
	if(!final_s && !mask_done) begin
	 internal_qr[9][2] <= 1'b0; 
	 internal_qr[8][2] <= 1'b0;		// assign mode value 00
	 {internal_qr[0][8:0], internal_qr[2][1:0], 
			internal_qr[4][1:0], internal_qr[6][1:0], 
			internal_qr[8][1:0]} 	<= {internal_qr[0][8:0], internal_qr[2][1:0], 
										internal_qr[4][1:0], internal_qr[6][1:0], internal_qr[8][1:0]} ^ 17'b11111111111111111;
	 mask_done	<=	1'b1;
	 // $display("final=%b,internal_qr[2]=%b,internal_qr[3][1:0]=%b",final_s,internal_qr[9],internal_qr[8]);
	 // $display("%b",internal_qr[11]);
		// $display("%b",internal_qr[10]);
		// $display("%b",internal_qr[9]);
		// $display("%b",internal_qr[8]);
		// $display("%b",internal_qr[7]);
		// $display("%b",internal_qr[6]);
		// $display("%b",internal_qr[5]);
		// $display("%b",internal_qr[4]);
		// $display("%b",internal_qr[3]);
		// $display("%b",internal_qr[2]);
		// $display("%b",internal_qr[1]);
		// $display("%b",internal_qr[0]);
	
	
    end
	else if(final_s && !mask_done) begin
	 internal_qr[9][2] = 1'b0; 
	 internal_qr[8][2] = 1'b1;		// assign mode value 01
	 {internal_qr[0][1:0], internal_qr[1][1:0], 
			internal_qr[0][5:4], internal_qr[1][5:4], 
			internal_qr[0][8]  , internal_qr[1][8]  ,
			internal_qr[4][1:0], internal_qr[5][1:0],
			internal_qr[8][1:0], internal_qr[9][1:0]} 			<= {internal_qr[0][1:0], internal_qr[1][1:0], 
																	internal_qr[0][5:4], internal_qr[1][5:4], 
																	internal_qr[0][8]  , internal_qr[1][8]  ,
																	internal_qr[4][1:0], internal_qr[5][1:0],
																	internal_qr[8][1:0], internal_qr[9][1:0]} ^
																	18'b111111111111111111;	
	 mask_done	<=	1'b1;
	  $display("final=%b,internal_qr[2]=%b,internal_qr[3][1:0]=%b",final_s,internal_qr[9],internal_qr[8]);
	
	end
	
	//Applying Error parity
	else if(mask_done) begin
	 internal_qr[7][2] <= internal_qr[7][1] ^ internal_qr[7][0];
	 internal_qr[6][2] <= internal_qr[6][1] ^ internal_qr[6][0];
	 internal_qr[5][2] <= internal_qr[5][1] ^ internal_qr[5][0];
	 internal_qr[4][2] <= internal_qr[4][1] ^ internal_qr[4][0];
	 internal_qr[3][2] <= internal_qr[3][1] ^ internal_qr[3][0];
	 internal_qr[2][2] <= internal_qr[1][2] ^ internal_qr[0][2];
	 internal_qr[2][3] <= internal_qr[1][3] ^ internal_qr[0][3];
	 internal_qr[2][4] <= internal_qr[1][4] ^ internal_qr[0][4];
	 internal_qr[2][5] <= internal_qr[1][5] ^ internal_qr[0][5];
	 internal_qr[2][6] <= internal_qr[1][6] ^ internal_qr[0][6];
	 internal_qr[2][7] <= internal_qr[1][7] ^ internal_qr[0][7];
	 internal_qr[2][8] <= internal_qr[1][8] ^ internal_qr[0][8];
	 end

  end
  
  
  //creating the output qr
  always @(posedge clk)  begin
  if(rst_b) begin
	qr[10:0] 	<= 11'd0;
	op_cntr 	<= 4'd10;
	end
  else if(create_b) begin
	qr[10:0]	<= internal_qr[op_cntr][10:0];
	op_cntr 	<= op_cntr-1'd1;
	end
  else
	qr[10:0] 	<= qr[10:0];
  end
  
  
  
   
   
endmodule