module sa;
	
	class Exercise2;
		rand bit [7:0] data;
		rand bit [3:0] addr;
		
		constraint c1{	
			data == 5;
			addr dist {0:/10,[1:14]:/80,15:/10};
		
		}
	endclass	
		
		
		
	initial begin
      Exercise2 p;
	  p=new();
	  
	  repeat(10) begin
		p.randomize();
		$display("data:%d, \addr:%p",p.data,p.addr);	
		
    end
	end
  
endmodule