class component_b extends uvm_component;
  // Transaction method instantiation
  transaction                                      trans;

  // UVM Blocking Put Imp method instantiation
  uvm_blocking_put_imp #(transaction, component_b) trans_in;

  // Utility declaration
  `uvm_component_utils(component_b)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_in = new("trans_in", this);
  endfunction

  // IMP port put method
  virtual task put(transaction trans);
    `uvm_info(get_type_name(), $sformatf("Received trans on IMP port"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("printing trans,\n%0s", trans.sprint()), UVM_LOW)
  endtask
endclass
