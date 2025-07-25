class spi_test extends uvm_test;

	`uvm_component_utils(spi_test)

	spi_environment env;
  spi_seq seq;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = spi_environment :: type_id :: create("env",this);
	endfunction

	virtual task run_phase(uvm_phase phase);

		phase.raise_objection(this);
      seq = spi_seq ::type_id::create("seq",this);
      seq.start(env.agt.seqr);
      #50 
		phase.drop_objection(this);
       
	endtask
endclass
