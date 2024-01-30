// UVM CallBack
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "driver.sv"
`include "environment.sv"
`include "basic_test.sv"

program testbench;
  // Calling TestCase
  initial begin
    run_test();
  end
endprogram
