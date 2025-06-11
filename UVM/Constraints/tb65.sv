//Conditional Index Constraints
//For a dynamic array, enforce that every even-indexed element (0, 2, 4...) is greater than the preceding odd-indexed element.

class constr;
  
  rand int a[$];
  
  constraint c1{a.size inside {[1:500]};}
  constraint c2{foreach(a[i]){
    			if(i>0){
                  if(i%2==0){
                    a[i]>a[i-1];
    }}}}
                    constraint c3{foreach(a[i]){a[i] inside {[1:5000]};}}
  
endclass
                    
module x;
  constr c;
  initial begin
    c=new();
    c.randomize();
    
    
    $display("%p",c.a);
    
  end
  
  
endmodule