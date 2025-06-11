//created on 5/12/23 by preetha K
module AES_sample(rst,
			clk,
			start,
			plain_text,
			inti_key,
			cipher_done,
			cipher_text,
			clk1);


	//inputs
	input 			    rst;					//reset
	input 			    clk;					//clk
	input				start;					//starts the key expansion
	input  		[127:0] plain_text;				//input plain message data
	input  		[127:0] inti_key;				//initial cipher key

	//outputs
	output reg			cipher_done;		
	output reg	[127:0] cipher_text;			//Output ciphered data
	output reg  [5:0]	clk1;					//count no. of clk cycles

	//data types	
	
	//Substitution box
	wire			[7:0]  	sub_box	   	[15:0][15:0];	//has default values of sbox
	wire			[7:0]  	inv_sub_box	[15:0][15:0];	//has default values of Inverse sbox
	
	//transformation registers
	reg  		 	[7:0]  	roundkey_t [3:0][3:0];		//roundkey transformation: xor of state_pt and state_ck
	reg  		 	[7:0]  	sbox_t     [3:0][3:0];		//substitute the values in roundkey_t matrix from sub_box
	reg  		 	[7:0]  	shiftrow_t [3:0][3:0];		//shiftrow transformation matrix from sbox_t matrix	
	reg  		 	[7:0]   inv_mixcol_t  [3 :0][3:0];		//MixCol transformation matrix from shiftrow_t matrix	
	
	//round counter
	reg				[3:0]	round;						//round counter
	reg 			[3:0] 	nxt_round;					//next round value of round counter
	
	//round keys
	reg   		[32:0]  round_cnst[10:1];	//round constant for key expansion
	reg			[127:0] round1_key;
	reg			[127:0] round2_key;
	reg			[127:0] round3_key;
	reg			[127:0] round4_key;
	reg			[127:0] round5_key;
	reg			[127:0] round6_key;
	reg			[127:0] round7_key;
	reg			[127:0] round8_key;
	reg			[127:0] round9_key;
	reg			[127:0] round10_key;
	
	//key expansion words
	reg 			[31:0] word0[10:1];			//contains values [127:96]
	reg 			[31:0] word1[10:1];			//contains values [95:64]
	reg 			[31:0] word2[10:1];			//contains values [63:32]
	reg 			[31:0] word3[10:1];			//contains values [31:0]
	reg 			[31:0] word3_d;				//word3 dash- result of the gfuction
	reg 			[31:0] shift_word;			//circular left shifts the word by 1 byte
	reg				[31:0] sbox_word;			//transforms the word using sub_box
	reg				[31:0] round_cnst_word;		//xor operation on the word with  round_cnst
	
		
	//inputs for tasks
	reg 			[7:0]   state_in   [3:0][3:0];		//used to hold input state Matrices for tasks
	reg  		 	[7:0]  	state_ip1  [3:0][3:0];		//storing the 1st input for roundkey byte values as states
	reg  		 	[7:0]  	state_ip2  [3:0][3:0];		//storing the different round keys values as states
	
	//outputs for tasks	
	reg				[127:0] sbox_op;					//stores the output of sbox transformation in binary
	reg				[127:0] round_op;					//stores the output of roundkey_transformation in binary
	reg				[127:0] shift_op;					//stores the output of shiftrow_transformation in binary
	reg				[127:0] mix_op;					    //stores the output of MixCol_transformation in binary
	
	reg				[7:0] temp2,temp4,temp8;
	
	reg						keyExpansion_done;		
	
	
	//reg			[4:0]  	shift_amount;				//amount of bits to be shifted
	//reg 			[31:0] 	tempword;					//hold the row of a matrix
	//reg 			[31:0] 	tempword_cir_shift;			//tempword circular shift result	
	
	
	integer i,j;
	

	//Code begin
	
	//tasks
	
	//display task for state matrix
	task disp_sMatrix( input [127:0] bin_val);
	begin
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_in[i][j] = bin_val[(8*(15-(i+4*j))) + : (8)];
			end
		end
			
		for(i = 0; i<4 ; i = i+1) begin
				for(j = 0; j<4 ; j = j+1) begin
					$write("%h \t",state_in[i][j]);	
				end
				$display("");
			end
	end
	endtask
	
	//AddRoundKey transformation task
	task AddRoundKey( input [127:0] ip1,ip2, output [127:0] op);
	begin
	
		$display("Round key ip1 = %h",ip1);
		$display("Round key ip2 = %h",ip2);
		
		/*for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_ip1[i][j] = ip1[(8*(15-(i+4*j))) + : (8)];
				state_ip2[i][j] = ip2[(8*(15-(i+4*j))) + : (8)];
			end
		end
		
		//roundkey_t: xor of state_pt and state_ck
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				roundkey_t[i][j] = state_ip1[i][j] ^ state_ip2[i][j] ;
			end
		end
		
		op = {roundkey_t[0][0],roundkey_t[1][0],roundkey_t[2][0],roundkey_t[3][0],
			roundkey_t[0][1],roundkey_t[1][1],roundkey_t[2][1],roundkey_t[3][1],
			roundkey_t[0][2],roundkey_t[1][2],roundkey_t[2][2],roundkey_t[3][2],
			roundkey_t[0][3],roundkey_t[1][3],roundkey_t[2][3],roundkey_t[3][3]};*/
		
		op= ip1 ^ ip2;
		
		$display("roundkey output=%h \t",op);
		disp_sMatrix(op);
			
	end
	endtask
	
	//Inverse Substitution box transformation task	
	task InvSubBytes( input [127:0] sbox_in,output reg [127:0] sbox_op);
	begin	
		
		$display("Inverse sbox_in = %h",sbox_in);
		
		//converting the sbox_in into state_in matrix
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_in[i][j] = sbox_in[(8*(15-(i+4*j))) + : (8)];
			end
		end			
			
		//Inverse sbox transformation
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				sbox_t[i][j] = inv_sub_box[state_in[i][j][7:4]][state_in[i][j][3:0]];
			end
		end			
			
		//displaying state matrix
		$display("\nstate matrix ");
			
		sbox_op = {sbox_t[0][0],sbox_t[1][0],sbox_t[2][0],sbox_t[3][0],
					sbox_t[0][1],sbox_t[1][1],sbox_t[2][1],sbox_t[3][1],
					sbox_t[0][2],sbox_t[1][2],sbox_t[2][2],sbox_t[3][2],
					sbox_t[0][3],sbox_t[1][3],sbox_t[2][3],sbox_t[3][3]};

						
		$display("sbox_out=%h \t",sbox_op);
		disp_sMatrix(sbox_op);
			
	end	
	endtask
	
	//Inverse shift row transformation task
	task InvShiftRows( input [127:0] ip, output [127:0] op);
	begin
	
		$display("Inverse shift row ip = %h",ip);
		
		op[127:120] = ip[127:120];	op[95:88] = ip[95:88];		op[63:56] = ip[63:56];		op[31:24] = ip[31:24];
		op[119:112] = ip[23:16];	op[87:80] = ip[119:112];	op[55:48] = ip[87:80];		op[23:16] = ip[55:48];
		op[111:104] = ip[47:40];	op[79:72] = ip[15:8];		op[47:40] = ip[111:104];	op[15:8]  = ip[79:72];
		op[103:96]  = ip[71:64];	op[71:64] = ip[39:32];		op[39:32] = ip[7:0];		op[7:0]   = ip[103:96];
		
		/*for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_in[i][j] = ip[(8*(15-(i+4*j))) + : (8)];
			end
		end
		
		//shiftrow transformation		
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
			
			tempword={state_in[i][0],state_in[i][1],state_in[i][2],state_in[i][3]};
			//$display("%h",tempword);
			tempword_cir_shift=(tempword << shift_amount) | (tempword >> (32 - shift_amount));
			shiftrow_t[i][0] = tempword_cir_shift[31:24];
			shiftrow_t[i][1] = tempword_cir_shift[23:16];
			shiftrow_t[i][2] = tempword_cir_shift[15:8];
			shiftrow_t[i][3] = tempword_cir_shift[7:0];
		end
		
		op = {shiftrow_t[0][0],shiftrow_t[1][0],shiftrow_t[2][0],shiftrow_t[3][0],
			shiftrow_t[0][1],shiftrow_t[1][1],shiftrow_t[2][1],shiftrow_t[3][1],
			shiftrow_t[0][2],shiftrow_t[1][2],shiftrow_t[2][2],shiftrow_t[3][2],
			shiftrow_t[0][3],shiftrow_t[1][3],shiftrow_t[2][3],shiftrow_t[3][3]};*/
		
		$display("shiftrow output=%h \t",op);
		disp_sMatrix(op);
			
	end
	endtask	
	
	//Inverse Mix Column transformation task
	task InvMixColumns( input [127:0] ip, output [127:0] op);
	begin
	
		$display("Inverse Mix Col ip = %h",ip);
		
		for(i = 0; i<4 ; i = i+1) begin
			for(j = 0; j<4 ; j = j+1) begin
				state_in[i][j] = ip[(8*(15-(i+4*j))) + : (8)];
			end
		end
		
		//InvMixCol transformation		
		for(i = 0; i<4 ; i = i+1) begin
			//if(i==0) begin
			for(j = 0; j<4 ; j = j+1) begin
				if(i==0) begin
					inv_mixcol_t[i][j] = multiplyBy_0e(state_in[0][j]) ^ multiplyBy_0b(state_in[1][j]) ^ multiplyBy_0d(state_in[2][j]) ^multiplyBy_09(state_in[3][j]);
								
								// $display("a=%h \t",((state_in[0][j][7] == 1'b1) ? (( state_in[0][j] << 1'b1) ^ 8'h1b) : (state_in[0][j] << 1'b1)));
								// $display("b=%h \t",(state_in[1][j] ^ ((state_in[1][j][7] == 1'b1) ? (( state_in[1][j] << 1'b1) ^ 8'h1b) : (state_in[1][j] << 1'b1))) );
								// $display("c=%h \t",state_in[2][j]);
								// $display("d=%h \t",state_in[3][j]);
				end
				if(i==1) begin
					inv_mixcol_t[i][j] = multiplyBy_09(state_in[0][j]) ^ multiplyBy_0e(state_in[1][j]) ^ multiplyBy_0b(state_in[2][j]) ^multiplyBy_0d(state_in[3][j]);								
				end
				if(i==2) begin
					inv_mixcol_t[i][j] = multiplyBy_0d(state_in[0][j]) ^ multiplyBy_09(state_in[1][j]) ^ multiplyBy_0e(state_in[2][j]) ^multiplyBy_0b(state_in[3][j]);								
				end
				if(i==3) begin
					inv_mixcol_t[i][j] = multiplyBy_0b(state_in[0][j]) ^ multiplyBy_0d(state_in[1][j]) ^ multiplyBy_09(state_in[2][j]) ^multiplyBy_0e(state_in[3][j]);								
				end
			end	
			
			
		end
		
		op = {inv_mixcol_t[0][0],inv_mixcol_t[1][0],inv_mixcol_t[2][0],inv_mixcol_t[3][0],
			inv_mixcol_t[0][1],inv_mixcol_t[1][1],inv_mixcol_t[2][1],inv_mixcol_t[3][1],
			inv_mixcol_t[0][2],inv_mixcol_t[1][2],inv_mixcol_t[2][2],inv_mixcol_t[3][2],
			inv_mixcol_t[0][3],inv_mixcol_t[1][3],inv_mixcol_t[2][3],inv_mixcol_t[3][3]};
		
		$display("InvMixCol output=%h \t",op);
		disp_sMatrix(op);
			
	end
	endtask	
	
	//functions 
	
	//fn. multiply by (0e)
	//(0e) = (8 ^ 4 ^2)	
	function [7:0] multiplyBy_0e;
	input [7:0] ip;
	begin
		temp2	=	(ip << 1'b1) ^ ( {8{ip[7]}} & 8'h1b );
		temp4	=	(temp2 << 1'b1) ^ ( {8{temp2[7]}} & 8'h1b );
		temp8	=	(temp4 << 1'b1) ^ ( {8{temp4[7]}} & 8'h1b );
		
		multiplyBy_0e = temp2 ^ temp4 ^ temp8;		
	end
	endfunction
	
	//fn. multiply by (0d)
	//(0d) = (8 ^ 4 ^ 1)	
	function [7:0] multiplyBy_0d;
	input [7:0] ip;
	begin
		temp2	=	(ip << 1'b1) ^ ( {8{ip[7]}} & 8'h1b );
		temp4	=	(temp2 << 1'b1) ^ ( {8{temp2[7]}} & 8'h1b );
		temp8	=	(temp4 << 1'b1) ^ ( {8{temp4[7]}} & 8'h1b );
		
		multiplyBy_0d = ip ^ temp4 ^ temp8;		
	end
	endfunction
	
	
	//fn. multiply by (0b)
	//(0b) = (8 ^ 2 ^ 1)	
	function [7:0] multiplyBy_0b;
	input [7:0] ip;
	begin
		temp2	=	(ip << 1'b1) ^ ( {8{ip[7]}} & 8'h1b );
		temp4	=	(temp2 << 1'b1) ^ ( {8{temp2[7]}} & 8'h1b );
		temp8	=	(temp4 << 1'b1) ^ ( {8{temp4[7]}} & 8'h1b );
		
		multiplyBy_0b = ip ^ temp2 ^ temp8;		
	end
	endfunction
	
	
	//fn. multiply by (09)
	//(09) = (8 ^ 1)	
	function [7:0] multiplyBy_09;
	input [7:0] ip;
	begin
		temp2	=	(ip << 1'b1) ^ ( {8{ip[7]}} & 8'h1b );
		temp4	=	(temp2 << 1'b1) ^ ( {8{temp2[7]}} & 8'h1b );
		temp8	=	(temp4 << 1'b1) ^ ( {8{temp4[7]}} & 8'h1b );
		
		multiplyBy_09 = ip ^ temp8;		
	end
	endfunction
	
	
	//Key expansion task
	task KeyExpansion( input [127:0] ip, output [127:0] op1,op2,op3,op4,op5,op6,op7,op8,op9,op10);
	begin
	
		round_cnst[1]	=	32'h01000000;
		
		//round1 transformation
		GFunction(ip[31:0],round_cnst[1],word3_d);
		word0[1] = ip[127:96] ^ word3_d;
		word1[1] = ip[95:64]  ^ word0[1];
		word2[1] = ip[63:32]  ^ word1[1];
		word3[1] = ip[31:0]   ^ word2[1];
		
		op1 = {word0[1],word1[1],word2[1],word3[1]};
		
		//round2 transformation
		genRoundCnst(round_cnst[1],round_cnst[2]);
		GFunction(word3[1],round_cnst[2],word3_d);
		word0[2] = word0[1] ^ word3_d;
		word1[2] = word1[1] ^ word0[2];
		word2[2] = word2[1] ^ word1[2];
		word3[2] = word3[1] ^ word2[2];
		
		op2 = {word0[2],word1[2],word2[2],word3[2]};
		
		//round3 transformation
		genRoundCnst(round_cnst[2],round_cnst[3]);
		GFunction(word3[2],round_cnst[3],word3_d);
		word0[3] = word0[2] ^ word3_d;
		word1[3] = word1[2] ^ word0[3];
		word2[3] = word2[2] ^ word1[3];
		word3[3] = word3[2] ^ word2[3];
		
		op3 = {word0[3],word1[3],word2[3],word3[3]};
		
		//round4 transformation
		genRoundCnst(round_cnst[3],round_cnst[4]);
		GFunction(word3[3],round_cnst[4],word3_d);
		word0[4] = word0[3] ^ word3_d;
		word1[4] = word1[3] ^ word0[4];
		word2[4] = word2[3] ^ word1[4];
		word3[4] = word3[3] ^ word2[4];
		
		op4 = {word0[4],word1[4],word2[4],word3[4]};
		
		//round5 transformation
		genRoundCnst(round_cnst[4],round_cnst[5]);
		GFunction(word3[4],round_cnst[5],word3_d);
		word0[5] = word0[4] ^ word3_d;
		word1[5] = word1[4] ^ word0[5];
		word2[5] = word2[4] ^ word1[5];
		word3[5] = word3[4] ^ word2[5];
		
		op5 = {word0[5],word1[5],word2[5],word3[5]};
		
		//round6 transformation
		genRoundCnst(round_cnst[5],round_cnst[6]);
		GFunction(word3[5],round_cnst[6],word3_d);
		word0[6] = word0[5] ^ word3_d;
		word1[6] = word1[5] ^ word0[6];
		word2[6] = word2[5] ^ word1[6];
		word3[6] = word3[5] ^ word2[6];
		
		op6 = {word0[6],word1[6],word2[6],word3[6]};
		
		//round7 transformation
		genRoundCnst(round_cnst[6],round_cnst[7]);
		GFunction(word3[6],round_cnst[7],word3_d);
		word0[7] = word0[6] ^ word3_d;
		word1[7] = word1[6] ^ word0[7];
		word2[7] = word2[6] ^ word1[7];
		word3[7] = word3[6] ^ word2[7];
		
		op7 = {word0[7],word1[7],word2[7],word3[7]};
		
		//round8 transformation
		genRoundCnst(round_cnst[7],round_cnst[8]);
		GFunction(word3[7],round_cnst[8],word3_d);
		word0[8] = word0[7] ^ word3_d;
		word1[8] = word1[7] ^ word0[8];
		word2[8] = word2[7] ^ word1[8];
		word3[8] = word3[7] ^ word2[8];
		
		op8 = {word0[8],word1[8],word2[8],word3[8]};
		
		//round9 transformation
		genRoundCnst(round_cnst[8],round_cnst[9]);
		GFunction(word3[8],round_cnst[9],word3_d);
		word0[9] = word0[8] ^ word3_d;
		word1[9] = word1[8] ^ word0[9];
		word2[9] = word2[8] ^ word1[9];
		word3[9] = word3[8] ^ word2[9];
		
		op9 = {word0[9],word1[9],word2[9],word3[9]};
		
		//round10 transformation
		genRoundCnst(round_cnst[9],round_cnst[10]);
		GFunction(word3[9],round_cnst[10],word3_d);
		word0[10] = word0[9] ^ word3_d;
		word1[10] = word1[9] ^ word0[10];
		word2[10] = word2[9] ^ word1[10];
		word3[10] = word3[9] ^ word2[10];
		
		op10 = {word0[10],word1[10],word2[10],word3[10]};
		
		keyExpansion_done	=	1'b1;
		$display(" keyExpansion_done =%h\t",keyExpansion_done);
	
		
		
		// $display("key 1 output=%h \t",op1);
		// $display("key 2 output=%h \t",op2);
		// $display("key 3 output=%h \t",op3);
		// $display("key 4 output=%h \t",op4);
		// $display("key 5 output=%h \t",op5);
		// $display("key 6 output=%h \t",op6);
		// $display("key 7 output=%h \t",op7);
		// $display("key 8 output=%h \t",op8);
		// $display("key 9 output=%h \t",op9);
		// $display("key 10 output=%h \t",op10);
		
		// disp_sMatrix(op1);
		// $display("");
		// disp_sMatrix(op2);
		// $display("");	
		// disp_sMatrix(op3);
		// $display("");	
		// disp_sMatrix(op4);
		// $display("");	
		// disp_sMatrix(op5);
		// $display("");	
		// disp_sMatrix(op6);
		// $display("");	
		// disp_sMatrix(op7);
		// $display("");	
		// disp_sMatrix(op8);
		// $display("");	
		// disp_sMatrix(op9);
		// $display("");	
		// disp_sMatrix(op10);
		// $display("");	
		
	end
	endtask	
	
	//GFunction task( has shift_word, sbox_word and round_cnst operation )
	task GFunction( input [31:0] ip,input[31:0]r_cnst, output [31:0] op);
	begin
		shift_word 		= 	{ip[23:16],ip[15:8],ip[7:0],ip[31:24]};		//1 byte left shift
		
		sbox_word		=	{	sub_box[shift_word[31:28]][shift_word[27:24]],
								sub_box[shift_word[23:20]][shift_word[19:16]],
								sub_box[shift_word[15:12]][shift_word[11:8 ]],
								sub_box[shift_word[ 7:4 ]][shift_word[ 3:0 ]]	};	//sbox transformation of shift word bytes
		
		round_cnst_word	=	r_cnst ^ sbox_word; //xoring sbox_word with the round constant of that round
		// $display(" \n shift_word output=%h \n sbox_word output=%h \n round_cnst_word output=%h\t",shift_word,sbox_word,round_cnst_word);
		
		
		op				=	round_cnst_word;
							
	
	end
	endtask
	
	//Generates the next round constant value based on previous value
	task genRoundCnst( input [31:0] ip, output [31:0] op);
	begin
	
		op	=	(( ip << 1'b1) ^ ( {32{ip[31]}} & 32'h1b000000 ));		//generates the nxt round constant (mul by 2)
		$display(" round op =%h\t",op);
	
	end
	endtask
	
	
		
		assign sub_box[0][0] = 8'h63;		assign sub_box[0][1] = 8'h7c;		assign sub_box[0][2] = 8'h77;		assign sub_box[0][3] = 8'h7b;	assign sub_box[0][4] = 8'hf2;		assign sub_box[0][5] = 8'h6b;		assign sub_box[0][6] = 8'h6f;		assign sub_box[0][7] = 8'hc5;	assign sub_box[0][8] = 8'h30;		assign sub_box[0][9] = 8'h01;		assign sub_box[0][10] = 8'h67;		assign sub_box[0][11] = 8'h2b;	assign sub_box[0][12] = 8'hfe;		assign sub_box[0][13] = 8'hd7;		assign sub_box[0][14] = 8'hab;		assign sub_box[0][15] = 8'h76;	
			
		assign sub_box[1][0] = 8'hca;		assign sub_box[1][1] = 8'h82;		assign sub_box[1][2] = 8'hc9;		assign sub_box[1][3] = 8'h7d;	assign sub_box[1][4] = 8'hfa;		assign sub_box[1][5] = 8'h59;		assign sub_box[1][6] = 8'h47;		assign sub_box[1][7] = 8'hf0;	assign sub_box[1][8] = 8'had;		assign sub_box[1][9] = 8'hd4;		assign sub_box[1][10] = 8'ha2;		assign sub_box[1][11] = 8'haf;	assign sub_box[1][12] = 8'h9c;		assign sub_box[1][13] = 8'ha4;		assign sub_box[1][14] = 8'h72;		assign sub_box[1][15] = 8'hc0;
			
		assign sub_box[2][0] = 8'hb7;		assign sub_box[2][1] = 8'hfd;		assign sub_box[2][2] = 8'h93;		assign sub_box[2][3] = 8'h26;	assign sub_box[2][4] = 8'h36;		assign sub_box[2][5] = 8'h3f;		assign sub_box[2][6] = 8'hf7;		assign sub_box[2][7] = 8'hcc;	assign sub_box[2][8] = 8'h34;		assign sub_box[2][9] = 8'ha5;		assign sub_box[2][10] = 8'he5;		assign sub_box[2][11] = 8'hf1;	assign sub_box[2][12] = 8'h71;		assign sub_box[2][13] = 8'hd8;		assign sub_box[2][14] = 8'h31;		assign sub_box[2][15] = 8'h15;	
			
		assign sub_box[3][0] = 8'h04;		assign sub_box[3][1] = 8'hc7;		assign sub_box[3][2] = 8'h23;		assign sub_box[3][3] = 8'hc3;	assign sub_box[3][4] = 8'h18;		assign sub_box[3][5] = 8'h96;		assign sub_box[3][6] = 8'h05;		assign sub_box[3][7] = 8'h9a;	assign sub_box[3][8] = 8'h07;		assign sub_box[3][9] = 8'h12;		assign sub_box[3][10] = 8'h80;		assign sub_box[3][11] = 8'he2;	assign sub_box[3][12] = 8'heb;		assign sub_box[3][13] = 8'h27;		assign sub_box[3][14] = 8'hb2;		assign sub_box[3][15] = 8'h75;
			
		assign sub_box[4][0] = 8'h09;		assign sub_box[4][1] = 8'h83;		assign sub_box[4][2] = 8'h2c;		assign sub_box[4][3] = 8'h1a;	assign sub_box[4][4] = 8'h1b;		assign sub_box[4][5] = 8'h6e;		assign sub_box[4][6] = 8'h5a;		assign sub_box[4][7] = 8'ha0;	assign sub_box[4][8] = 8'h52;		assign sub_box[4][9] = 8'h3b;		assign sub_box[4][10] = 8'hd6;		assign sub_box[4][11] = 8'hb3;	assign sub_box[4][12] = 8'h29;		assign sub_box[4][13] = 8'he3;		assign sub_box[4][14] = 8'h2f;		assign sub_box[4][15] = 8'h84;
			
		assign sub_box[5][0] = 8'h53;		assign sub_box[5][1] = 8'hd1;		assign sub_box[5][2] = 8'h00;		assign sub_box[5][3] = 8'hed;	assign sub_box[5][4] = 8'h20;		assign sub_box[5][5] = 8'hfc;		assign sub_box[5][6] = 8'hb1;		assign sub_box[5][7] = 8'h5b;	assign sub_box[5][8] = 8'h6a;		assign sub_box[5][9] = 8'hcb;		assign sub_box[5][10] = 8'hbe;		assign sub_box[5][11] = 8'h39;	assign sub_box[5][12] = 8'h4a;		assign sub_box[5][13] = 8'h4c;		assign sub_box[5][14] = 8'h58;		assign sub_box[5][15] = 8'hcf;
			
		assign sub_box[6][0] = 8'hd0;		assign sub_box[6][1] = 8'hef;		assign sub_box[6][2] = 8'haa;		assign sub_box[6][3] = 8'hfb;	assign sub_box[6][4] = 8'h43;		assign sub_box[6][5] = 8'h4d;		assign sub_box[6][6] = 8'h33;		assign sub_box[6][7] = 8'h85;	assign sub_box[6][8] = 8'h45;		assign sub_box[6][9] = 8'hf9;		assign sub_box[6][10] = 8'h02;		assign sub_box[6][11] = 8'h7f;	assign sub_box[6][12] = 8'h50;		assign sub_box[6][13] = 8'h3c;		assign sub_box[6][14] = 8'h9f;		assign sub_box[6][15] = 8'ha8;
			
		assign sub_box[7][0] = 8'h51;		assign sub_box[7][1] = 8'ha3;		assign sub_box[7][2] = 8'h40;		assign sub_box[7][3] = 8'h8f;	assign sub_box[7][4] = 8'h92;		assign sub_box[7][5] = 8'h9d;		assign sub_box[7][6] = 8'h38;		assign sub_box[7][7] = 8'hf5;	assign sub_box[7][8] = 8'hbc;		assign sub_box[7][9] = 8'hb6;		assign sub_box[7][10] = 8'hda;		assign sub_box[7][11] = 8'h21;	assign sub_box[7][12] = 8'h10;		assign sub_box[7][13] = 8'hff;		assign sub_box[7][14] = 8'hf3;		assign sub_box[7][15] = 8'hd2;
			
		assign sub_box[8][0] = 8'hcd;		assign sub_box[8][1] = 8'h0c;		assign sub_box[8][2] = 8'h13;		assign sub_box[8][3] = 8'hec;	assign sub_box[8][4] = 8'h5f;		assign sub_box[8][5] = 8'h97;		assign sub_box[8][6] = 8'h44;		assign sub_box[8][7] = 8'h17;	assign sub_box[8][8] = 8'hc4;		assign sub_box[8][9] = 8'ha7;		assign sub_box[8][10] = 8'h7e;		assign sub_box[8][11] = 8'h3d;	assign sub_box[8][12] = 8'h64;		assign sub_box[8][13] = 8'h5d;		assign sub_box[8][14] = 8'h19;		assign sub_box[8][15] = 8'h73;
			
		assign sub_box[9][0] = 8'h60;		assign sub_box[9][1] = 8'h81;		assign sub_box[9][2] = 8'h4f;		assign sub_box[9][3] = 8'hdc;	assign sub_box[9][4] = 8'h22;		assign sub_box[9][5] = 8'h2a;		assign sub_box[9][6] = 8'h90;		assign sub_box[9][7] = 8'h88;	assign sub_box[9][8] = 8'h46;		assign sub_box[9][9] = 8'hee;		assign sub_box[9][10] = 8'hb8;		assign sub_box[9][11] = 8'h14;	assign sub_box[9][12] = 8'hde;		assign sub_box[9][13] = 8'h5e;		assign sub_box[9][14] = 8'h0b;		assign sub_box[9][15] = 8'hdb;
			
		assign sub_box[10][0] = 8'he0;		assign sub_box[10][1] = 8'h32;		assign sub_box[10][2] = 8'h3a;		assign sub_box[10][3] = 8'h0a;	assign sub_box[10][4] = 8'h49;		assign sub_box[10][5] = 8'h06;	    assign sub_box[10][6] = 8'h24;	    assign sub_box[10][7] = 8'h5c;	 assign sub_box[10][8] = 8'hc2;	   	 assign sub_box[10][9] = 8'hd3;		 assign sub_box[10][10] = 8'hac;	 assign sub_box[10][11] = 8'h62;assign sub_box[10][12] = 8'h91;	    assign sub_box[10][13] = 8'h95;	    assign sub_box[10][14] = 8'he4;		assign sub_box[10][15] = 8'h79;
			
		assign sub_box[11][0] = 8'he7;		assign sub_box[11][1] = 8'hc8;		assign sub_box[11][2] = 8'h37;		assign sub_box[11][3] = 8'h6d;	assign sub_box[11][4] = 8'h8d;		assign sub_box[11][5] = 8'hd5;	   	assign sub_box[11][6] = 8'h4e;	   	assign sub_box[11][7] = 8'ha9;	 assign sub_box[11][8] = 8'h6c;	   	 assign sub_box[11][9] = 8'h56;		 assign sub_box[11][10] = 8'hf4;	 assign sub_box[11][11] = 8'hea;assign sub_box[11][12] = 8'h65;	    assign sub_box[11][13] = 8'h7a;	    assign sub_box[11][14] = 8'hae;   	assign sub_box[11][15] = 8'h08;
			
		assign sub_box[12][0] = 8'hba;		assign sub_box[12][1] = 8'h78;		assign sub_box[12][2] = 8'h25;		assign sub_box[12][3] = 8'h2e;	assign sub_box[12][4] = 8'h1c;		assign sub_box[12][5] = 8'ha6;	    assign sub_box[12][6] = 8'hb4;	    assign sub_box[12][7] = 8'hc6;	 assign sub_box[12][8] = 8'he8;	   	 assign sub_box[12][9] = 8'hdd;		 assign sub_box[12][10] = 8'h74;	 assign sub_box[12][11] = 8'h1f; assign sub_box[12][12] = 8'h4b; 	 assign sub_box[12][13] = 8'hbd;	 assign sub_box[12][14] = 8'h8b;	 assign sub_box[12][15] = 8'h8a;
			
		assign sub_box[13][0] = 8'h70;		assign sub_box[13][1] = 8'h3e;		assign sub_box[13][2] = 8'hb5;		assign sub_box[13][3] = 8'h66;	assign sub_box[13][4] = 8'h48;		assign sub_box[13][5] = 8'h03;	    assign sub_box[13][6] = 8'hf6;	    assign sub_box[13][7] = 8'h0e;	 assign sub_box[13][8] = 8'h61;	   	 assign sub_box[13][9] = 8'h35;		 assign sub_box[13][10] = 8'h57;	 assign sub_box[13][11] = 8'hb9;assign sub_box[13][12] = 8'h86;	    assign sub_box[13][13] = 8'hc1;	    assign sub_box[13][14] = 8'h1d;		assign sub_box[13][15] = 8'h9e;
			
		assign sub_box[14][0] = 8'he1;		assign sub_box[14][1] = 8'hf8;		assign sub_box[14][2] = 8'h98;		assign sub_box[14][3] = 8'h11;	assign sub_box[14][4] = 8'h69;		assign sub_box[14][5] = 8'hd9;	    assign sub_box[14][6] = 8'h8e;	    assign sub_box[14][7] = 8'h94;	 assign sub_box[14][8] = 8'h9b;	     assign sub_box[14][9] = 8'h1e;		 assign sub_box[14][10] = 8'h87;	 assign sub_box[14][11] = 8'he9;assign sub_box[14][12] = 8'hce;	    assign sub_box[14][13] = 8'h55;	    assign sub_box[14][14] = 8'h28;  	assign sub_box[14][15] = 8'hdf;
			
		assign sub_box[15][0] = 8'h8c;		assign sub_box[15][1] = 8'ha1;		assign sub_box[15][2] = 8'h89;		assign sub_box[15][3] = 8'h0d;	assign sub_box[15][4] = 8'hbf;		assign sub_box[15][5] = 8'he6;	    assign sub_box[15][6] = 8'h42;	    assign sub_box[15][7] = 8'h68;	 assign sub_box[15][8] = 8'h41;	   	 assign sub_box[15][9] = 8'h99;		 assign sub_box[15][10] = 8'h2d;	 assign sub_box[15][11] = 8'h0f;assign sub_box[15][12] = 8'hb0;	 	assign sub_box[15][13] = 8'h54;	 	assign sub_box[15][14] = 8'hbb;	 	assign sub_box[15][15] = 8'h16;
		
		assign inv_sub_box[0][0] = 8'h52;
		assign inv_sub_box[0][1] = 8'h09;
		assign inv_sub_box[0][2] = 8'h6a;
		assign inv_sub_box[0][3] = 8'hd5;
		assign inv_sub_box[0][4] = 8'h30;
		assign inv_sub_box[0][5] = 8'h36;
		assign inv_sub_box[0][6] = 8'ha5;
		assign inv_sub_box[0][7] = 8'h38;
		assign inv_sub_box[0][8] = 8'hbf;
		assign inv_sub_box[0][9] = 8'h40;
		assign inv_sub_box[0][10] = 8'ha3;
		assign inv_sub_box[0][11] = 8'h9e;
		assign inv_sub_box[0][12] = 8'h81;
		assign inv_sub_box[0][13] = 8'hf3;
		assign inv_sub_box[0][14] = 8'hd7;
		assign inv_sub_box[0][15] = 8'hfb;

		assign inv_sub_box[1][0] = 8'h7c;
		assign inv_sub_box[1][1] = 8'he3;
		assign inv_sub_box[1][2] = 8'h39;
		assign inv_sub_box[1][3] = 8'h82;
		assign inv_sub_box[1][4] = 8'h9b;
		assign inv_sub_box[1][5] = 8'h2f;
		assign inv_sub_box[1][6] = 8'hff;
		assign inv_sub_box[1][7] = 8'h87;
		assign inv_sub_box[1][8] = 8'h34;
		assign inv_sub_box[1][9] = 8'h8e;
		assign inv_sub_box[1][10] = 8'h43;
		assign inv_sub_box[1][11] = 8'h44;
		assign inv_sub_box[1][12] = 8'hc4;
		assign inv_sub_box[1][13] = 8'hde;
		assign inv_sub_box[1][14] = 8'he9;
		assign inv_sub_box[1][15] = 8'hcb;
					
				
		assign inv_sub_box[2][0] = 8'h54;
		assign inv_sub_box[2][1] = 8'h7b;
		assign inv_sub_box[2][2] = 8'h94;
		assign inv_sub_box[2][3] = 8'h32;
		assign inv_sub_box[2][4] = 8'ha6;
		assign inv_sub_box[2][5] = 8'hc2;
		assign inv_sub_box[2][6] = 8'h23;
		assign inv_sub_box[2][7] = 8'h3d;
		assign inv_sub_box[2][8] = 8'hee;
		assign inv_sub_box[2][9] = 8'h4c;
		assign inv_sub_box[2][10] = 8'h95;
		assign inv_sub_box[2][11] = 8'h0b;
		assign inv_sub_box[2][12] = 8'h42;
		assign inv_sub_box[2][13] = 8'hfa;
		assign inv_sub_box[2][14] = 8'hc3;
		assign inv_sub_box[2][15] = 8'h4e;		
					
				
		assign inv_sub_box[3][0] = 8'h08;
		assign inv_sub_box[3][1] = 8'h2e;
		assign inv_sub_box[3][2] = 8'ha1;
		assign inv_sub_box[3][3] = 8'h66;
		assign inv_sub_box[3][4] = 8'h28;
		assign inv_sub_box[3][5] = 8'hd9;
		assign inv_sub_box[3][6] = 8'h24;
		assign inv_sub_box[3][7] = 8'hb2;
		assign inv_sub_box[3][8] = 8'h76;
		assign inv_sub_box[3][9] = 8'h5b;
		assign inv_sub_box[3][10] = 8'ha2;
		assign inv_sub_box[3][11] = 8'h49;
		assign inv_sub_box[3][12] = 8'h6d;
		assign inv_sub_box[3][13] = 8'h8b;
		assign inv_sub_box[3][14] = 8'hd1;
		assign inv_sub_box[3][15] = 8'h25;
					
				
		assign inv_sub_box[4][0] = 8'h72;
		assign inv_sub_box[4][1] = 8'hf8;
		assign inv_sub_box[4][2] = 8'hf6;
		assign inv_sub_box[4][3] = 8'h64;
		assign inv_sub_box[4][4] = 8'h86;
		assign inv_sub_box[4][5] = 8'h68;
		assign inv_sub_box[4][6] = 8'h98;
		assign inv_sub_box[4][7] = 8'h16;
		assign inv_sub_box[4][8] = 8'hd4;
		assign inv_sub_box[4][9] = 8'ha4;
		assign inv_sub_box[4][10] = 8'h5c;
		assign inv_sub_box[4][11] = 8'hcc;
		assign inv_sub_box[4][12] = 8'h5d;
		assign inv_sub_box[4][13] = 8'h65;
		assign inv_sub_box[4][14] = 8'hb6;
		assign inv_sub_box[4][15] = 8'h92;
					
				
		assign inv_sub_box[5][0] = 8'h6c;
		assign inv_sub_box[5][1] = 8'h70;
		assign inv_sub_box[5][2] = 8'h48;
		assign inv_sub_box[5][3] = 8'h50;
		assign inv_sub_box[5][4] = 8'hfd;
		assign inv_sub_box[5][5] = 8'hed;
		assign inv_sub_box[5][6] = 8'hb9;
		assign inv_sub_box[5][7] = 8'hda;
		assign inv_sub_box[5][8] = 8'h5e;
		assign inv_sub_box[5][9] = 8'h15;
		assign inv_sub_box[5][10] = 8'h46;
		assign inv_sub_box[5][11] = 8'h57;
		assign inv_sub_box[5][12] = 8'ha7;
		assign inv_sub_box[5][13] = 8'h8d;
		assign inv_sub_box[5][14] = 8'h9d;
		assign inv_sub_box[5][15] = 8'h84;
					
				
		assign inv_sub_box[6][0] = 8'h90;
		assign inv_sub_box[6][1] = 8'hd8;
		assign inv_sub_box[6][2] = 8'hab;
		assign inv_sub_box[6][3] = 8'h00;
		assign inv_sub_box[6][4] = 8'h8c;
		assign inv_sub_box[6][5] = 8'hbc;
		assign inv_sub_box[6][6] = 8'hd3;
		assign inv_sub_box[6][7] = 8'h0a;
		assign inv_sub_box[6][8] = 8'hf7;
		assign inv_sub_box[6][9] = 8'he4;
		assign inv_sub_box[6][10] = 8'h58;
		assign inv_sub_box[6][11] = 8'h05;
		assign inv_sub_box[6][12] = 8'hb8;
		assign inv_sub_box[6][13] = 8'hb3;
		assign inv_sub_box[6][14] = 8'h45;
		assign inv_sub_box[6][15] = 8'h06;
					
				
		assign inv_sub_box[7][0] = 8'hd0;
		assign inv_sub_box[7][1] = 8'h2c;
		assign inv_sub_box[7][2] = 8'h1e;
		assign inv_sub_box[7][3] = 8'h8f;
		assign inv_sub_box[7][4] = 8'hca;
		assign inv_sub_box[7][5] = 8'h3f;
		assign inv_sub_box[7][6] = 8'h0f;
		assign inv_sub_box[7][7] = 8'h02;
		assign inv_sub_box[7][8] = 8'hc1;
		assign inv_sub_box[7][9] = 8'haf;
		assign inv_sub_box[7][10] = 8'hbd;
		assign inv_sub_box[7][11] = 8'h03;
		assign inv_sub_box[7][12] = 8'h01;
		assign inv_sub_box[7][13] = 8'h13;
		assign inv_sub_box[7][14] = 8'h8a;
		assign inv_sub_box[7][15] = 8'h6b;
					
				
		assign inv_sub_box[8][0] = 8'h3a;
		assign inv_sub_box[8][1] = 8'h91;
		assign inv_sub_box[8][2] = 8'h11;
		assign inv_sub_box[8][3] = 8'h41;
		assign inv_sub_box[8][4] = 8'h4f;
		assign inv_sub_box[8][5] = 8'h67;
		assign inv_sub_box[8][6] = 8'hdc;
		assign inv_sub_box[8][7] = 8'hea;
		assign inv_sub_box[8][8] = 8'h97;
		assign inv_sub_box[8][9] = 8'hf2;
		assign inv_sub_box[8][10] = 8'hcf;
		assign inv_sub_box[8][11] = 8'hce;
		assign inv_sub_box[8][12] = 8'hf0;
		assign inv_sub_box[8][13] = 8'hb4;
		assign inv_sub_box[8][14] = 8'he6;
		assign inv_sub_box[8][15] = 8'h73;
					
				
		assign inv_sub_box[9][0] = 8'h96;
		assign inv_sub_box[9][1] = 8'hac;
		assign inv_sub_box[9][2] = 8'h74;
		assign inv_sub_box[9][3] = 8'h22;
		assign inv_sub_box[9][4] = 8'he7;
		assign inv_sub_box[9][5] = 8'had;
		assign inv_sub_box[9][6] = 8'h35;
		assign inv_sub_box[9][7] = 8'h85;
		assign inv_sub_box[9][8] = 8'he2;
		assign inv_sub_box[9][9] = 8'hf9;
		assign inv_sub_box[9][10] = 8'h37;
		assign inv_sub_box[9][11] = 8'he8;
		assign inv_sub_box[9][12] = 8'h1c;
		assign inv_sub_box[9][13] = 8'h75;
		assign inv_sub_box[9][14] = 8'hdf;
		assign inv_sub_box[9][15] = 8'h6e;
					
				
		assign inv_sub_box[10][0] = 8'h47;
		assign inv_sub_box[10][1] = 8'hf1;
		assign inv_sub_box[10][2] = 8'h1a;
		assign inv_sub_box[10][3] = 8'h71;
		assign inv_sub_box[10][4] = 8'h1d;
		assign inv_sub_box[10][5] = 8'h29;
		assign inv_sub_box[10][6] = 8'hc5;
		assign inv_sub_box[10][7] = 8'h89;
		assign inv_sub_box[10][8] = 8'h6f;
		assign inv_sub_box[10][9] = 8'hb7;
		assign inv_sub_box[10][10] = 8'h62;
		assign inv_sub_box[10][11] = 8'h0e;
		assign inv_sub_box[10][12] = 8'haa;
		assign inv_sub_box[10][13] = 8'h18;
		assign inv_sub_box[10][14] = 8'hbe;
		assign inv_sub_box[10][15] = 8'h1b;
					
				
		assign inv_sub_box[11][0] = 8'hfc;
		assign inv_sub_box[11][1] = 8'h56;
		assign inv_sub_box[11][2] = 8'h3e;
		assign inv_sub_box[11][3] = 8'h4b;
		assign inv_sub_box[11][4] = 8'hc6;
		assign inv_sub_box[11][5] = 8'hd2;
		assign inv_sub_box[11][6] = 8'h79;
		assign inv_sub_box[11][7] = 8'h20;
		assign inv_sub_box[11][8] = 8'h9a;
		assign inv_sub_box[11][9] = 8'hdb;
		assign inv_sub_box[11][10] = 8'hc0;
		assign inv_sub_box[11][11] = 8'hfe;
		assign inv_sub_box[11][12] = 8'h78;
		assign inv_sub_box[11][13] = 8'hcd;
		assign inv_sub_box[11][14] = 8'h5a;
		assign inv_sub_box[11][15] = 8'hf4;
					
				
		assign inv_sub_box[12][0] = 8'h1f;
		assign inv_sub_box[12][1] = 8'hdd;
		assign inv_sub_box[12][2] = 8'ha8;
		assign inv_sub_box[12][3] = 8'h33;
		assign inv_sub_box[12][4] = 8'h88;
		assign inv_sub_box[12][5] = 8'h07;
		assign inv_sub_box[12][6] = 8'hc7;
		assign inv_sub_box[12][7] = 8'h31;
		assign inv_sub_box[12][8] = 8'hb1;
		assign inv_sub_box[12][9] = 8'h12;
		assign inv_sub_box[12][10] = 8'h10;
		assign inv_sub_box[12][11] = 8'h59;
		assign inv_sub_box[12][12] = 8'h27;
		assign inv_sub_box[12][13] = 8'h80;
		assign inv_sub_box[12][14] = 8'hec;
		assign inv_sub_box[12][15] = 8'h5f;
					
				
		assign inv_sub_box[13][0] = 8'h60;
		assign inv_sub_box[13][1] = 8'h51;
		assign inv_sub_box[13][2] = 8'h7f;
		assign inv_sub_box[13][3] = 8'ha9;
		assign inv_sub_box[13][4] = 8'h19;
		assign inv_sub_box[13][5] = 8'hb5;
		assign inv_sub_box[13][6] = 8'h4a;
		assign inv_sub_box[13][7] = 8'h0d;
		assign inv_sub_box[13][8] = 8'h2d;
		assign inv_sub_box[13][9] = 8'he5;
		assign inv_sub_box[13][10] = 8'h7a;
		assign inv_sub_box[13][11] = 8'h9f;
		assign inv_sub_box[13][12] = 8'h93;
		assign inv_sub_box[13][13] = 8'hc9;
		assign inv_sub_box[13][14] = 8'h9c;
		assign inv_sub_box[13][15] = 8'hef;
					
				
		assign inv_sub_box[14][0] = 8'ha0;
		assign inv_sub_box[14][1] = 8'he0;
		assign inv_sub_box[14][2] = 8'h3b;
		assign inv_sub_box[14][3] = 8'h4d;
		assign inv_sub_box[14][4] = 8'hae;
		assign inv_sub_box[14][5] = 8'h2a;
		assign inv_sub_box[14][6] = 8'hf5;
		assign inv_sub_box[14][7] = 8'hb0;
		assign inv_sub_box[14][8] = 8'hc8;
		assign inv_sub_box[14][9] = 8'heb;
		assign inv_sub_box[14][10] = 8'hbb;
		assign inv_sub_box[14][11] = 8'h3c;
		assign inv_sub_box[14][12] = 8'h83;
		assign inv_sub_box[14][13] = 8'h53;
		assign inv_sub_box[14][14] = 8'h99;
		assign inv_sub_box[14][15] = 8'h61;
					
				
		assign inv_sub_box[15][0] = 8'h17;
		assign inv_sub_box[15][1] = 8'h2b;
		assign inv_sub_box[15][2] = 8'h04;
		assign inv_sub_box[15][3] = 8'h7e;
		assign inv_sub_box[15][4] = 8'hba;
		assign inv_sub_box[15][5] = 8'h77;
		assign inv_sub_box[15][6] = 8'hd6;
		assign inv_sub_box[15][7] = 8'h26;
		assign inv_sub_box[15][8] = 8'he1;
		assign inv_sub_box[15][9] = 8'h69;
		assign inv_sub_box[15][10] = 8'h14;
		assign inv_sub_box[15][11] = 8'h63;
		assign inv_sub_box[15][12] = 8'h55;
		assign inv_sub_box[15][13] = 8'h21;
		assign inv_sub_box[15][14] = 8'h0c;
		assign inv_sub_box[15][15] = 8'h7d;

			
