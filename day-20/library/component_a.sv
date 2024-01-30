class component_a extends uvm_component;
  // Utility declaration
  `uvm_component_utils(component_a)

  // Event method instantiation
  uvm_event ev;

  // Event CallBack method instantiation
  event_callback ev_cb;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    ev_cb = new("ev_cb");

    ev    = uvm_event_pool::get_global("ev_ab");
    ev.add_callback(ev_cb);

    `uvm_info(get_type_name(), $sformatf(" Before triggering the event"), UVM_LOW)
    #50;

    ev.trigger();

    `uvm_info(get_type_name(), $sformatf(" After triggering the event"), UVM_LOW)

    phase.drop_objection(this);
  endtask : run_phase
endclass
