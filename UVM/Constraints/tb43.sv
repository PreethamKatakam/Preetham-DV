module sa;
	
	class Exercise1;
		rand bit [7:0] data;
		rand bit [3:0] addr;
		
		constraint c1{	
			addr inside {[3:4]};
		
		}
	endclass	
		
		
		
	initial begin
      Exercise1 p;
	  p=new();
	  
	  repeat(10) begin
		p.randomize();
		$display("data:%d, \addr:%p",p.data,p.addr);	
		
    end
	end
  
