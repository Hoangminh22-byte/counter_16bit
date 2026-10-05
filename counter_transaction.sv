class counter_txn extends uvm_sequence_item;

    rand bit        rst_n;
    rand bit        enable;
         bit [15:0] count;

    `uvm_object_utils_begin(counter_txn)
        `uvm_field_int(rst_n,  UVM_ALL_ON)
        `uvm_field_int(enable, UVM_ALL_ON)
        `uvm_field_int(count,  UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "counter_txn");
        super.new(name);
    endfunction

endclass