class component_a extends uvm_component;
  // Utility declaration
  `uvm_component_utils(component_a)

  // Event method instantiation
  uvm_event ev;

  // Construction
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Event creation
    ev = uvm_event_pool::get_global("ev_ab");
    `uvm_info(get_type_name(), $sformatf("Before Triggering the Event"), UVM_LOW)
    #10
    ev.trigger();
    `uvm_info(get_type_name(), $sformatf("After Triggering the Event"), UVM_LOW)
    phase.drop_objection(this);
  endtask : run_phase
endclass

