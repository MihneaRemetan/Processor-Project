# 16-bit Processor (Structural Verilog)

A custom-built 16-bit processor designed and implemented entirely in **structural Verilog**, focusing on low-level hardware design, modularity, and precise control logic.

---

## 1. Overview

ASIP16 is a fully functional 16-bit processor implemented entirely in structural Verilog — no behavioral shortcuts, no `always @(*)` case statements for control logic. Every control signal is derived from Boolean equations and gate-level instantiations.

It runs real programs from memory and supports a full instruction set (arithmetic, logic, branching, stack, I/O). An ASIP extension adds hardware-accelerated tensor operations, including element-wise ops and full matrix multiplication as single instructions.

The Control Unit uses 174 one-hot FSM states to generate 123 control signals. The ALU has its own FSM for multi-cycle ops, and the whole system is integrated into a SoC with memory and I/O under one clock.

---

## 2. Project Structure

```
ASIP16-Processor/
│
├── SoC/                                # System-on-Chip (top level)
│   ├── SoC.v                           # SoC module — integrates CPU, Memory, I/O
│   ├── SoC_tb2.v                       # Main testbench with verification tasks
│   └── Helpful/                        # Reference documentation
│       ├── instructions_format.txt     # Full ISA specification
│       └── VERILOG_TASKS_DOCUMENTATION.md
│
├── Processor/
│   ├── CPU/
│   │   └── CPU.v                       # Top-level CPU — wires everything together
│   │
│   ├── Control-Unit/
│   │   ├── Control_Unit_CPU.v          # 174-state one-hot FSM (123 control signals)
│   │   └── ffd_OneHot.v                # D flip-flop primitive for one-hot encoding
│   │
│   ├── ALU16/                          # Self-contained ALU subsystem
│   │   ├── ALU/
│   │   │   └── ALU.v                   # ALU top-level with internal register file
│   │   ├── Control_Unit/
│   │   │   └── Control_Unit.v          # ALU FSM (5-bit state, 19 control signals)
│   │   ├── Registers/
│   │   │   ├── A.v                     # Accumulator register (17-bit)
│   │   │   ├── Q.v                     # Secondary operand (shift/rotate capable)
│   │   │   ├── M.v                     # Multiplicand/divisor register
│   │   │   └── counter.v               # Iteration counter for multi-cycle ops
│   │   └── Combinational/
│   │       ├── RCA/                    # Ripple-carry adder + full adder cell
│   │       ├── muxes/                  # 2:1, 4:1, 8:1, 16:1 multiplexers
│   │       ├── comparator/             # 4-bit magnitude comparator
│   │       └── encoder/                # Priority encoder
│   │
│   ├── Registers/
│   │   ├── PC.v                        # Program Counter (with RCA increment)
│   │   ├── SP.v                        # Stack Pointer (inc/dec/load)
│   │   ├── IR.v                        # Instruction Register
│   │   ├── AC.v                        # Accumulator
│   │   ├── AR.v                        # Address Register
│   │   ├── FLAGS.v                     # Status flags: N, Z, C, V
│   │   ├── X.v, Y.v                    # General-purpose registers
│   │   └── R2.v – R9.v                 # Extended registers (ASIP operations)
│   │
│   └── SignExtendUnit/
│       ├── SignExtendUnit.v            # Extends 5/8/9-bit immediates to 16-bit
│       └── SEU_Controller.v            # Karnaugh-map-based format selector
│
├── Memory/
│   └── memory_512x16.v                 # 512-word unified memory (hex-loadable)
│
├── IO/
│   ├── input_unit.v                    # Handshake input (inp_req / inp_ack)
│   └── output_unit.v                   # Handshake output (out_req / out_ack)
│
├── Programs/                           # Pre-assembled programs (hex)
│   ├── program.hex                     # General-purpose test (min/max of array)
│   ├── program_asip_add.hex            # Tensor addition
│   ├── program_asip_sub.hex            # Tensor subtraction
│   ├── program_asip_elmul.hex          # Element-wise multiplication
│   └── program_asip_mul.hex            # Matrix multiplication (MULM)
│
├── run.sh                              # Build & run script (Icarus Verilog)
├── files_relative.txt                  # Source file list for iverilog
└── README.md
```


---

## 3. Architecture

The processor follows a classical **accumulator-based architecture** inspired by the IAS machine, with a centralized control strategy and a unified memory space for both instructions and data.

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

## 4. Core Components

- **ALU (Arithmetic Logic Unit)** – executes arithmetic and logical operations  
- **Control Unit** – FSM-based control signal generation  
- **Registers** – data storage (AC, PC, SP, FLAGS, etc.)  
- **Memory** – unified instruction and data storage  
- **I/O subsystem** – handshake-based communication  
- **SoC layer** – integrates all components  

