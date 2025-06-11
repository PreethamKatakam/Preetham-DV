//`include mem_seq_item.sv
class seq_item1 extends mem_seq_item;
  
  `uvm_object_utils(seq_item1)
  
  function new(string name ="seq_item1");
    super.new(name);    
  endfunction
  
  constraint c1{if(count <= 0)
  				{
  				we == 0;
                }
    			else we ==1;
               }
  
  function void post_randomize();
    count = count-1;
  endfunction
  
  
endclass