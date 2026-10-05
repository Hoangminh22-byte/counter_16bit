class counter_driver extends uvm_driver #(counter_txn);

        `uvm_component_utils(counter_driver)

        virtual counter_if vif;

        function new(string name,
                     uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if (!uvm_config_db#(virtual counter_if)::get(
                    this, "", "vif", vif))
                `uvm_fatal("DRV", "Cannot get virtual interface")
        endfunction

        task run_phase(uvm_phase phase);
            counter_txn tr;

            forever begin
                seq_item_port.get_next_item(tr);

                @(negedge vif.clk);
                vif.rst_n  = tr.rst_n;
                vif.enable = tr.enable;

                seq_item_port.item_done();
            end
        endtask

    endclass