class environment extends uvm_env;
  // Utility declaration
  `uvm_component_utils(environment)

  // Agent method instantiation
  agent      agt;

  // Scoreboard method instantiation
  scoreboard sb;

  // Constructor
  function new(string name = "environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create agent method
    agt = agent::type_id::create("agt", this);

    // Create scoreboard method
    sb  = scoreboard::type_id::create("sb", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    agt.mon.item_collect_port.connect(sb.item_collect_export);
  endfunction
endclass
