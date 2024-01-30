class dma_reg_test extends dma_model_base_test;
  // Utility declaration
  `uvm_component_utils(dma_reg_test)

  // Register method instantiation
  dma_reg_seq reg_seq;

  // Constructor
  function new(string name = "dma_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create sequence method
    reg_seq = dma_reg_seq::type_id::create("reg_seq");
  endfunction : build_phase

  // Run phase
  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    if (!reg_seq.randomize()) begin
      `uvm_error("", "Randomize failed")
    end

    // Setting sequence in reg_seq
    reg_seq.regmodel       = env.regmodel;
    reg_seq.starting_phase = phase;
    reg_seq.start(env.dma_agnt.sequencer);
    phase.drop_objection(this);

    // Set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
endclass : dma_reg_test
