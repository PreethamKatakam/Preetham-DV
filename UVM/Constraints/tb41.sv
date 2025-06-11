module sa;
	
	class ether;
		rand bit [3:0] in_use;
		rand bit [47:0] mac_addr[4];
		rand bit [3:0] is_100;
		rand bit [31:0] run_for_n_frames;
		
		constraint local_unicast{		
		foreach(mac_addr[i])
			mac_addr[i][41:40]==2'b00;
		}
		
		constraint reasonab{
			run_for_n_frames inside{[1:100]};
		
		}
	endclass	
		
		
		
	initial begin
      ether p;
	  p=new();
	  
	  repeat(10) begin
		p.randomize();
		$display("in_use:%d, \nmac_addr:%p, \nis_100:%d, \nrun_for_n_frames:%d ",p.in_use,p.mac_addr,p.is_100,p.run_for_n_frames);	
		$display();
		$display();
    end
	end
  
endmodule