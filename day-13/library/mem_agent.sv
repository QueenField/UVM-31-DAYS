`include "mem_seq_item.sv"
`include "mem_sequencer.sv"
`include "mem_sequence.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"

class mem_agent extends uvm_agent;
  // Driver method instantiation
  mem_driver    driver;

  // Sequencer method instantiation
  mem_sequencer sequencer;

  // Monitor method instantiation
  mem_monitor   monitor;

  // Utility declaration
  `uvm_component_utils(mem_agent)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create monitor method
    monitor = mem_monitor::type_id::create("monitor", this);

    // Create driver and sequencer methods only for active agent
    if (get_is_active() == UVM_ACTIVE) begin
      driver    = mem_driver::type_id::create("driver", this);
      sequencer = mem_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connecting the driver and sequencer port
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase
endclass : mem_agent
