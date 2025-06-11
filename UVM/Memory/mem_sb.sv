class mem_sb extends uvm_scoreboard;
  
  mem_seq_item pkt_item[$];
  reg [7:0]m_m[15:0]; //16x8 memory
  virtual m_intf vif;
  
 uvm_analysis_imp#(mem_seq_item,mem_sb) item_col_export;
   
  `uvm_component_utils(mem_sb)
  
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_col_export = new("item_col_export",this);
    if(!uvm_config_db#(virtual m_intf) :: get(this,"","vif",vif))
      `uvm_fatal("No Vif","Virtual Interface not Connected");  
  endfunction 
  
  function void write(mem_seq_item pkt);
    pkt_item.push_back(pkt);
   // `uvm_info(get_type_name,$sformatf("%p",pkt_item),UVM_LOW);
  endfunction
  
  task run_phase(uvm_phase phase);
    mem_seq_item mem_pkt;
    
    forever begin
      wait(pkt_item.size() > 0);
      mem_pkt = pkt_item.pop_front();
      //`uvm_info(get_type_name,$sformatf("%p",mem_pkt),UVM_LOW);
      
      
      //introduce the clock from vif and write same logic as design then compare as below
      @(posedge vif.clk) begin
        if(mem_pkt.we) begin
          m_m[mem_pkt.addr] <= mem_pkt.data_in;          
        end
          
        if(m_m === vif.m_m)
        	`uvm_info(get_type_name,$sformatf("CODE WORKING!!!!!!!!!!!\n%p <--- m_m\n%p <--- DUT m_m",m_m,vif.m_m),UVM_LOW)
      	else
            `uvm_error(get_type_name,$sformatf("CODE NOT WORKING!!!!!!!\n%p <--- m_m\n%p <--- DUT m_m",m_m,vif.m_m));
      
      end
        
        
        
    
    end
  endtask
  
endclass