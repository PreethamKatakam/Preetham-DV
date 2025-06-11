module sa;
	class BusOp;     
	 typedef enum {BYTE, WORD, LWRD, QWRD} length_e;
	 typedef enum {READ, WRITE, RMW, INTR} access_e;
	 rand length_e length;
	 rand access_e access;
	 constraint valid_RMW_LWRD{
	 (access==RMW) -> (length==LWRD);}
	endclass

	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("length:%p \t access: %p",p.length,p.access);
      end
    end
  
endmodule