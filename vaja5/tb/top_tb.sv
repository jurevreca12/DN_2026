
module top_tb;

    // Declare testbench signals
    logic clock;
    logic reset;
    logic enable;
    logic [7:0] anode_assert;
    logic [6:0] segs;

    // Instantiate the stopwatch module
    top uut (
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .anode_assert(anode_assert),
        .segs(segs)
    );

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 100 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        $dumpfile("output/tb.vcd");
        $dumpvars;

        reset = 1;
        enable = 0;

        // Apply reset
        #10;
        reset = 0;

        // Start counting
        #20;
        enable = 1;

        // Run simulation for 5 seconds
        #(50000000);
        $finish;
    end

    // Monitor outputs
    
endmodule
