module sa;
	class BusOp;
      typedef enum {MEM,IO,NTG} addr_space_e;
      
		rand addr_space_e addr_space;
		rand bit [31:0] addr;
		constraint c_addr_space{
			if (addr_space == MEM)
				addr inside {[0:32'h0FFF_FFFF] };
          else if (addr_space == IO)
				addr inside {[32'h1000_0000 : 32'h7FFF_FFFF]};
			else
				addr inside {[32'h8000_0000: 32'heeff_fffe] };
		}	
	endclass

	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("addr_space:%p \t addr: %x",p.addr_space,p.addr);
      end
    end
  
endmodule