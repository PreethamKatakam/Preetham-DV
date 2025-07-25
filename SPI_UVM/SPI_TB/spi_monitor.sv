class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)
  	
  uvm_analysis_port#(spi_seq_item) mon_ap;
  uvm_analysis_port#(spi_seq_item) mon_ap2;
  
  spi_seq_item tx;
  virtual spi_interface vif;
  
  
	function new(string name,uvm_component parent);
		super.new(name,parent);
       mon_ap = new("mon_ap",this);
      mon_ap2 = new("mon_ap2",this); 
       cg=new();	//  covergroup creation
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      `uvm_info(get_type_name(),$sformatf("inside monitor build phase"),UVM_LOW)
        
      if(!uvm_config_db #(virtual spi_interface)::get(this,"","vif",vif))begin
      `uvm_fatal(get_type_name(),"virtual interface not set on top level")
      end
	endfunction

 //    // // // ===  coverages === // //
  covergroup cg();
    coverpoint tx.cs1_n;
    coverpoint tx.cs2_n;
    coverpoint tx.cnt;
    coverpoint tx.en;
    coverpoint tx.data_m;
    coverpoint tx.data_s; 
  endgroup
  
//   // // // ===  coverages === // //
 
  
  virtual task run_phase(uvm_phase phase);
    forever begin
    //repeat(5) begin  
      @(posedge vif.clk);
      
      tx=spi_seq_item::type_id::create("tx",this);
     
      wait(vif.rst == 0) begin
      
      tx.data_m = vif.data_m;
      tx.data_s = vif.data_s;
      tx.data_s1 = vif.data_s1;
      tx.data_s2 = vif.data_s2;
      tx.cs1_n =vif.cs1_n;
      tx.cs2_n = vif.cs2_n;
      tx.mosi = vif.mosi;
      tx.miso = vif.miso;
      tx.int_mosi_s1 = vif.int_mosi_s1;
      tx.int_mosi_s2 = vif.int_mosi_s2;
      tx.int_miso_m = vif.int_miso_m;
      tx.int_mosi_m = vif.int_mosi_m;
      tx.int_miso_s1 = vif.int_miso_s1;
      tx.int_miso_s2 = vif.int_miso_s2;
      tx.cnt = vif.cnt;
      tx.en = vif.en;
      
   
        `uvm_info(get_type_name(),$sformatf("\n=====RESET======\n monITOR :: qu.data_m = %0d::qu.int_mosi_m = %0d \n qu.data_s1 = %0d :: qu.int_miso_s1 = %0d qu.data_s2 = %0d :: qu.int_miso_s2 =%0d \n qu.rst =%0d; qu.cnt = %0d qu.en = %0d cs1_n = %0b, cs2_n = %0b,  ",vif.data_m,vif.int_mosi_m,vif.data_s1,vif.int_miso_s1,vif.data_s2,vif.int_miso_s2,vif.rst,vif.cnt,vif.en,vif.cs1_n,vif.cs2_n),UVM_LOW)
      
        mon_ap.write(tx);
      end

      wait(vif.rst == 1) begin
      
      tx.data_m = vif.data_m;
        tx.data_s = vif.data_s;
      tx.data_s1 = vif.data_s1;
      tx.data_s2 = vif.data_s2;
      tx.cs1_n =vif.cs1_n;
      tx.cs2_n = vif.cs2_n;
      tx.mosi = vif.mosi;
      tx.miso = vif.miso;
      tx.int_mosi_s1 = vif.int_mosi_s1;
      tx.int_mosi_s2 = vif.int_mosi_s2;
      tx.int_miso_m = vif.int_miso_m;
      tx.int_mosi_m = vif.int_mosi_m;
      tx.int_miso_s1 = vif.int_miso_s1;
      tx.int_miso_s2 = vif.int_miso_s2;
      tx.cnt = vif.cnt;
      tx.en = vif.en;
     
        `uvm_info(get_type_name(),$sformatf("\n=====SHIFTED======\n monITOR :: qu.data_m = %0d::qu.int_mosi_m = %0d \n qu.data_s1 = %0d :: qu.int_miso_s1 = %0d qu.data_s2 = %0d :: qu.int_miso_s2 =%0d \n qu.rst =%0d; qu.cnt = %0d qu.en = %0d cs1_n = %0b, cs2_n = %0b,  ",vif.data_m,vif.int_mosi_m,vif.data_s1,vif.int_miso_s1,vif.data_s2,vif.int_miso_s2,vif.rst,vif.cnt,vif.en,vif.cs1_n,vif.cs2_n),UVM_LOW)
       
       
        mon_ap2.write(tx);
        cg.sample(); // covergroup triggerint
        $display("---------------------------------");
        $display(" coverage = %2f", cg.get_coverage());
        $display("---------------------------------");
      end

      
    end
	endtask


endclass