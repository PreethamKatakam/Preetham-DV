//Magic Square Array
//Design constraints for a 3x3 2D array where each row, column, and diagonal sums to 15, and all elements are unique and between 1-9.


class sample ;
  rand int a[3][3];
  
  constraint row{foreach(a[i,j]){
    			a[i].sum()==15;  	
  					}}
  
    constraint column{//foreach(a[i,j]){
     					//a[i][0].sum()==15;  	
  					//}
      a[0][0]+a[1][0]+a[2][0]==15;
      a[0][1]+a[1][1]+a[2][1]==15;
      a[0][2]+a[1][2]+a[2][2]==15;
      a[0][0]+a[1][1]+a[2][2]==15;
      a[2][0]+a[1][1]+a[0][2]==15;
    
    }
    
    constraint range {foreach(a[i,j]){
      				a[i][j] inside {[1:9]};  	
  					}}
   
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
  
  