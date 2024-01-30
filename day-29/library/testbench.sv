// Adder Model verified with UVM
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "base_test.sv"

module testbench;
  // Clock and Reset declaration
  bit clk;
  bit reset;

  // Clock Generation
  always #2 clk = ~clk;

  // Reset Generation
  initial begin
    reset = 1;
    #5;
    reset = 0;
  end

  // Interface instantiation
  add_if vif (clk, reset);

  // DUT instantiation
  adder dut (
    .clk  (vif.clk),
    .reset(vif.reset),
    .in1  (vif.ip1),
    .in2  (vif.ip2),
    .out  (vif.out)
  );

  initial begin
    // Passing the interface handle to lower heirarchy using set method
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);

    // Enable wave dump
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

  // Calling TestCase
  initial begin
    run_test("base_test");
  end
endmodule
