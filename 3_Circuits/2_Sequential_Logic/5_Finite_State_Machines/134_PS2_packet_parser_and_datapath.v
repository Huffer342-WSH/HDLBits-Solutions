module top_module (
    input             clk,
    input      [ 7:0] in,
    input             reset,      // Synchronous reset
    output reg [23:0] out_bytes,
    output            done
);  //

    // FSM from fsm_ps2
    parameter reg [1:0] BYTE1 = 2'b00;
    parameter reg [1:0] BYTE2 = 2'b01;
    parameter reg [1:0] BYTE3 = 2'b11;
    parameter reg [1:0] DONE = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[3] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[3] == 1'b1) ? BYTE2 : BYTE1;
        endcase
    end


    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset == 1'b1) state <= BYTE1;
        else begin
            state <= next_state;
        end
    end


    // Output logic
    assign done = (state == DONE) ? 1'b1 : 1'b0;


    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        out_bytes[23:8] <= out_bytes[15:0];
        out_bytes[7:0]  <= in[7:0];
    end

endmodule
