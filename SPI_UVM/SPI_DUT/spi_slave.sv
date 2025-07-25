//SPI slave DUT
module spi_slave(clk,rst,cs_n,mosi,data_s,miso);
  
  input clk,rst;
  input cs_n;
  input mosi;
  input [7:0] data_s;
  output reg miso;
  
  //internal slave mosi and miso
  //logic  [7:0]int_buffer;
  logic  [7:0]int_mosi_s;  
  logic  [7:0]int_miso_s;
  logic  [3:0] cnt; //count the number of clk for only bit transfers
  logic en;
  
  //rst
  always @(posedge clk) begin
    if(rst)begin
      int_mosi_s <= 8'b00000000;
      int_miso_s <= 8'b00000000;
      miso		 <= 1'bz;
      en 		 <= 1'b1;
      cnt 		 <= 4'b0000;
    end
    else begin
      cnt 		 <= cnt + 1;
    end    
  end
  
  
  //using mode 0
  
  //sampling
  always @(posedge clk) begin     
    if(en && (cnt == 0) && (!cs_n)) begin
    //  $display("en : %b cnt : %0d cs_n :%b data_s:%b",en,cnt,cs_n,data_s[7]);
      int_miso_s <= data_s;
      miso 		 <= (!cs_n) ? data_s[7] : 1'bz ;      
    end
    
    if(en && (cnt > 0) && !cs_n) begin
      miso <= int_miso_s[7] ;
    end
  end
  
  //shifting
  always @(negedge clk) begin
    if(en && (cnt > 0) && (!cs_n)) begin
      int_miso_s <= int_miso_s << 1; //left shifting miso
      int_mosi_s <= {int_mosi_s[6:0],mosi};
    end
    
      
  end
  
  always @(posedge clk) begin    
    if(cnt == 4'b1000) begin
      en <=1'b0; //stopping the shifting and sampling after 8 clock cycles
    end
  end
  
  
endmodule
