module sa;
	class packet;     
	 rand int strobe[10];
	 constraint c_l{
	// $countones(strobe)==4;
		strobe.sum() == 4;
		}
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("strobe:%p, sum:%p",p.strobe,p.strobe.sum());
      end
    end
  
endmodule