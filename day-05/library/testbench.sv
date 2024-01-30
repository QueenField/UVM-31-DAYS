// Pack/Unpack to Array of Bit Type
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_seq_item.sv"

// TestBench
module testbench;
  // Sequence Item method instantiation
  mem_seq_item seq_item_0;
  mem_seq_item seq_item_1;

  bit          bit_packed_data[];

  initial begin
    // Create sequence item method
    seq_item_0 = mem_seq_item::type_id::create("seq_item_0");
    seq_item_1 = mem_seq_item::type_id::create("seq_item_1");

    // PACK
    // Randomize sequence item method 0
    seq_item_0.randomize();

    // Print sequence item method 0
    seq_item_0.print();

    // Pack sequence item method 0
    seq_item_0.pack(bit_packed_data);
    foreach (bit_packed_data[i]) begin
      `uvm_info("PACK", $sformatf("bit_packed_data[%0d]= %0b", i, bit_packed_data[i]), UVM_LOW)
    end

    // UNPACK
    // Print sequence item method 1
    `uvm_info("UNPACK", "Before UnPack", UVM_LOW)
    seq_item_1.print();

    // Unpack sequence item method 1
    seq_item_1.unpack(bit_packed_data);

    // Print sequence item method 1
    `uvm_info("UNPACK", "After UnPAck", UVM_LOW)
    seq_item_1.print();
  end
endmodule
