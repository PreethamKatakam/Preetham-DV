module sa;
	
	class range;
		randc bit [15:0] value;
		int max_val;
		
		function new(input int max_val=20);
			this.max_val=max_val;
		endfunction
		
		constraint c_max_val{value<max_val;}
	endclass

			


	
	initial begin
      range p;   
      p = new();// Create a packet

      repeat(15) begin
          p.randomize();
        $display("value:%d",p.value);
      end
    end
  
endmodule