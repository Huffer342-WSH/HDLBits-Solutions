module top_module (
    input  clk,
    input  in,
    input  reset,
    output out
);  //


  parameter reg [3:0] A = 4'b0001;
  parameter reg [3:0] B = 4'b0010;
  parameter reg [3:0] C = 4'b0100;
  parameter reg [3:0] D = 4'b1000;
  reg [3:0] state;
  reg [3:0] next_state;
  // State  ransition logic
  always @(*) begin
    case (state)
      A:       next_state = in ? B : A;
      B:       next_state = in ? B : C;
      C:       next_state = in ? D : A;
      D:       next_state = in ? B : C;
      default: next_state = A;
    endcase
  end
  // State flip-flops with synchronous reset

  always @(posedge clk) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  // Output logic
  assign out = (state == D);

endmodule
