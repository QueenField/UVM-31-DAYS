class driver extends uvm_component;
  // Utility declaration
  `uvm_component_utils(driver)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    drive_pkt();
  endtask

  // Drive
  task drive_pkt();
    `uvm_info("DRIVER", "Inside drive_pkt method", UVM_LOW);
  endtask
endclass
