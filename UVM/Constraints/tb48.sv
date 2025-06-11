module sa;

	int cnt0=0,cnt1=0;
	int rep,i;
		
	class Gr_image;
		rand int image [10];
		bit unsigned [35:0]tot[10];
	
		int i=0;
		
		constraint c1{
					image[0] == 1;
					  foreach(image[i]){
						  image[i] inside {[0:1]};
						  image.sum()==8;
					  }
					  
		}
		
		
		function void post_randomize();
			i=0;
			while(i<10)begin				
				tot[rep]=image[i]+tot[rep];
				tot[rep]=tot[rep]*10;
				i++;
				//$display("%2d",tot[rep]);		
			end
			tot[rep]=tot[rep]/10;
			//$write("%2d",tot[rep]);
			rep++;
			$display;
		endfunction
		
	endclass
	
	initial begin
		Gr_image p = new();
		repeat(10) begin
			p.randomize();
			
			
			foreach(p.image[i]) begin
					$write("%2d",p.image[i]);
					if(p.image[i])
						cnt1++;
					else
						cnt0++;              
			end
			//i=0;
			$display;
			$display;
			
			// while(i<10)begin				
				// tot[rep]=p.image[i]+tot[rep];
				// tot[rep]=tot[rep]*10;
				// i++;
				// //$display("%2d",tot[rep]);		
			// end
			// tot[rep]=tot[rep]/10;
				
			
				
			// //$write("%2d",tot[rep]);
				
			// rep++;
			// $display;		  
		end
		foreach(p.tot[i])
		$display("%d",p.tot[i]);
		$display("cnt0:%d\tcnt1:%d",cnt0,cnt1);
          
	end	
		
endmodule