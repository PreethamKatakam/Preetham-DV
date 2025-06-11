// Code your testbench here
// or browse Examples
//Write a constraint for 3*3 matrix in that the value 0 should appears atmost 2 times(in the sense it can be 1 time,2 time or no zero value)

class sample ;
  rand bit [3][3]a;
  
  constraint row{a[0][0]+a[0][1]+a[0][2]+
                 a[1][0]+a[1][1]+a[1][2]+
                 a[2][0]+a[2][1]+a[2][2] > 6;  	
  					}
  
     function void post_randomize();
                      foreach(a[i,j]) begin
                        //$display("%p",a[i][0]);
                      end
                      
                      endfunction
                      
  
  
endclass


module a;
  sample s;
  
  initial begin
    s=new();
    repeat(5) begin
    	s.randomize;
    	for(int i=0;i<3;i=i+1) begin
      		for(int j=0;j<3;j=j+1) begin
        		$write("%d",s.a[i][j]);
      		end      
      		$display();
    	end
       	$display();
    end
  end
  
endmodule
  
  