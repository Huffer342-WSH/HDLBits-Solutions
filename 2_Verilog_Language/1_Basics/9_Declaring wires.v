`default_nettype none
module top_module (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire out,
    output wire out_n
);
    wire x1;
    wire x2;
    assign x1 = a & b;
    assign x2 = c & d;
    assign out = x1 | x2;
    assign out_n = ~(x1 | x2);


endmodule
