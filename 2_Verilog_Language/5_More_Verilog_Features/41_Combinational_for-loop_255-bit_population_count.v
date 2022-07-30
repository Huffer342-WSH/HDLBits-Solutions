module top_module(
           input [254:0] in,
           output [7:0] out );

integer  i,count;
always @(*) begin
    count = 0;
    for (i = 0  ; i<255 ; i++ ) begin
        if (in[i]==1'b1) begin
            count++;
        end
    end
    out = count[7:0];
end
endmodule
