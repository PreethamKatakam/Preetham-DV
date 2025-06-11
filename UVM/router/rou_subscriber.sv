class rou_sub extends uvm_subscriber#(rou_seq_item);
  
  uvm_analysis_imp #(rou_seq_item,rou_sub) item_collected_export; 
  covergroup a;
    
  endgroup
  
  function void write(rou_seq_item pkt);
    
  endfunction
  
  
endclass