---

## 5. Instruction Set

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

## Verification & Testing

Each module is tested using **dedicated testbenches**.

Verification includes:
- simulation  
- waveform inspection  
- signal-level debugging  

This ensures correctness at both module and system level.

---

## 6. ASIP: Hardware Matrix Multiplication

The ASIP extension represents the most advanced component of this processor, with the `MULM` instruction at its core.

While conventional processors rely on nested loops and multiple instructions to perform matrix multiplication, ASIP16 executes the entire operation as a **single instruction**. This is achieved through a hardware-controlled sequence managed by the CPU Control Unit, which:

1. Extracts matrix dimensions directly from the instruction encoding  

2. Traverses rows of matrix A and columns of matrix B  

3. Computes dot products via coordinated ALU operations and memory accesses  

4. Stores the resulting matrix back into memory  

5. Streams each computed element through the I/O interface  

The `MULM` instruction alone accounts for approximately **one-third of the ASIP control states**, underscoring the complexity of mapping a high-level algorithm to a fully hardware-driven execution model.

```text

Example: A(3×3) × B(3×1) = C(3×1)

A = | 2  0  1 |    B = | 1 |    C = |  5 |

    | 3  5  6 |        | 2 |        | 31 |

    | 7  8  9 |        | 3 |        | 50 |

```
All tensor operations (`ADDM`, `SUBM`, `ELMULM`, `MULM`) support configurable matrix dimensions (2×3, 1×3, 3×3, 2×2) and operate directly on memory-resident data, eliminating the need for intermediate register transfers.

---

## 7. How an Instruction Executes

To illustrate how the processor works at the signal level, here's what happens when `ADD X` executes — the accumulator adds the value in register X:

Every instruction follows this **fetch → decode → execute** pattern, with the Control Unit advancing through its one-hot FSM states and asserting the appropriate control signals at each step.

---

## Prerequisites

### Required

- **[Icarus Verilog](http://iverilog.icarus.com/)** — open-source Verilog simulator

```bash
# Debian / Ubuntu
sudo apt install iverilog

# Arch Linux
sudo pacman -S iverilog

# macOS (Homebrew)
brew install icarus-verilog
```

### Optional

- **[GTKWave](http://gtkwave.sourceforge.net/)** — waveform viewer for `.vcd` files

```bash
# Debian / Ubuntu
sudo apt install gtkwave

# macOS (Homebrew)
brew install --cask gtkwave
```

---

## 8. Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/LNM31/ASIP16-Processor.git
cd ASIP16-Processor
```

### 2. Make the run script executable

```bash
chmod +x run.sh
```

### 3. Run a program

**Interactive mode** — select from available programs:

```bash
./run.sh
```

```
Available programs:

  1) program.hex
  2) program_asip_add.hex
  3) program_asip_elmul.hex
  4) program_asip_mul.hex
  5) program_asip_sub.hex

Select program (1-5):
```

**Direct mode** — specify the program:

```bash
./run.sh program                 # General-purpose program
./run.sh program_asip_mul 1      # Matrix multiplication (2×3 matrices)
```

ASIP programs prompt for matrix dimensions:
- `1` → 2×3
- `2` → 1×3
- `3` → 3×3
- `4` → 2×2

### Providing Input During Simulation

The processor reads input through the I/O handshake protocol during execution. **For ASIP programs** (`program_asip_*.hex`), the input sequence is:

1. Enter the number of **rows** (N)
2. Enter the number of **columns** (M)
3. Enter the matrix elements **one by one** (row by row, for each matrix)

For `program_asip_mul` (matrix multiplication), you input both matrices sequentially — first all elements of matrix A, then all elements of matrix B.

> **For non-ASIP programs** (e.g., `program.hex`), refer to the comments inside the `.hex` file — they describe the expected input sequence for each specific program.

### 4. View waveforms (optional)

```bash
gtkwave SoC/soc_tb2.vcd
```

---

## 9. Design Highlights

| Feature | Description |
|--------|------------|
| Structural Design | No behavioral shortcuts, all signals explicitly defined |
| Modular Architecture | Components tested independently |
| FSM Control | Centralized execution control |
| Full Integration | Complete working processor system |

---

## 10. Project Goals

| Goal | Description |
|------|------------|
| Hardware Understanding | Learn processor internals |
| Structural HDL | Work at low-level design |
| Control Logic | Understand FSM behavior |
| Scalability | Build modular systems |

---

## 11. Supported Platforms

| Platform | Status |
|----------|--------|
| Linux | Tested |
| macOS | Should work (Homebrew support) |
| Windows | Not tested |

---

• Systems  
• Embedded Systems  
• Low-level & Computer Architecture
