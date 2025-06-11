module sa;

	class packet;
		rand bit rw;
		rand bit [7:0] data_in;
		rand bit [3:0] addr;
		
		constraint c1{
					addr inside {[0:7]};
		}
	endclass
	
	initial begin
		packet p = new();
		
		repeat(20) begin
			p.c1.constraint_mode(0);
			p.randomize() with {addr inside {[0:8]};};
			$display("rw : %d, \tdata_in : %d, \taddr : %d",p.rw,p.data_in,p.addr);
		end
	end	
		
endmodule