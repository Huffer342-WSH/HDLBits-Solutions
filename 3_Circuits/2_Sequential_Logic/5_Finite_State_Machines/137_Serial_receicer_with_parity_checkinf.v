module top_module (
    input        clk,
    input        in,
    input        reset,     // Synchronous reset
    output [7:0] out_byte,
    output       done
);  //

    // Use FSM from Fsm_serial
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
    parameter reg [3:0] PARITY = 4'b1111;
    parameter reg [3:0] ERROR = 4'b1110;
    parameter reg [3:0] IDLE = 4'b1010;

    reg [3:0] state, next_state;
    reg odd;
    always @(*) begin
        case (state)
            STOP:    next_state = (in == 1'b1) ? IDLE : START;
            ERROR:   next_state = (in == 1'b1) ? IDLE : ERROR;
            IDLE:    next_state = (in == 1'b1) ? IDLE : START;
            START:   next_state = DATA0;
            DATA0:   next_state = DATA1;
            DATA1:   next_state = DATA2;
            DATA2:   next_state = DATA3;
            DATA3:   next_state = DATA4;
            DATA4:   next_state = DATA5;
            DATA5:   next_state = DATA6;
            DATA6:   next_state = DATA7;
            DATA7:   next_state = PARITY;
            PARITY:  next_state = (in == 1'b1) ? STOP : ERROR;
            default: next_state = IDLE;
        endcase
    end
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    always @(posedge clk) begin
        if (next_state == DATA0) begin
            odd <= in;
        end else begin
            if (in == 1'b1) odd <= ~odd;
        end
    end
    assign done = (state == STOP && odd == 1'b0);


    // New: Datapath to latch input bits.
    /* LSB 先发低位 */
    reg [9:0] data;
    always @(posedge clk) begin
        data[9:0] <= {in, data[9:1]};
    end
    assign out_byte = data[7:0];
    // assign out_byte = {state, 3'b000, odd};
    // New: Add parity checking.

endmodule
