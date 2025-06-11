//Exclusion of Array Elements
//Variable x (1-100) must not match any element in a pre-randomized array excluded (5 unique values between 1-100).


class array;
  rand int x;
  int a[];
  constraint c1{foreach(a[i])
  {x!=a[i];}}
    constraint c2 {x inside{[1:100]};}
  
  function void pre_randomize();
    a='{10,23,45,54,98};    
  endfunction
endclass
                
                
module m;
  array a1;
  
  initial begin
    repeat (10) begin
      a1=new();
      a1.randomize();
      $display("%d",a1.x);
      
    end
    
  end
  
  
endmodule