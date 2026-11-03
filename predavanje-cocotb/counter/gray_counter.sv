`timescale 1ns/1ps

module gray_counter #(parameter integer LIMIT = 10000000) (
    input logic clk,
    input logic rst,
    input logic up_down, // Switch for up/down counting
    output logic [3:0] gray_code
);
    
    logic [26:0] prescale_count; // 27-bit binary counter to scale to 1 Hz
    logic [3:0]  binary_code_count; // 4-bit gray code counter
    logic [3:0]  gray_code_count; // 4-bit gray code counter
    logic        prescale_tick;

		assign prescale_tick = (prescale_count == LIMIT);
    always_ff @(posedge clk) begin 
        if(rst)
            prescale_count <= 0;
        else
          	prescale_count <= prescale_tick ? 27'b0 : (prescale_count + 1);
    end

		always_ff @(posedge clk) begin
				if(rst)
      			binary_code_count <= 0;
        else if (prescale_tick & up_down)
            binary_code_count <= binary_code_count + 1;
        else if (prescale_tick & ~up_down)
            binary_code_count <= binary_code_count - 1;
		end    

    // Gray Code Converter 
    always_comb begin : GrayCodeConverter
        case(binary_code_count)
            4'b0000: gray_code_count = 4'b0000;
            4'b0001: gray_code_count = 4'b0001;
            4'b0010: gray_code_count = 4'b0011;
            4'b0011: gray_code_count = 4'b0010;
            4'b0100: gray_code_count = 4'b0110;
            4'b0101: gray_code_count = 4'b0111;
            4'b0110: gray_code_count = 4'b0101;
            4'b0111: gray_code_count = 4'b0100;
            4'b1000: gray_code_count = 4'b1100;
            4'b1001: gray_code_count = 4'b1101;
            4'b1010: gray_code_count = 4'b1111;
            4'b1011: gray_code_count = 4'b1110;
            4'b1100: gray_code_count = 4'b1010;
            4'b1101: gray_code_count = 4'b1011;
            4'b1110: gray_code_count = 4'b1001;
            4'b1111: gray_code_count = 4'b1000;
            default: gray_code_count = 4'b0000;
        endcase
    end

    assign gray_code = gray_code_count;
endmodule

