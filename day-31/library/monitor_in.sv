class monitor_in extends uvm_monitor;
  // Utility declaration
  `uvm_component_utils(monitor_in)

  // Virtual Interface
  virtual vif inter;

  // UVM analysis port
  // Send transaction to scoreboard
  uvm_analysis_port #(sequence_item) c1_port;

  // Sequence Item method instantiation
  sequence_item                      s_item;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    c1_port = new("analysis_port_c1", this);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    uvm_config_db#(virtual vif)::get(this, "", "interface", inter);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    s_item = sequence_item::type_id::create("s_item");
    forever begin
      @(inter.d, inter.clk) wait (!inter.reset);
      @(posedge inter.clk) s_item.d <= inter.d;
      `uvm_info(get_type_name, $sformatf("clk=%0d,s_item.d=%0d,inter.reset=%0d", inter.clk, s_item.d, inter.reset), UVM_LOW)
      begin
        s_item.qb = ~s_item.q;
        `uvm_info(get_type_name, $sformatf("BFM s_item.q=%0d,s_item.qb=%0d", s_item.q, s_item.qb), UVM_LOW)
        @(posedge inter.clk, posedge inter.reset);
        begin
          if (inter.reset) begin
            s_item.q <= 1'b0;
          end else begin
            s_item.q <= s_item.d;
          end
          `uvm_info(get_type_name, $sformatf("BFM2s_item.d=%0d,clk=%0d,reset=%0d", s_item.d, inter.clk, inter.reset), UVM_LOW)
          c1_port.write(s_item);
        end
      end
    end
  endtask
endclass
