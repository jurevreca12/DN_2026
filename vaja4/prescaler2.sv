module prescaler #(LIMIT=3125) (
	input logic clk,
	input logic rst,
	output logic pwm_tick
);
	logic [16:0] counter;
	
	assign pwm_tick = (counter == LIMIT);

	always_ff @(posedge clk) begin
		if (rst | pwm_tick)
			counter <= '0;
		else
			counter <= counter + 1;
	end
	
endmodule
