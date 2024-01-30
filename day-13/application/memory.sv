module memory #(
  parameter ADDR_WIDTH = 2,
  parameter DATA_WIDTH = 8
) (
  input clk,
  input reset,

  // Control signals
  input                       wr_en,
  input                       rd_en,

  // Address Signals
  input      [ADDR_WIDTH-1:0] addr,

  // Data signals
  input      [DATA_WIDTH-1:0] wdata,
  output reg [DATA_WIDTH-1:0] rdata
);

  // Memory
  reg [DATA_WIDTH-1:0] mem[2**ADDR_WIDTH];

  // Reset 
  always @(posedge reset) begin
    for (int i = 0; i < 2 ** ADDR_WIDTH; i++) begin
      mem[i] = 8'hFF;
    end
  end

  // Write data to Memory
  always @(posedge clk) begin
    if (wr_en) begin
      mem[addr] <= wdata;
    end
  end

  // Read data from Memory
  always @(posedge clk) begin
    if (rd_en) begin
      rdata <= mem[addr];
    end
  end
endmodule
