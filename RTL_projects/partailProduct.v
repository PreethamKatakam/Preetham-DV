//created on 13/12/23
module partailProduct(x,
						w,
						partProduct0,
						partProduct1,
						partProduct2,
						partProduct3,
						sum_2,
						carry_2);

	input 	[7:0] 	x;
	input	[7:0] 	w;
	output  reg 	[10:0]	partProduct0;
	output  reg 	[10:0]	partProduct1;
	output  reg 	[10:0]	partProduct2;
	output  reg 	[10:0]	partProduct3;
	output  reg		[11:0]  sum_2;
	output  reg		[11:0]  carry_2;
	
	
	reg 	[3:0]	neg;
	reg 	[3:0]	one;
	reg 	[3:0]	two;
	reg 	[8:0]	na		[3:0];
	reg 	[8:1]	p		[3:0];
	reg 	[3:0]	T;
	reg 	[2:0]	c;
	reg				E;
	reg 			t1;
	reg 			d;
	reg 	[7:0]	s;
	reg				a0;
	reg				a1;
	reg				a2;
	
	reg		[10:0]  sum_1;
	reg		[10:0]  carry_1;
	
	reg 	[12:0] wrt_s1;
	reg 	[11:0] wrt_c1;
	reg 	[10:0] wrt_1;
	
	reg 	[13:0] wrt_s2;
	reg 	[12:0] wrt_c2;
	
	
	// reg		[11:0]  sum_2;
	// reg		[11:0]  carry_2;
	
	integer i,j;
	
	
	function sum_HA;//half adder sum
	input a;
	input b;
	begin		
		sum_HA = a ^ b;		
	end
	endfunction
	
	function sum_FA;//full adder sum
	input a;
	input b;
	input c;
	begin		
		sum_FA = a ^ b ^ c;		
	end
	endfunction
	
	function carry_HA;//half adder carry
	input a;
	input b;
	begin		
		carry_HA = a & b;		
	end
	endfunction
	
	function carry_FA;//full adder carry
	input a;
	input b;
	input c;
	begin		
		carry_FA = (a & b) | (b & c) | (c & a);		
	end
	endfunction
	
	
	
	
	always @ * begin
	
		//neg
		neg[0]	=	w[1];
		for(i = 1 ;i <= 3; i = i+1) begin
			neg[i]	=	w[2*i+1] & ( !(w[2*i]) | !(w[2*i-1]) );
		end
		
		//one
		one[0]	=	w[0];
		for(i = 1 ;i <= 3; i = i+1) begin
			one[i]	=	( w[2*i] ^ (w[2*i-1]) );
		end
		
		//two
		two[0]	=	(w[1] & !w[0]);
		for(i = 1 ;i <= 3; i = i+1) begin
			two[i]	=	( (!w[2*i+1] & w[2*i] & w[2*i-1]) | (w[2*i+1] & !w[2*i] & !w[2*i-1]) );
		end
		
		//na
		for(i = 0 ;i <= 3; i = i+1) begin
			for(j = 0 ;j <= 7; j = j+1) begin
				na[i][j]	=	!(x[j] ^ w[2*i+1]);
			end
		end
		
		for(i = 0 ;i <= 3; i = i+1) begin
			na[i][8]	=	na[i][7];
		end
		
		
		//p
		for(i = 0 ;i <= 3; i = i+1) begin
			for(j = 1 ;j <= 8; j = j+1) begin
				p[i][j]	=	!((na[i][j-1] | !two[i]) & (na[i][j] | !one[i]));
				//$display(" p[%0d][%0d] =%b\t",i,j,p[i][j]);		
			end
		end
		
		//T
		for(i = 0 ;i <= 3; i = i+1) begin
			T[i]	=	!( !one[i] | !x[0] );
		end
		
		//c
		for(i = 0 ;i < 3; i = i+1) begin
			c[i]	=	neg[i] & ( !one[i] | !x[0] );
		end
		
		//E
		if( (!(x & w[7])) == 1'b0) begin
			E	=	!x[1];
		end
		else begin
			E	=	x[1];
		end
		
		//t1
		t1	=	!( (!one[3] | !E) & (!two[3] | !x[0]) );
		
		//d
		d	=	!(!w[7] | x[0]) & !((w[5] | x[0]) & (w[6] | x[0]) & (w[6] | w[5]));
		
		//s
		for(i = 0 ;i <= 3; i = i+1) begin
			s[i]	=	p[i][8];
		end
		
		//a0,a1,a2
		a2	=	!(s[0] & !d);
		a1	=	s[0] & !d;
		a0	=	!(s[0] ^ !d);	


		partProduct0	=	{a2,a1,a0,p[0][7],p[0][6],p[0][5],p[0][4],p[0][3],p[0][2],p[0][1],T[0]};
		partProduct1	=	{1'b1,!s[1],p[1][7],p[1][6],p[1][5],p[1][4],p[1][3],p[1][2],p[1][1],T[1],c[0]};
		partProduct2	=	{1'b1,!s[2],p[2][7],p[2][6],p[2][5],p[2][4],p[2][3],p[2][2],p[2][1],T[2],c[1]};
		partProduct3	=	{1'b1,!s[3],p[3][7],p[3][6],p[3][5],p[3][4],p[3][3],p[3][2],t1,T[3],c[2]};
		
		$display(" p[0] =     %b\t",p[0]);
		$display(" p[1] =    %b\t",p[1]);
		$display(" p[2] =  %b\t",p[2]);
		$display(" p[3] =%b\t",p[3]);
		
		$display(" s[0] =%b\t",s[0]);
		$display(" s[1] =%b\t",s[1]);
		$display(" s[2] =%b\t",s[2]);
		$display(" s[3] =%b\t",s[3]);
		
		$display(" partProduct0 =     %b\t",partProduct0);
		$display(" partProduct1 =    %b\t",partProduct1);
		$display(" partProduct2 =  %b\t",partProduct2);
		$display(" partProduct3 =%b\t",partProduct3);
		
		
		sum_1[0]  = sum_HA(p[0][1],c[0]);
		sum_1[1]  = sum_HA(p[0][2],T[1]);
		sum_1[2]  = sum_FA(p[0][3],p[1][1],c[1]);
		sum_1[3]  = sum_FA(p[0][4],p[1][2],T[2]);
		sum_1[4]  = sum_FA(p[0][5],p[1][3],p[2][1]);
		sum_1[5]  = sum_FA(p[0][6],p[1][4],p[2][2]);
		sum_1[6]  = sum_FA(p[0][7],p[1][5],p[2][3]);
		sum_1[7]  = sum_FA(a0,p[1][6],p[2][4]);
		sum_1[8]  = sum_FA(a1,p[1][7],p[2][5]);
		sum_1[9]  = sum_FA(a2,!s[1],p[2][6]);
		sum_1[10] = sum_HA(1'b1,p[2][7]);
		
		carry_1[0]  = carry_HA(p[0][1],c[0]);
		carry_1[1]  = carry_HA(p[0][2],T[1]);
		carry_1[2]  = carry_FA(p[0][3],p[1][1],c[1]);
		carry_1[3]  = carry_FA(p[0][4],p[1][2],T[2]);
		carry_1[4]  = carry_FA(p[0][5],p[1][3],p[2][1]);
		carry_1[5]  = carry_FA(p[0][6],p[1][4],p[2][2]);
		carry_1[6]  = carry_FA(p[0][7],p[1][5],p[2][3]);
		carry_1[7]  = carry_FA(a0,p[1][6],p[2][4]);
		carry_1[8]  = carry_FA(a1,p[1][7],p[2][5]);
		carry_1[9]  = carry_FA(a2,!s[1],p[2][6]);
		carry_1[10] = carry_HA(1'b1,p[2][7]);
		
		wrt_s1 = {!s[2],sum_1[10:0],T[0]};
		wrt_c1 = {1'b1,carry_1[10:0]};
		wrt_1  = partProduct3;
		
		$display(" wrt_s1       =   %b\t",wrt_s1);
        $display(" wrt_c1       =  %b\t",wrt_c1);
        $display(" wrt_1        =%b\t",wrt_1);
		
		
		sum_2[0]   = sum_HA(sum_1[1],carry_1[0]);
		sum_2[1]   = sum_HA(sum_1[2],carry_1[1]);
		sum_2[2]   = sum_HA(sum_1[3],carry_1[2]);
		sum_2[3]   = sum_FA(sum_1[4],carry_1[3],c[2]);
		sum_2[4]   = sum_FA(sum_1[5],carry_1[4],T[3]);
		sum_2[5]   = sum_FA(sum_1[6],carry_1[5],t1);
		sum_2[6]   = sum_FA(sum_1[7],carry_1[6],p[3][2]);
		sum_2[7]   = sum_FA(sum_1[8],carry_1[7],p[3][3]);
		sum_2[8]   = sum_FA(sum_1[9],carry_1[8],p[3][4]);
		sum_2[9]   = sum_FA(sum_1[10],carry_1[9],p[3][5]);
		sum_2[10]  = sum_FA(sum_1[10],carry_1[9],p[3][5]);
		sum_2[11]  = sum_HA(1'b1,p[3][7]);
		
		carry_2[0]   = carry_HA(sum_1[1],carry_1[0]);
		carry_2[1]   = carry_HA(sum_1[2],carry_1[1]);
		carry_2[2]   = carry_HA(sum_1[3],carry_1[2]);
		carry_2[3]   = carry_FA(sum_1[4],carry_1[3],c[2]);
		carry_2[4]   = carry_FA(sum_1[5],carry_1[4],T[3]);
		carry_2[5]   = carry_FA(sum_1[6],carry_1[5],t1);
		carry_2[6]   = carry_FA(sum_1[7],carry_1[6],p[3][2]);
		carry_2[7]   = carry_FA(sum_1[8],carry_1[7],p[3][3]);
		carry_2[8]   = carry_FA(sum_1[9],carry_1[8],p[3][4]);
		carry_2[9]   = carry_FA(sum_1[10],carry_1[9],p[3][5]);
		carry_2[10]  = carry_FA(sum_1[10],carry_1[9],p[3][5]);
		carry_2[11]  = carry_HA(1'b1,p[3][7]);
		
		wrt_s2 = {!s[3],sum_2[11:0],T[0]};
		wrt_c2 = {1'b1,carry_2[11:0]};
		
		$display(" wrt_s2       =    %b\t",wrt_s2);
		$display(" wrt_c2	 	=   %b\t",wrt_c2);
	
	end
	
endmodule
	
	
	
	
	
	
