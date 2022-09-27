module top_module (
    input            clk,
    input            reset,
    input      [3:1] s,
    output reg       fr3,
    output reg       fr2,
    output reg       fr1,
    output           dfr
);

    parameter reg [1:0] STATE_UP = 2'b01;
    parameter reg [1:0] STATE_DOWM = 2'b10;

    reg [1:0] state_curn, state_next;
    reg [3:1] s_prev;
    always @(*) begin
        if (s > s_prev) state_next = STATE_UP;
        else if (s < s_prev) state_next = STATE_DOWM;
        else state_next = state_curn;
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state_curn <= STATE_DOWM;
            s_prev <= 3'b000;
        end else begin
            state_curn <= state_next;
            s_prev <= s;
        end
    end


    always @(posedge clk) begin
        if (reset == 1'b1) begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b1;
        end else begin
            fr1 <= ~s[3];
            fr2 <= ~s[2];
            fr3 <= ~s[1];
        end
    end

    assign dfr = (state_curn == STATE_DOWM) ? 1'b1 : 1'b0;
endmodule
