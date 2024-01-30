class component_a extends uvm_component;
  // Utility declaration
  `uvm_component_utils(component_a)

  // Event method instantiation
  uvm_event ev;

  // Transaction method instantiation
  transaction trans;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    #50

    // Create transaction method
    trans = transaction::type_id::create("trans", this);

    trans.randomize();
    `uvm_info(get_type_name(), $sformatf("randomized trans, \n%0s", trans.sprint()), UVM_LOW)

    // Event creation
    ev = uvm_event_pool::get_global("ev_ab");

    `uvm_info(get_type_name(), $sformatf("Before Triggering the event"), UVM_LOW)
    ev.trigger(trans);
    `uvm_info(get_type_name(), $sformatf("After Triggering the event"), UVM_LOW)
    phase.drop_objection(this);
  endtask : run_phase
endclass
