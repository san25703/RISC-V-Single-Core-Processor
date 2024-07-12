# Single Cycle Processor Design and Simulation

This repository contains the Verilog implementation and simulation files for a single-cycle processor design. The project focuses on designing a processor that executes instructions within a single clock cycle, utilizing a modular approach to enhance understanding, testing, and debugging.

## Project Description

The single-cycle processor is designed to complete the fetch, decode, execute, memory access, and write-back stages of an instruction within one clock cycle. This project includes essential components that interact seamlessly to ensure the correct execution of instructions. Each component is implemented as a separate Verilog module.

### Key Components

#### 1. Program Counter (PC)
The Program Counter is responsible for holding the address of the next instruction to be executed. It increments its value to point to the subsequent instruction address after each clock cycle.

#### 2. Instruction Memory
The Instruction Memory module stores the instructions to be executed by the processor. It fetches the instruction located at the address provided by the Program Counter.

#### 3. Register Files
The Register Files module manages the processor's registers, allowing read and write operations. It provides two read ports and one write port to facilitate concurrent access to register values during instruction execution.

#### 4. Sign Extend Unit
The Sign Extend Unit extends the immediate values in the instructions to 32 bits, ensuring they are correctly processed during arithmetic and logical operations.

#### 5. Arithmetic and Logic Unit (ALU)
The ALU performs arithmetic and logical operations based on the control signals it receives. It is a critical component for executing R-type, I-type, and other instruction formats.

#### 6. Control Unit
The Control Unit generates the necessary control signals based on the opcode and function fields of the instruction. These signals direct the data flow and operations within the processor.

#### 7. Data Memory
The Data Memory module handles the read and write operations to the memory during load and store instructions. It interfaces with the ALU to determine memory addresses and manages data transfer to and from memory.

#### 8. PC Adder
The PC Adder calculates the address of the next instruction by adding a fixed offset (typically 4 bytes for word-aligned instructions) to the current Program Counter value.

## Design Flow

1. **Instruction Fetch**: The processor fetches the instruction from Instruction Memory using the address provided by the Program Counter.
2. **Instruction Decode**: The fetched instruction is decoded to determine the operation type and the required operands.
3. **Execute**: The ALU performs the required arithmetic or logical operation based on the instruction type and control signals.
4. **Memory Access**: For load and store instructions, the Data Memory module handles data transfer between the processor and memory.
5. **Write Back**: The result of the operation (from the ALU or Data Memory) is written back to the appropriate register in the Register Files.

Sure, here's the additional content to specify that the processor supports only R-type, I-type, and L-type instructions:

### Supported Instruction Types

This single-cycle processor is designed to support the following instruction types:

- **R-type Instructions**: These instructions perform register-to-register arithmetic and logical operations. Examples include `ADD`, `SUB`, `AND`, and `OR`.
- **I-type Instructions**: These instructions use immediate values for operations and typically include arithmetic operations, load, and immediate data. Examples include `ADDI`, `ORI`, and `LW`.
- **L-type Instructions**: These instructions handle load operations from memory. An example is the `LW` (Load Word) instruction.

## Simulation and Testing

### Testbench
A comprehensive testbench is provided to simulate the processor's operation. The testbench initializes the clock and reset signals, and it provides a sequence of instructions to be executed by the processor. The simulation outputs can be viewed using waveform viewers like GTKWave to verify the correct operation of each module.
