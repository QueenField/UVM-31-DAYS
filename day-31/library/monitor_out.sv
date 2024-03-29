class monitor_out extends uvm_monitor;
  // Utility declaration
  `uvm_component_utils(monitor_out)

  // Virtual Interface
  virtual vif inter;

  // UVM analysis port
  // Send transaction to scoreboard
  uvm_analysis_port #(sequence_item) c2_port;

  // Sequence Item method instantiation
  sequence_item                      s_item;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    c2_port = new("analysis_port_c2", this);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    uvm_config_db#(virtual vif)::get(this, "", "interface", inter);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    s_item = sequence_item::type_id::create("s_item");
    forever begin
      @(inter.q, inter.qb);
      s_item.qb <= inter.qb;
      @(posedge inter.clk);
      s_item.q <= inter.q;
      `uvm_info(get_type_name, $sformatf("s_item.q=%0d,s_item.qb=%0d", s_item.q, s_item.qb), UVM_LOW)
      c2_port.write(s_item);
    end
  endtask
endclass
