class rou_driver extends uvm_driver#(rou_seq_item);
  `uvm_component_utils(rou_driver)
  
  virtual rou_if vif;
  function new(string name="rou_driver",uvm_component parent);
    super.new(name,parent);
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
      `uvm_info(get_type_name(),"Inside driver",UVM_LOW)
      seq_item_port.get_next_item(req);
      
      //logic
      @(posedge vif.DRIVER.clk);
      vif.driver_cb.en <= req.en;
      
      vif.driver_cb.Rou_In[0] <= req.Rou_In0;
      vif.driver_cb.Rou_In[1] <= req.Rou_In1;
      vif.driver_cb.Rou_In[2] <= req.Rou_In2;
      vif.driver_cb.Rou_In[3] <= req.Rou_In3;
      
//       req.Rou_Out0 <= vif.driver_cb.Rou_Out[0];
//       req.Rou_Out1 <= vif.driver_cb.Rou_Out[1];
//       req.Rou_Out2 <= vif.driver_cb.Rou_Out[2];
//       req.Rou_Out3 <= vif.driver_cb.Rou_Out[3];
      
     // `uvm_info(get_type_name(),$sformatf("en: %0d",req.en),UVM_LOW)
      
      seq_item_port.item_done();
      
    end
    
  endtask
  
endclass
                                     