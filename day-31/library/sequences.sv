class sequences extends uvm_sequence #(sequence_item);
  // Utility declaration
  `uvm_object_utils(sequences)

  // Sequence Item method instantiation
  sequence_item s_item;

  // Constructor
  function new(string name = "sequence");
    super.new(name);
  endfunction

  // Sequence body
  task body();
    s_item = sequence_item::type_id::create("s_item");
    begin
      `uvm_do(s_item)
    end
  endtask
endclass
