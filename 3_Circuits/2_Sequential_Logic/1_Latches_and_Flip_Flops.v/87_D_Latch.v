module top_module (
           input d,
           input ena,
           output reg  q);

always @(ena) begin
    if (ena == 1'b0) begin
        q <= q;
    end
    else begin
        q <= d;
    end
end
endmodule
