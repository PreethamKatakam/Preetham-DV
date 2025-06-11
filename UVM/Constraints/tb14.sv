module sa;
	class BusOp;
     rand bit d,e;
	 constraint c {(d==1) <->(e==1);}	
	endclass

	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("d:%p \t e: %x",p.d,p.e);
      end
    end
  
endmodule