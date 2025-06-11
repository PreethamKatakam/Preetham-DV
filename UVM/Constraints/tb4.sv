
module s1;

class Ranges;
  rand bit [31:0] c;
  rand bit [31:0] d;
  bit [31:0] lo=10, hi=35;
constraint c_range {

  c inside {[lo:hi] };
}
constraint d_range {

  !(d inside {[lo:hi] });
}

endclass

  
 initial begin
   Ranges p;
   
   p = new();// Create a packet
   repeat(5) begin
    p.randomize();
  
     $display("c:%0d \t d:%0d",p.c,p.d);
   end
end
endmodule
 
          
  