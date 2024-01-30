class agent extends uvm_agent;
  // Utility declaration
  `uvm_component_utils(agent)

  // Driver method instantiation
  driver  drv;

  // Sequence method instantiation
  seqcr   seqr;

  // Monitor method instantiation
  monitor mon;

  // Constructor
  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create driver and sequencer methods only for active agent
    if (get_is_active == UVM_ACTIVE) begin
      drv  = driver::type_id::create("drv", this);
      seqr = seqcr::type_id::create("seqr", this);
    end

    // Create monitor method
    mon = monitor::type_id::create("mon", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connecting the driver and sequencer port
    if (get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass
