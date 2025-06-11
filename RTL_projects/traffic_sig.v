module traffic_light (
    input clk,                 // System clock
    input reset,               // Reset signal
	
	//Assuming that the Interrupt is taken only when the Interrupts are going when there is a red signal in it's direction
    input ambulance,           // Interrupt #1 signal (Ambulance)
    input vip_movement,        // Interrupt #2 signal (VIP Movement)
	
    //All the output signals are considered in one direction i.e., all go from south to north or east or west
	output reg green_north,    // Green light for north direction
    output reg red_north,      // Red light for north direction
    output reg green_west,     // Green light for west direction
    output reg red_west,       // Red light for west direction
    output reg green_east,     // Green light for east direction
    output reg red_east        // Red light for east direction
);

// Define states
typedef enum {
    ST_GREEN_S2N,
    ST_GREEN_S2W,
    ST_GREEN_S2E    
} state_t;

// Internal signals
//reg [1:0] 
state_t state;
reg [5:0] timer;

// State machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= ST_GREEN_S2W;    // Reset to ST_GREEN_S2W state
        timer <= 6'd0;
    end 
	else if( red_north && ambulance) begin
		state <= ST_GREEN_S2N;
		timer <= 6'd0;
	end
	else if( red_east && ambulance) begin
		state <= ST_GREEN_S2E;
		timer <= 6'd0;
	end
	else if( red_north && vip_movement) begin
		state <= ST_GREEN_S2N;
		timer <= 6'd0;
	end
	else if( red_east && vip_movement) begin
		state <= ST_GREEN_S2E;
		timer <= 6'd0;
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
		endcase
        if (timer == 6'd60)
            timer <= 6'd0;
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

