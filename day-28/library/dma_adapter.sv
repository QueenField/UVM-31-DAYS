//  Register Adapter - dma_adapter
class dma_adapter extends uvm_reg_adapter;
  // Utility declaration
  `uvm_object_utils(dma_adapter)

  // Constructor
  function new(string name = "dma_adapter");
    super.new(name);
  endfunction

  // Reg2bus method 
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    dma_seq_item tx;

    tx       = dma_seq_item::type_id::create("tx");

    tx.wr_en = (rw.kind == UVM_WRITE);
    tx.addr  = rw.addr;

    if (tx.wr_en) begin
      tx.wdata = rw.data;
    end

    if (!tx.wr_en) begin
      tx.rdata = rw.data;
    end

    return tx;
  endfunction

  // Bus2reg method 
  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    dma_seq_item tx;

    assert ($cast(tx, bus_item))
    else `uvm_fatal("", "A bad thing has just happened in my_adapter")

    rw.kind   = tx.wr_en ? UVM_WRITE : UVM_READ;
    rw.addr   = tx.addr;
    rw.data   = tx.rdata;

    rw.status = UVM_IS_OK;
  endfunction
endclass
