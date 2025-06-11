module samp;
  
 class Packet;
 // The random variables
	rand bit [31:0] src, dst, data[8];
	randc bit [ 7:0] kind;
 // Limit the values for src
  	constraint c {src > 10;
                  src < 15;}
 endclass
                

initial begin
  Packet p;
  p = new();// Create a packet
  repeat(1) begin
    p.randomize();
    foreach(p.data[i])
      $display("src :%d,\t dst:%d,\t data:%d,\t kind:%d",p.src,p.dst,p.data[i],p.kind);
	end
end

endmodule