`timescale 1ns/1ps

module gray_counter_tb;

    localparam integer LIMIT = 3;

    logic clk = 0;
    logic rst;
    logic up_down;
    logic [3:0] gray_code;

    gray_counter #(.LIMIT(LIMIT)) dut (
        .clk(clk),
        .rst(rst),
        .up_down(up_down),
        .gray_code(gray_code)
    );

    // One rising edge, then allow nonblocking assignments to settle.
    task automatic clock_edge;
        begin
            clk = 1; #5; 
            clk = 0; #5;
        end
    endtask

    task automatic check_gray(input logic [3:0] expected);
        begin
            if (gray_code !== expected)
                $fatal(1, "FAIL: expected gray_code=%04b, got %04b",
                       expected, gray_code);
            else
                $display("PASS: gray_code=%04b", gray_code);
        end
    endtask

    // Wait for one prescaler tick: LIMIT+1 clock edges.
    task automatic wait_for_tick;
        integer i;
        begin
            for (i = 0; i <= LIMIT; i = i + 1)
                clock_edge();
        end
    endtask

    initial begin
        $dumpfile("dump.fst");
        $dumpvars();
        rst = 1;
        up_down = 1;

        clock_edge(); // Apply reset on a rising edge.
        rst = 0;
        check_gray(4'b0000);

        // Count up: binary 1, 2, 3 -> Gray 1, 3, 2.
        wait_for_tick();
        check_gray(4'b0001);
        wait_for_tick();
        check_gray(4'b0011);
        wait_for_tick();
        check_gray(4'b0010);

        // Count down: binary 2 -> Gray 3.
        up_down = 0;
        wait_for_tick();
        check_gray(4'b0011);

        // Reset returns the output to Gray zero.
        rst = 1;
        clock_edge();
        rst = 0;
        check_gray(4'b0000);

        $display("All gray_counter tests passed.");
        $finish;
    end

endmodule
