//Weighted Mode Distribution
//Variable mode (0,1,2) has a 50%/30%/20% distribution. If mode=0, data=10-20; mode=1, data=50-60; mode=2, data=100 or 200.


class distr;
  rand int mode;
  rand int data;
  
  constraint mode_c{mode inside {[0:2]};
                    mode dist {0:=50, 1:=30,2:=20};}
  
  constraint data_c{if(mode==0)
    					data inside {[10:20]};
                    if(mode==1)
                      data inside {[50:60]};
                    if(mode==2)
                      data inside {100,200};}
  
  
endclass


module m;
  distr d;
  int c_0,c_1,c_2;
  initial begin
    repeat(100) begin
      d=new();
      d.randomize();
      $display("Mode = %0d, Data= %0d",d.mode,d.data);
      if(d.mode ==0)           
        c_0=c_0+1;
      if(d.mode ==1)
        c_1=c_1+1;
      if(d.mode ==2)
        c_2=c_2+1;
    end
    $display("c_0 = %0d, c_1= %0d c_2=%0d",c_0,c_1,c_2);
      
  end
  
endmodule