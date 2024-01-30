// Non Blocking TLM FIFO
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "basic_test.sv"

module testbench;
  // Calling TestCase
  initial begin
    run_test("basic_test");
  end
endmodule
