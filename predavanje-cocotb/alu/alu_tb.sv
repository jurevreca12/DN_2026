module tb;

    logic [3:0] a;
    logic [3:0] b;
    logic [2:0] alu_control;
    logic [3:0] c;

    alu dut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .c(c)
    );

    task automatic check(
        input logic [3:0] test_a,
        input logic [3:0] test_b,
        input logic [2:0] control,
        input logic [3:0] expected
    );
        begin
            a = test_a;
            b = test_b;
            alu_control = control;

            #1; // Allow combinational logic to settle.

            if (c !== expected) begin
                $error(
                    "FAIL: a=%0d b=%0d control=%03b expected=%0d got=%0d",
                    a, b, alu_control, expected, c
                );
            end else begin
                $display(
                    "PASS: a=%0d b=%0d control=%03b result=%0d",
                    a, b, alu_control, c
                );
            end
        end
    endtask

    initial begin
        check(3,  2, 3'b000, 5);   // add
        check(3,  2, 3'b001, 1);   // subtract
        check(3,  2, 3'b010, 2);   // AND
        check(3,  2, 3'b011, 3);   // OR
        check(3,  2, 3'b100, 1);   // XOR
        check(7,  7, 3'b101, 1);   // equal
        check(10, 12, 3'b101, 0);  // not equal
        check(10, 12, 3'b110, 10); // pass a
        check(10, 12, 3'b111, 12); // pass b
        check(15, 1, 3'b000, 0);   // 4-bit addition wraps around

        $finish;
    end

endmodule
