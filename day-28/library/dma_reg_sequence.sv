//  Register Access Sequence
class dma_reg_seq extends uvm_sequence;
  // Utility declaration
  `uvm_object_utils(dma_reg_seq)

  // Instance
  dma_reg_model regmodel;

  // Constructor
  function new(string name = "");
    super.new(name);
  endfunction

  // Sequence body
  task body;
    // Instance
    uvm_status_e          status;
    uvm_reg_data_t        incoming;

    // Data Signals
    bit            [31:0] rdata;

    if (starting_phase != null) begin
      starting_phase.raise_objection(this);
    end

    // Write to the Registers
    regmodel.reg_intr.write(status, 32'h1234_1234);
    regmodel.reg_ctrl.write(status, 32'h1234_5678);
    regmodel.reg_io_addr.write(status, 32'h1234_9ABC);
    regmodel.reg_mem_addr.write(status, 32'h1234_DEF0);

    // Read from the Registers
    regmodel.reg_intr.read(status, rdata);
    regmodel.reg_ctrl.read(status, rdata);
    regmodel.reg_io_addr.read(status, rdata);
    regmodel.reg_mem_addr.read(status, rdata);

    if (starting_phase != null) begin
      starting_phase.drop_objection(this);
    end
  endtask
endclass
