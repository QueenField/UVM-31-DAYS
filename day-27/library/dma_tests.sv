`include "dma_env.sv"
`include "dma_sequence.sv"

class dma_reg_test extends uvm_test;
  // Utility declaration
  `uvm_component_utils(dma_reg_test)

  // Environment method instantiation
  dma_model_env  env;

  // Sequence method instantiation
  write_sequence wr_seq;
  read_sequence  rd_seq;

  // Constructor
  function new(string name = "dma_reg_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment method
    env    = dma_model_env::type_id::create("env", this);

    // Create sequence method
    wr_seq = write_sequence::type_id::create("wr_seq");

    // Create sequence method
    rd_seq = read_sequence::type_id::create("rd_seq");
  endfunction

  // End of elobaration phase
  virtual function void end_of_elaboration();
    // Print the topology
    print();
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    wr_seq.t_addr = `INTR_SFR_ADDR;
    wr_seq.t_data = 32'hFFFF_0F0F;
    wr_seq.start(env.dma_agnt.sequencer);

    wr_seq.t_addr = `CTRL_SFR_ADDR;
    wr_seq.t_data = 32'h1234_5678;
    wr_seq.start(env.dma_agnt.sequencer);

    wr_seq.t_addr = `IO_ADDR_SFR_ADDR;
    wr_seq.t_data = 32'hABCD_EF12;
    wr_seq.start(env.dma_agnt.sequencer);

    wr_seq.t_addr = `MEM_ADDR_SFR_ADDR;
    wr_seq.t_data = 32'h9731_2345;
    wr_seq.start(env.dma_agnt.sequencer);

    rd_seq.t_addr = `INTR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);

    rd_seq.t_addr = `CTRL_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);

    rd_seq.t_addr = `IO_ADDR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);

    rd_seq.t_addr = `MEM_ADDR_SFR_ADDR;
    rd_seq.start(env.dma_agnt.sequencer);
    phase.drop_objection(this);
  endtask
endclass
