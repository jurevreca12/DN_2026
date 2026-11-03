module buggy_fifo #(
    parameter integer DATA_WIDTH = 8,
    parameter integer DEPTH      = 4,
    parameter integer COUNT_WIDTH = $clog2(DEPTH + 1),
    parameter integer PTR_WIDTH   = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input  logic                  clk,
    input  logic                  rst,       // Synchronous, active-high reset

    input  logic                  in_valid,
    output logic                  in_ready,
    input  logic [DATA_WIDTH-1:0] in_data,

    output logic                  out_valid,
    input  logic                  out_ready,
    output logic [DATA_WIDTH-1:0] out_data
);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_WIDTH-1:0]  wr_ptr;
    logic [PTR_WIDTH-1:0]  rd_ptr;
    logic [COUNT_WIDTH-1:0] count;

    logic push;
    logic pop;

    assign in_ready  = (count < DEPTH);
    assign out_valid = (count != 0);

    // Data is meaningful when out_valid is high.
    assign out_data = mem[rd_ptr];

    assign push = in_valid && in_ready;
    assign pop  = out_valid && out_ready;

    function automatic logic [PTR_WIDTH-1:0] next_ptr(
        input logic [PTR_WIDTH-1:0] ptr
    );
        if (ptr == DEPTH - 1)
            next_ptr = '0;
        else
            next_ptr = ptr + 1'b1;
    endfunction

    always_ff @(posedge clk) begin
        if (rst) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
        end else begin
            if (push) begin
                mem[wr_ptr] <= in_data;
                wr_ptr <= next_ptr(wr_ptr);
            end

            if (pop)
                rd_ptr <= next_ptr(rd_ptr);
            if (push)
                count <= count + 1'b1;
            else if (pop)
                count <= count - 1'b1;
        end
    end
endmodule

