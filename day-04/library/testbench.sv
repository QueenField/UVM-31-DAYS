// Copy a Method
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_seq_item.sv"

// TestBench
module testbench;
  // Sequence Item method instantiation
  mem_seq_item seq_item_0;
  mem_seq_item seq_item_1;

  initial begin
    // Create sequence item method
    seq_item_0 = mem_seq_item::type_id::create("seq_item_0");
    seq_item_1 = mem_seq_item::type_id::create("seq_item_1");

    // Randomize sequence item method 0
    seq_item_0.randomize();

    // Print sequence item method 0
    seq_item_0.print();

    // Copying sequence item method 0 to sequence item method 1
    seq_item_1.copy(seq_item_0);

    // Print sequence item method 1
    seq_item_1.print();
  end
endmodule
