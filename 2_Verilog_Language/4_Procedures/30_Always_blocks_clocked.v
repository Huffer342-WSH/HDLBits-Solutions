// synthesis verilog_input_version verilog_2001
/**
 * @brief   Build an XOR gate three ways, 
 *          using an assign statement, 
 *          a combinational always block, 
 *          and a clocked always block.
 */
module top_module(
           input clk,
           input a,
           input b,
           output wire out_assign,
           output reg out_always_comb,
           output reg out_always_ff   );

/**
 * @brief   assign statement
 */
assign out_assign = a ^ b;


/**
 * @brief   combinational always block
 */
always @(*) begin
    out_always_comb = a ^ b;
end


/**
 * @brief   clocked always block
 */
always @(posedge clk) begin
    out_always_ff <= a ^ b;
end

endmodule
