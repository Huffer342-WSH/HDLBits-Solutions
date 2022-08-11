// synthesis verilog_input_version verilog_2001
module top_module (
    input       a,
    input       b,
    output wire out_assign,
    output reg  out_alwaysblock
);

    //And gate with assign
    assign out_assign = a & b;

    //And gate with combinatinal alway blocks
    always @(*) begin
        out_alwaysblock = a & b;
    end


endmodule
