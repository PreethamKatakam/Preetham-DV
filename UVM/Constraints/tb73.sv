module sa;

	class Gr_image;
		rand bit image [10][10];
		int i,j;
		constraint c1{
					//foreach(image[i])
			/*foreach(image[i]) {
				foreach(image[i][j]) {
                  image[i][j]  dist {1:=50,0:=50};
				}
			}*/
          image.sum()==20;
          
		}
	endclass
	
	initial begin
		Gr_image p = new();
		int cnt0=0,cnt1=0;
		repeat(1) begin
			p.randomize();
			
			
			for(int i=0;i<10;i++) begin
				for(int j=0;j<10;j++) begin
					$write("%b",p.image[i][j]);
					if(p.image[i][j])
						cnt1++;
					else
						cnt0++;
				end
              $display;
			end
          $display("cnt0:%d\tcnt1:%d",cnt0,cnt1);
          
		end
	end	
		
endmodule