module sa;
	class packet;     
	 rand bit[4:0] d[10];
	 constraint c_l{
		foreach(d[i])
			foreach(d[j])
				if(i!=j)
					d[i]!=d[j];
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