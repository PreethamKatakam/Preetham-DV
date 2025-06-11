
module sa;
	class packet;     
      rand bit[31:0] d[];
	 constraint c_l{
       d.size() inside {[1:10]};
		}
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("d: %d, size % 4096: %d ",p.d,p.(d.size()));
      end
    end
  
endmodule