module counter_16bit (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    output logic [15:0] count
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 16'd0;
        else if (enable)
            count <= count + 16'd1;
    end

endmodule