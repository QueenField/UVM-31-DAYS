// dma_sequence
class dma_sequence extends uvm_sequence #(dma_seq_item);
  // Utility declaration
  `uvm_object_utils(dma_sequence)

  // Constructor
  function new(string name = "dma_sequence");
    super.new(name);
  endfunction

  `uvm_declare_p_sequencer(dma_sequencer)

  // Create, randomize and send the item to driver
  virtual task body();
    repeat (2) begin
      req = dma_seq_item::type_id::create("req");
      wait_for_grant();
      req.randomize();
      send_request(req);
      wait_for_item_done();
    end
  endtask
endclass

// Write_sequence 
class write_sequence extends uvm_sequence #(dma_seq_item);
  // Utility declaration
  `uvm_object_utils(write_sequence)

  // Constructor
  function new(string name = "write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do_with(req, {req.wr_en==1;})
  endtask
endclass

// Read_sequence
class read_sequence extends uvm_sequence #(dma_seq_item);
  // Utility declaration
  `uvm_object_utils(read_sequence)

  // Constructor
  function new(string name = "read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do_with(req, {req.wr_en==0;})
  endtask
endclass
