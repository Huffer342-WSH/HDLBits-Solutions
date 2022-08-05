
module top_module (
           input  [3:0] SW,
           input  [3:0] KEY,
           output [3:0] LEDR
       );


MUXDFF sub_module[3:0](
           .clk (  KEY[0]               ),
           .E   (  KEY[1]               ),
           .L   (  KEY[2]               ),
           .w   (  {KEY[3],LEDR[3:1]}   ),
           .R   (  SW[3:0]              ),
           .Q   (  LEDR[3:0]            )
       );

endmodule


    module MUXDFF (
        input clk,
        input w, R, E, L,
        output reg  Q
    );

always @(posedge clk) begin
    Q <= L ? R :(E ? w : Q);
end
endmodule
