class mem_sequence extends uvm_sequence #();
  // Utility declaration
  `uvm_object_utils(mem_sequence)

  // Constructor
  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  // Sequence body
  virtual task body();
    // Step-1. create req
    req = mem_sequence::type_id::create("req");

    // Step-2. wait for grant
    wait_for_grant();

    // Step-3. randomize the req
    assert (req.randomize());

    // Step-4. send request to driver
    send_request(req);

    // Step-5. wait for item done from driver
    wait_for_item_done();

    // Step-6. get response from driver
    get_response(rsp);
  endtask
endclass
