class packet;
  rand int a;
  constraint c1{a inside {[0:10]};}
  
  function void post_randomize();
      for(int j=0;j<=a;j++)begin
        $write("(");
      end
    $write("*");
        for(int k=0;k<=a;k++)begin
          $write(")");
        end
    $display();    

  endfunction  
                
endclass
      
      module ola;
        packet pkt;
        initial begin
        pkt=new();
        
          repeat(50) begin        
        pkt.randomize();
        end
        end
      endmodule
