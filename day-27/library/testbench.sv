// Register Access without RAL Model
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "dma_sfr_defines.sv"
`include "dma_interface.sv"
`include "dma_tests.sv"

module testbench;
  // Clock and Reset declaration
  bit clk;
  bit reset;

  // Clock Generation
  always #5 clk = ~clk;

  // Reset Generation
  initial begin
    reset = 1;
    #5;
    reset = 0;
  end

  // Interface instantiation
  dma_if intf (clk, reset);

  // DUT instantiation
  dma dut (
    .clk  (intf.clk),
    .reset(intf.reset),
    .addr (intf.addr),
    .wr_en(intf.wr_en),
    .valid(intf.valid),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
  );

  initial begin
    // Passing the interface handle to lower heirarchy using set method
    uvm_config_db#(virtual dma_if)::set(uvm_root::get(), "*", "vif", intf);
  end

  // Calling TestCase
  initial begin
    run_test();
  end

  // Wave dump
  //   initial begin
  //     $dumpfile("dump.vcd");
  //     $dumpvar;
  //   end

endmodule
