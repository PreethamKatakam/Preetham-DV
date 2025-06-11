module sa;
	class packet;     
	 rand byte len[];
	 constraint c_l{
	// $countones(strobe)==4;
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