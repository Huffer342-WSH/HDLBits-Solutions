module top_module (
    input  clk,
    input  resetn,  // active-low synchronous reset
    input  x,
    input  y,
    output f,
    output g
);

    parameter reg [4:0] ST_RESET = 5'd0;
    parameter reg [4:0] ST_START = 5'd1;
    parameter reg [4:0] ST_START2 = 5'd9;
    parameter reg [4:0] ST_X_0 = 5'd2;
    parameter reg [4:0] ST_X_1 = 5'd3;
    parameter reg [4:0] ST_X_10 = 5'd4;
    parameter reg [4:0] ST_X_101 = 5'd5;
    parameter reg [4:0] ST_Y_0 = 5'd6;
    parameter reg [4:0] ST_G_1 = 5'd7;
    parameter reg [4:0] ST_G_0 = 5'd8;

    reg [4:0] state, next_state;

    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            state <= ST_RESET;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            ST_RESET:  next_state = ST_START;
            ST_START:  next_state = ST_START2;
            ST_START2: next_state = x ? ST_X_1 : ST_X_0;
            ST_X_0:    next_state = x ? ST_X_1 : ST_X_0;
            ST_X_1:    next_state = x ? ST_X_1 : ST_X_10;
            ST_X_10:   next_state = x ? ST_X_101 : ST_X_0;
            ST_X_101:  next_state = y ? ST_G_1 : ST_Y_0;
            ST_Y_0:    next_state = y ? ST_G_1 : ST_G_0;
            ST_G_1:    next_state = ST_G_1;
            ST_G_0:    next_state = ST_G_0;
        endcase
    end

    assign f = (state == ST_START) ? 1'b1 : 1'b0;
    assign g = (state == ST_X_101) || (state == ST_G_1) || (state == ST_Y_0);
endmodule
