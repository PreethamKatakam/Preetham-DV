//Pythagorean Triplet
//Randomize positive integers a, b, and c (all < 100) such that a2+b2=c2


class pythag;
  rand int a,b,c;
  
  constraint c1{(a*a) +(b*b) == (c*c);}
  constraint c2{a inside {[1:100]};
               b inside {[1:100]};
               c inside {[1:100]};}
  
endclass

module s;
  pythag p;
  
  initial begin
    repeat(10) begin
    p=new();
    p.randomize();
      $display("a=%0d,b=%0d,c=%0d",p.a,p.b,p.c);
      $display("a2=%0d,b2=%0d,c2=%0d",p.a*p.a,p.b*p.b,p.c*p.c);
  end  
  end
endmodule