//pixel image 10x10

module sa;

	int cnt0=0,cnt1=0;
		
	class Gr_image;
		rand int image [10];
		int i=0;
		
		constraint c1{
					
		  foreach(image[i]){
			  image[i] inside {[0:1]};
			  image.sum()==8;
		  }
		  
		}
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
			$display;		  
		end
		$display("cnt0:%d\tcnt1:%d",cnt0,cnt1);
          
	end	
		
endmodule