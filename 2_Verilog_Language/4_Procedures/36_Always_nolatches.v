// synthesis verilog_input_version verilog_2001
module top_module (
           input [15:0] scancode,
           output reg left,
           output reg down,
           output reg right,
           output reg up  );
/*
    assign a defaule value to all four outputs befour case statement,can 
    avoid assign theme in every case but only assign the output which need to 
    change.
*/
always @(*) begin
    {left,down,right,up} = 4'b0000;
    case (scancode)
        16'he06b :
            left = 1'b1;
        16'he072:
            down = 1'b1;
        16'he074:
            right = 1'b1;
        16'he075:
            up = 1'b1;
    endcase
end
endmodule
