class spi_environment extends uvm_env;

	`uvm_component_utils(spi_environment)

	spi_agent agt;
	//spi_scoreboard1 scb1;
  	spi_scoreboard2 scb2;

	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt = spi_agent :: type_id :: create("agt",this);
   //   scb1 = spi_scoreboard1 :: type_id :: create("scb1",this);
      scb2 = spi_scoreboard2 :: type_id :: create("scb2",this);
	endfunction 

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
    //  agt.mon.mon_ap.connect(scb1.mon_ap);
      agt.mon.mon_ap2.connect(scb2.mon_ap2);
	endfunction

endclass
