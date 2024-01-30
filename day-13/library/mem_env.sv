`include "mem_agent.sv"
`include "mem_scoreboard.sv"

class mem_environment extends uvm_env;
  // Agent method instantiation
  mem_agent      mem_agnt;

  // Scoreboard method instantiation
  mem_scoreboard mem_scb;

  // Utility declaration
  `uvm_component_utils(mem_environment)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build phase 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create agent method
    mem_agnt = mem_agent::type_id::create("mem_agnt", this);

    // Create scoreboard method
    mem_scb  = mem_scoreboard::type_id::create("mem_scb", this);
  endfunction : build_phase

  // Connect phase 
  function void connect_phase(uvm_phase phase);
    mem_agnt.monitor.item_collected_port.connect(mem_scb.item_collected_export);
  endfunction : connect_phase
endclass : mem_environment
