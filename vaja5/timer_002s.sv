module timer_002s (
	input  logic clock,
	input  logic reset,
	output logic time_tick
);
	localparam int LIMIT = 200000;
	logic [17:0] counter;

	always_ff @(posedge clock) begin
		if (reset || (counter == (LIMIT - 1)))
			counter <= '0;
		else 
			counter <= counter + 1'b1;
	end

	assign time_tick = (counter == (LIMIT - 1));

endmodule
