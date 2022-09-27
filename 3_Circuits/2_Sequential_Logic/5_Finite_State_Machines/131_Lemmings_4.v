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

  parameter reg [6:0] LEFT = 7'b0000001;
  parameter reg [6:0] DIG_L = 7'b0000010;
  parameter reg [6:0] FALL_L = 7'b0000100;
  parameter reg [6:0] RIGHT = 7'b0001000;
  parameter reg [6:0] FALL_R = 7'b0010000;
  parameter reg [6:0] DIG_R = 7'b0100000;
  parameter reg [6:0] SPLAT = 7'b1000000;


  reg [6:0] state;
  reg [6:0] next_state;
  reg [4:0] count_falling;
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
        if (ground == 1'b1) begin
          if (count_falling > 5'd19) next_state = SPLAT;
          else next_state = LEFT;
        end else next_state = FALL_L;
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
        if (ground == 1'b1) begin
          if (count_falling > 5'd19) next_state = SPLAT;
          else next_state = RIGHT;
        end else next_state = FALL_R;
      end
      SPLAT:   next_state = SPLAT;
      default: next_state = SPLAT;
    endcase
  end

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= LEFT;
    end else begin
      if (state == FALL_L || state == FALL_R) begin
        if (count_falling >= 5'd20) count_falling <= count_falling;  //防止越界
        else count_falling <= count_falling + 5'b1;
        state <= next_state;
      end else begin
        count_falling <= 5'b0;
        state <= next_state;
      end
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
      SPLAT: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
      end
    endcase

  end
endmodule
