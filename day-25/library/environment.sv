`include "transaction.sv"
`include "component_a.sv"
`include "component_b.sv"

class environment extends uvm_env;
  // Component method instantiation
  component_a                 comp_a;
  component_b                 comp_b;

  // TLM FIFO declaration
  uvm_tlm_fifo #(transaction) fifo_ab;

  // Utility declaration
  `uvm_component_utils(environment)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create component method
    comp_a  = component_a::type_id::create("comp_a", this);
    comp_b  = component_b::type_id::create("comp_b", this);

    fifo_ab = new("fifo_ab", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    comp_a.trans_out.connect(fifo_ab.put_export);
    comp_b.trans_in.connect(fifo_ab.get_export);
  endfunction
endclass
