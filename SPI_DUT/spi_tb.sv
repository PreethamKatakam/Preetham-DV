// Code your testbench here
// or browse Examples
module tb;
  
  reg clk,rst,cs1_n,cs2_n;
  reg [7:0] data_m,data_s1,data_s2;
  //wire miso;
  
  //module spi_wrapper(clk,rst,cs1_n,cs2_n,data_m,data_s);
  spi_wrapper DUT(clk,rst,cs1_n,cs2_n,data_m,data_s1,data_s2);
  
  always #5 clk = ~clk;
  
  initial begin
    clk=0;
    rst = 1;
    data_m = 8'd89;//8'b01001100;//8'b11010110;
   	data_s1 = 8'd55;//8'b10000001;//10110110;//8'b10011001;
    data_s2 = 8'd92;//8'b10000001;//10110110;//8'b10011001;
    cs2_n=1;
    cs1_n=2;//2 also works because, 2 is converted to 10 in binary
    
    #50
    rst=0;
    
  end
  
//   always @(posedge clk) begin
//     //mosi = $random();
//     mosi = buff[7];
//     buff = buff << 1;
//     $display("miso : %0b \t mosi : %0b ",miso,mosi);
//   end
  
//   initial begin
//      $monitor("int_buffer: %0b ",DUT.int_mosi_s);
    
//   end
  
  
  initial begin
  $dumpfile("dump.vcd"); $dumpvars;
     #150 
   // $display("int_buffer: %0b ",DUT.int_mosi_s);
    #10 $stop;
  end
  
  
  
  
endmodule

// module tb;
  
//   reg clk,rst,cs_n,mosi;
//   reg [7:0] buff,data_s;
//   wire miso;
  
  
//   spi_slave1 DUT(clk,rst,cs_n,mosi,data_s,miso);
  
//   always #5 clk = ~clk;
  
//   initial begin
//     clk=1;
//     rst = 1;
//     buff = 8'b11010110;
//    	data_s= 8'b10000001;
    
//     #10
//     rst=0;
//     cs_n=1;
    
//   end
  
//   always @(posedge clk) begin
//     //mosi = $random();
//     mosi = buff[7];
//     buff = buff << 1;
//     $display("miso : %0b \t mosi : %0b ",miso,mosi);
//   end
  
//   initial begin
//      $monitor("int_buffer: %0b ",DUT.int_mosi_s);
    
//   end
  
  
//   initial begin
//   $dumpfile("dump.vcd"); $dumpvars;
//      #110 
//     $display("int_buffer: %0b ",DUT.int_mosi_s);
//     #10 $stop;
//   end
  
  
  
  
// endmodule
