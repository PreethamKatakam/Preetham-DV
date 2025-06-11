module sa;
	class packet;     
	 rand bit[31:0] len[];
	 constraint c_l{
		foreach (len[i])
			len[i] inside {[1:255]};
		len.sum() < 1024;
		len.size() inside {[1:8]};
		}
		
		function void display();
			$write("sum=%4d, val=",len.sum());
			foreach(len[i]) $write("",len[i]);
			$display;
		endfunction
			
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(15) begin
          p.randomize();
        p.display();
      end
    end
  
endmodule