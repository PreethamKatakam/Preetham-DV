module s1;

class Bus;
// Operand length
  typedef enum {B, WO, LWRD } length_e; 
  rand length_e len;
// Weights for dist constraint
  bit [31:0] w_byte=5, w_word=5, w_lwrd=80;
constraint c_len {

len dist {B := w_byte, 
          WO := w_word,
          LWRD := w_lwrd};  }
endclass
  
  
 initial begin
   Bus p;
   
   p = new();// Create a packet
   repeat(20) begin
    p.randomize();
  
      $display("len:%0p",p.len);
   end
end
endmodule
 
endmodule