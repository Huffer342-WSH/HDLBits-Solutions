module top_module (
    input            clk,
    input            slowena,
    input            reset,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 4'd0;
        end else begin
            if (slowena == 1'b1) begin
                if (q == 4'd9) q <= 4'd0;
                else q <= q + 4'd1;
            end else q <= q;
        end
    end
endmodule
