module top_module (
    input              clk,
    input              load,
    input      [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load == 1'b1) begin
            q <= data;
        end else begin
            q[511:0] <= {q[510:0], 1'b0} ^ {1'b0, q[511:1]};
        end
    end

endmodule
