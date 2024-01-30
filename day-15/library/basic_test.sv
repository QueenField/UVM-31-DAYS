`include "environment.sv"

class basic_test extends uvm_test;
  // Utility declaration
  `uvm_component_utils(basic_test)

  // Environment method instantiation
  environment env;

  // Constructor
  function new(string name = "basic_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment method
    env = environment::type_id::create("env", this);
  endfunction : build_phase

  // End of elaboration phase
  virtual function void end_of_elaboration();
    // Print topology
    print(); 
  endfunction : end_of_elaboration
endclass
