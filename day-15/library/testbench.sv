// UVM HeartBeat
`include "uvm_macros.svh"
import uvm_pkg::*;

uvm_callbacks_objection target_objection;

`include "basic_test.sv"

module testbench;
  // Calling TestCase
  initial begin
    target_objection = new("target_objection");
    run_test("basic_test");
  end
endmodule
