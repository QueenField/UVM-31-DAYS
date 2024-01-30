class agent1 extends uvm_agent;
  // Utility declaration
  `uvm_component_utils(agent1)

  // Driver method instantiation
  driver     dr;

  // Monitor method instantiation
  monitor_in min;

  // Sequencer method instantiation
  sequencer  sr;

  // Constructor
  function new(string name = "agent1", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    // Create sequence method
    sr  = sequencer::type_id::create("sr", this);

    // Create monitor method
    min = monitor_in::type_id::create("min", this);

    // Create driver method
    dr  = driver::type_id::create("dr", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connecting the driver and sequencer port
    dr.seq_item_port.connect(sr.seq_item_export);

    `uvm_info(get_type_name, $sformatf("agent1"), UVM_LOW)
  endfunction
endclass
