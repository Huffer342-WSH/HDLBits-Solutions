module top_module (
    input      clk,
    input      areset,
    input      x,
    output reg z
);

    parameter reg [1:0] ST_ZERO = 2'd0;
    parameter reg [1:0] ST_FIRST = 2'd1;
    parameter reg [1:0] ST_INVERSE = 2'd2;

    reg [1:0] state, next_state;
    reg x_pre;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= ST_ZERO;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        x_pre <= x;
    end

    always @(*) begin
        case (state)
            ST_ZERO:
            if (x == 1'b0) begin
                next_state = ST_ZERO;
            end else begin
                next_state = ST_FIRST;
            end
            ST_FIRST:   next_state = ST_INVERSE;
            ST_INVERSE: next_state = ST_INVERSE;
            default:    next_state = ST_ZERO;
        endcase
    end

    always @(*) begin
        case (state)
            ST_ZERO:    z = 1'b0;
            ST_FIRST:   z = 1'b1;
            ST_INVERSE: z = ~x_pre;
        endcase
    end
endmodule
