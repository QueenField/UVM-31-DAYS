class component_a extends uvm_component;
  // Transaction method instantiation
  transaction                          trans;

  // UVM Blocking Put Imp method instantiation
  uvm_blocking_put_port #(transaction) trans_out;

  // Utility declaration
  `uvm_component_utils(component_a)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_out = new("trans_out", this);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Create transaction method
    trans = transaction::type_id::create("trans", this);

    void'(trans.randomize());
    `uvm_info(get_type_name(), $sformatf("before calling port put method"), UVM_LOW)
    trans_out.put(trans);
    `uvm_info(get_type_name(), $sformatf("after calling port put method"), UVM_LOW)

    phase.drop_objection(this);
  endtask
endclass
