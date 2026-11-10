

module top (
    input logic clock,
    input logic reset,
    input logic [5:0] SW,
    output logic [2:0] RGB
);
		// define parameters
		localparam PRESCALER_WIDTH =  12;
		localparam LIMIT = 3125;
		
		// define the limit_value
		logic [PRESCALER_WIDTH-1:0] limit_value;
		assign limit_value = LIMIT;
		
		// instantiate the prescaler 
		// produces a 32 kHz clock
		prescaler #(
		    .PRESCALER_WIDTH(PRESCALER_WIDTH)
		) prescaler_inst (
		    .clock(clock),
		    .reset(reset),
		    .limit(limit_value),
		    .clock_enable(clock_enable)
		);
		
		// instantiate the PWM controller for the red LED
		pwm_controller 
		#(
		    .RESOLUTION(4)
		) PWM_controller_red (
		    .clock(clock),
		    .reset(reset),
		    .SW(SW[1:0]),
		    .clock_enable(clock_enable),
		    .PWM(RGB[0])
		);
		
		
		// instantiate the PWM controller for the red LED
		pwm_controller 
		#(
		    .RESOLUTION(4)
		) pwm_controller_blue (
		    .clock(clock),
		    .reset(reset),
		    .SW(SW[3:2]),
		    .clock_enable(clock_enable),
		    .PWM(RGB[1])
		);
		
		// instantiate the PWM controller for the red LED
		pwm_controller #(
		    .RESOLUTION(4)
		) pwm_controller_green
		(
		    .clock(clock),
		    .reset(reset),
		    .SW(SW[5:4]),
		    .clock_enable(clock_enable),
		    .PWM(RGB[2])
		); 
endmodule
