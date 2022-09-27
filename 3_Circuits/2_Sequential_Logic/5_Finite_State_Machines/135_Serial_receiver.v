module top_module (
    input  clk,
    input  in,
    input  reset,  // Synchronous reset
    output done
);

    parameter reg [3:0] STOP = 4'b0000;
    parameter reg [3:0] START = 4'b0001;
    parameter reg [3:0] DATA0 = 4'b0011;
    parameter reg [3:0] DATA1 = 4'b0010;
    parameter reg [3:0] DATA2 = 4'b0110;
    parameter reg [3:0] DATA3 = 4'b0111;
    parameter reg [3:0] DATA4 = 4'b0101;
    parameter reg [3:0] DATA5 = 4'b0100;
    parameter reg [3:0] DATA6 = 4'b1100;
    parameter reg [3:0] DATA7 = 4'b1101;
    parameter reg [3:0] ERROR = 4'b1111;
    parameter reg [3:0] IDLE = 4'b1110;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            STOP:  next_state = (in == 1'b1) ? IDLE : START;
            ERROR: next_state = (in == 1'b1) ? IDLE : ERROR;
            IDLE:  next_state = (in == 1'b1) ? IDLE : START;
            START: next_state = DATA0;
            DATA0: next_state = DATA1;
            DATA1: next_state = DATA2;
            DATA2: next_state = DATA3;
            DATA3: next_state = DATA4;
            DATA4: next_state = DATA5;
            DATA5: next_state = DATA6;
            DATA6: next_state = DATA7;
            DATA7: next_state = (in == 1'b1) ? STOP : ERROR;
        endcase
    end
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state = IDLE;
        end else begin
            state <= next_state;
        end
    end
    assign done = (state == STOP);
endmodule
