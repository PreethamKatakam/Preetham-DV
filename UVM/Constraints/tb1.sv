module samp;



class Stim;
  const bit [31:0] CONGEST_ADDR = 42;
  typedef enum {READ, WRITE, CONTROL} stim_e;
randc stim_e kind;// Enumerated var
rand bit [31:0] len, src, dst;
randc bit congestion_test;
  constraint c_stim{len < 1000;
                    len > 0;
                    if (congestion_test){
                      dst inside {[CONGEST_ADDR-10 : CONGEST_ADDR+10]};
                    src == CONGEST_ADDR;
                    }
  					else
                      src inside {0, [2:10], [100:107]};
  }
endclass
  
  
  
  initial begin
  Stim p;
  p = new();// Create a packet
    repeat(5) begin
    p.randomize();
   // foreach(p.data[i])
      $display("\n\nKind :%p,\t len:%d,\t src:%d,\t dst:%d,\t congestion_test:%d,\t congest_adder:%d\n\n",p.kind,p.len,p.src,p.dst,p.congestion_test,p.CONGEST_ADDR);
	end
end

endmodule