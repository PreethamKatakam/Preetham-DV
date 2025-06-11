module sa;
	class BusOp;
     rand bit x;
	 rand bit [1:0] y;
	 constraint c_xy{
	 y>0;
	 (x==0) -> (y==0);
	 }
	endclass

	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("x:%b \t y: %d",p.x,p.y);
      end
    end
  
endmodule