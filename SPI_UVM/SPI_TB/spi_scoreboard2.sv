class spi_scoreboard2 extends uvm_scoreboard;

  `uvm_component_utils(spi_scoreboard2)
  
  virtual spi_interface vif;
  uvm_analysis_imp #(spi_seq_item,spi_scoreboard2) mon_ap2;
  spi_seq_item qu_m[$];

	function new (string name, uvm_component parent);
		super.new(name,parent);
      mon_ap2 = new("mon_ap2",this);
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
  
  
  task run_phase (uvm_phase phase);
     spi_seq_item qu;
      
      forever begin
         
      if(qu_m.size() >0 ) begin
        `uvm_info(get_type_name(),$sformatf("\n ***IN SCORE BOARD 2***"),UVM_LOW)
        qu=qu_m.pop_front();
      if(qu.cs1_n == 0) begin
        if((qu.data_m == qu.int_mosi_s1)  && (qu.data_s1 == qu.int_miso_m)) begin
          `uvm_info(get_type_name(),$sformatf(" Scoreboard 2 = DATA MATCHED AT SLAVE 1"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d  qu.int_mosi_s1 = %0d; qu.int_mosi_s2 = %0d ",qu.int_miso_m,qu.int_mosi_s1,qu.int_mosi_s2),UVM_LOW)        end
        else 
          begin
            `uvm_error(get_type_name(),$sformatf("Scoreboard 2 = DATA ***ERROR*** MATCHED AT SLAVE 1"))
            `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d  qu.int_mosi_s1 = %0d; qu.int_mosi_s2 = %0d ",qu.int_miso_m,qu.int_mosi_s1,qu.int_mosi_s2),UVM_LOW)          end
          end
      else if(qu.cs2_n == 0)begin 
        if((qu.data_m == qu.int_mosi_s2)  && (qu.data_s2 == qu.int_miso_m)) begin
          `uvm_info(get_type_name(),$sformatf("Scoreboard 2 = DATA MATCHED AT SLAVE 2"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d  qu.int_mosi_s1 = %0d; qu.int_mosi_s2 = %0d ",qu.int_miso_m,qu.int_mosi_s1,qu.int_mosi_s2),UVM_LOW)        end
         else
           begin
             `uvm_error(get_type_name(),$sformatf("Scoreboard 2 = DATA ***ERROR*** MATCHED AT SLAVE 2"))
             `uvm_info(get_type_name(),$sformatf("\n scoreboard :: qu.int_miso_m = %0d  qu.int_mosi_s1 = %0d; qu.int_mosi_s2 = %0d ",qu.int_miso_m,qu.int_mosi_s1,qu.int_mosi_s2),UVM_LOW)           end
	  end
    end
          #1;
           end
    
  endtask
endclass