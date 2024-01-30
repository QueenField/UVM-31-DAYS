// UVM Event Example
`include "uvm_macros.svh"
import uvm_pkg::*;

module testbench;
  // 1. Declaring the event
  uvm_event event_1;

  initial begin
    // 2. Creating the event
    event_1 = new();

    fork
      // Triggers the event
      begin
        $display("================================================================");
        #50 $display($time, " Triggering the event");
        // 4. Trigger the event
        event_1.trigger;
      end

      // Wait for event to trigger
      begin
        $display($time, " waiting for the event to trigger");
        // 3. Waiting for event trigger
        event_1.wait_trigger;
        $display($time, " Event Triggered");
        $display("===============================================================");
      end
    join
  end
endmodule
