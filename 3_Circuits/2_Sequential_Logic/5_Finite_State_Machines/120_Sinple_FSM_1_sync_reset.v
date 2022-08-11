// Note the Verilog-1995 module declaration syntax here:
module top_module (
    input  clk,
    input  reset,
    input  in,
    output out
);


    // Fill in state name declarations
    parameter reg A = 0, B = 1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) present_state <= B;
        else present_state <= next_state;
    end

    always @(*) begin
        case (present_state)
            B:       next_state <= (in == 1) ? B : A;
            A:       next_state <= (in == 1) ? A : B;
            default: next_state <= (in == 1) ? B : A;
        endcase
    end

    assign out = (present_state == B);

endmodule
