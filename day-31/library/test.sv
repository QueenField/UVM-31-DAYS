class test extends uvm_test;
  // Utility declaration
  `uvm_component_utils(test)

  // Sequence method instantiation
  sequences   seq;

  // Environment method instantiation
  environment env;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    // Create sequence method
    seq = sequences::type_id::create("seq", this);

    // Create environment method
    env = environment::type_id::create("env", this);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat (5) begin
      #5;
      seq.start(env.ag1.sr);
      `uvm_info(get_type_name(), $sformatf("hello"), UVM_NONE)
    end
    phase.drop_objection(this);
  endtask
endclass
