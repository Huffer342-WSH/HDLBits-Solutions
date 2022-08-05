module top_module(
           input clk,
           input reset,    // Active-high synchronous reset to 32'h1
           output reg [31:0] q
       );

always @(posedge clk ) begin
    if (reset == 1'b1) begin
        q <= 32'b1;
    end
    else begin
        q[30:0] <= q[31:1];//该次非阻塞赋值中的重复部分会被代替

        q[31]   <= q[0]  ^ 1'b0;
        q[21]   <= q[22] ^ q[0];
        q[1]    <= q[2]  ^ q[0];
        q[0]    <= q[1]  ^ q[0];
    end
end
endmodule
