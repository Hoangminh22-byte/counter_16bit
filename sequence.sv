class counter_sequence extends uvm_sequence #(counter_txn);

        `uvm_object_utils(counter_sequence)

        function new(string name = "counter_sequence");
            super.new(name);
        endfunction

        task body();
            counter_txn tr;

            // Reset trong 2 chu kỳ
            repeat (2) begin
                tr = counter_txn::type_id::create("tr");
                start_item(tr);
                tr.rst_n  = 0;
                tr.enable = 0;
                finish_item(tr);
            end

            // Enable = 1: đếm lên
            repeat (20) begin
                tr = counter_txn::type_id::create("tr");
                start_item(tr);
                tr.rst_n  = 1;
                tr.enable = 1;
                finish_item(tr);
            end

            // Enable = 0: giữ nguyên
            repeat (5) begin
                tr = counter_txn::type_id::create("tr");
                start_item(tr);
                tr.rst_n  = 1;
                tr.enable = 0;
                finish_item(tr);
            end

            // Reset lại
            tr = counter_txn::type_id::create("tr");
            start_item(tr);
            tr.rst_n  = 0;
            tr.enable = 0;
            finish_item(tr);

        endtask

    endclass