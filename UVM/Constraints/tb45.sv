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
	  int ct1,ct2,ct3;
      Exercise2 p;
	  p=new();
	  
	  repeat(100000) begin
		p.randomize();
		//$display("data:%d, \addr:%p",p.data,p.addr);	
		
		if(p.addr == 0)
			ct1++;
		else if(p.addr == 4'd15)
			ct3++;
		else
			ct2++;
		
    end
		$display("ct1:%d\tct2:%d\tct3:%d",(ct1/1000),(ct2/1000),(ct3/1000));
	end
  
endmodule