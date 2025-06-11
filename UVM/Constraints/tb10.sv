module sa;
	class LogImp;
		rand bit d,e;
		constraint c{(d==1) -> (e==1);}
	endclass
	
	
	initial begin
      LogImp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("d:%d,\t e:%d",p.d,p.e);
      end
    end
  
endmodule