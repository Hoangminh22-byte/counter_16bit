class counter_monitor extends uvm_monitor;

    `uvm_component_utils(counter_monitor)

    virtual counter_if vif;
    uvm_analysis_port #(counter_txn) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Cannot get virtual interface")
    endfunction

    task run_phase(uvm_phase phase);
        counter_txn tr;

        forever begin
            // Chờ cạnh lên của clock
            @(posedge vif.clk);

            // Tạo transaction mới
            tr = counter_txn::type_id::create("tr");

            // Thu thập đầy đủ thông tin từ Interface vào Transaction
            tr.rst_n  = vif.rst_n;
            tr.enable = vif.enable;
            #1step;
            tr.count  = vif.count; // Lấy cả giá trị output tại Monitor

            // Gửi transaction sang Scoreboard
            ap.write(tr);

            `uvm_info("MON",
                $sformatf("Sampled: rst_n=%0b enable=%0b count=%0d",
                tr.rst_n, tr.enable, tr.count),
                UVM_MEDIUM)
        end
    endtask

endclass