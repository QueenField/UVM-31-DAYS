`include "transaction.sv"
`include "component_a.sv"
`include "component_b.sv"

class basic_test extends uvm_test;
  // Utility declaration
  `uvm_component_utils(basic_test)

  // Components method instantiation
  component_a cmp_a;
  component_b cmp_b;

  // Constructor 
  function new(string name = "basic_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create component method
    cmp_a = component_a::type_id::create("cmp_a", this);
    cmp_b = component_b::type_id::create("cmp_b", this);
  endfunction : build_phase

  // End of eloboration phase 
  virtual function void end_of_elaboration();
    // Print topology
    print();
  endfunction
endclass : basic_test
