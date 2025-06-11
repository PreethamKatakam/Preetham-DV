`timescale 1ms/1ms
module tb_traffic_sig;

    // Parameters
    parameter CLK_PERIOD = 1000; // Clock period in simulation time units
    
    // Signals
    reg clk = 1;               // Clock signal
    reg reset;             // Reset signal (active high)
    reg ambulance = 0;         // Ambulance interrupt signal
    reg vip_movement = 0;      // VIP movement interrupt signal
    
    // Instantiate the traffic_sig module
    traffic_sig traffic_sig_inst (
        .clk(clk),
        .reset(reset),
        .ambulance(ambulance),
        .vip_movement(vip_movement),
        .green_north(green_north),
        .red_north(red_north),
        .green_west(green_west),
        .green_east(green_east),
        .red_east(red_east)
    );
    
    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;
    
    // Initial stimulus
    initial begin
        // Reset signal toggles
        reset = 0;
        #1000 reset = 1;
        #1000 reset = 0;
		
		// End simulation
        #550000 $stop;
        
    end
	
	initial begin
        // Test with ambulance interrupt
        #100000 ambulance = 1;
        #40000 ambulance = 0;
    end

	initial begin
        // Test with VIP movement interrupt
        #340000 vip_movement = 1;
        #70000 vip_movement = 0;
        
        
    end
    
    // Monitor
    always @(posedge clk) begin
        $display("At time %t: Green North = %b, Red North = %b, Green West = %b, Green East = %b, Red East = %b", 
            $time, green_north, red_north, green_west,  green_east, red_east);
    end
    
endmodule
