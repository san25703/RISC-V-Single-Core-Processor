module instruction_memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0];
  
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

    initial begin
        //mem[0] = 32'hFFC4A303; // Initialize first memory location
        //mem[1] = 32'h00832383;
        //mem[0] = 32'h0064A423;
        mem[0] = 32'h0062E233;
    end
endmodule
