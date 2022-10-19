module top_module (
    input        clk,
    input        resetn,  // active-low synchronous reset
    input  [3:1] r,       // request
    output [3:1] g        // grant
);

    parameter reg [3:0] ST_A = 4'b0001;
    parameter reg [3:0] ST_B = 4'b0010;
    parameter reg [3:0] ST_C = 4'b0100;
    parameter reg [3:0] ST_D = 4'b1000;

    reg [3:0] state, next_state;
    always @(posedge clk) begin
        if (~resetn) begin
            state <= ST_A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            ST_A: begin
                if (r[1] == 1'b1) next_state = ST_B;
                else if (r[2:1] == 2'b10) next_state = ST_C;
                else if (r[3:1] == 3'b100) next_state = ST_D;
                else next_state = ST_A;
            end
            ST_B: next_state = r[1] ? ST_B : ST_A;
            ST_C: next_state = r[2] ? ST_C : ST_A;
            ST_D: next_state = r[3] ? ST_D : ST_A;
        endcase
    end

    assign g[3:1] = state[3:1];
endmodule
