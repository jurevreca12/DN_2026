module top (
	input  logic clock,
	input  logic reset,
	input  logic enable,
	output logic [7:0] anode_assert,
	output logic [6:0] segs
);
	logic [31:0] count;

	counter_1s c1s (
		.clock  (clock),
		.reset  (reset),
		.enable (enable),
		.count  (count)
	);

	SevSegDisplay ssd (
		.clock        (clock),
		.reset        (reset),
		.digit1       (count[3:0]),
		.digit2       (count[7:4]),
		.digit3       (count[11:8]),
		.digit4       (count[15:12]),
		.digit5       (count[19:16]),
		.digit6       (count[23:20]),
		.digit7       (count[27:24]),
		.digit8       (count[31:28]),
		.anode_select (anode_assert),
		.segs         (segs)
	);
endmodule
