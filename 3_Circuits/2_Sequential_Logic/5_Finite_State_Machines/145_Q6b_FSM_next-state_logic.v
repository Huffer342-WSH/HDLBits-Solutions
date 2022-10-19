module top_module (
    input  [3:1] y,
    input        w,
    output       Y2
);

    parameter reg [3:1] A = 3'd0;
    parameter reg [3:1] B = 3'd1;
    parameter reg [3:1] C = 3'd2;
    parameter reg [3:1] D = 3'd3;
    parameter reg [3:1] E = 3'd4;
    parameter reg [3:1] F = 3'd5;

    reg [3:1] next_state;
    always @(*) begin
        case (y)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
        endcase
    end

    assign Y2 = next_state[2];

endmodule
