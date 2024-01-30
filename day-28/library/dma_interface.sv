interface dma_if (
  input logic clk,
  input logic reset
);

  // Declaration of signals
  logic [31:0] addr;
  logic        wr_en;
  logic        valid;
  logic [31:0] wdata;
  logic [31:0] rdata;

  // Driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output addr;
    output wr_en;
    output valid;
    output wdata;
    input rdata;
  endclocking

  // Monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input addr;
    input wr_en;
    input valid;
    input wdata;
    input rdata;
  endclocking

  // Driver modport
  modport DRIVER(clocking driver_cb, input clk, reset);

  // Monitor modport  
  modport MONITOR(clocking monitor_cb, input clk, reset);

endinterface
