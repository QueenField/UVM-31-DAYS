// Compare a Method
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_seq_item.sv"

// TestBench
module testbench;
  // Sequence Item method instantiation
  mem_seq_item seq_item_0;
  mem_seq_item seq_item_1;

  initial begin
    // Create Method
    seq_item_0 = mem_seq_item::type_id::create("seq_item_0");
    seq_item_1 = mem_seq_item::type_id::create("seq_item_1");

    // Match Case
    // Randomize seq_item_0
    seq_item_0.randomize();

    // Randomize sequence item method 1
    seq_item_1.randomize();

    // Print sequence item method 0
    seq_item_0.print();

    // Print sequence item method 1
    seq_item_1.print();

    // Compare Method
    if (seq_item_0.compare(seq_item_1)) begin
      `uvm_info("", "seq_item_0 matching with seq_item_1", UVM_LOW)
    end else begin
      `uvm_info("", "seq_item_0 is not matching with seq_item_1", UVM_LOW)
    end

    // Match Case
    // Copying sequence item method 0 to sequence item method 1
    seq_item_1.copy(seq_item_0);

    // Compare Method
    if (seq_item_0.compare(seq_item_1)) begin
      `uvm_info("", "seq_item_0 matching with seq_item_1", UVM_LOW)
    end else begin
      `uvm_info("", "seq_item_1 is not matching with seq_item_1", UVM_LOW)
    end
  end
endmodule
