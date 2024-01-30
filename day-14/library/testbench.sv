// UVM Barrier Example
`include "uvm_macros.svh"
import uvm_pkg::*;

module testbench;
  // Barrier method instantiation
  uvm_barrier target_barrier;

  initial begin
    // Constructor
    target_barrier = new("target_barrier", 3);

    fork
      begin
        // Process 1
        $display($time, " Inside the process a");
        #50 $display($time, " process a completed");
        $display($time, " process a waiting for barrier");
        target_barrier.wait_for();
        $display($time, " process a after wait for");
      end
      begin
        // Process 2
        $display($time, " Inside the process b");
        #50 $display($time, " process b completed");
        $display($time, " process b waiting for barrier");
        target_barrier.wait_for();
        $display($time, " process b after wait for");
      end
      begin
        // Process 3
        $display($time, " Inside the process c");
        #70 $display($time, " process c completed");
        $display($time, " process c waiting for barrier");
        target_barrier.wait_for();
        $display($time, " process c after wait for");
      end
      begin
        // Process 4
        $display($time, " Inside the process a");
        #30 $display($time, " process d completed");
        $display($time, " process d waiting for barrier");
        target_barrier.wait_for();
        $display($time, " process d after wait for");
      end
    join
  end
endmodule
