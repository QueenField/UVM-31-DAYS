`include "seq_item.sv"
`include "base_seq.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "environment.sv"

class base_test extends uvm_test;
  // Environment method instantiation
  environment env_o;

  // Sequence method instantiation
  base_seq bseq;

  // Utility declaration
  `uvm_component_utils(base_test)

  // Constructor
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment method
    env_o = environment::type_id::create("env_o", this);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Create sequence method
    bseq = base_seq::type_id::create("bseq");

    repeat (10) begin
      #5;
      bseq.start(env_o.agt.seqr);
    end

    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of TestCase", UVM_LOW);
  endtask
endclass
