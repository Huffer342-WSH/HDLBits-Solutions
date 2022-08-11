module top_module (
    input             clk,
    input             reset,
    input      [31:0] in,
    output reg [31:0] out
);

    reg [31:0] in_pre;
    always @(posedge clk) begin
        in_pre <= in;

        if (reset == 1'b1) begin
            out <= 32'b0;
        end else begin
            out <= out | (~in & in_pre);
        end
    end


endmodule
