module top_module (
           input clk,
           input reset,            // Synchronous reset
           input [7:0] d,
           output reg [7:0] q
       );

// 同步复位 ，reset不用写入敏感列表
always @(posedge clk ) begin
    if (reset == 1'b1) begin
        q[7:0] <= 8'd0;
    end
    else begin
        q[7:0] <= d[7:0];
    end
end
endmodule
