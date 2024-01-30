`include "mem_env.sv"
class mem_model_base_test extends uvm_test;
  // Utility declaration
  `uvm_component_utils(mem_model_base_test)

  // Environment method instantiation
  mem_environment env;

  // Constructor
  function new(string name = "mem_model_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // Build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment method
    env = mem_environment::type_id::create("env", this);
  endfunction : build_phase

  // End of elobaration phase 
  virtual function void end_of_elaboration();
    // Print topology
    print();
  endfunction

  // Report phase  
  function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) > 0) begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----           TEST FAIL           ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end else begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
  endfunction
endclass : mem_model_base_test
