module sa;
	class packet;     
	 rand bit[7:0] val;
	endclass

	class packArr;
		bit [7:0] ua [64];
		
		function void pre_randomize();
			packet p1;
			p1=new();
			foreach (ua[i]) begin
				p1.randomize();
				ua[i]=p1.val;
			end
			$display("val:%p",p1.val);
		endfunction
	endclass

			


	
	initial begin
      packArr p;   
      p = new();// Create a packet

      //repeat(15) begin
          p.randomize();
        $display("ua:%p",p.ua);
      //end
    end
  
endmodule