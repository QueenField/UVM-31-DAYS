module dma #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32
) (
  input clk,
  input reset,

  // Control signals
  input                  wr_en,
  input                  valid,

  // Address Signals
  input [ADDR_WIDTH-1:0] addr,

  // Data signals
  input  [DATA_WIDTH-1:0] wdata,
  output [DATA_WIDTH-1:0] rdata
);

  logic [DATA_WIDTH-1:0] t_data;

  reg   [DATA_WIDTH-1:0] intr;
  reg   [DATA_WIDTH-1:0] control;
  reg   [DATA_WIDTH-1:0] io_address;
  reg   [DATA_WIDTH-1:0] mem_address;

  // Reset
  always @(posedge reset) begin
    intr        <= 0;
    control     <= 0;
    io_address  <= 0;
    mem_address <= 0;
  end

  assign rdata = t_data;

  always @(posedge clk) begin
    if (wr_en & valid) begin
      if (addr == 32'h400) begin
        intr <= wdata;
      end else if (addr == 32'h404) begin
        control <= wdata;
      end else if (addr == 32'h408) begin
        io_address <= wdata;
      end else if (addr == 32'h40C) begin
        mem_address <= wdata;
      end

      $display("Design WR addr %0h Data %0h", addr, wdata);
    end else if (!wr_en & valid) begin
      if (addr == 32'h400) begin
        t_data = intr;
      end else if (addr == 32'h404) begin
        t_data = control;
      end else if (addr == 32'h408) begin
        t_data = io_address;
      end else if (addr == 32'h40C) begin
        t_data = mem_address;
      end

      $display("Design RD addr %0h Data %0h", addr, t_data);
    end
  end
endmodule
