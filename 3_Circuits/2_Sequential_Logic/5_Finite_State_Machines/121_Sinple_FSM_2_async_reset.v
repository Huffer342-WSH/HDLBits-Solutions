module top_module (
    input  clk,
    input  areset,  // Asynchronous reset to OFF
    input  j,
    input  k,
    output out
);  //

    parameter OFF = 0, ON = 1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            OFF:     next_state = j ? ON[0] : OFF[0];
            ON:      next_state = k ? OFF[0] : ON[0];
            default: next_state = OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset == 1'b1) begin
            state <= OFF[0];
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == OFF[0]) ? 1'b0 : 1'b1;

endmodule
