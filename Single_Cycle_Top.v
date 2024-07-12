`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Register_Files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"

module Single_Cycle_Top(
    input clk,
    input rst
);
    // Declare internal signals
    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, ALUResult, ReadData, PCPlus4, RD2_Top, SrcB, Result;
    wire [2:0] ALU_Control_Top;
    wire [1:0] ImmSrc;
    wire RegWrite_Top, MemWrite, ALUSrc,ResultSrc;

    PC_Module PC_Module(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PCPlus4)
    );

    instruction_memory instruction_memory(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    Reg_file Reg_file(
        .clk(clk),
        .rst(rst),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .WD3(Result),
        .WE3(RegWrite_Top),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Mux Mux_Register_to_ALU(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .ImmSrc(ImmSrc[0]),
        .Imm_Ext(Imm_Ext_Top)
    );

    alu alu(
        .A(RD1_Top), 
        .B(SrcB), 
        .ALUControl(ALU_Control_Top), 
        .Result(ALUResult), 
        .N(), 
        .Z(), 
        .C(), 
        .V()
    );

    Control_Unit_Top Control_Unit_Top(
        .op(RD_Instr[6:0]),
        .RegWrite(RegWrite_Top),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(),
        .ALUControl(ALU_Control_Top)
    );

    Mux Mux_data_memort_to_reg_file(
        .a(ALUResult),
        .b(ReadData),
        .c(Result),
        .s(ResultSrc)
    );

    data_memory data_memory(
        .clk(clk),
        .rst(rst),
        .A(ALUResult),
        .WD(RD2_Top),
        .WE(MemWrite),
        .RD(ReadData)
    );

    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    // Debug statements
    always @(posedge clk) begin
        $display("clk: %b, rst: %b", clk, rst);
        $display("PC: %h, Instruction: %h", PC_Top, RD_Instr);
        $display("ALU Result: %h, Read Data: %h", ALUResult, ReadData);
    end

endmodule
