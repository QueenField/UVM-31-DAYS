class component_b extends uvm_component;
  // Utility declaration
  `uvm_component_utils(component_b)
  
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

    // Event creation
    ev = uvm_event_pool::get_global("ev_ab");

    `uvm_info(get_type_name(), $sformatf("waiting for the event trigger"), UVM_LOW)
    ev.wait_trigger;
    `uvm_info(get_type_name(), $sformatf("event got triggerd"), UVM_LOW)

    $cast(trans, ev.get_trigger_data());
    `uvm_info(get_type_name(), $sformatf("trans received, \n%0s", trans.sprint()), UVM_LOW)

    phase.drop_objection(this);
  endtask : run_phase
endclass
