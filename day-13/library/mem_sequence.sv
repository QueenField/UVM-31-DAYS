class mem_sequence extends uvm_sequence #(mem_seq_item);
  // Utility declaration
  `uvm_object_utils(mem_sequence)

  // Constructor
  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  `uvm_declare_p_sequencer(mem_sequencer)

  // Sequence body
  virtual task body();
    repeat (2) begin
      // Create sequence method
      req = mem_seq_item::type_id::create("req");

      wait_for_grant();

      // Randomize sequence method
      req.randomize();

      send_request(req);
      wait_for_item_done();
    end
  endtask
endclass

// Write_sequence
class write_sequence extends uvm_sequence #(mem_seq_item);
  // Utility declaration
  `uvm_object_utils(write_sequence)

  // Constructor
  function new(string name = "write_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do_with(req, {req.wr_en==1;})
  endtask
endclass

// Read_sequence
class read_sequence extends uvm_sequence #(mem_seq_item);
  // Utility declaration
  `uvm_object_utils(read_sequence)

  // Constructor
  function new(string name = "read_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do_with(req, {req.rd_en==1;})
  endtask
endclass

// Write Read sequence
class write_read_sequence extends uvm_sequence #(mem_seq_item);
  // Utility declaration
  `uvm_object_utils(write_read_sequence)

  // Constructor
  function new(string name = "write_read_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do_with(req, {req.wr_en==1;})
    `uvm_do_with(req, {req.rd_en==1;})
  endtask
endclass

// WR RD sequence 
class wr_rd_sequence extends uvm_sequence #(mem_seq_item);
  // Sequence method instantiation
  write_sequence wr_seq;
  read_sequence  rd_seq;

  // Utility declaration
  `uvm_object_utils(wr_rd_sequence)

  // Constructor
  function new(string name = "wr_rd_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_do(wr_seq)
    `uvm_do(rd_seq)
  endtask
endclass
