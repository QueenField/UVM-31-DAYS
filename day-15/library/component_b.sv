class component_b extends uvm_component;
  // Utility declaration
  `uvm_component_utils(component_b)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("[ Comp-B ] Objection raised"), UVM_LOW)

    for (int i = 0; i < 10; i++) begin
      `uvm_info(get_type_name(), $sformatf("[ Comp-B ] Idx=%0d raising target_objection objection", i), UVM_LOW)
      target_objection.raise_objection(this);
      #30;
    end
    phase.drop_objection(this);
  endtask : run_phase
endclass
