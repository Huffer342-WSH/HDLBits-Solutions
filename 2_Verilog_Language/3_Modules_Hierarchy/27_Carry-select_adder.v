module top_module(
           input [31:0] a,
           input [31:0] b,
           output [31:0] sum
       );

supply0 logic0;
supply1 logic1;
wire c;
wire [15:0] sum1,sum2;

add16 ad1(
          .a(a[15:0]),
          .b( b[ 15 : 0 ] ),
          .cin( logic0 ),
          .cout( c ),
          .sum( sum[15:0] )
      );

add16 ad2(
          .a(a[31:16]),
          .b( b[ 31:16 ] ),
          .cin( logic0 ),
          .cout(  ),
          .sum( sum1 )
      );

add16 ad3(
          .a(a[31:16]),
          .b( b[ 31:16 ] ),
          .cin( logic1 ),
          .cout(  ),
          .sum( sum2 )
      );

assign sum[31:16] = c==1'b0 ?sum1:sum2;

endmodule
