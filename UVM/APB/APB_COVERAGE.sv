
class coverage extends uvm_component;
`uvm_component_utils(coverage)
apb_seq_item p1;

covergroup cvg;
A:coverpoint p1.pwdata

			{bins a1={[0:32]};
			/*bins a2={[33:87]};
			bins a3={[88:110]};
			bins a4={[111:189]};
			bins a5={[190:211]};
			bins a6={[212:255]};*/}
B:coverpoint p1.paddr
			{bins b1={[0:40]};
			/*bins b2={[41:89]};
			bins b3={[90:125]};
			bins b4={[126:167]};
			bins b5={[168:189]};
			bins b6={[190:255]};*/}
C:coverpoint p1.pwrite{bins c={[0:1]};}
D:coverpoint p1.psel{bins d={[0:1]};}
E:coverpoint p1.pen{bins e={[0:1]};}
endgroup

function new(string name="coverage",uvm_component parent);
super.new(name,parent);
cvg=new();
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
p1=apb_seq_item::type_id::create("p1");
endfunction
endclass
