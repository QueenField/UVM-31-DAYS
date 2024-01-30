class component_a extends uvm_component;
  // Transaction method instantiation
  transaction                      trans;

  // UVM Non-Blocking Put Imp method instantiation
  uvm_analysis_port #(transaction) analysis_port;

  // Utility declaration
  `uvm_component_utils(component_a)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Create transaction method
    trans = transaction::type_id::create("trans", this);

    void'(trans.randomize());
    `uvm_info(get_type_name(), $sformatf("transaction randomized"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("printing trans,\n%0s", trans.sprint()), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("before callling port write method"), UVM_LOW)
    analysis_port.write(trans);
    `uvm_info(get_type_name(), $sformatf("after callling port write method"), UVM_LOW)

    phase.drop_objection(this);
  endtask
endclass
