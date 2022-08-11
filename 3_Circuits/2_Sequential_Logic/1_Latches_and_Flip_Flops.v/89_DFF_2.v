module top_module (
    input      clk,
    input      d,
    input      r,    // synchronous reset
    output reg q
);

    always @(posedge clk) begin
        if (r == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule
