module samp;

  int cg_dst,cl_dst;

class Transaction;
  rand bit [1:0] src, dst;
  constraint c_dist{
    src dist {0:=40, [1:3]:=60};
    // src = 0, weight = 40/220
    //src = 1, weight = 60/220
    // src = 2, weight = 60/220
    // src = 3, weight = 60/220
    dst dist {0:/40, [1:3]:/60};
    // dst = 0, weight = 40/100
    // dst = 1, weight = 20/100
    // dst = 2, weight = 20/100
    // dst = 3, weight = 20/100
  }
  
endclass
  
  
  initial begin
  Transaction p;
  p = new();// Create a packet
    repeat(10) begin
    p.randomize();
   // foreach(p.data[i])
      $display(" src:%d,\t dst:%d",p.src,p.dst);
      if(p.dst>0)
        cg_dst=cg_dst+1;
      else
        cl_dst=cl_dst+1;
      
	end
    
    
end
  
  initial begin
      #10 
      $display("gr_zero: %d \t zero: %d",cg_dst,cl_dst);
    end
endmodule