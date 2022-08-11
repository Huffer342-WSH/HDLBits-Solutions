module top_module (
    input            clk,
    input      [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] in_pre;
    always @(posedge clk) begin
        in_pre <= in;
        pedge[7:0] = in & ~in_pre;
    end
endmodule
