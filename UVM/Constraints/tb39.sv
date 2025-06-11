module sa;
	
	parameter MAX_SIZE=10;
	
	class randV;
		rand bit [3:0] src,dst;
	endclass
	
	
	
	class randA;
		rand randV item[10];
		
		function new();
			//array=new[MAX_SIZE];
			foreach(item[i])
				item[i]=new();
		endfunction
		
		constraint c1{
					foreach (item[i])
						if(i>0)
							item[i].dst>item[i-1].dst;}
		
		
	endclass

			


	randA p;   
      
	initial begin
      p = new();// Create a packet

      repeat(1) begin
          p.randomize();
		  foreach(p.item[i])
			$display("item[%0d]:%d",i,p.item[i].dst);
       // $display("value:%d",p.value);
      end
    end
  
endmodule