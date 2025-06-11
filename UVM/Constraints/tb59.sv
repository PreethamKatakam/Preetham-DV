//Soft vs. Hard Constraint Conflict
//Define a soft constraint x > 10 and a hard constraint x < 5. Predict the randomization outcome and explain solver behavior.
class sample;
  rand int x;
  
  constraint c1{soft x>10;
               x<5;}
  
endclass


module a;
  sample s;
  initial begin
    s=new();
    s.randomize;
    $display(s.x);
    
  end
  
endmodule