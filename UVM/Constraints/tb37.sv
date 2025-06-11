module sa;
	
	class range;
		randc bit [15:0] value;
		int max_val;
		
		function new(input int max_val=20);
			this.max_val=max_val;
		endfunction
		
		constraint c_max_val{value<max_val;}
	endclass

	
	class unqArr;
		int max_arr_size,max_val;
		rand bit [15:0] ua[];
		constraint c_size{ua.size() inside {[1:max_arr_size]};}
		
		function new(input int max_arr_size=2,max_val=2);
			this.max_arr_size=max_arr_size;
			if (max_val<max_arr_size)
				this.max_val=max_arr_size;
			else
				this.max_val=max_val;
		endfunction
		
		function void post_randomize();
			range r;
			r=new(max_val);
			foreach(ua[i]) begin
				r.randomize();
				ua[i]=r.value;
			end
		endfunction
			
		function void display();
			$write("Size: %3d",ua.size());
			foreach(ua[i]) $write("%4d",ua[i]);
			$display;
		endfunction
	endclass

			


	
	initial begin
      unqArr p;   
      p = new();// Create a packet

      repeat(15) begin
          p.randomize();
		  p.display();
       // $display("value:%d",p.value);
      end
    end
  
endmodule