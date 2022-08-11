module top_module (
    input  [3:0] x,
    input  [3:0] y,
    output [4:0] sum
);

    supply0 logic_0;
    wire [3:1] carry;

    full_adder sub_adder[3:0] (
        .a(x[3:0]),
        .b(y[3:0]),
        .cin({carry[3:1], logic_0}),
        .cout({sum[4], carry[3:1]}),
        .sum(sum[3:0])
    );
endmodule



module full_adder (
    input  a,
    b,
    cin,
    output sum,
    cout
);
    assign {cout, sum} = a + b + cin;

endmodule  //full_adder
