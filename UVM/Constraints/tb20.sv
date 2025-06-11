module sa;
	class bathtub;     
	 int value;
	 int width=50,depth=6,seed=1;
	 
	 function void pre_randomize();
		value=$dist_exponential(seed,depth);
		
		if(value>width) 
			value=width;
		
		if($urandom_range(1))
			value=width-value;
	 endfunction
	 
	endclass

	
	initial begin
      bathtub p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("value:%d \t depth: %d \t width: %d ",p.value,p.depth,p.width);
      end
    end
  
endmodule