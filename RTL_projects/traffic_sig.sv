module traffic_sig (
    input clk,                 // System clock
    input reset,               // Reset signal
	
	//Assuming that the Interrupt is tiggered only when the Interrupts are going when there is a red signal in it's direction
    input ambulance,           // Interrupt #1 signal (Ambulance)
    input vip_movement,        // Interrupt #2 signal (VIP Movement)
	
    //All the output signals are considered in one direction i.e., all go from south to north or east or west
	output reg green_north,    // Green light for north direction
    output reg red_north,      // Red light for north direction
    output reg green_east,     // Green light for east direction
    output reg red_east,        // Red light for east direction
	output reg green_west     // Green light for west direction
    
);

// Define states
typedef enum logic [1:0] {
    ST_GREEN_S2N,	// State turning Green for vehicles going from south to north
    ST_GREEN_S2W,	// State turning Green for vehicles going from south to west
    ST_GREEN_S2E    // State turning Green for vehicles going from south to east
} state_t;

// Internal signals
	
state_t state;
reg [5:0] 	timer;
reg 		interrupt1;	//Interrupt for Emergency vehicles
reg 		interrupt2; //Interrupt for VIP vehicles


// State machine
always @(posedge clk) begin
    if (reset) begin
        state <= ST_GREEN_S2W;    				// Reset to ST_GREEN_S2W state
        timer <= 6'd0;
		interrupt1 	<= 1'd0;
		interrupt2 	<= 1'd0;
    end 
	else if( red_north && ambulance && !interrupt1) begin 		//Emergency vehicle going to north but signal is Red
		state <= ST_GREEN_S2N;
		timer <= 6'd0;
		interrupt1 <= 1'b1;
	end
	else if( red_east && ambulance && !interrupt1) begin 		//Emergency vehicle going to east but signal is Red
		state <= ST_GREEN_S2E;
		timer <= 6'd0;
		interrupt1 <= 1'b1;
	end
	else if( red_north && vip_movement && !interrupt2) begin	//VIP vehicle going to north but signal is Red			
		state <= ST_GREEN_S2N;
		timer <= 6'd0;
		interrupt2 <= 1'b1;
	end
	else if( red_east && vip_movement && !interrupt2) begin		//VIP vehicle going to east but signal is Red
		state <= ST_GREEN_S2E;
		timer <= 6'd0;
		interrupt2 <= 1'b1;
	end	
	else begin
        case (state)
            ST_GREEN_S2W: begin
                state <= ST_GREEN_S2N;
            end
			
            ST_GREEN_S2N: begin
				if (timer == 6'd60)
                    state <= ST_GREEN_S2E;
            end
			
			ST_GREEN_S2E: begin
                if (timer == 6'd60)
                    state <= ST_GREEN_S2N;
            end
			
			default: begin
                state <= ST_GREEN_S2N;
            end			
		endcase
    if (timer == 6'd60) begin  //timer, interrupt1, interrupt2 resetting asfter every 60 sec
        timer 		<= 6'd0;
		interrupt1 	<= 1'd0;
		interrupt2 	<= 1'd0;
	end
    else
        timer <= timer + 1;
    end
end

// Output logic
always @* begin
    case (state)
        ST_GREEN_S2N: begin
            green_north = 1'b1;
            red_north = 1'b0;
            green_east = 1'b0;
            red_east = 1'b1;
			green_west = 1'b1;            
        end
        ST_GREEN_S2W: begin
            green_north = 1'b0;
            red_north = 1'b1;
            green_east = 1'b0;
            red_east = 1'b1;
			green_west = 1'b1;            
        end
        ST_GREEN_S2E: begin
            green_north = 1'b0;
            red_north = 1'b1;
            green_east = 1'b1;
            red_east = 1'b0;
			green_west = 1'b1;            
        end
    endcase
end

endmodule

