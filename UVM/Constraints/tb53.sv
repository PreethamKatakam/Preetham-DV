//In a 5-over match with three bowlers (A, B, and C), where each can bowl a minimum of 1 over and a maximum of 2 overs, A can concede between 0 to 5 runs, B between 0 to 15 runs, and C between 0 to 20 runs, with each over consisting of 6 balls and the last ball of every over being a dot ball—how would you write the SystemVerilog constraints for this scenario?


class sample;
  rand int a[],b[],c[];
  rand int a_sum;
  constraint overs{a.size inside {6,12};
                   b.size inside {6,12};
                   c.size inside {6,12};}
  
  constraint tot_overs{a.size+b.size+c.size == 30;}
  
  constraint runs{foreach(a[i]){
    				a[i] inside {[0:6]};
  					}
    			  foreach(b[i]){
    				b[i] inside {[0:6]};
  					}
                  foreach(c[i]){
    				c[i] inside {[0:6]};
  					}  
    			  a.sum() inside {[0:5]};
                  b.sum() inside {[0:15]};
                  c.sum() inside {[0:20]};
                 
                 
                 foreach(a[i]){
                   if((i+1)%6 ==0){
                     a[i]==0;
  					}
                 }
                     foreach(b[i]){
                   if((i+1)%6 ==0){
                     b[i]==0;
  					}
                 }
                     foreach(c[i]){
                   if((i+1)%6 ==0){
                     c[i]==0;
  					}
                 }
                 }
endclass


module ola;
  sample s;
  
  initial begin
    s= new();
    repeat(3) begin
    	s.randomize();
    
      $display("a=%p",s.a);
      $display("b= %p",s.b);
      $display("c= %p",s.c);
    end
  end
  
endmodule
  