//Randc with Even Distribution
//Use randc to cycle through all values 1-10 in x, but constrain x to be even. Explain how this affects the randomization sequence.

class sample;
  
  randc int value;
  
  constraint c1{value inside {[1:10]};}
  constraint c2{value%2 ==0;}
endclass


module x;
  sample p;
  
  initial begin
    p=new();
    
    repeat(10) begin
    p.randomize();    
      $display("Val %d",p.value);
      end
  end
  
endmodule