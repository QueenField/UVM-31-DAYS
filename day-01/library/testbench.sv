// Create and Print a Method
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_seq_item.sv"

// TestBench
module testbench;
  // Sequence Item method instantiation
  mem_seq_item seq_item;

  initial begin
    // Create sequence item method
    seq_item = mem_seq_item::type_id::create();

    // Randomize sequence item method
    seq_item.randomize();

    // Print sequence item method
    seq_item.print();
  end
endmodule
