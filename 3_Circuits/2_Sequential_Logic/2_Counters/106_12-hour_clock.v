//  Quartus synthesis:
//  Info (21057): Implemented 70 device resources after synthesis - the final resource count might be different
//  Info (21058): Implemented 3 input pins
//  Info (21059): Implemented 25 output pins
//  Info (21061): Implemented 42 logic cells

module top_module(
           input clk,
           input reset,
           input ena,
           output reg pm,
           output [7:0] hh,
           output [7:0] mm,
           output [7:0] ss);

wire [2:0] en_c;
wire [2:0] load_c;
wire [23:0] D_c;

BCD_counter_8bit u_bcd_cnt[2:0](
                     clk,
                     en_c[2:0],
                     load_c[2:0],
                     D_c[23:0],
                     {hh,mm,ss}
                 );

assign  en_c[0] = ena;
assign  en_c[1] = ss[7:0] == 8'h59;
assign  en_c[2] = en_c[1] & ( mm[7:0] == 8'h59 );

assign  load_c[0] = reset | en_c[1];
assign  load_c[1] = reset | en_c[2];
assign  load_c[2] = reset | (en_c[2] & hh == 8'h12 );

assign  D_c[15:0] = 16'h0000;
assign  D_c[23:16] = reset ? 8'h12 : 8'h01;

always @(posedge clk) begin
    if (reset == 1'b1) begin
        pm <= 1'b0;
    end
    else begin
        if (( {hh,mm,ss} == 24'h115959) && (ena == 1'b1)) begin
            pm <= ~pm;
        end
        else begin
            pm <= pm;
        end
    end
end

endmodule


    module BCD_counter_8bit (
        input clk,
        input en,
        input load,
        input [7:0] D,
        output reg [7:0] Q
    );

always @(posedge clk) begin
    if (load == 1'b1) begin
        Q <= D;
    end
    else begin
        if (en == 1'b1) begin
            if(Q[3:0] == 4'h9 ) begin
                Q[3:0] <= 4'h0;
                Q[7:4] <= Q[7:4] + 4'h1;
            end
            else begin
                Q[3:0] <= Q[3:0] + 4'h1;
                Q[7:4] <= Q[7:4] ;
            end
        end
        else begin
            Q <= Q ;
        end
    end
end

endmodule //8bit_BCD_counter