//	end	
	
	//Key expansion -> generates round keys
	always @ * begin
		if(rst) begin
			keyExpansion_done	= 1'b0;
			$display(" keyExpansion_done =%h\t",keyExpansion_done);
						
		end
		else if(start) begin
			KeyExpansion(inti_key,round1_key,round2_key,round3_key,round4_key,round5_key,round6_key,round7_key,round8_key,round9_key,round10_key);
		end
	end
	
	//Encryption rounds
	always @ * begin
		if(!keyExpansion_done) begin
			cipher_text	=	128'd0;
			cipher_done = 1'b0;
		end
		
		else if(keyExpansion_done & !cipher_done) begin
			//$display(" keyExpansion_done =%h\t",keyExpansion_done);
			//$display(" round =%h\t",round);
			
			case(round)
				4'b0000: begin
							 AddRoundKey(plain_text,round10_key,round_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);
			
						 end
				4'b0001: begin
							 InvShiftRows(round_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round9_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end
				4'b0010: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round8_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end
				4'b0011: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round7_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b0100: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round6_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b0101: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round5_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b0110: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round4_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b0111: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round3_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b1000: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round2_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b1001: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,round1_key,round_op);
							 InvMixColumns(round_op,mix_op);
							 nxt_round = round+1;
							 $display("round=%h \t",round);		
						 end		 
				4'b1010: begin
							 InvShiftRows(mix_op,shift_op);
							 InvSubBytes(shift_op,sbox_op);
							 AddRoundKey(sbox_op,inti_key,round_op);
							 cipher_text = round_op;
							 cipher_done = 1'd1;
							 $display("round=%h \t",round);		
						 end
			endcase
		end		
	end
	
	//round increment
	always @(posedge clk or posedge rst) begin
		if (rst) begin
		  round <= 4'b0000; // Reset round at the beginning
		  nxt_round <= 4'b0000;
		 // $display("642 round =%h\t",round);
			
		end 
		else begin
		  round <= nxt_round; // Update round based on next_round
		//  $display("647 round =%h\t",round);
		end
	end
	
	//round increment
	/*always @(posedge clk or posedge rst) begin
		if (rst) begin
		  cipher_done <= 1'b0; 
		end 
		
		else if(round == 4'd10) begin
		  cipher_done <= 1'b1; 
		end
		
		else begin
		  cipher_done <= cipher_done; 
		end
	end*/
	
	
	always @(posedge clk) begin
		if (rst) begin
		  clk1	<= 6'd0;
		 end 
		else begin
		  clk1 <= clk1 +1'd1; 
		end
	end
	
	
endmodule