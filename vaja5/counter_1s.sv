module counter_1s (
	input  logic clock,
	input  logic reset,
	input  logic enable,
	output logic [31:0] count
);

	localparam int LIMIT = 100000000;
	logic [31:0] fst_cnt;
	
	always_ff @(posedge clock) begin
		if (reset || (fst_cnt == (LIMIT - 1)))
			fst_cnt <= '0;
		else
			fst_cnt <= fst_cnt + 1'b1;
	end

	always_ff @(posedge clock) begin
		if (reset)
			count <= '0;
		else if (enable && (fst_cnt == (LIMIT - 1)))
			count <= count + 1'b1;
	end

endmodule
