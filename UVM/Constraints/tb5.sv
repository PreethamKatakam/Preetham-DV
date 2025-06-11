module s2;

class Fib;
  rand bit [7:0] f;
  bit [7:0] vals[9:0] ;
  int a, b,i,f;
  
  constraint c_fibonacci{
    f inside vals;}
 
  
  function void pre_randomize();
    vals[0]=0;
    vals[1]=1;
    a=vals[0];
    b=vals[1];
      for(i=2;i<=10;i++) begin
          f=a+b;
          a=b;
          b=f;
          vals[i]=f;
        end      
  endfunction
  
endclass
  
  
   
 initial begin
   Fib p;   
   p = new();// Create a packet
   
   repeat(5) begin
    p.randomize();
    $display("f:%0d",p.f);
   end
   
    #10
   for(int i=0;i<10;i++)
     $display("vals: %d",p.vals[i]);   
   end
  
  
endmodule