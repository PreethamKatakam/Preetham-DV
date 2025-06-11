//Question: Randomize three variables (a, b, c) such that:

//a + b + c = 100
//a is always a multiple of 5, b is a multiple of 3, and c is an odd number.

// Code your testbench here
// or browse Examples
class sample ;
  rand int a,b,c;
  
  constraint c1 { a+b+c == 100;}
  constraint c2 { a%5 ==0;b%3 == 0; c%2==1;}
  
  
  
  
endclass

module ola;
  sample s;
  
  initial begin
    s= new();
    
    s.randomize();
    $display("a=%0d, b=%0d, c=%0d, sum = %d",s.a,s.b,s.c,s.a+s.b+s.c);
  end
  
endmodule