module top_module (
           input clk,
           input enable,
           input S,
           input A, B, C,
           output Z );

reg [7:0]Dff;

always @(posedge clk ) begin
    if(enable == 1'b1) begin
        Dff[7:0] <= { Dff[6:0] , S };
    end
    else begin
        Dff <= Dff;
    end
end

assign Z = Dff[ { A,B,C } ];
endmodule
