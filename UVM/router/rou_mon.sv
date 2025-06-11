class rou_mon extends uvm_monitor;
  
  virtual rou_if vif;
  uvm_analysis_port#(rou_seq_item) item_collected_port;
  
  rou_seq_item seq_item;
  
  `uvm_component_utils(rou_mon)
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    seq_item = new();
    item_collected_port = new("item_collected_port", this);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual rou_if) :: get(this,"","vif",vif))
      `uvm_fatal("No Vif","Virtual Interface not done");
  endfunction
  
  //run phase
  
  task run_phase(uvm_phase phase);
    forever begin
      `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
      `uvm_info(get_type_name(),"Inside Monitor",UVM_LOW)
      //logic
      @(posedge vif.MONITOR.clk);
      seq_item.en =vif.monitor_cb.en;
      seq_item.Rou_Out0 = vif.monitor_cb.Rou_Out[0];
      seq_item.Rou_Out1 = vif.monitor_cb.Rou_Out[1];
      seq_item.Rou_Out2 = vif.monitor_cb.Rou_Out[2];
      seq_item.Rou_Out3 = vif.monitor_cb.Rou_Out[3];
      
      //@(posedge vif.MONITOR.clk);
            
      seq_item.Rou_In0 = vif.monitor_cb.Rou_In[0] ;
      seq_item.Rou_In1 = vif.monitor_cb.Rou_In[1] ;
      seq_item.Rou_In2 = vif.monitor_cb.Rou_In[2] ;
      seq_item.Rou_In3 = vif.monitor_cb.Rou_In[3] ;
      
      //@(posedge vif.MONITOR.clk);
        
      seq_item.out_rand0 = vif.out_rand0 ;
      seq_item.out_rand1 = vif.out_rand1 ;
      seq_item.out_rand2 = vif.out_rand2 ;
      seq_item.out_rand3 = vif.out_rand3 ;
      
      
      
      
      `uvm_info(get_type_name(),$sformatf("en=%d\n\t\t\t\t\t\t\t\t\tRou_In: %0h %0h %0h %0h\n\t\t\t\t\t\t\t\t\tRou_Out: %0h %0h %0h %0h",seq_item.en,seq_item.Rou_In3,seq_item.Rou_In2,seq_item.Rou_In1,seq_item.Rou_In0,seq_item.Rou_Out3,seq_item.Rou_Out2,seq_item.Rou_Out1,seq_item.Rou_Out0),UVM_LOW)
      
    //  `uvm_info(get_type_name(),$sformatf("Rou_Out: %0p",vif.monitor_cb.Rou_Out),UVM_LOW)
      
      
      
      item_collected_port.write(seq_item);
      
      
      
   
    end
    
  endtask
  
endclass