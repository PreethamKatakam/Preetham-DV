//Temporal Counter Sequence
//Generate a counter count where each new randomization produces a value greater than the previous (starting at 1).


class seq;
  rand bit [10:0]a;
  static int temp=1;
  
  constraint c1{a>temp;}
  //constraint c2{a inside {[1:5000]};}
  function void post_randomize();
    temp=a;
  endfunction
  
  
endclass


module x;
  seq s;
  
  initial begin
    repeat (10) begin
      s=new();
      s.randomize();
      $display("%d",s.temp);
    end
  end
  
endmodule