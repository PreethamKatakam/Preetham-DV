module sa;
	class RandcInside;
		int array[];	//Values to choose
		randc bit [15:0] index;	// Index into array
		
		function new (input int a[]) ; // Construct & initialize
			array = a;
		endfunction
		
		function int pick();	// Return most recent pick
			return array [index] ;
		endfunction

		constraint c_size {index < array.size();}
	endclass
	
	
	initial begin
      RandcInside p;   
      p = new('{10,20,21,12,1,5,9});// Create a packet

      repeat(5) begin
          p.randomize();
        $display("Picked Item:%d,\t Index:%d",p.pick(),p.index);
      end
    end
  
endmodule