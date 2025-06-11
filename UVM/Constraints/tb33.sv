module sa;
	class packet;     
	 rand bit[4:0] d[10];
	 constraint c_l{
		foreach(d[i])
			if(i>0)
				d[i]>d[i-1];
				}
	endclass

	
	initial begin
      packet p;   
      p = new();// Create a packet

      repeat(15) begin
          p.randomize();
        $display("d:%p",p.d);
      end
    end
  
endmodule