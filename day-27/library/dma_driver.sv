`include "dma_seq_item.sv"

class dma_driver extends uvm_driver #(dma_seq_item);
  // Virtual Interface
  virtual dma_if vif;

  // Utility declaration
  `uvm_component_utils(dma_driver)

  // Constructor 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dma_if)::get(this, "", "vif", vif)) begin
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
    @(posedge vif.clk);

    vif.driver_cb.addr  <= req.addr;

    vif.driver_cb.valid <= 1;
    vif.driver_cb.wr_en <= req.wr_en;
    if (req.wr_en) begin  // Write operation
      vif.driver_cb.wdata <= req.wdata;
      @(posedge vif.clk);
    end else begin  // Read operation
      @(posedge vif.clk);
      vif.driver_cb.wr_en <= 0;
      @(posedge vif.clk);
      req.rdata = vif.driver_cb.rdata;
    end

    vif.driver_cb.valid <= 0;
  endtask : drive
endclass : dma_driver
