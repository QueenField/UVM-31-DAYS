class component_a extends uvm_component;
  // Transaction method instantiation
  transaction                             trans;

  // UVM Non-Blocking Put Imp method instantiation
  uvm_nonblocking_put_port #(transaction) trans_out;

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

    #100;

    // Create transaction method
    trans = transaction::type_id::create("trans", this);

    void'(trans.randomize());
    `uvm_info(get_type_name(), $sformatf("transaction randomized"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("printing trans,\n%0s", trans.sprint()), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("before callling port put method"), UVM_LOW)
    void'(trans_out.try_put(trans));
    `uvm_info(get_type_name(), $sformatf("after callling port put method"), UVM_LOW)

    phase.drop_objection(this);
  endtask
endclass
