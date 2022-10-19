module top_module (
    input  clk,
    input  reset,  // synchronous reset
    input  w,
    output z
);



    parameter reg [3:1] A = 3'd0;
    parameter reg [3:1] B = 3'd1;
    parameter reg [3:1] C = 3'd2;
    parameter reg [3:1] D = 3'd3;
    parameter reg [3:1] E = 3'd4;
    parameter reg [3:1] F = 3'd5;

    reg [3:1] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
        endcase
    end

    assign z = (state == E) || (state == F);



endmodule
