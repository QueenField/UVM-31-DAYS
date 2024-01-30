// D Flip-Flop verified with UVM
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "sequence_item.sv"
`include "sequences.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor_in.sv"
`include "agent1.sv"
`include "monitor_out.sv"
`include "agent2.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

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

  // Virtual interface
  vif inter (clk, reset);

  // DUT instantiation
  dff dut (inter);

  initial begin
    // Passing the interface handle to lower heirarchy using set method
    uvm_config_db#(virtual vif)::set(null, "*", "interface", inter);

    // Enable wave dump
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  // Calling TestCase
  initial begin
    run_test("test");
  end
endmodule
