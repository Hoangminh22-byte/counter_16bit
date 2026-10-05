class counter_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(counter_scoreboard)

    uvm_analysis_imp #(counter_txn, counter_scoreboard) analysis_export;

    logic [15:0] expected_count = 16'd0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction


    function void write(counter_txn tr);

        // 1. Mô hình dự đoán (Golden Model)
        if (!tr.rst_n)
            expected_count = 16'd0;
        else if (tr.enable)
            expected_count = expected_count + 16'd1;

        // 2. So sánh Golden Model với kết quả thực tế thu thập từ Transaction (tr.count)
        if (tr.count !== expected_count) begin
            `uvm_error("SCB",
                $sformatf("Mismatch! Expected=%0d, Actual=%0d",
                expected_count, tr.count))
        end
        else begin
            `uvm_info("SCB",
                $sformatf("PASS: count=%0d", tr.count),
                UVM_MEDIUM)
        end

    endfunction

endclass