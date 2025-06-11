module sa1;	
	class Days;
		typedef enum {SUN, MON, TUE, WED, THU, FRI,SAT} days_e;
		days_e choices [$];
		rand days_e choice;
		constraint cday {choice inside choices;}
	endclass
	
	initial begin
      Days p;   
      p = new();// Create a packet

      repeat(5) begin
          p.randomize();
        $display("f:%p",p.choice);
      end
    end
  
endmodule