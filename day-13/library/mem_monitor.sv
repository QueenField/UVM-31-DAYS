class mem_monitor extends uvm_monitor;
  // Virtual Interface
  virtual mem_if vif;

  // Analysis port
  // Send transaction to scoreboard
  uvm_analysis_port #(mem_seq_item) item_collected_port;

  // Sequence Item method instantiation
  mem_seq_item trans_collected;

  // Utility declaration
  `uvm_component_utils(mem_monitor)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_collected     = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
  endfunction : build_phase

  // Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      wait (vif.monitor_cb.wr_en || vif.monitor_cb.rd_en);
      trans_collected.addr = vif.monitor_cb.addr;
      if (vif.monitor_cb.wr_en) begin
        trans_collected.wr_en = vif.monitor_cb.wr_en;
        trans_collected.wdata = vif.monitor_cb.wdata;
        trans_collected.rd_en = 0;
        @(posedge vif.clk);
      end
      if (vif.monitor_cb.rd_en) begin
        trans_collected.rd_en = vif.monitor_cb.rd_en;
        trans_collected.wr_en = 0;
        @(posedge vif.clk);
        @(posedge vif.clk);
        trans_collected.rdata = vif.monitor_cb.rdata;
      end
      item_collected_port.write(trans_collected);
    end
  endtask : run_phase
endclass : mem_monitor
