//Prime Number Distribution
//Randomize a 16-bit variable p such that it is a prime number. Use a helper function to check primality within constraints.
  
  
  
  class prime;
    rand bit [15:0]a;
    int i,j;
    
    constraint c1{a == pr(a);}
    
    function bit [15:0] pr(bit [15:0]x);
      int i,j=0;
      for(i=1;i<2**16;i =i+1) begin
        if(x%i==0) begin
          j=j+1;
        end        
      end
      
      if(j==2)
        return x;
      else
        return 2;
      
    endfunction
    
  endclass
  
  
  module s;
    prime p;
    
    initial begin
      p=new();
      p.randomize();
      $display("%d",p.a);
      
    end
    
    
  endmodule