//Consecutive Pair Validation
//For a dynamic array, ensure the sum of any two consecutive elements is even, and no three consecutive elements repeat any value.



class pair;
  rand int ar[$];
  
  
  constraint size{ar.size() inside {[1:50]};}
  constraint range{foreach(ar[i])
                       {
                         ar[i] inside {[1:10]};
                       
                       }}
  
  constraint logix{foreach(ar[i]){
    				if(i<(ar.size()-2)){
                      ar[i]!=ar[i+1];
                      ar[i]!=ar[i+2];}
                       }
                       foreach(ar[i])
                       {
                         if(i<(ar.size()-1)){
                           (ar[i]+ar[i+1]) % 2==0;
                       }
                       
                       }}
                       
  
endclass
                           
                           
                           
module m;
  pair p;
  
  initial begin
    p=new();
    
    p.randomize();
    $display("%p",p.ar);
    
  end
  
endmodule