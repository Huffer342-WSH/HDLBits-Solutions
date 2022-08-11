// synthesis verilog_input_version verilog_2001
module top_module (
    input      [7:0] in,
    output reg [2:0] pos
);

    /*
     A case statement behaves as though each item is checked sequentially (in reality, /
   a big combinational logic function). Notice how there are certain inputs (e.g.,     /
   4'b1111) that will match more than one case item. The first match is chosen (so     /
   4'b1111 matches the first item, out = 0, but not any of the later ones).
*/
    always @(*) begin
        casez (in[7:0])
            8'bzzzz_zzz1: pos[2:0] = 3'd0;
            8'bzzzz_zz10: pos[2:0] = 3'd1;
            8'bzzzz_z100: pos[2:0] = 3'd2;
            8'bzzzz_1000: pos[2:0] = 3'd3;
            8'bzzz1_0000: pos[2:0] = 3'd4;
            8'bzz10_0000: pos[2:0] = 3'd5;
            8'bz100_0000: pos[2:0] = 3'd6;
            8'b1000_0000: pos[2:0] = 3'd7;
            default:      pos[2:0] = 3'd0;
        endcase
    end


endmodule
