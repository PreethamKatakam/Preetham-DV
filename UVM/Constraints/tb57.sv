//Bidirectional Modular Inverse
//Randomize two variables a and b (1-255) such that (a×b)mod  256=1,
  
  class bidirect;
    rand int a,b;
    
    constraint logix{a inside {[1:255]};
                     b inside {[1:255]};
                     (a*b) % 256 == 1;
                       }
  endclass
  
  
   module s;
    bidirect d;
    
    initial begin
      repeat(10) begin
      	d=new();
      	d.randomize();
        $display("%d %d",d.a,d.b);
      end
    end
    
    
  endmodule
                       