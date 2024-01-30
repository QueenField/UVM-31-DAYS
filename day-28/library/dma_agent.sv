`include "dma_driver.sv"
`include "dma_sequencer.sv"
`include "dma_monitor.sv"

class dma_agent extends uvm_agent;
  // Driver method instantiation
  dma_driver    driver;

  // Sequencer method instantiation
  dma_sequencer sequencer;

  // Monitor method instantiation
  dma_monitor   monitor;

  // Utility declaration
  `uvm_component_utils(dma_agent)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create monitor method
    monitor = dma_monitor::type_id::create("monitor", this);

    // Create driver and sequencer methods only for active agent
    if (get_is_active() == UVM_ACTIVE) begin
      driver    = dma_driver::type_id::create("driver", this);
      sequencer = dma_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connecting the driver and sequencer port
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction
endclass
