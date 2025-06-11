//Dynamic Array with Exponential Growth
//Constrain a dynamic array arr with size 5-10. The first element is 1, each subsequent element is double the previous, and the last element must be a power of 2.
  
  
  class dynamic;
    rand int a[$];
    
    constraint size{a.size() inside {[5:10]};}
    constraint logix{a[0]==1;
                     foreach(a[i]){
                       if(i>0){
                         a[i] == 2*a[i-1];
                       }
                     }
                       }
  endclass
  
  
  module s;
    dynamic d;
    
    initial begin
      d=new();
      d.randomize();
      $display("%p",d.a);
      
    end
    
    
  endmodule