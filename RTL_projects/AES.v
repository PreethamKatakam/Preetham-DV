module AES(rst,
			plain_text,
			inti_key,
			cipher_text);


	//inputs
	input 		   rst;					//reset
	input  [127:0] plain_text;			//input plain message data
	input  [127:0] inti_key;			//initial cipher key

	//outputs
	output [127:0] cipher_text;			//Output ciphered data

	//data types
	//typedef logic 	[7 :0]  byte1;
	wire   		 	[32:0]  round_cnst;					//round constant for key expansion

	reg   		 	[7:0]  inp_byte [15:0];				//converting the plain_text input bits into bytes
	reg  		 	[7:0]  state_pt [3 :0][3:0];		//storing the plain_text byte values as states
	reg  		 	[7:0]  state_ck [3 :0][3:0];		//storing the cipher key values as states
	reg				[7:0]  sub_box[15:0][15:0];
	reg  		 	[7:0]  roundkey_t  [3 :0][3:0];		//roundkey transformation: xor of state_pt and state_ck
	reg  		 	[7:0]  sbox_t  [3 :0][3:0];			//substitute the values in roundkey_t matrix from sub_box
	reg  		 	[7:0]  shiftrow_t  [3 :0][3:0];		//shiftrow transformation matrix from sbox_t matrix	
	reg				[4:0]  shift_amount;				//amount of bits to be shifted
	reg 			[31:0] tempword;					//hold the row of a matrix
	reg 			[31:0] tempword_cir_shift;			//tempword circular shift result
	
	
		
	
	integer i,j;


	//Code begin
	
	//tasks
	
	//display tasks
	task display_state(input [7:0]  state [3 :0][3:0]);
		//		
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",state[i][j]);	
			end
			$display("Hello");
		end			
	endtask
	
	
	//This block of code converts the input plain_text of bits into bytes and then into state_pt matrix 
	/*
	initial begin
	#20
	$display("plain_text = %h",plain_text);
		//converting input bits to bytes
		for(i = 15 ; i>=0 ; i = i-1) begin
			inp_byte[15-i] = plain_text[(8*i) + : (8)];	//the range is from 8i to 8i+8
		end
		
		//displaying inp_byte and plain_text to compare them
		$display("\n Byte vs Plain_text Conversion");
		for(i = 0 ; i<=15 ; i = i+1) begin
			$display("inp_byte[%d] = %h,	plain_text[%d:%d]= %h",i,inp_byte[i],(8*(15-i)+7),(8*(15-i)),plain_text[(8*(15-i)) + : (8)]);
		end
		
		//converting the bytes into state_pt matrix
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_pt[i][j] = inp_byte[i + (4*j)];	
			end
		end
		
		//displaying inp_byte
		$display("\n state_pt matrix from inp_byte");
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",state_pt[i][j]);	
			end
			$display("");
		end			
		
	end*/
	
	
	//This block of code converts the input plain_text of bits directly into state_pt matrix 
	always @ (posedge rst)
	begin
	// sub_box[0][15:0]='{8'h63,8'h7c,8'h77,8'h7b,8'hf2,8'h6b,8'h6f,8'hc5,8'h30,8'h01,8'h67,8'h2b,8'hfe,8'hd7,8'hab,8'h76};
	//Sbox instantiation
	
	sub_box[0][0] <= 8'h63;		sub_box[0][1] <= 8'h7c;		sub_box[0][2] <= 8'h77;		sub_box[0][3] <= 8'h7b;		sub_box[0][4] <= 8'hf2;		sub_box[0][5] <= 8'h6b;		sub_box[0][6] <= 8'h6f;		sub_box[0][7] <= 8'hc5;		sub_box[0][8] <= 8'h30;		sub_box[0][9] <= 8'h01;		sub_box[0][10] <= 8'h67;	sub_box[0][11] <= 8'h2b;	sub_box[0][12] <= 8'hfe;	sub_box[0][13] <= 8'hd7;	sub_box[0][14] <= 8'hab;	sub_box[0][15] <= 8'h76;	
	
	sub_box[1][0] <= 8'hca;		sub_box[1][1] <= 8'h82;		sub_box[1][2] <= 8'hc9;		sub_box[1][3] <= 8'h7d;		sub_box[1][4] <= 8'hfa;		sub_box[1][5] <= 8'h59;		sub_box[1][6] <= 8'h47;		sub_box[1][7] <= 8'hf0;		sub_box[1][8] <= 8'had;		sub_box[1][9] <= 8'hd4;		sub_box[1][10] <= 8'ha2;	sub_box[1][11] <= 8'haf;	sub_box[1][12] <= 8'h9c;	sub_box[1][13] <= 8'ha4;	sub_box[1][14] <= 8'h72;	sub_box[1][15] <= 8'hc0;
	
	sub_box[2][0] <= 8'hb7;		sub_box[2][1] <= 8'hfd;		sub_box[2][2] <= 8'h93;		sub_box[2][3] <= 8'h26;		sub_box[2][4] <= 8'h36;		sub_box[2][5] <= 8'h3f;		sub_box[2][6] <= 8'hf7;		sub_box[2][7] <= 8'hcc;		sub_box[2][8] <= 8'h34;		sub_box[2][9] <= 8'ha5;		sub_box[2][10] <= 8'he5;	sub_box[2][11] <= 8'hf1;	sub_box[2][12] <= 8'h71;	sub_box[2][13] <= 8'hd8;	sub_box[2][14] <= 8'h31;	sub_box[2][15] <= 8'h15;	
	
	sub_box[3][0] <= 8'h04;		sub_box[3][1] <= 8'hc7;		sub_box[3][2] <= 8'h23;		sub_box[3][3] <= 8'hc3;		sub_box[3][4] <= 8'h18;		sub_box[3][5] <= 8'h96;		sub_box[3][6] <= 8'h05;		sub_box[3][7] <= 8'h9a;		sub_box[3][8] <= 8'h07;		sub_box[3][9] <= 8'h12;		sub_box[3][10] <= 8'h80;	sub_box[3][11] <= 8'he2;	sub_box[3][12] <= 8'heb;	sub_box[3][13] <= 8'h27;	sub_box[3][14] <= 8'hb2;	sub_box[3][15] <= 8'h75;
	
	sub_box[4][0] <= 8'h09;		sub_box[4][1] <= 8'h83;		sub_box[4][2] <= 8'h2c;		sub_box[4][3] <= 8'h1a;		sub_box[4][4] <= 8'h1b;		sub_box[4][5] <= 8'h6e;		sub_box[4][6] <= 8'h5a;		sub_box[4][7] <= 8'ha0;		sub_box[4][8] <= 8'h52;		sub_box[4][9] <= 8'h3b;		sub_box[4][10] <= 8'hd6;	sub_box[4][11] <= 8'hb3;	sub_box[4][12] <= 8'h29;	sub_box[4][13] <= 8'he3;	sub_box[4][14] <= 8'h2f;	sub_box[4][15] <= 8'h84;
	
	sub_box[5][0] <= 8'h53;		sub_box[5][1] <= 8'hd1;		sub_box[5][2] <= 8'h00;		sub_box[5][3] <= 8'hed;		sub_box[5][4] <= 8'h20;		sub_box[5][5] <= 8'hfc;		sub_box[5][6] <= 8'hb1;		sub_box[5][7] <= 8'h5b;		sub_box[5][8] <= 8'h6a;		sub_box[5][9] <= 8'hcb;		sub_box[5][10] <= 8'hbe;	sub_box[5][11] <= 8'h39;	sub_box[5][12] <= 8'h4a;	sub_box[5][13] <= 8'h4c;	sub_box[5][14] <= 8'h58;	sub_box[5][15] <= 8'hcf;
	
	sub_box[6][0] <= 8'hd0;		sub_box[6][1] <= 8'hef;		sub_box[6][2] <= 8'haa;		sub_box[6][3] <= 8'hfb;		sub_box[6][4] <= 8'h43;		sub_box[6][5] <= 8'h4d;		sub_box[6][6] <= 8'h33;		sub_box[6][7] <= 8'h85;		sub_box[6][8] <= 8'h45;		sub_box[6][9] <= 8'hf9;		sub_box[6][10] <= 8'h02;	sub_box[6][11] <= 8'h7f;	sub_box[6][12] <= 8'h50;	sub_box[6][13] <= 8'h3c;	sub_box[6][14] <= 8'h9f;	sub_box[6][15] <= 8'ha8;
	
	sub_box[7][0] <= 8'h51;		sub_box[7][1] <= 8'ha3;		sub_box[7][2] <= 8'h40;		sub_box[7][3] <= 8'h8f;		sub_box[7][4] <= 8'h92;		sub_box[7][5] <= 8'h9d;		sub_box[7][6] <= 8'h38;		sub_box[7][7] <= 8'hf5;		sub_box[7][8] <= 8'hbc;		sub_box[7][9] <= 8'hb6;		sub_box[7][10] <= 8'hda;	sub_box[7][11] <= 8'h21;	sub_box[7][12] <= 8'h10;	sub_box[7][13] <= 8'hff;	sub_box[7][14] <= 8'hf3;	sub_box[7][15] <= 8'hd2;
	
	sub_box[8][0] <= 8'hcd;		sub_box[8][1] <= 8'h0c;		sub_box[8][2] <= 8'h13;		sub_box[8][3] <= 8'hec;		sub_box[8][4] <= 8'h5f;		sub_box[8][5] <= 8'h97;		sub_box[8][6] <= 8'h44;		sub_box[8][7] <= 8'h17;		sub_box[8][8] <= 8'hc4;		sub_box[8][9] <= 8'ha7;		sub_box[8][10] <= 8'h7e;	sub_box[8][11] <= 8'h3d;	sub_box[8][12] <= 8'h64;	sub_box[8][13] <= 8'h5d;	sub_box[8][14] <= 8'h19;	sub_box[8][15] <= 8'h73;
	
	sub_box[9][0] <= 8'h60;		sub_box[9][1] <= 8'h81;		sub_box[9][2] <= 8'h4f;		sub_box[9][3] <= 8'hdc;		sub_box[9][4] <= 8'h22;		sub_box[9][5] <= 8'h2a;		sub_box[9][6] <= 8'h90;		sub_box[9][7] <= 8'h88;		sub_box[9][8] <= 8'h46;		sub_box[9][9] <= 8'hee;		sub_box[9][10] <= 8'hb8;	sub_box[9][11] <= 8'h14;	sub_box[9][12] <= 8'hde;	sub_box[9][13] <= 8'h5e;	sub_box[9][14] <= 8'h0b;	sub_box[9][15] <= 8'hdb;
	
	sub_box[10][0] <= 8'he0;	sub_box[10][1] <= 8'h32;	sub_box[10][2] <= 8'h3a;	sub_box[10][3] <= 8'h0a;	sub_box[10][4] <= 8'h49;	sub_box[10][5] <= 8'h06;	sub_box[10][6] <= 8'h24;	sub_box[10][7] <= 8'h5c;	sub_box[10][8] <= 8'hc2;	sub_box[10][9] <= 8'hd3;	sub_box[10][10] <= 8'hac;	sub_box[10][11] <= 8'h62;	sub_box[10][12] <= 8'h91;	sub_box[10][13] <= 8'h95;	sub_box[10][14] <= 8'he4;	sub_box[10][15] <= 8'h79;
	
	sub_box[11][0] <= 8'he7;	sub_box[11][1] <= 8'hc8;	sub_box[11][2] <= 8'h37;	sub_box[11][3] <= 8'h6d;	sub_box[11][4] <= 8'h8d;	sub_box[11][5] <= 8'hd5;	sub_box[11][6] <= 8'h4e;	sub_box[11][7] <= 8'ha9;	sub_box[11][8] <= 8'h6c;	sub_box[11][9] <= 8'h56;	sub_box[11][10] <= 8'hf4;	sub_box[11][11] <= 8'hea;	sub_box[11][12] <= 8'h65;	sub_box[11][13] <= 8'h7a;	sub_box[11][14] <= 8'hae;	sub_box[11][15] <= 8'h08;
	
	sub_box[12][0] <= 8'hba;	sub_box[12][1] <= 8'h78;	sub_box[12][2] <= 8'h25;	sub_box[12][3] <= 8'h2e;	sub_box[12][4] <= 8'h1c;	sub_box[12][5] <= 8'ha6;	sub_box[12][6] <= 8'hb4;	sub_box[12][7] <= 8'hc6;	sub_box[12][8] <= 8'he8;	sub_box[12][9] <= 8'hdd;	sub_box[12][10] <= 8'h74;	sub_box[12][11] <= 8'h1f;	sub_box[12][12] <= 8'h4b;	sub_box[12][13] <= 8'hbd;	sub_box[12][14] <= 8'h8b;	sub_box[12][15] <= 8'h8a;
	
	sub_box[13][0] <= 8'h70;	sub_box[13][1] <= 8'h3e;	sub_box[13][2] <= 8'hb5;	sub_box[13][3] <= 8'h66;	sub_box[13][4] <= 8'h48;	sub_box[13][5] <= 8'h03;	sub_box[13][6] <= 8'hf6;	sub_box[13][7] <= 8'h0e;	sub_box[13][8] <= 8'h61;	sub_box[13][9] <= 8'h35;	sub_box[13][10] <= 8'h57;	sub_box[13][11] <= 8'hb9;	sub_box[13][12] <= 8'h86;	sub_box[13][13] <= 8'hc1;	sub_box[13][14] <= 8'h1d;	sub_box[13][15] <= 8'h9e;
	
	sub_box[14][0] <= 8'he1;	sub_box[14][1] <= 8'hf8;	sub_box[14][2] <= 8'h98;	sub_box[14][3] <= 8'h11;	sub_box[14][4] <= 8'h69;	sub_box[14][5] <= 8'hd9;	sub_box[14][6] <= 8'h8e;	sub_box[14][7] <= 8'h94;	sub_box[14][8] <= 8'h9b;	sub_box[14][9] <= 8'h1e;	sub_box[14][10] <= 8'h87;	sub_box[14][11] <= 8'he9;	sub_box[14][12] <= 8'hce;	sub_box[14][13] <= 8'h55;	sub_box[14][14] <= 8'h28;	sub_box[14][15] <= 8'hdf;
	
	sub_box[15][0] <= 8'h8c;	sub_box[15][1] <= 8'ha1;	sub_box[15][2] <= 8'h89;	sub_box[15][3] <= 8'h0d;	sub_box[15][4] <= 8'hbf;	sub_box[15][5] <= 8'he6;	sub_box[15][6] <= 8'h42;	sub_box[15][7] <= 8'h68;	sub_box[15][8] <= 8'h41;	sub_box[15][9] <= 8'h99;	sub_box[15][10] <= 8'h2d;	sub_box[15][11] <= 8'h0f;	sub_box[15][12] <= 8'hb0;	sub_box[15][13] <= 8'h54;	sub_box[15][14] <= 8'hbb;	sub_box[15][15] <= 8'h16;	

	#20
	
	$display("plain_text = %h \n inti_key = %h",plain_text, inti_key);
		
		//converting the plain_text into state_pt matrix
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_pt[i][j] = plain_text[(8*(15-(i+4*j))) + : (8)];
				state_ck[i][j] = inti_key[(8*(15-(i+4*j))) + : (8)];
			end
		end
		
		//roundkey_t: xor of state_pt and state_ck
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				roundkey_t[i][j] = state_pt[i][j] ^ state_ck[i][j] ;
			end
		end
		
		//sbox transformation
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				sbox_t[i][j] = sub_box[roundkey_t[i][j][7:4]][roundkey_t[i][j][3:0]]  ;
			end
		end
		
		//shiftrow transformation
		
		// shiftrow_t[0][0]=sbox_t[0][0];
		// shiftrow_t[0][]=sbox_t[0][0];
		// shiftrow_t[0][0]=sbox_t[0][0];
		// shiftrow_t[0][0]=sbox_t[0][0];
	
		for(i = 0; i<4 ; i = i+1) begin
			if(i==0) begin
				shift_amount=5'd0;						
			end
			if(i==1) begin
				shift_amount=5'd8;						
			end
			if(i==2) begin
				shift_amount=5'd16;						
			end
			if(i==3) begin
				shift_amount=5'd24;						
			end
			
			tempword={sbox_t[i][0],sbox_t[i][1],sbox_t[i][2],sbox_t[i][3]};
			//$display("%h",tempword);
			tempword_cir_shift=(tempword << shift_amount) | (tempword >> (32 - shift_amount));
			shiftrow_t[i][0] = tempword_cir_shift[31:24];
			shiftrow_t[i][1] = tempword_cir_shift[23:16];
			shiftrow_t[i][2] = tempword_cir_shift[15:8];
			shiftrow_t[i][3] = tempword_cir_shift[7:0];
		end
		
		
		
		//displaying state_pt matrix
		$display("\nstate matrix for plain_text");
		//display_state(state_pt);
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",state_pt[i][j]);	
			end
			$display("");
		end			
		
		//displaying state_ck matrix
		$display("\nstate matrix for inti_key");
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",state_ck[i][j]);	
			end
			$display("");
		end
			
		//displaying Sbox matrix
		$display("\nstate matrix for round key transformation");
		for(i = 0; i<16 ; i = i+1) begin
			for(j = 0; j<16 ; j = j+1) begin
				$write("%h \t",sub_box[i][j]);	
			end
			$display("");
		end
			
		
		//displaying roundkey_t matrix
		$display("\nstate matrix for round key transformation");
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",roundkey_t[i][j]);	
			end
			$display("");
		end			
		
		//displaying sbox_t matrix
		$display("\nstate matrix for round key transformation");
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",sbox_t[i][j]);	
			end
			$display("");
		end
		
		//$display("\n%h,%h",roundkey_t[0][0][7:4],roundkey_t[0][0][3:0]);
		
		//displaying shiftrow_t matrix
		$display("\nstate matrix for shift row transformation");
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				$write("%h \t",shiftrow_t[i][j]);	
			end
			$display("");
		end
		
		
		
	end
	
	// initial begin
	// #30
	// display_state(state_ck);
	// end
	
	
	
	
	
	
	endmodule