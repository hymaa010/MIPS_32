# MIPS_32 Processor Implementation

A 32-bit single-cycle MIPS processor implemented in Verilog. This project supports a subset of the MIPS instruction set and demonstrates core components of a CPU datapath.

![image](https://github.com/user-attachments/assets/d4628ea8-c20c-4d60-a765-be7dac9c78c7)


## Features
- **Supported Instructions**: `lw`, `sw`, `addi`, `beq`, `j`, and R-type instructions (`add`, `sub`, `and`, `or`, `slt`).
- **Key Components**:
  - 32-bit ALU with arithmetic/logic operations
  - Register File (32 registers)
  - Instruction and Data Memory modules
  - Sign-extension unit
  - Control Unit and ALU Control
- Harvard architecture (separate instruction/data memory).

## Modules Overview

### 1. `MUX2` (2:1 Multiplexer)
- Generic-width multiplexer for selecting between two inputs.
- **Parameters**: `width` (default data width).
- **Inputs**: `A`, `B`, `s` (select signal).
- **Output**: `f` (selected value).

### 2. `signext` (Sign Extension Unit)
- Extends 16-bit immediate value to 32 bits with sign preservation.
- **Input**: `[15:0] A` (16-bit immediate).
- **Output**: `[31:0] f` (sign-extended value).

### 3. `control` (Control Unit)
- Generates control signals based on opcode.
- **Input**: `[5:0] op` (instruction opcode).
- **Outputs**: `regdst`, `branch`, `memread`, `memtoreg`, `memwrite`, `alusrc`, `regwrite`, `jump`, `aluop`.
  
  ![image](https://github.com/user-attachments/assets/aef1ceb8-8ca3-4273-986c-976f429e05a0)


### 4. `ALUControl`
- Decodes ALU operation from `ALUOp` and `funct` field.
- **Inputs**: `[1:0] ALUOp`, `[5:0] funct`.
- **Output**: `[2:0] alucontrol`.

### 5. `ALU` (Arithmetic Logic Unit)
- Performs arithmetic/logic operations.
- **Inputs**: `[31:0] A`, `B`, `[2:0] alucontrol`.
- **Outputs**: `[31:0] out`, `Z` (zero flag), `N` (negative flag).
- **Operations**: AND, OR, ADD, SUB, SLT.

### 6. `instmem` (Instruction Memory)
- 256-entry ROM for storing instructions.
- **Input**: `[31:0] address`.
- **Output**: `[31:0] data`.

### 7. `datamem` (Data Memory)
- 1024-entry RAM for data storage with synchronous write.
- **Inputs**: `address`, `writedata`, `wr_en`, `r_en`, `clk`.
- **Output**: `[31:0] readdata`.

### 8. `regfile` (Register File)
- 32 registers with asynchronous read and synchronous write.
- **Inputs**: Read/Write addresses, `wr_en`, `clk`, `datain`.
- **Outputs**: `read1`, `read2`.

### 9. `top` (Top-Level Module)
- Integrates all components into a complete processor.
- **Input**: `clk` (clock signal).
- **Output**: `[7:0] out` (lower 8 bits of ALU result for debugging).

## Usage

### Prerequisites
- Verilog simulator (e.g., Icarus Verilog, ModelSim)
- Basic understanding of MIPS architecture

### Simulation Steps
1. **Compile**:
   ```bash
   iverilog -o mips32 top.v tb.v  # Include your testbench
