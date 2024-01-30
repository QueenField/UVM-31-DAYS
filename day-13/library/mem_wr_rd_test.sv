class mem_wr_rd_test extends mem_model_base_test;
  // Utility declaration
  `uvm_component_utils(mem_wr_rd_test)

  // Sequence method instantiation
  wr_rd_sequence seq;

  // Constructor
  function new(string name = "mem_wr_rd_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create sequence method
    seq = wr_rd_sequence::type_id::create("seq");
  endfunction : build_phase

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.mem_agnt.sequencer);
    phase.drop_objection(this);

    // Set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
endclass : mem_wr_rd_test
