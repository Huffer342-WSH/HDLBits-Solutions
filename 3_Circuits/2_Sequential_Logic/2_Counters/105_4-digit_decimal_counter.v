module top_module (
    input         clk,
    input         reset,  // Synchronous active-high reset
    output [ 3:1] ena,
    output [15:0] q
);


    bcd_counter sub_counter[3:0] (
        clk,
        {ena[3:1], {1'b1}},
        reset,
        q[15:0]
    );

    assign ena[1] = q[3] & q[0];
    assign ena[2] = q[7] & q[4] & ena[1];
    assign ena[3] = q[11] & q[8] & ena[2];

endmodule



module bcd_counter (
    input clk,
    input slowena,
    input reset,
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
