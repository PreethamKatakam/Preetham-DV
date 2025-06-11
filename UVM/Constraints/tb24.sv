module sa;
	class packet;     
	 rand byte pkt1_len,pkt2_len;
	 constraint c_l{
		pkt1_len+pkt2_len==64;
		}
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("pkt1_len: %d, pkt2_len: %d ",p.pkt1_len,p.pkt2_len);
      end
    end
  
endmodule