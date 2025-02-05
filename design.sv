// Code your design here
module router(
  	input wire [31:0]Rou_In[3:0],
    input wire clk,
    input wire rst,
  	input wire en,
    output reg [31:0]Rou_Out[3:0]
);
  	
  	reg [1:0] random_numbers [0:3]; // Array to hold 4 unique random numbers
	reg [31:0] mt[0:623]; // State vector
    reg [11:0] index; // Current index in the state vector
    reg [3:0] used; // Bitmask to track used numbers
    reg [1:0] num; // Declare num at the module level
	reg [1:0] out_rand[3:0];
	reg [1:0] temp_out_rand[3:0];
    reg [9:0] rou_count;	
  	reg valid ;// Signal to indicate when the numbers are ready
	integer count; // Counter for unique numbers
    
    initial begin
        index = 0;
        count = 0;
        used = 4'b0000; // No numbers used at start
        valid = 0;

        // Seed initialization
		//The use of 5489 as a default seed value in the Mersenne Twister algorithm is primarily for consistency and reproducibility across various implementations. It allows users to generate predictable sequences of random numbers unless they choose to specify their own seed, thus maintaining the high-quality randomness characteristics inherent to the Mersenne Twister.
        mt[0] = 5489; // Example seed
		
		//The constant 1812433253 is integral to the initialization phase of the Mersenne Twister algorithm, ensuring that it produces high-quality pseudorandom numbers by influencing how initial states are computed.This choice, along with other parameters and operations within the algorithm, helps achieve its long period and uniform distribution properties, making it one of the most widely used pseudorandom number generators today 
        for (int i = 1; i < 624; i = i + 1) begin
            mt[i] = (1812433253 * (mt[i-1] ^ (mt[i-1] >> 30)) + i);
        end
		
    end

  	//Generation of random no.s using Merseene Twister Method
    always @(posedge clk) begin
      if (rst || (count == 4)) begin
            index <= 0;
            count <= 0;
            used <= 4'b0000; // Reset used numbers
            valid <= 0;
        end       
      else if(count >= 0)begin
            if (count < 4) begin
                if (index == 0) begin
                    // Generate new numbers in the MT array
                    for (int i = 0; i < 624; i = i + 1) begin
                        reg [31:0] y;
                        y = (mt[i] & 32'h80000000) | (mt[(i + 1) % 624] & 32'h7fffffff);
                        mt[i] = mt[(i + 397) % 624] ^ (y >> 1);
                        if (y[0]) mt[i] = mt[i] ^ 32'h9908b0df; // Tempering
                    end
                end
                
                // Generate a random number in range [1,4]
              
                num = (mt[index] % 4); // Get a number in range [0,3]
                
                // Check if the number is unique and not already used
                if (!used[num]) begin
                  random_numbers[count] = num + 1; // Store the unique number (convert to [1,4])
                 // $display(" %t random_numbers [%0d]: %d",$time,count,random_numbers[count]);
                    used[num] <= 1; // Mark this number as used
                    count <= count + 1; // Increment count of unique numbers
                    
                     if (count == 3) begin
                         valid <= 1; // Indicate that we have generated all unique numbers after storing the last one.
						 
						 temp_out_rand[0] <= random_numbers[0] ;
						 temp_out_rand[1] <= random_numbers[1] ;
						 temp_out_rand[2] <= random_numbers[2] ;
						 temp_out_rand[3] <= random_numbers[3] ;
						 
                       //$display(" %t count :%0d random_numbers : %p",$time,count,random_numbers);
        
                     end 
                end

                index <= (index + 1) % 624; // Move to next index
                
            end              
        end 
          
    end 
	
	always @(posedge clk) begin
      if(rst )
      		rou_count <= 1'b0;
    	else
      		rou_count <= rou_count + 1;
  	end
  

	always @(posedge clk) begin
      if(rst) begin
        out_rand[0] <= 2'b10;
        out_rand[1] <= 2'b00;
        out_rand[2] <= 2'b11;
        out_rand[3] <= 2'b01;
      end
      else if(en) begin
        if(rou_count % 10 == 0 && rou_count >0) begin  
        	$display("%d",count);
        	out_rand[0] <= temp_out_rand[0] ;
        	out_rand[1] <= temp_out_rand[1] ;
        	out_rand[2] <= temp_out_rand[2] ;
        	out_rand[3] <= temp_out_rand[3] ;
        end
        else begin
          $display("Ola! Out_rand= %0p",out_rand);
        	out_rand[0] <= out_rand[0] ;
        	out_rand[1] <= out_rand[1] ;
        	out_rand[2] <= out_rand[2] ;
        	out_rand[3] <= out_rand[3] ;        
      	end      
      end        
    end

  
	always @(posedge clk) begin
      Rou_Out[0] <= Rou_In[out_rand[0]];
      Rou_Out[1] <= Rou_In[out_rand[1]];
      Rou_Out[2] <= Rou_In[out_rand[2]];
      Rou_Out[3] <= Rou_In[out_rand[3]];
	end 
  
  
	//always @(posedge clk) begin
      //$monitor("%t  coun =%d ,out_rand[0] = %d,out_rand[1] = %d,out_rand[2] = %d,out_rand[3] = %d Rou_Out[0] = %0d,Rou_Out[1] = %0d,Rou_Out[2] = %0d,Rou_Out[3] = %0d",$time,rou_count,out_rand[0],out_rand[1],out_rand[2],out_rand[3],Rou_Out[0],Rou_Out[1],Rou_Out[2],Rou_Out[3]);
	//end
  
  
  always @(posedge clk) begin
    //$monitor("%t  out_rand = %0d,out_rand[1] = %d,out_rand[2] = %d,out_rand[3] = %d Rou_Out[0] = %0d,Rou_Out[1] = %0d,Rou_Out[2] = %0d,Rou_Out[3] = %0d",$time,out_rand[0],out_rand[1],out_rand[2],out_rand[3],Rou_Out[0],Rou_Out[1],Rou_Out[2],Rou_Out[3]);
    
    $display("%0t Out_rand= %0p",$time,out_rand);
    $display("Rou_In[%0d]= %0d   Rou_Out[0]= %0d",out_rand[0],Rou_In[out_rand[0]], Rou_Out[0]);
    $display("Rou_In[%0d]= %0d   Rou_Out[1]= %0d",out_rand[1],Rou_In[out_rand[1]], Rou_Out[1]);
    $display("Rou_In[%0d]= %0d   Rou_Out[2]= %0d",out_rand[2],Rou_In[out_rand[2]], Rou_Out[2]);
    $display("Rou_In[%0d]= %0d   Rou_Out[3]= %0d",out_rand[3],Rou_In[out_rand[3]], Rou_Out[3]);
        
	end
  
  
endmodule


