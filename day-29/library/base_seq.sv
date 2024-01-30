class base_seq extends uvm_sequence #(seq_item);
  // Sequence Item method instantiation
  seq_item req;

  // Utility declaration
  `uvm_object_utils(base_seq)

  // Constructor
  function new(string name = "base_seq");
    super.new(name);
  endfunction

  // Sequence body
  task body();
    `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
    `uvm_do(req);
  endtask
endclass
