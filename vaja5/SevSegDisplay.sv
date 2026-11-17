module SevSegDisplay(
	input  logic clock,
	input  logic reset,
	input  logic [3:0] digit1,
	input  logic [3:0] digit2,
	input  logic [3:0] digit3,
	input  logic [3:0] digit4,
	input  logic [3:0] digit5,
	input  logic [3:0] digit6,
	input  logic [3:0] digit7,
	input  logic [3:0] digit8,
	output logic [7:0] anode_select,
	output logic [6:0] segs
);
	logic [3:0]  curr_digit;
	logic time_tick;
	logic [31:0] digits;
	assign digits = {digit8, digit7, digit6, digit5, digit4, digit3, digit2, digit1};
	
	value_to_digit v2d (
		.value        (digits),
		.anode_select (anode_select),
		.digit        (curr_digit)
	);

	digits_to_segments d2s (
		.digit (curr_digit),
		.segs  (segs)
	);

	timer_002s t002 (
		.clock     (clock),
		.reset     (reset),
		.time_tick (time_tick)
	);

	anode_assert ae (
		.clock        (clock),
		.reset        (reset),
		.clock_enable (time_tick),
		.anode_select (anode_select)
	);
endmodule
