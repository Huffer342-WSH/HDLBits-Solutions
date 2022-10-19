module top_module (
    input  clk,
    input  reset,  // Synchronous reset
    input  s,
    input  w,
    output z
);


    parameter reg [1:0] ST_IDLE = 2'b00;
    parameter reg [1:0] ST_BIT1 = 2'b01;
    parameter reg [1:0] ST_BIT2 = 2'b11;
    parameter reg [1:0] ST_BIT3 = 2'b10;

    reg [2:0] series_w;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= ST_IDLE;
            series_w <= 3'b0;
        end else begin
            state <= next_state;
            if (state != ST_IDLE) begin
                series_w[2:0] = {series_w[1:0], w};
            end else begin
                series_w <= 3'b0;
            end

        end

    end

    always @(*) begin
        case (state)
            ST_IDLE:
            if (s == 1'b0) begin
                next_state = ST_IDLE;
            end else begin
                next_state = ST_BIT1;
            end
            ST_BIT1: next_state = ST_BIT2;
            ST_BIT2: next_state = ST_BIT3;
            ST_BIT3: next_state = ST_BIT1;
            default: next_state = ST_IDLE;
        endcase
    end

    assign z = (state == ST_BIT1) &&
        ((series_w == 3'b110) || (series_w == 3'b101) || (series_w == 3'b011));


endmodule
