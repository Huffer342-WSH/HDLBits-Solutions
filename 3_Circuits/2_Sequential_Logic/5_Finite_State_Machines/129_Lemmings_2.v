module top_module (
        input  wire clk,
        input  wire areset,
        input  wire bump_left,
        input  wire bump_right,
        input  wire ground,
        output reg  walk_left,
        output reg  walk_right,
        output reg  aaah
    );

    parameter reg [3:0] LEFT   = 4'b0001;
    parameter reg [3:0] FALL_L = 4'b0010;
    parameter reg [3:0] RIGHT  = 4'b0100;
    parameter reg [3:0] FALL_R = 4'b1000;

    reg [3:0] state     ;
    reg [3:0] next_state;

    always @( *) begin
        case (state)
            FALL_L : begin
                if(ground == 1'b0)
                    next_state = FALL_L;
                else
                    next_state = LEFT;
            end
            LEFT : begin
                if(ground == 1'b0)
                    next_state = FALL_L;
                else if (bump_left == 1'b1)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT : begin
                if(ground == 1'b0)
                    next_state = FALL_R;
                else if (bump_right == 1'b1)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_R : begin
                if(ground == 1'b0)
                    next_state = FALL_R;
                else
                    next_state = RIGHT;
            end
            default :
                next_state = state;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if ( areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        if(state == FALL_L ||  state == FALL_R) begin
            walk_right <= 1'b0;
            walk_left  <= 1'b0;
            aaah       <= 1'b1;
        end
        else if(state == LEFT) begin
            walk_right <= 1'b0;
            walk_left  <= 1'b1;
            aaah       <= 1'b0;
        end
        else begin
            walk_right <= 1'b1;
            walk_left  <= 1'b0;
            aaah       <= 1'b0;
        end
    end
endmodule
