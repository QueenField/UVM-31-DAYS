// UVM Event wait_ptrigger
`include "uvm_macros.svh"
import uvm_pkg::*;

module testbench;
  // Event method instantiation
  uvm_event event_1 = new();

  initial begin
    fork
      $display("===========================================================================");
      // Triggers the event
      begin
        $display($time, " Triggering The Event");
        event_1.trigger;
      end

      // Wait for event to trigger
      begin
        $display($time, " Waiting for the event to trigger");
        event_1.wait_ptrigger;
        $display($time, " Event Triggered");
      end
    join
  end

  initial begin
    #50;
    $display($time, " Ending the simulation");
    $display("=============================================================================");
    $finish;
  end
endmodule
