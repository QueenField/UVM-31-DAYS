class component_b extends uvm_component;
  // Transaction method instantiation
  transaction                          trans;

  uvm_tlm_analysis_fifo #(transaction) analy_fifo;

  // Utility declaration
  `uvm_component_utils(component_b)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    analy_fifo = new("analy_fifo", this);
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #100;
    `uvm_info(get_type_name(), $sformatf(" Before calling analysis fifo get method"), UVM_LOW)
    analy_fifo.get(trans);
    `uvm_info(get_type_name(), $sformatf(" After  calling analysis fifo get method"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf(" Printing trans, \n %s", trans.sprint()), UVM_LOW)

    phase.drop_objection(this);
  endtask
endclass
