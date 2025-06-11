module sa;
	class Bidir;
	rand bit [15:0] r,s,t;
	constraint c_bidir {r<t;
						s==r;
						t<10;
						s>5;
						}
endclass
	
	
	initial begin
      Bidir p;   
      p = new();// Create a packet

      repeat(5) begin
          p.randomize();
        $display("r:%d,\t s:%d,\t t:%d",p.r,p.s,p.t);
      end
    end
  
endmodule