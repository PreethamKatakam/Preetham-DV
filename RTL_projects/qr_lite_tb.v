module qr_lite_tb;

  reg      clk,rst_b;
  reg      accept_s;
  reg	   [3:0] data_s;
  reg	   final_s;		
  reg	   create_b;
  
  wire 	   [10:0] qr;
  
  integer f,i;
  
 
  
  
  qr_lite qr_lite_inst(.clk(clk), 
					   .rst_b(rst_b), 
					   .accept_s(accept_s), 
					   .data_s(data_s), 
					   .final_s(final_s),
					   .create_b(create_b), 
					   .qr(qr));
          
  always #5 clk = ~clk;
  
  
  
  
	initial begin
		rst_b 		=1'b1;
		clk 		=1'b0;
		accept_s	=1'b0;
		data_s		=4'd0;
		create_b	=1'b0;		
	//$display("%b",qr_lite_inst.accept);
	repeat (2) @ (posedge clk);
	rst_b = 1'b0;
	
	end
	
	//file open
	// initial
    // begin
      // f = $fopen("qr_output.txt","w");
    // end
	
	// //initial begin
	// always@(posedge clk) begin
      // //for (i = 0; i<14; i=i+1)
	  // if(create_b)
        // $fdisplay(f,"%b\n",qr);
		// end
    // //end
	
	task writeToFile;
    begin
      // Open the file for writing
      f = $fopen("qr_output.txt", "a");

      // Check if the file opened successfully
      if (f == 0) begin
        $display("Error: Unable to open file for writing");
        $finish;
      end

      // Write data to the file using fdisplay
	  for(i=10 ; i>=0 ; i=i-1) begin
      $fwrite(f, "%b ", qr[i]);
	  end
	  $fdisplay(f,"");

      // Close the file
      $fclose(f);
    end
  endtask
	
	
	always @(posedge clk) begin
    // Call the task to write to the file
	if(create_b)    writeToFile;
  end
	
	
	
	//rst
//	initial	begin    	
	// #7 rst_b =1'b1;
	// #11 rst_b =1'b0;
	 	
	// #590 rst_b =1'b1;
	// #11 rst_b =1'b0;
	// end
	
	//data_s && accept_s
	initial begin
	#25  data_s = 4'b1110;
	#20 accept_s =1'b1;
	#20 accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
		
	#10  data_s = 4'b0011;
	#20  accept_s =1'b1;
	#20  accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	#10  data_s = 4'b1101;
	#20  accept_s =1'b1;
	#20 accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	#10  data_s = 4'b1011;
	#20 accept_s =1'b1;
	#20 accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	#10  data_s = 4'b1001;
	#20 accept_s =1'b1;
	#20  accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	#10  data_s = 4'b0001;
	#20  accept_s =1'b1;
	#20  accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
		
	#10  data_s = 4'b0011;
	#20  accept_s =1'b1;
	#20 accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	#10  data_s = 4'b1000;
	#20  accept_s =1'b1;
	#20  accept_s =1'b0;
	//$display("%b",qr_lite_inst.digit_cnt);
	
	
	
	// //for(i=0; i<10; i=i+1) begin
		// $display("%b",qr_lite_inst.internal_qr[11]);
		// $display("%b",qr_lite_inst.internal_qr[10]);
		// $display("%b",qr_lite_inst.internal_qr[9]);
		// $display("%b",qr_lite_inst.internal_qr[8]);
		// $display("%b",qr_lite_inst.internal_qr[7]);
		// $display("%b",qr_lite_inst.internal_qr[6]);
		// $display("%b",qr_lite_inst.internal_qr[5]);
		// $display("%b",qr_lite_inst.internal_qr[4]);
		// $display("%b",qr_lite_inst.internal_qr[3]);
		// $display("%b",qr_lite_inst.internal_qr[2]);
		// $display("%b",qr_lite_inst.internal_qr[1]);
		// $display("%b",qr_lite_inst.internal_qr[0]);
	// //end
	#400 $stop;
	end
	
	//final_s
	initial begin
	#450 final_s =1'b1;
	// $display("%b",qr_lite_inst.internal_qr[11]);
		// $display("%b",qr_lite_inst.internal_qr[10]);
		// $display("%b",qr_lite_inst.internal_qr[9]);
		// $display("%b",qr_lite_inst.internal_qr[8]);
		// $display("%b",qr_lite_inst.internal_qr[7]);
		// $display("%b",qr_lite_inst.internal_qr[6]);
		// $display("%b",qr_lite_inst.internal_qr[5]);
		// $display("%b",qr_lite_inst.internal_qr[4]);
		// $display("%b",qr_lite_inst.internal_qr[3]);
		// $display("%b",qr_lite_inst.internal_qr[2]);
		// $display("%b",qr_lite_inst.internal_qr[1]);
		// $display("%b",qr_lite_inst.internal_qr[0]);
	
	end
	
	//create_b
	initial begin
	#470 create_b =1'b1;
	#120 create_b =1'b0;
		
	end
	
	// initial
      // begin
        // $fclose(f);  
      // end
  
  

endmodule