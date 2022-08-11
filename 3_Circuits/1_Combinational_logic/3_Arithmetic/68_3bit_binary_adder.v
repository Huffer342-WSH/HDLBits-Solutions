module top_module (
    input  [2:0] a,
    b,
    input        cin,
    output [2:0] cout,
    output [2:0] sum
);

    one_bit_binary_adder sub_adder[2:0] (
        .a(a[2:0]),
        .b(b[2:0]),
        .cin({cout[1:0], cin}),
        .cout(cout[2:0]),
        .sum(sum[2:0])
    );

endmodule


module one_bit_binary_adder (
    input  a,
    b,
    cin,
    output sum,
    cout
);
    assign {cout, sum} = a + b + cin;

endmodule  //one_bit_binary_adder
