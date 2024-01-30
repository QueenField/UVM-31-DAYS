class dma_sequencer extends uvm_sequencer #(dma_seq_item);
  // Utility declaration
  `uvm_component_utils(dma_sequencer)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
