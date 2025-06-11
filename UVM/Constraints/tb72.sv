// // Code your testbench here
// // or browse Examples
// /no 2 consequetive bits should be 1


// class stu;
  
  
//   rand bit [31:0] a;
  
//   constraint c1{foreach(a[i]){
//     if(i<30)
//       a[i]+a[i+1] <= 1; 
//   }}
  
// endclass


// module a;
//   stu s;
  
//   initial begin
    
//     s=new();
//     s.randomize();
//     $display("%b",s.a);
    
//   end
  
// endmodule



// Code your testbench here
// or browse Examples
//Unique Struct Pairs
//Create an array of 5 structs, each containing two integers. Ensure all pairs are unique, and within each pair, element1≠element2


class stu;
  
  
  rand bit [31:0] a;
  
  constraint c1{(a & (a>>1)) ==0;}
  
endclass


module a;
  stu s;
  
  initial begin
    
    s=new();
    s.randomize();
    $display("%b",s.a);
    
  end
  
endmodule