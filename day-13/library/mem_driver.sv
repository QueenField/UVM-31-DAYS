class mem_driver extends uvm_driver #(mem_seq_item);
  // Virtual Interface
  virtual mem_if vif;

  // Utility declaration
  `uvm_component_utils(mem_driver)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
  endfunction : build_phase

  // Run phase 
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase

  // Drive
  virtual task drive();
    vif.driver_cb.wr_en <= 0;
    vif.driver_cb.rd_en <= 0;
    @(posedge vif.clk);

    vif.driver_cb.addr <= req.addr;

    if (req.wr_en) begin
      // Write operation
      vif.driver_cb.wr_en <= req.wr_en;
      vif.driver_cb.wdata <= req.wdata;
      @(posedge vif.clk);
    end else if (req.rd_en) begin
      // Read operation
      vif.driver_cb.rd_en <= req.rd_en;
      @(posedge vif.clk);
      vif.driver_cb.rd_en <= 0;
      @(posedge vif.clk);
      req.rdata = vif.driver_cb.rdata;
    end
  endtask : drive
endclass : mem_driver
