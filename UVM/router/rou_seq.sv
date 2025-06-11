class rou_seq extends uvm_sequence#(rou_seq_item);
  
  `uvm_object_utils(rou_seq)
  
  function new(string name="rou_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(100) begin
      `uvm_do(req);
    end
  endtask 
  
endclass