module AES_sample_tb;
  
  reg 			   rst,clk,start;	
  reg	   [127:0] plain_text;
  reg	   [127:0] inti_key;		
  
  wire 	   [127:0] cipher_text;
  wire		cipher_done,clk1;
  
  //integer f,i;
  
 
  
  
  AES_sample AES_sample_init(.rst(rst),
								.clk(clk),
							   .plain_text(plain_text), 
							   .start(start),
							   .inti_key(inti_key), 
							   .cipher_text(cipher_text),
							   .cipher_done(cipher_done),
							   .clk1(clk1));


  
  //plaint text
 /* initial begin
	rst			=1'b0;
	#10
	rst			=1'b1;
	plain_text	=128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	//2b7e151628aed2a6abf7158809cf4f3c;
	//d4bf5d30e0b452aeb84111f11e2798e5;
	//2b7e151628aed2a6abf7158809cf4f3c;
	
	#100 $stop;
  end
  */
   always #5 clk = ~clk;
	  
  //plaint text
  initial begin
		rst			=1'b0;
	#10	rst			=1'b1;
	#10 rst			=1'b0;
	
	#500 $stop;
	
  end
  
  initial begin
	clk			=1'b0;		
  end
  
  initial begin
			start		=1'b0;
	#35 	start		=1'b1;	
	end
  
  
  initial begin
	#15
	plain_text	=128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	inti_key	=128'h000102030405060708090a0b0c0d0e0f; 
	
  end
  
endmodule