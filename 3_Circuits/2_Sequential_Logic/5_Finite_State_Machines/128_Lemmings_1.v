module top_module (
    input  clk,
    input  areset,      // Freshly brainwashed Lemmings walk left.
    input  bump_left,
    input  bump_right,
    output walk_left,
    output walk_right
);

  // parameter LEFT=0, RIGHT=1, ...
  parameter reg LEFT = 1'b1;
  parameter reg RIGHT = 1'b0;

  reg state, next_state;

  always @(*) begin
    // State transition logic
    case (state)
      LEFT: begin
        if (bump_left == 1'b1) next_state = RIGHT;
        else next_state = LEFT;
      end
      RIGHT: begin
        if (bump_right == 1'b1) next_state = LEFT;
        else next_state = RIGHT;
      end
      default: next_state = state;
    endcase
  end

  always @(posedge clk, posedge areset) begin
    // State flip-flops with asynchronous reset
    if (areset == 1'b1) begin
      state <= LEFT;
    end else begin
      state <= next_state;
    end
  end

  // Output logic
  // assign walk_left = (state == ...);
  // assign walk_right = (state == ...);
  assign walk_left  = (state == LEFT) ? 1'b1 : 1'b0;
  assign walk_right = (state == RIGHT) ? 1'b1 : 1'b0;

endmodule
