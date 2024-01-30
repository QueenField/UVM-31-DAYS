class driver extends uvm_driver #(seq_item);
  // Virtual Interface
  virtual add_if vif;

  // Utility declaration
  `uvm_component_utils(driver)

  // Constructor
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Not set at top level");
    end
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    forever begin
      // Driver to the DUT
      //@(posedge vif.clk);
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", req.ip1, req.ip2), UVM_LOW);
      vif.ip1 <= req.ip1;
      vif.ip2 <= req.ip2;
      //@(posedge vif.clk);
      // Req.out <= vif.out;
      seq_item_port.item_done();
    end
  endtask
endclass
