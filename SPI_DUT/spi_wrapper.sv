// Code your design here
`include "spi_master.sv"
`include "spi_slave.sv"

module spi_wrapper(clk,rst,cs1_n,cs2_n,data_m,data_s1,data_s2);
    
  input logic clk,rst;
  input logic cs1_n;
  input logic cs2_n;
  input logic [7:0] data_m;
  input logic [7:0] data_s1;
  input logic [7:0] data_s2;
  
  //logic [7:0] s1_out;
  
  logic miso_s1; //slave 1 miso output
  logic miso_s2; //slave 2 miso output
  logic miso; //master input based on cs1 and cs2
  logic mosi;
  logic clk_m;
  logic cs1_n_out;
  logic cs2_n_out;
  
  //spi_master(clk,rst,cs1_n,cs2_n,miso,data_m,clk_o,cs1_n_out,cs2_n_out,mosi);
  
  
  assign miso = (!cs1_n_out && cs2_n_out) ? miso_s1 :
    			(!cs2_n_out && cs1_n_out) ? miso_s2 :
    			1'bz;
    
    
    
  spi_master master(.clk(clk),
                    .rst(rst),
                    .cs1_n(cs1_n),
                    .cs2_n(cs2_n),
                    .miso(miso),
                    .data_m(data_m),
                    .clk_o(clk_m),
                    .cs1_n_out(cs1_n_out),
                    .cs2_n_out(cs2_n_out),
                    .mosi(mosi) );
  
  //module spi_slave1(clk,rst,cs_n,mosi,data_s,miso);
  //slave 1
  spi_slave slave1(.clk(clk_m),
                   .rst(rst),
                   .cs_n(cs1_n_out),
                   .mosi(mosi),
                   .data_s(data_s1),
                   .miso(miso_s1) );
  
  //slave 2
  spi_slave slave2(.clk(clk_m),
                   .rst(rst),
                   .cs_n(cs2_n_out),
                   .mosi(mosi),
                   .data_s(data_s2),
                   .miso(miso_s2) );
  
  
  
endmodule


