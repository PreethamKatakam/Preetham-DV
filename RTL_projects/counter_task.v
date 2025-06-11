/*	https://verificationacademy.com/forums/systemverilog/always-block-task
No. you can not use an always block inside any procedural code, including a task. An always block implements the following two concepts:

it creates a process thread by execution of the procedural code within the block.
Once the procedural block completes, it repeats execution of the procedural block indefinitely. That process continues until the end of the simulation.
An initial block does only implements the first concept. Once the procedural block completes, that process terminates.
In you need an infinite loop, you can use the procedural forever looping statement. That can be used anywhere a procedural statement is allowed, including inside a task.

The short answer is the BNF syntax does not allow it. A task only allows a subset of constructs within it, and always is not part of that set.

There is no need for the always construct in SystemVerilog.
always block_of_statements;
could be written as
initial forever block_of_statements;
and could also be written as
initial while(1) block_of_statements;
and

initial begin
   forever block_of_statements;
  end

You need to realize that the initial construct is not a procedural statement; it is an instantiation of a process, That process begins execution of the procedural statement that followed it.
always is just a shortcut for initial forever that shows the intent better as a process that is always present.


The original question was about always blocks. But the answer is the same for initial blocks - the both cannot be used inside a task because they are not procedural statements.

Then another question came up about the procedural forever statement, why was it allowed in a task, but not always. And again I tried to explain the difference between procedural statements and always/initial constructs.

*/


//created on 14/12/23
module counter_task(clk,rst,load1,load2,count1,count2);

input rst;
input clk;
input load1;
input load2;

output count1;
output count2;

task counter(input load, output count);
	begin
	always @(posedge clk) begin
		if(rst) begin
			count <= 1'b0;
		end
		else begin
			count = load + 1;
		end
	end
endtask

counter(load1,count1);
counter(load2,count2);


endmodule