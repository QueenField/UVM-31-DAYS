interface vif (
  input logic clk,
  input logic reset
);

  // Declaration of signals
  logic d;
  logic q;
  logic qb;

  // Modport dut
  modport dut(input clk, reset, d, output q, qb);

  // Modport testbench
  modport tb(input clk, reset, clocking cb);

  // Clocking block  
  clocking cb @(posedge clk);
    default input #2 output #1;
    output d;
    input q;
    input qb;
  endclocking
endinterface
