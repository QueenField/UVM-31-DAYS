class environment extends uvm_env;
  // Driver method instantiation
  driver driv;

  // Utility declaration
  `uvm_component_utils(environment)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create driver method
    driv = driver::type_id::create("driv", this);
  endfunction
endclass
