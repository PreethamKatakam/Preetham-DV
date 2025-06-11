module sa;
	
	  
	initial begin
      bit [15:0] len;
	  int cntg5,cntg2,cntg0;
	  
	  repeat(100) begin
		  randcase
			  1:len=$urandom_range(0,2);
			  8:len=$urandom_range(3,5);
			  1:len=$urandom_range(6,7);
		  endcase
		  $display("Len:%d",len);
		  
		  if(len > 5)
			cntg5 ++;
		  else if(len > 2)
			cntg2 ++;
		  else
			cntg0 ++;
		  
	  end
	  $display("cntg0:%d \t cntg2:%d \t cntg5:%d",cntg0,cntg2,cntg5);
    end
  
endmodule