class agent2 extends uvm_agent;
  // Utility declaration
  `uvm_component_utils(agent2)

  // Monitor method instantiation
  monitor_out mout;

  // Constructor
  function new(string name = "agent2", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    // Create monitor method
    mout = monitor_out::type_id::create("mout", this);

    `uvm_info(get_type_name, $sformatf("agent2"), UVM_LOW)
  endfunction
endclass
