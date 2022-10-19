module top_module (
    input      clk,
    input      areset,
    input      x,
    output reg z
);

    parameter reg [1:0] ST_ORIGNAL = 2'b01;
    parameter reg [1:0] ST_INVERSE = 2'b10;

    reg [1:0] state, next_state;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= ST_ORIGNAL;
        end else begin
            state <= next_state;
        end
    end
    always @(*) begin
        case (state)
            ST_ORIGNAL:
            if (x == 1'b1) begin
                next_state = ST_INVERSE;
            end else begin
                next_state = ST_ORIGNAL;
            end
            ST_INVERSE:
            if (x == 1'b0) begin
                next_state = ST_INVERSE;
            end
            default: next_state = ST_ORIGNAL;
        endcase
    end


    always @(*) begin
        case (state)
            ST_ORIGNAL: z = x;
            ST_INVERSE: z = ~x;
            default:    z = x;
        endcase
    end

endmodule
