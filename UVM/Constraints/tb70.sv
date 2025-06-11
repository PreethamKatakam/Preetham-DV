//Unique Struct Pairs
//Create an array of 5 structs, each containing two integers. Ensure all pairs are unique, and within each pair, element1≠element2


class stu;
  
  typedef struct {
   rand int a,b;    
  }unq_str;
  
  rand unq_str us[5];
  
  constraint c1{foreach(us[i]){
    us[i].a inside {[1:200]}; 
    us[i].b inside {[300:500]}; }}
  
endclass


module a;
  stu s;
  
  initial begin
    s=new();
    s.randomize();
    $display("%p",s.us);
    
  end
  
endmodule