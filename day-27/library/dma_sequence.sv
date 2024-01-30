// dma_sequence
class dma_sequence extends uvm_sequence #(dma_seq_item);
  // Utility declaration
  `uvm_object_utils(dma_sequence)

  // Constructor
  function new(string name = "dma_sequence");
    super.new(name);
  endfunction

  `uvm_declare_p_sequencer(dma_sequencer)

  // Sequence body
  virtual task body();
    repeat (2) begin
      // Create sequence method
      req = dma_seq_item::type_id::create("req");
      wait_for_grant();

      // Randomize sequence method
      req.randomize();

      send_request(req);
      wait_for_item_done();
    end
  endtask
endclass

// write_sequence
class write_sequence extends uvm_sequence #(dma_seq_item);
  bit [31:0] t_addr, t_data;

  // Utility declaration
  `uvm_object_utils(write_sequence)

  // Constructor
  function new(string name = "write_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do_with(req, {req.wr_en==1;req.addr==t_addr;req.wdata==t_data;})
  endtask
endclass

// read_sequence
class read_sequence extends uvm_sequence #(dma_seq_item);
  bit [31:0] t_addr;

  // Utility declaration
  `uvm_object_utils(read_sequence)

  // Constructor
  function new(string name = "read_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do_with(req, {req.wr_en==0;req.addr==t_addr;})
  endtask
endclass
