
module sa;
	class packet;     
      rand bit[31:0] addr;
	 constraint c_l{
       addr[11:0] inside{[0:20],[4075,4095]};
		}
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("addr: %d, addr % 4096: %d ",p.addr,p.(addr[11:0]));
      end
    end
  
endmodule