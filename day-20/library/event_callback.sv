class event_callback extends uvm_event_callback;
  // Utility declaration
  `uvm_object_utils(event_callback)

  // Constructor
  function new(string name = "event_callback");
    super.new(name);
  endfunction

  // Pre trigger method
  virtual function bit pre_trigger(uvm_event e, uvm_object data);
    `uvm_info(get_type_name(), $sformatf(" [Callback] Inside event pre_trigger callback"), UVM_LOW)
  endfunction

  // Post trigger method
  virtual function void post_trigger(uvm_event e, uvm_object data);
    `uvm_info(get_type_name(), $sformatf(" [Callback] Inside event post_trigger callback"), UVM_LOW)
  endfunction
endclass
