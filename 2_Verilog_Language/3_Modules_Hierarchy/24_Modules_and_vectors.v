module top_module (
    input            clk,
    input      [7:0] d,
    input      [1:0] sel,
    output reg [7:0] q
);

    wire [31:0] data;
    assign data[7:0] = d[7:0];

    my_dff8 md1 (
        clk,
        d[7:0],
        data[15:8]
    );
    my_dff8 md2 (
        clk,
        data[15:8],
        data[23:16]
    );
    my_dff8 md3 (
        clk,
        data[23:16],
        data[31:24]
    );

    always @(*) begin
        q[7:0] = data[(sel * 8) +: 8];
    end



endmodule
