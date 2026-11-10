module rgb_controller_tb;

    // Declare testbench signals
    logic clock;
    logic reset;
    logic [5:0] SW;
    logic [2:0] RGB;

    // Instantiate the rgb_controller module
    top uut (
        .clock(clock),
        .reset(reset),
        .SW(SW),
        .RGB(RGB)
    );

    integer i;
		logic [5:0] sw_vals[11] = '{
			6'b00_00_00,
			6'b00_00_01,
			6'b00_00_10,
			6'b00_00_11,
			6'b00_01_00,
			6'b00_10_00,
			6'b00_11_00,
			6'b01_00_00,
			6'b10_00_00,
			6'b11_00_00,
			6'b11_11_11
		};
    // Parameters
    localparam CL = 10; // Clock period in ns

    // Clock generation
    initial begin
        clock = 0;
        forever #(CL/2) clock = ~clock; // 100 MHz clock
    end

    // Test sequence
    initial begin
        $dumpfile("output/tb.vcd");
        $dumpvars;
        // Initialize signals
        reset = 1;
				repeat (2) @(posedge clock);
        reset = 0;

				for (i = 0; i < 11; i=i+1) begin
        		SW = sw_vals[i];
						repeat(16 * 3125) @(posedge clock);
				end
        $finish;
    end

   

endmodule
