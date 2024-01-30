module adder (
  input            clk,
  input            reset,
  input      [7:0] in1,
  input      [7:0] in2,
  output reg [8:0] out
);

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      out <= 0;
    end else begin
      out <= in1 + in2;
    end
  end
endmodule
