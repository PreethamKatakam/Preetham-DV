// Code your testbench here
// or browse Examples
class a;
  rand int x;
  
  constraint c1 {x inside {[100:1000000000]};}

  function void post_randomize();
    int rem,rev;
    $display("%d",x);   
     
    while(x!=0) begin
      rem = x%10;
      rev = (rev*10) + rem;
      x= x/10;
    end
     $display("%d",rev);   
                              
  endfunction
                            
endclass
                            
module y;
  a a1;
  
  initial begin
    a1 = new();
    a1.randomize();
    
  end
  
  
endmodule