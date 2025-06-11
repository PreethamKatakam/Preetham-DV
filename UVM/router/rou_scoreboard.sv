class rou_sb extends uvm_scoreboard;
  
  rou_seq_item pkt_qu[$];
  
  bit [31:0]Rou_In[3:0][$];
  bit [31:0]Rou_Out[3:0];
  bit [1:0] out_rand[3:0];
	
  virtual rou_if vif;  
  uvm_analysis_imp#(rou_seq_item,rou_sb) item_collected_export;
  
  `uvm_component_utils(rou_sb)
  
  
  function new(string name="rou_sb", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phases
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export",this);
    if(!uvm_config_db#(virtual rou_if) :: get(this,"","vif",vif))
      `uvm_fatal("No Vif","Virtual Interface not done");
  endfunction
  
  virtual function void write(rou_seq_item pkt);
    //print();
    pkt_qu.push_back(pkt);
    //`uvm_info(get_type_name(),$sformatf("Rou_Out: %0p",pkt.Rou_Out0),UVM_LOW)
      
  endfunction
  
  
  virtual task run_phase(uvm_phase phase);
    rou_seq_item rou_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      rou_pkt = pkt_qu.pop_front();
      
      Rou_In[0].push_back(rou_pkt.Rou_In0);
      Rou_In[1].push_back(rou_pkt.Rou_In1);
      Rou_In[2].push_back(rou_pkt.Rou_In2);
      Rou_In[3].push_back(rou_pkt.Rou_In3);
      
      Rou_Out[0] = rou_pkt.Rou_Out0;
      Rou_Out[1] = rou_pkt.Rou_Out1;
      Rou_Out[2] = rou_pkt.Rou_Out2;
      Rou_Out[3] = rou_pkt.Rou_Out3;
      
      out_rand[0] = rou_pkt.out_rand0;
      out_rand[1] = rou_pkt.out_rand1;
      out_rand[2] = rou_pkt.out_rand2;
      out_rand[3] = rou_pkt.out_rand3;
      
      `uvm_info(get_type_name(),$sformatf("Rou_In: %0d %0d %0d %0d",Rou_In[0][0],Rou_In[1][0],Rou_In[2][0],Rou_In[3][0]),UVM_LOW)
//       `uvm_info(get_type_name(),$sformatf("Rou_Out: %0p -- %0d",Rou_Out[0],vif.out_rand0),UVM_LOW)
//       `uvm_info(get_type_name(),$sformatf("Rou_Out: %0p -- %0d",Rou_Out[1],vif.out_rand1),UVM_LOW)
//       `uvm_info(get_type_name(),$sformatf("Rou_Out: %0p -- %0d",Rou_Out[2],vif.out_rand2),UVM_LOW)
//       `uvm_info(get_type_name(),$sformatf("Rou_Out: %0p -- %0d",Rou_Out[3],vif.out_rand3),UVM_LOW)
      
      if(out_rand[0] !== 2'bx && out_rand[1] !== 2'bx && out_rand[2] !== 2'bx && out_rand[3] !== 2'bx ) begin 
    	
      if(Rou_In[out_rand[0]][0] == Rou_Out[0]) begin
        `uvm_info(get_type_name(),$sformatf("- ::DATA Match:: - Rou_In[%0d] = %0d, Rou_Out[0] = %0d ",vif.out_rand0,Rou_In[out_rand[0]][0],Rou_Out[0]),UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(),$sformatf("- ::DATA MisMatch :: -Rou_In[%0d] = %0d, Rou_Out[0] = %0d   ",vif.out_rand0,Rou_In[out_rand[0]][0],Rou_Out[0]))       
      end
      
        if(Rou_In[out_rand[1]][0] == Rou_Out[1]) begin
        `uvm_info(get_type_name(),$sformatf("- ::DATA Match:: - Rou_In[%0d] = %0d, Rou_Out[1] = %0d ",vif.out_rand1,Rou_In[out_rand[1]][0],Rou_Out[1]),UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(),$sformatf("- ::DATA MisMatch :: -Rou_In[%0d] = %0d, Rou_Out[1] = %0d   ",vif.out_rand1,Rou_In[out_rand[1]][0],Rou_Out[1]))       
      end
      
       if(Rou_In[out_rand[2]][0] == Rou_Out[2]) begin
        `uvm_info(get_type_name(),$sformatf("- ::DATA Match:: - Rou_In[%0d] = %0d, Rou_Out[2] = %0d ",vif.out_rand2,Rou_In[out_rand[2]][0],Rou_Out[2]),UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(),$sformatf("- ::DATA MisMatch :: -Rou_In[%0d] = %0d, Rou_Out[2] = %0d   ",vif.out_rand2,Rou_In[out_rand[2]][0],Rou_Out[2]))       
      end
      
       if(Rou_In[out_rand[3]][0] == Rou_Out[3]) begin
        `uvm_info(get_type_name(),$sformatf("- ::DATA Match:: - Rou_In[%0d] = %0d, Rou_Out[3] = %0d ",vif.out_rand3,Rou_In[out_rand[3]][0],Rou_Out[3]),UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(),$sformatf("- ::DATA MisMatch :: -Rou_In[%0d] = %0d, Rou_Out[3] = %0d   ",vif.out_rand3,Rou_In[out_rand[3]][0],Rou_Out[3]))       
      end
      
      end
      
      
      @(posedge vif.clk);
      `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
      `uvm_info(get_type_name(),"Inside SB",UVM_LOW)
      
      if(Rou_In[0].size() > 1)
        Rou_In[0].pop_front();
      
      if(Rou_In[1].size() > 1)
        Rou_In[1].pop_front();
      
      if(Rou_In[2].size() > 1)
        Rou_In[2].pop_front();
      
      if(Rou_In[3].size() > 1)
        Rou_In[3].pop_front();
      
    end
  endtask  
endclass