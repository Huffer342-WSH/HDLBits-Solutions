module top_module (
           input  clk,
           input  resetn,   // synchronous reset
           input  in,
           output out);

reg [3:0]dff;

assign out  = dff[0];

always @(posedge clk ) begin
    if(resetn == 1'b0) begin
        dff<=4'b0;
    end
    else begin
        dff[3:0] <= { in , dff[3:1] };
    end
end

endmodule
