# 🧠 16-bit Processor (Structural Verilog)

A custom-built 16-bit processor designed and implemented entirely in **structural Verilog**, focusing on low-level hardware design, modularity, and precise control logic.

---

## 🚀 Overview

This project implements a complete processor architecture using a **fully structural approach**, without relying on high-level behavioral constructs. All control signals and datapath interactions are explicitly defined at hardware level.

The processor is capable of executing programs from memory and supports:
- arithmetic and logic operations  
- branching and control flow  
- stack manipulation  
- basic input/output operations  

The entire system is integrated as a **System-on-Chip (SoC)**, combining CPU, memory, and I/O components under a single clock domain.

---

## 🏗️ Architecture

The processor follows a classical design based on two main subsystems:

- **Datapath** – handles computation and data movement  
- **Control Unit** – generates control signals using an FSM  

The design is modular, allowing independent testing of each component before full system integration.

### Key Architectural Properties

| Property | Value |
|----------|-------|
| Word size | 16-bit |
| Instruction width | Fixed 16-bit |
| Memory | 512 × 16-bit, unified |
| Address space | 9-bit (word-addressable) |
| Register file | AC, X, Y, PC, SP, AR, IR, FLAGS |
| ALU operations | ADD, SUB, MUL, DIV, MOD, AND, OR, XOR, NOT, shifts, rotates |
| Control strategy | Centralized FSM (structural) |
| I/O model | Memory-mapped, handshake-based |
| Stack | Descending, managed by SP |

---

## 🧩 Core Components

- **ALU (Arithmetic Logic Unit)** – executes arithmetic and logical operations  
- **Control Unit** – FSM-based control signal generation  
- **Registers** – data storage (AC, PC, SP, FLAGS, etc.)  
- **Memory** – unified instruction and data storage  
- **I/O subsystem** – handshake-based communication  
- **SoC layer** – integrates all components  

---

## 🧪 Verification & Testing

Each module is tested using **dedicated testbenches**.

Verification includes:
- simulation  
- waveform inspection  
- signal-level debugging  

This ensures correctness at both module and system level.

---

## ⚙️ Instruction Set

### Memory Instructions

| Mnemonic | Description |
|----------|-------------|
| `LDR Reg, #Addr` | Load register from memory address |
| `LDA Reg, Offset` | Load accumulator from `Mem[Reg + Offset]` |
| `STR Reg, #Addr` | Store register to memory address |
| `STA Reg, Offset` | Store accumulator to `Mem[Reg + Offset]` |
| `LDA #Addr` | Load accumulator from direct memory |
| `STA #Addr` | Store accumulator to direct memory |

---

### Stack & I/O Instructions

| Mnemonic | Description |
|----------|-------------|
| `PSH {Reg}` | Push register onto stack |
| `POP {Reg}` | Pop value from stack into register |
| `IN Reg` | Read input via handshake |
| `OUT Reg` | Write output via handshake |

---

### Branch Instructions

| Mnemonic | Condition | Description |
|----------|-----------|-------------|
| `BEQ Addr` | Z = 1 | Branch if equal |
| `BNE Addr` | Z = 0 | Branch if not equal |
| `BGT Addr` | Z = 0, N = V | Branch if greater |
| `BLT Addr` | N ≠ V | Branch if less |
| `BGE Addr` | N = V | Branch if greater or equal |
| `BLE Addr` | Z = 1 or N ≠ V | Branch if less or equal |
| `BRA Addr` | — | Unconditional branch |
| `JMP Addr` | — | Jump (subroutine call) |
| `RET` | — | Return from subroutine |

---

### ALU Instructions

| Mnemonic | Operation |
|----------|-----------|
| `ADD` | `AC = AC + operand` |
| `SUB` | `AC = AC - operand` |
| `MUL` | `AC = AC × operand` |
| `DIV` | `AC = AC ÷ operand` |
| `MOD` | `AC = AC % operand` |
| `AND` | `AC = AC & operand` |
| `OR`  | `AC = AC \| operand` |
| `XOR` | `AC = AC ^ operand` |
| `NOT` | `AC = ~operand` |

---

### Shift & Rotate Instructions

| Mnemonic | Operation |
|----------|-----------|
| `LSR` | Logical shift right |
| `LSL` | Logical shift left |
| `RSR` | Rotate right |
| `RSL` | Rotate left |

---

### Compare & Move Instructions

| Mnemonic | Operation |
|----------|-----------|
| `CMP` | Compare values (sets flags) |
| `TST` | Test values using AND |
| `MOV` | Move data between registers |
| `MOV #Imm` | Load immediate value |

---

## ▶️ Getting Started

### 1. Clone the repository
    git clone https://github.com/MihneaRemetan/Processor-Project.git
    cd Processor-Project

### 2. Compile the design
    iverilog -o processor.out $(cat files_relative.txt)

### 3. Run the simulation
    vvp processor.out

### 4. View waveforms (optional)
    gtkwave dump.vcd

---

## 📂 Project Structure

    Processor/
    ├── CPU/
    ├── ControlUnit/
    ├── ALU/
    ├── Registers/
    ├── Memory/
    ├── IO/
    ├── SoC/
    └── Testbenches/

---

## ⭐ Design Highlights

| Feature | Description |
|--------|------------|
| Structural Design | No behavioral shortcuts, all signals explicitly defined |
| Modular Architecture | Components tested independently |
| FSM Control | Centralized execution control |
| Full Integration | Complete working processor system |

---

## 🎯 Project Goals

| Goal | Description |
|------|------------|
| Hardware Understanding | Learn processor internals |
| Structural HDL | Work at low-level design |
| Control Logic | Understand FSM behavior |
| Scalability | Build modular systems |

---

## ⚠️ Notes

| Aspect | Detail |
|-------|--------|
| Scope | Simulation and architecture |
| FPGA | Not targeted for synthesis |
| Purpose | Educational project |

---

## Supported Platforms

| Platform | Status |
|----------|--------|
| Linux | Tested |
| macOS | Should work (Homebrew support) |
| Windows | Not tested |

---

## 👤 Author

**Mihnea Remețan**  
• Systems  
• Embedded Systems  
• Low-level & Computer Architecture
