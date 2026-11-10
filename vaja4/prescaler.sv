////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dr. Ratko Pilipović
//
// Design Name:   prescaler.sv
// Module Name:   prescaler
// Project Name:  digital_systems_design
// Target Device:  
// Tool versions:  
// Description: 
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Prescaler
// 
// Develop a prescaler with the following properties:
///////////////////////////////////////////////////////////////////////////////

module prescaler
    #(parameter PRESCALER_WIDTH = 8)
    (
        input logic clock,
        input logic reset,
        input logic [PRESCALER_WIDTH-1:0] limit,
        output logic clock_enable
    );

    logic [PRESCALER_WIDTH-1:0] count;

    always_ff @(posedge clock) begin 
        if (reset) 
            count <= '0;
        else begin
            if (count == limit-1) 
                count <= '0;
            else
                count <= count + 1'b1;
        end
    end

		assign clock_enable = (count == limit-1);
endmodule
