`default_nettype none
module top_module (
    input  a    ,
    input  b    ,
    input  c    ,
    input  d    ,
    output out  ,
    output out_n
);
    wire x1;
    wire x2;
    assign x1 = a&b;
    assign x2 = c&d;
    assign out = x1|x2;
    assign out_n = ~(x1|x2);


endmodule
