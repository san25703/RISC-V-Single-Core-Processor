module alu(A, B, ALUControl, Result, N, Z, C, V);
     //declaring inputs
     input [31:0] A, B;
     input [2:0] ALUControl;
     //declaring output
     output [31:0] Result;
     output N, Z, C, V;

     //declaring interim wires
     wire [31:0] a_and_b;
     wire [31:0] a_or_b;
     wire [31:0] not_b;

     wire [31:0] mux_1;
     wire [31:0] sum;
     wire [31:0] mux_2;
     wire [31:0] slt; //set less than means extending zero for perfect calculation at MUX

     wire cout; //for carry flag
     

     //Logic Designing
     //AND operation
     assign a_and_b = A & B;
     //OR operation
     assign a_or_b = A | B;
     //NOT operation
     assign not_b = ~B;
     //Ternary operation
     assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;

     //Addition and Subtraction
     assign {cout, sum} = A + mux_1 + ALUControl[0]; //cancatenation

     //Zero Extension
     assign slt = {31'b0000000000000000000000000000000,sum[31]};

     //Designing 4by1 MUX
     assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum : 
                    (ALUControl[2:0] == 3'b000) ? sum : 
                    (ALUControl[2:0] == 3'b010) ? a_and_b : 
                    (ALUControl[2:0] == 3'b011) ? a_or_b :
                    (ALUControl[2:0] == 3'b101) ? slt : 32'h00000000;

     assign Result = mux_2;

     //Flags Assignment
     assign Z = &(~Result); //Zero FLag

     assign N = Result[31]; //Negative Flag

     assign C = cout & (~ALUControl[1]); //carry flag

     assign V = (~(ALUControl[1])) & (A[31] ^ B[31]) & (~(A[31] ^ B[31] ^ ALUControl[0])); //overflow flag 

endmodule