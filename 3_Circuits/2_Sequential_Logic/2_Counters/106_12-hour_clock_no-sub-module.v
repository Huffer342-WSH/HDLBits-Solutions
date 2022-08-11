module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            ss[7:0] <= 8'h00;
        end else begin
            if (ena == 1'b0) begin
                ss[7:0] <= ss[7:0];
            end else begin
                if (ss[7:0] == 8'h59) begin
                    ss[7:0] <= 8'h00;
                end else begin
                    ss[7:0] <= ss[7:0] + (ss[3:0] == 4'h9 ? 8'h7 : 8'h1);
                end
            end
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            mm[7:0] <= 8'h00;
        end else begin
            if (ena == 1'b0 | ss[7:0] != 8'h59) begin
                mm[7:0] <= mm[7:0];
            end else begin
                if (mm[7:0] == 8'h59) begin
                    mm[7:0] <= 8'h00;
                end else begin
                    mm[7:0] <= mm[7:0] + (mm[3:0] == 4'h9 ? 8'h7 : 8'h1);
                end
            end
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            hh[7:0] <= 8'h12;
        end else begin
            if (ena == 1'b0 | mm[7:0] != 8'h59 | ss[7:0] != 8'h59) begin
                hh[7:0] <= hh[7:0];
            end else begin
                if (hh[7:0] == 8'h12) begin
                    hh[7:0] <= 8'h01;
                end else begin
                    hh[7:0] <= hh[7:0] + (hh[3:0] == 4'h9 ? 8'h7 : 8'h1);
                end
            end
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            pm <= 1'b0;
        end
        if ({hh, mm, ss} == 24'h115959 && ena == 1'b1) begin
            pm <= ~pm;
        end else begin
            pm <= pm;
        end
    end

endmodule
