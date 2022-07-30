module top_module (
           input [31:0] a,
           input [31:0] b,
           output [31:0] sum
       );//

supply0 cin;
wire c;

add16 ad1(
          .a(a[15:0]),
          .b( b[ 15 : 0 ] ),
          .cin( cin ),
          .cout( c ),
          .sum( sum[15:0] )
      );

add16 ad2(
          .a(a[31:16]),
          .b( b[ 31:16 ] ),
          .cin( c ),
          .cout(  ),
          .sum( sum[31:16] )
      );


endmodule


    module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
assign {cout,sum} = a+b+cin;

endmodule
