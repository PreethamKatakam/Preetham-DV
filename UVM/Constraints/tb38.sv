module sa;
	
	parameter MAX_SIZE=10;
	
	class randV;
		rand bit [31:0] value;
	endclass
	
	
	
	class randA;
		rand randV array[];
		constraint c_size{array.size() inside {[1:MAX_SIZE]};}
		
		function new();
			array=new[MAX_SIZE];
			foreach(array[i])
				array[i]=new();
		endfunction
		
	endclass

			


	randA p;   
      
	initial begin
      p = new();// Create a packet

      repeat(1) begin
          p.randomize();
		  foreach(p.array[i])
			$display("array:%p",p.array[i]);
       // $display("value:%d",p.value);
      end
    end
  
endmodule