`define CH1

`ifdef CH1
module top_module ( input clk,
                    input [ 7: 0 ] d,
                    input [ 1: 0 ] sel,
                    output reg [ 7: 0 ] q );

wire [ 31: 0 ] data;
assign data[ 7: 0 ] = d[ 7: 0 ];

my_dff8 md1( clk, d[ 7: 0 ], data[ 15: 8 ] );
my_dff8 md2( clk, data[ 15: 8 ], data[ 23: 16 ] );
my_dff8 md3( clk, data[ 23: 16 ], data[ 31: 24 ] );


always @( * ) begin
    q[ 7: 0 ] = data[ ( sel * 8 ) +: 8 ];
end


endmodule

    `elsif CH2

    module top_module (
        input clk,
        input [ 7: 0 ] d,
        input [ 1: 0 ] sel,
        output reg [ 7: 0 ] q
    );

wire [ 7: 0 ] o1, o2, o3;		// output of each my_dff8

// Instantiate three my_dff8s
my_dff8 d1 ( clk, d, o1 );
my_dff8 d2 ( clk, o1, o2 );
my_dff8 d3 ( clk, o2, o3 );

// This is one way to make a 4-to-1 multiplexer
always @( * )        		// Combinational always block
case ( sel )
    2'h0:
        q = d;
    2'h1:
        q = o1;
    2'h2:
        q = o2;
    2'h3:
        q = o3;
endcase

endmodule
`endif

