`timescale 1ns/1ps

module alu (
	input  logic [3:0] a,
	input  logic [3:0] b,
	input  logic [2:0] alu_control,
	output logic [3:0] c 
);
	assign c = (alu_control == 3'b000) ? (a + b) :
			   (alu_control == 3'b001) ? (a - b) :
			   (alu_control == 3'b010) ? (a & b) :
			   (alu_control == 3'b011) ? (a | b) :
			   (alu_control == 3'b100) ? (a ^ b) :
			   (alu_control == 3'b101) ? (a == b) :
			   (alu_control == 3'b110) ? a :
			   (alu_control == 3'b111) ? b :
			   4'b0000;
endmodule
