
class qr_seq extends uvm_sequence#(qr_seq_item);
  
  `uvm_object_utils(qr_seq)
  
  function new(string name="qr_seq");
    super.new(name);
  endfunction
  
  
  virtual task body();
    repeat(2) begin
      `uvm_do(req);      
    end
  endtask
  
  
  
  
endclass