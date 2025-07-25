class spi_scoreboard1 extends uvm_scoreboard;

  `uvm_component_utils(spi_scoreboard1)
  
  virtual spi_interface vif;
  uvm_analysis_imp #(spi_seq_item,spi_scoreboard1) mon_ap;
  spi_seq_item qu_m[$];

	function new (string name, uvm_component parent);
		super.new(name,parent);
      mon_ap = new("mon_ap",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db#(virtual spi_interface) ::get(this,"","vif",vif))begin
        `uvm_fatal(get_type_name(),"NO_vif in the scoreboard");
      end
	endfunction 
  virtual function void write(spi_seq_item seq);
        qu_m.push_back(seq);
       
      endfunction
  
  task run_phase(uvm_phase phase);
    spi_seq_item qu;
    
    forever begin 
      if(qu_m.size () > 0) begin
       
        qu = qu_m.pop_front();
        
        if((qu.data_m == qu.int_mosi_m) && ( (qu.data_s1 ==qu.int_miso_s1) || (qu.data_s2 == qu.int_miso_s2)) &&  qu.rst == 0) begin
		
          `uvm_info(get_type_name(),$sformatf("Scoreboard AT RESET & DATA MATCHED "),UVM_LOW)
          
          `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.data_m = %0d::qu.int_mosi_m = %0d \n qu.data_s1 = %0d::qu.int_miso_s1 = %0d || qu.data_s2 = %0d::qu.int_miso_s2 =%0d \n qu.rst =%0d; qu.cnt = %0d qu.en = %0d  ",qu.data_m,qu.int_mosi_m,qu.data_s1,qu.int_miso_s1,qu.data_s2,qu.int_miso_s2,qu.rst,qu.cnt,qu.en),UVM_LOW)       
       end
        else 
          begin
            `uvm_error(get_type_name(),$sformatf("Scoreboard AT RESET & DATA ***NOT *** MATCHED "))
            
            
           // `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu=%0p ",qu),UVM_LOW)

             
          `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.data_m = %0d::qu.int_mosi_m = %0d \n qu.data_s1 = %0d::qu.int_miso_s1 = %0d || qu.data_s2 = %0d::qu.int_miso_s2 =%0d \n qu.rst =%0d; qu.cnt = %0d qu.en = %0d  ",qu.data_m,qu.int_mosi_m,qu.data_s1,qu.int_miso_s1,qu.data_s2,qu.int_miso_s2,qu.rst,qu.cnt,qu.en),UVM_LOW)
      end
      end
      #1;
    end
  endtask
endclass
           
           
           
           
           
     















//         if(qu.int_miso_m == 0 && qu.int_mosi_s1 == 0 && qu.rst == 0 && qu.int_mosi_s2 == 0) begin
          
//           `uvm_info(get_type_name(),$sformatf("Scoreboard AT RESET & DATA MATCHED "),UVM_LOW)
          
//           `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d \n qu.int_mosi_s1 = %0d; \n qu.rst =%0d; \n qu.int_mosi_s2 =%0d ",qu.int_miso_m,qu.int_mosi_s1,qu.rst,qu.int_mosi_s2),UVM_LOW)        
//         end
//         else 
//           begin
//             `uvm_error(get_type_name(),$sformatf("Scoreboard AT RESET & DATA ***NOT *** MATCHED "))
          	
//             `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d \n qu.int_mosi_s1 = %0d; \n qu.rst =%0d; \n qu.int_mosi_s2 =%0d ",qu.int_miso_m,qu.int_mosi_s1,qu.rst,qu.int_mosi_s2),UVM_LOW)                  
//           end




// `uvm_info("scoreboard",$sformatf("received data | %s ",seq.convert2string()),UVM_MEDIUM)
//     if(seq.data_m == seq.data_s1)
//       `uvm_info("scoreboard",$sformatf("PASS | master sent the data and the slave received data_m = %s data_s  %s ",seq.data_m,seq.data_s1),UVM_LOW)
//     else
//       `uvm_error("scoreboard",$sformatf(" FAIL | data reaceived by the slave with the data_m = %s data_s  %s ",seq.data_m,seq.data_s1))



