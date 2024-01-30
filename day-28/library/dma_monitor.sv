class dma_monitor extends uvm_monitor;
  // Virtual Interface
  virtual dma_if                    vif;

  // Analysis port
  // sending the transaction to scoreboard
  uvm_analysis_port #(dma_seq_item) item_collected_port;

  // Sequence Item method instantiation
  dma_seq_item                      trans_collected;

  // Utility declaration
  `uvm_component_utils(dma_monitor)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_collected     = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  // Build phase - getting the interface handle
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual dma_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
  endfunction : build_phase

  // Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      wait (vif.monitor_cb.valid);
      trans_collected.addr  = vif.monitor_cb.addr;
      trans_collected.wr_en = vif.monitor_cb.wr_en;

      if (vif.monitor_cb.wr_en) begin
        trans_collected.wr_en = vif.monitor_cb.wr_en;
        trans_collected.wdata = vif.monitor_cb.wdata;
        @(posedge vif.clk);
      end else begin
        @(posedge vif.clk);
        @(posedge vif.clk);
        trans_collected.rdata = vif.monitor_cb.rdata;
      end
      item_collected_port.write(trans_collected);
    end
  endtask
endclass
