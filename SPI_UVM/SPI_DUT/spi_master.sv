//SPI Master DUT
module spi_master(clk,rst,cs1_n,cs2_n,miso,data_m,clk_o,cs1_n_out,cs2_n_out,mosi);
  
  input clk,rst;
  input cs1_n,cs2_n;
  input miso;
  input [7:0] data_m; //Random master data generated in TB
  output clk_o;//clk out to slave
  output cs1_n_out,cs2_n_out;
  output reg mosi;
  
  //internal master mosi and miso
  logic 	  miso;
  logic  [7:0]int_mosi_m;  
  logic  [7:0]int_miso_m;
  logic  [3:0]cnt; //count the number of clk for only bit transfers
  logic 	  en;//Does the sampling and shifting only if en is high
  
  assign clk_o = clk;
  assign cs1_n_out = cs1_n;
  assign cs2_n_out = cs2_n;
  
  //rst
  always @(posedge clk) begin
    if(rst)begin
      int_mosi_m <= 8'b00000000;//data_m;
      int_miso_m <= 8'b00000000;//dummy data      
      cnt 		 <= 4'b0000;
      mosi 		 <= 1'bz;//data_m[7];
      en 		 <= 1'b1;
    end
    else begin
      cnt 		 <= cnt + 1;
    end    
  end
  
  //using mode 0 SPI
  
  //sampling
  always @(posedge clk) begin
    if(en && (cnt == 0)) begin
      int_mosi_m <= data_m;      
      mosi 		 <= data_m[7];      
    end
    
    if(en && (cnt > 0)) begin
      mosi <= int_mosi_m[7] ;
    end
    
  end
  
  //shifting
  always @(negedge clk) begin
    if(en && (cnt > 0)) begin
      int_miso_m <= {int_miso_m[6:0],miso};
      int_mosi_m <= int_mosi_m << 1; //left shifting mosi
    end
  end
  
  always @(posedge clk) begin    
    if(cnt == 4'b1000) begin
      en <=1'b0; //stopping the shifting and sampling after 8 clock cycles
    end
  end
  
  
endmodule



