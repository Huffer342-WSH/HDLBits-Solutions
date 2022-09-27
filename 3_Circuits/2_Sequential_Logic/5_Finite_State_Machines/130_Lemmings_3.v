module top_module (
    input      clk,
    input      areset,      // Freshly brainwashed Lemmings walk left.
    input      bump_left,
    input      bump_right,
    input      ground,
    input      dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

  parameter reg [5:0] LEFT = 6'b000001;
  parameter reg [5:0] DIG_L = 6'b000010;
  parameter reg [5:0] FALL_L = 6'b000100;
  parameter reg [5:0] RIGHT = 6'b001000;
  parameter reg [5:0] FALL_R = 6'b010000;
  parameter reg [5:0] DIG_R = 6'b100000;

  reg [5:0] state;
  reg [5:0] next_state;

  always @(*) begin
    case (state)
      LEFT: begin
        if (ground == 1'b0) next_state = FALL_L;
        else if (dig == 1'b1) next_state = DIG_L;
        else if (bump_left == 1'b1) next_state = RIGHT;
        else next_state = LEFT;
      end
      DIG_L: begin
        if (ground == 1'b1) next_state = DIG_L;
        else next_state = FALL_L;
      end
      FALL_L: begin
        if (ground == 1'b1) next_state = LEFT;
        else next_state = FALL_L;
      end
      RIGHT: begin
        if (ground == 1'b0) next_state = FALL_R;
        else if (dig == 1'b1) next_state = DIG_R;
        else if (bump_right == 1'b1) next_state = LEFT;
        else next_state = RIGHT;
      end
      DIG_R: begin
        if (ground == 1'b1) next_state = DIG_R;
        else next_state = FALL_R;
      end
      FALL_R: begin
        if (ground == 1'b1) next_state = RIGHT;
        else next_state = FALL_R;
      end
      default: next_state = state;
    endcase
  end

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= LEFT;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      LEFT: begin
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
      end
      DIG_L: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b1;
      end
      FALL_L: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
        digging = 1'b0;
      end
      RIGHT: begin
        walk_left = 1'b0;
        walk_right = 1'b1;
        aaah = 1'b0;
        digging = 1'b0;
      end
      DIG_R: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b1;
      end
      FALL_R: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
        digging = 1'b0;
      end
    endcase

  end
endmodule
