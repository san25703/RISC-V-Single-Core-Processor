module Single_Cycle_Top_Tb();
    reg clk = 1'b0, rst;

    Single_Cycle_Top Single_Cycle_Top_Design_Top (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        $dumpfile("Single_Cycle.vcd");
        $dumpvars(0, Single_Cycle_Top_Tb);  // Dump variables from the testbench scope
    end

    always begin
        #25 clk = ~clk;  // Clock period of 50 time units
    end

    initial begin
        rst = 1'b0;
        #50;  // Wait for 50 time units
        rst = 1'b1;
        #100;  // Wait for the reset signal to take effect
        rst = 1'b0;
        #300;  // Continue simulation for 300 time units
        $finish;
    end
endmodule
