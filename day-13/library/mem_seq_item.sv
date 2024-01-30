class mem_seq_item extends uvm_sequence_item;
  // Control Signals
  rand bit [1:0] addr;
  rand bit       wr_en;
  rand bit       rd_en;

  // Data Signals
  rand bit [7:0] wdata;

  bit      [7:0] rdata;

  // Utility and Field declarations
  `uvm_object_utils_begin(mem_seq_item)
  `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_field_int(wr_en, UVM_ALL_ON)
  `uvm_field_int(rd_en, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction

  // Constaints
  constraint wr_rd_c {wr_en != rd_en;}
  ;
endclass
