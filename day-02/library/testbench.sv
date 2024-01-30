// Clone a Method
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

    // Clone method
    // Create sequence item method 1 and copy sequence item method 0 to sequence item method 1 at once
    $cast(seq_item_1, seq_item_0.clone()); 

    // Change the sequence item method 1 values will not reflect on sequence item method 0 
    seq_item_1.addr  = 5;
    seq_item_1.wdata = 'h5D;

    // Print sequence item method 0
    `uvm_info("", "Printing seq_item_0", UVM_LOW)
    seq_item_0.print();

    // Print sequence item method 1
    `uvm_info("", "Printing seq_item_1", UVM_LOW)
    seq_item_1.print();
  end
endmodule
