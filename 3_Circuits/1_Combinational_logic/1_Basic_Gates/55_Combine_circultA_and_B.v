module top_module (input x, input y, output z);

wire z_IA1,z_IA2,z_IB1,z_IB2;


A_module IA1(x,y,z_IA1);
A_module IA2(x,y,z_IA2);
B_module IB1(x,y,z_IB1);
B_module IB2(x,y,z_IB2);

assign z = ( z_IA1 | z_IB1 ) ^ ( z_IA2 & z_IB2 );


endmodule

    module A_module (input x, input y, output z);

assign z = (x ^ y) & x;
endmodule

    module B_module ( input x, input y, output z );

assign z = ~(x ^ y);
endmodule
