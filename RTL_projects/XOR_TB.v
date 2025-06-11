module XOR_G_TB();
reg a,b;

wire y;


XOR_G XOR_GATE_INST(.A (a), .B (b),

.Y (y)

);

initial begin

a=1'b0; b=1'b0;

#10 a = 1'b0; b=1'b1; 
#10 a = 1'b1; b=1'b0;
#10 a = 1'b1; b=1'b1;
#20 $stop;

end

endmodule