module data_memory(clk,rst,A,WD,WE,RD);
    input [31:0] A, WD;
    input clk, WE, rst;
    output [31:0] RD;

    reg [31:0] Data_MEM [1023:0];

    //read
    assign RD = (~rst) ? 32'h00000000 : Data_MEM[A];

    //write
    always @ (posedge clk)
    begin
      if(WE)
      Data_MEM[A] <= WD;
    end
    assign RD = (~rst) ? 32'h00000000 : Data_MEM[A];

    initial begin
      Data_MEM[28] = 32'h00000020;
      Data_MEM[40] = 32'h00000002;
    end

endmodule