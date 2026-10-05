interface counter_if (input bit clk);
    logic rst_n;
    logic enable;
    logic [15:0] count;
endinterface //counter_if(input bit clk)