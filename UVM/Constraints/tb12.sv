module sa;
	class BusOp;
      typedef enum {BYTE,WORD,LWRD} length_e;
      typedef enum {READ,WRITE} operand_e;
		
		rand operand_e op;
		rand length_e len;
		constraint c_len_Iw{
			if (op == READ) {
				len inside { [BYTE:LWRD] };
			}	
			else{
				len == LWRD;
			}
		}	
	endclass

	
	initial begin
      BusOp p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("op:%p,\t len:%p",p.op,p.len);
      end
    end
  
endmodule