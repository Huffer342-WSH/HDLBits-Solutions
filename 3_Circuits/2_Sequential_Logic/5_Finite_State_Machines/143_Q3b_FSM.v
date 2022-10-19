module top_module (
    input  clk,
    input  reset,  // Synchronous reset
    input  x,
    output z
);


    parameter reg [2:0] ST_000 = 3'b000;
    parameter reg [2:0] ST_001 = 3'b001;
    parameter reg [2:0] ST_010 = 3'b010;
    parameter reg [2:0] ST_011 = 3'b011;
    parameter reg [2:0] ST_100 = 3'b100;

    reg [2:0] state, next_state;
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= ST_000;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            ST_000:  next_state = x == 1'b1 ? ST_001 : ST_000;
            ST_001:  next_state = x == 1'b1 ? ST_100 : ST_001;
            ST_010:  next_state = x == 1'b1 ? ST_001 : ST_010;
            ST_011:  next_state = x == 1'b1 ? ST_010 : ST_001;
            ST_100:  next_state = x == 1'b1 ? ST_100 : ST_011;
            default: next_state = ST_000;
        endcase
    end

    assign z = (state == ST_011) || (state == ST_100);
endmodule
