//Non-Contiguous Bitmask
//Constrain an 8-bit variable to have exactly 3 set bits, none of which are adjacent (e.g., 00101001 is valid, 00110011 is invalid).


class bitmask;
  rand bit [7:0] a;
  
  constraint setbit{$countones(a) == 3;}
  constraint c2{foreach(a[i])
    if(i<7){
    				if(a[i]){
                      a[i+1]!=1;}}
    }
  
endclass


module s;
  bitmask b;
  
  initial begin
    b=new();
      
    repeat(20) begin
      b.randomize();
      $display("%b",b.a);
      
    end
  end
  
endmodule