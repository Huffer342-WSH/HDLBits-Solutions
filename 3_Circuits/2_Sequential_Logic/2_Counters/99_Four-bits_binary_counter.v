module top_module (
    input            clk,
    input            reset,  // Synchronous active-high reset
    output reg [3:0] q
);

    //4位计数器正好计数16次，不需要手动置位，f下一个自然是0
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 4'b0;
        end else begin
            q <= q + 4'b1;
        end
    end
endmodule
