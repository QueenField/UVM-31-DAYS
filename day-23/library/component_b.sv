`include "sub_component_b_a.sv"

class component_b extends uvm_component;
  // Sub-Component B/A method instantiation
  sub_component_b_a                      sub_comp_b_a;

  // UVM Blocking Put Imp method instantiation
  uvm_blocking_put_export #(transaction) trans_in;

  // Utility declaration
  `uvm_component_utils(component_b)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_in = new("trans_in", this);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create component method
    sub_comp_b_a = sub_component_b_a::type_id::create("sub_comp_b_a", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    trans_in.connect(sub_comp_b_a.trans_in);
  endfunction
endclass
