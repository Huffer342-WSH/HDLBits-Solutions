module top_module (
    input      clk,
    input      aresetn,  // Asynchronous active-low reset
    input      x,
    output reg z
);
    parameter reg [1:0] ST0 = 2'd0;
    parameter reg [1:0] ST1 = 2'd1;
    parameter reg [1:0] ST10 = 2'd2;

    reg [1:0] state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= ST0;
        end else begin
            state <= next_state;
        end
    end


    always @(*) begin
        case (state)
            ST0: begin
                if (x == 1'b0) begin
                    next_state = ST0;
                    z = 1'b0;
                end else begin
                    next_state = ST1;
                    z = 1'b0;
                end
            end
            ST1: begin
                if (x == 1'b0) begin
                    next_state = ST10;
                    z = 1'b0;
                end else begin
                    next_state = ST1;
                    z = 1'b0;
                end
            end
            ST10: begin
                if (x == 1'b1) begin
                    next_state = ST1;
                    z = 1'b1;
                end else begin
                    next_state = ST0;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = ST0;
                z = 1'b0;
            end
        endcase
    end


endmodule
