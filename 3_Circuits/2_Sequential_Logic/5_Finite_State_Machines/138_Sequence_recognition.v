module top_module (
    input  clk,
    input  reset,  // Synchronous reset
    input  in,
    output disc,
    output flag,
    output err
);


    parameter reg [3:0] ST_NONE = 4'b0000;
    parameter reg [3:0] ST_ONE = 4'b0001;
    parameter reg [3:0] ST_TWO = 4'b0011;
    parameter reg [3:0] ST_THREE = 4'b0010;
    parameter reg [3:0] ST_FOUR = 4'b0110;
    parameter reg [3:0] ST_FIVE = 4'b0111;
    parameter reg [3:0] ST_SIX = 4'b0101;
    parameter reg [3:0] ST_ERROR = 4'b0100;
    parameter reg [3:0] ST_FLAG = 4'b1100;
    parameter reg [3:0] ST_DISCARD = 4'b1101;

    reg [3:0] state, next_state;


    always @(*) begin
        case (state)
            ST_NONE:    next_state = (in == 1'b1) ? ST_ONE : ST_NONE;
            ST_ONE:     next_state = (in == 1'b1) ? ST_TWO : ST_NONE;
            ST_TWO:     next_state = (in == 1'b1) ? ST_THREE : ST_NONE;
            ST_THREE:   next_state = (in == 1'b1) ? ST_FOUR : ST_NONE;
            ST_FOUR:    next_state = (in == 1'b1) ? ST_FIVE : ST_NONE;
            ST_FIVE:    next_state = (in == 1'b1) ? ST_SIX : ST_DISCARD;
            ST_SIX:     next_state = (in == 1'b1) ? ST_ERROR : ST_FLAG;
            ST_ERROR:   next_state = (in == 1'b1) ? ST_ERROR : ST_NONE;
            ST_FLAG:    next_state = (in == 1'b1) ? ST_ONE : ST_NONE;
            ST_DISCARD: next_state = (in == 1'b1) ? ST_ONE : ST_NONE;
            default:    next_state = ST_NONE;
        endcase
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= ST_NONE;
        end else begin
            state <= next_state;
        end
    end

    assign disc = (state == ST_DISCARD) ? 1'b1 : 1'b0;
    assign flag = (state == ST_FLAG) ? 1'b1 : 1'b0;
    assign err  = (state == ST_ERROR) ? 1'b1 : 1'b0;

endmodule
