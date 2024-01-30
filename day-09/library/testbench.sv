// Sequence with macro uvm_do
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_sequence.sv"

// TestBench
module testbench;
  // Sequence method instantiation
  mem_sequence memory_sequence;
  
  initial begin
    // Create sequence method
    memory_sequence = mem_sequence::type_id::create("mem_sequence");
  end
endmodule
