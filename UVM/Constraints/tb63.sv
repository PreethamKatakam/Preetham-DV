//Inheritance-Based Constraints
//A parent class constrains value < 10; a child class adds value > 5. Determine the valid range for value in the child class.
class parent;
  
  rand int value;
  
  constraint c1{value <10;}
endclass

class child extends parent;
  
  constraint c2{value >5;}
endclass

module x;
  parent p;
  child c;
  
  initial begin
    p=new();
    c=new();
    repeat(10) begin
    p.randomize();    
    $display("par %d",p.value);
    
    c.randomize();    
    $display("chi %d",c.value);
  end
  end
  
endmodule