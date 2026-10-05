`timescale 1ns/1ps

module tb_top;

    import uvm_pkg::*;
    import my_pkg::*;

    logic clk = 0;

    always #5 clk = ~clk;

    counter_if intf(clk);

    // DUT
    counter_16bit dut (
        .clk    (clk),
        .rst_n  (intf.rst_n),
        .enable (intf.enable),
        .count  (intf.count)
    );

    initial begin
        uvm_config_db#(virtual counter_if)::set(
            null, "*", "vif", intf
        );

        run_test("counter_test");
    end

endmodule