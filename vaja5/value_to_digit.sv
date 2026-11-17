module value_to_digit(
	input logic [31:0] value,
	input logic [7:0] anode_select,
	output logic [3:0] digit
);
	always_comb begin
		case(anode_select)
			8'b1111_1110: digit = value[3:0];
			8'b1111_1101: digit = value[7:4];
			8'b1111_1011: digit = value[11:8];
			8'b1111_0111: digit = value[15:12];
			8'b1110_1111: digit = value[19:16];
			8'b1101_1111: digit = value[23:20];
			8'b1011_1111: digit = value[27:24];
			8'b0111_1111: digit = value[31:28];
			default: digit = 4'b0000;
		endcase
	end

endmodule
