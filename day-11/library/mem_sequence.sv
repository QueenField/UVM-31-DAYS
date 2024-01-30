class mem_sequence extends uvm_sequence #();
  // Utility declaration
  `uvm_object_utils(mem_sequence)

  // Constructor
  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    `uvm_create(req)
    `uvm_rand_send(req);
  endtask
endclass
