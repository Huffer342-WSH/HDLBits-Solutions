module top_module (
    input  clk,
    input  in,
    input  areset,
    output out
);  //

    reg [3:0] state_curr, state_next;

    parameter reg [3:0] A = 4'b0001, B = 4'b0010, C = 4'b0100, D = 4'b1000;
    // State transition logic
    always @(*) begin
        case (state_curr)
            A:       state_next = in ? B : A;
            B:       state_next = in ? B : C;
            C:       state_next = in ? D : A;
            D:       state_next = in ? B : C;
            default: state_next = in ? B : A;
        endcase
    end


    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_curr <= A;
        end else begin
            state_curr <= state_next;
        end
    end

    // Output logic
    assign out = state_curr == D;
endmodule
