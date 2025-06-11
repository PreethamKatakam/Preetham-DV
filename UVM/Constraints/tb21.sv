module sa;
	class bathtub;     
	 rand bit [31:0] length;
	 bit [31:0] max_length=100;
	 constraint c_l{
		length inside {[1:max_length]};
		}
	endclass

	
	initial begin
      bathtub p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("length: %d ",p.length);
      end
    end
  
endmodule