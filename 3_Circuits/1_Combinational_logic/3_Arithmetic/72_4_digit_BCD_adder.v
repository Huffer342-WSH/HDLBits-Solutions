module top_module (
           input [15:0] a, b,
           input cin,
           output cout,
           output [15:0] sum );

wire [3:1]carry;

bcd_fadd sub_adder[3:0](
             .a( a[15:0] ),
             .b( b[15:0] ),
             .cin( {carry[3:1] , cin} ),
             .cout( {cout , carry[3:1]} ),
             .sum( sum[15:0] )
         );

endmodule
