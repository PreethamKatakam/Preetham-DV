//Permutation of Dynamic Array
//Generate an array of size 5-10 containing a permutation of numbers from 1 to N (where N is the array size).


class per;
  rand int ar[];
  
  constraint c1{ar.size() inside {[5:10]};
                unique{ar};}
  constraint c2{foreach(ar[i])
    				ar[i] inside {[1:ar.size()]};}
endclass

module b;
  per p;
  
  initial begin
    p=new();
    p.randomize();
    $display("%p",p.ar);
    
  end
  
endmodule
  