class monitor extends uvm_monitor;
  // Virtual Interface
  virtual add_if vif;

  // UVM analysis port
  // Send transaction to scoreboard
  uvm_analysis_port #(seq_item) item_collect_port;

  // Sequence Item method instantiation
  seq_item                      mon_item;

  // Utility declaration
  `uvm_component_utils(monitor)

  // Constructor
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
    mon_item          = new();
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Not set at top level");
    end
  endfunction

  // Build phase
  task run_phase(uvm_phase phase);
    forever begin
      wait (!vif.reset);
      @(posedge vif.clk);
      mon_item.ip1 = vif.ip1;
      mon_item.ip2 = vif.ip2;
      `uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", mon_item.ip1, mon_item.ip2), UVM_HIGH);
      @(posedge vif.clk);
      mon_item.out = vif.out;
      item_collect_port.write(mon_item);
    end
  endtask
endclass
