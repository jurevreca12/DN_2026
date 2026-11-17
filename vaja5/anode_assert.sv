module anode_assert (
	input  logic clock,
	input  logic reset,
	input  logic clock_enable,
	output logic [7:0] anode_select 
);
	logic [2:0] count;
	
	always_ff @(posedge clock) begin
		if (reset)
			count <= '0;
		else if (clock_enable)
			count <= count + 1'b1;
	end

	assign anode_select = ~(1 << count);
endmodule
