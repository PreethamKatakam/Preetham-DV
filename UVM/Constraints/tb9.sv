module sa;
	class BusOp;
		rand bit [31:0] addr;
		rand bit io_space_mode;
      constraint c_io{io_space_mode -> (addr[31] == 1'b1);}
	endclass
	
	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("addr:%b,\t io_space_mode:%b",p.addr,p.io_space_mode);
      end
    end
  
endmodule