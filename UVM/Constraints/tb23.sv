//constr.sv
class packet;     
	 rand bit [7:0] length;
	 rand bit [7:0] payload[];
	 constraint c_l{
		length > 0;
		payload.size() == length;
		}
	 constraint c_ext;	
	endclass



//test.sv
program automatic test;
	`include "constr.sv"
	
	 constraint packet::c_ext{length==1;}
	
		initial begin
      packet p;   
      p = new();// Create a packet

      repeat(20) begin
          p.randomize();
        $display("length: %d , payload: %d",p.length,p.payload);
      end
    end
endprogram


