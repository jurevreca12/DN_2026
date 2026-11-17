//  --A--
//  |   |
//  F   B
//  |   |
//  --G--
//  |   |
//  E   C
//  |   |
//  --D--
// 7'bGFE_DCBA

module digits_to_segments (
	input  logic [3:0] digit,
	output logic [6:0] segs
);
	always_comb begin
		case (digit) 
			4'b0000: segs = ~7'b011_1111; // 0
			4'b0001: segs = ~7'b000_0110; // 1
			4'b0010: segs = ~7'b101_1011; // 2
			4'b0011: segs = ~7'b100_1111; // 3
			4'b0100: segs = ~7'b110_0110; // 4
			4'b0101: segs = ~7'b110_1101; // 5
			4'b0110: segs = ~7'b111_1101; // 6
			4'b0111: segs = ~7'b000_0111; // 7
			4'b1000: segs = ~7'b111_1111; // 8
			4'b1001: segs = ~7'b110_1111; // 9
			4'b1010: segs = ~7'b111_0111; // A
			4'b1011: segs = ~7'b111_1100; // B
			4'b1100: segs = ~7'b101_1000; // C
			4'b1101: segs = ~7'b101_1110; // D
			4'b1110: segs = ~7'b111_1001; // E
			4'b1111: segs = ~7'b111_0001; // F
			default: segs = ~'0;
		endcase
	end
endmodule
