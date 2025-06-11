module sa;

		
	class StimData;
		rand int ola [];
		
		constraint c1{
					ola.size() inside {[1:1000]};
					}		
	endclass
	
	initial begin
		StimData p = new();
		repeat(1) begin
			p.randomize();
			$display("array:%p, size:%d",p.ola,p.ola.size());		
					  
		end
          
	end	
		
endmodule