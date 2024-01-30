`include "dma_agent.sv"

class dma_model_env extends uvm_env;
  // Agent method instantiation
  dma_agent dma_agnt;

  // Utility declaration
  `uvm_component_utils(dma_model_env)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create agent method
    dma_agnt = dma_agent::type_id::create("dma_agnt", this);
  endfunction
endclass
