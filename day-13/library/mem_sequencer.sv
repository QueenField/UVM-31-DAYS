class mem_sequencer extends uvm_sequencer #(mem_seq_item);
  // Utility declaration
  `uvm_component_utils(mem_sequencer)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass : mem_sequencer
