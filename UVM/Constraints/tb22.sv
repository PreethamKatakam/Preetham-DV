module sa;
	typedef enum {READ8,READ16,READ32} read_e;	 
	class bathtub;
	 rand read_e read_cmd;
	 int read8_wt=1,read16_wt=1,read32_wt=1;
	 constraint c_l{
		read_cmd dist{READ8:=read8_wt,
					  READ16:=read16_wt,
					  READ32:=read32_wt};
		}
	endclass

	
	initial begin
      bathtub p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("read_cmd: %p ",p.read_cmd);
      end
    end
  
endmodule