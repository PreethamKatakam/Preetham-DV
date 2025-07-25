class spi_seq_item extends uvm_sequence_item;

	bit rst;
  
  	rand bit cs1_n;
  	rand bit cs2_n;
  	rand bit [7:0] data_m;
  	rand bit [7:0] data_s;
  	rand bit [7:0] data_s1;
  	rand bit [7:0] data_s2;
  	
  //MASTER SIGNALS
   	logic mosi;
  logic  [7:0]int_miso_m; // data from salve(data_s)
  logic [7:0] int_mosi_m;
  
  //SLAVE SIGNALS
	logic miso;
  logic  [7:0]int_mosi_s1;  // data from master(data_m)
  logic  [7:0]int_mosi_s2;
  logic [7:0] int_miso_s1;
  logic [7:0] int_miso_s2;
  
  logic [3:0] cnt;
  logic en;
  
	`uvm_object_utils_begin (spi_seq_item)    // obj begin
	
  		//`uvm_field_int(rst,UVM_ALL_ON);
  		`uvm_field_int(cs1_n,UVM_ALL_ON);
  		`uvm_field_int(cs2_n,UVM_ALL_ON);
  		`uvm_field_int(data_m,UVM_ALL_ON);
  		`uvm_field_int(data_s,UVM_ALL_ON);
  		`uvm_field_int(data_s1,UVM_ALL_ON);
  		`uvm_field_int(data_s2,UVM_ALL_ON);
   		`uvm_field_int(mosi,UVM_ALL_ON);
		`uvm_field_int(miso,UVM_ALL_ON);
  	    `uvm_field_int(int_mosi_m,UVM_ALL_ON);
  		`uvm_field_int(int_miso_m,UVM_ALL_ON);
  		`uvm_field_int(int_mosi_s1,UVM_ALL_ON);
  		`uvm_field_int(int_mosi_s2,UVM_ALL_ON);
  		`uvm_field_int(int_miso_s1,UVM_ALL_ON);
  		`uvm_field_int(int_miso_s2,UVM_ALL_ON);
  		`uvm_field_int(cnt,UVM_ALL_ON);
  		`uvm_field_int(en,UVM_ALL_ON);
  	`uvm_object_utils_end


	function new(string name= "spi_seq_item");   // obj constructor uvm_object 
		super.new(name);
	endfunction
  
  constraint cs_valid {cs1_n == ~cs2_n;}
  
  virtual function string convert2string();
    return $sformatf("rst = %0b, cs1_n = %0b, cs2_n = %0b, data_m = %0b, data_s1 = %0b,data_s2 = %0b",rst,cs1_n,cs2_n,data_m,data_s1,data_s2);
  endfunction

endclass
