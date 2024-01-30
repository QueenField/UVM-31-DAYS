class basic_test extends uvm_test;
  // Environment method instantiation
  environment env;

  // Utility declaration
  `uvm_component_utils(basic_test)

  // Constructor
  function new(string name = "basic_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment method
    env = environment::type_id::create("env", this);
  endfunction
endclass
