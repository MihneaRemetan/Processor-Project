# 16-bit Processor (Structural Verilog)

A custom-built 16-bit processor designed and implemented entirely in **structural Verilog**, focusing on low-level hardware design, modularity, and precise control logic.

---

## 🚀 Overview

This project represents a complete processor system built from the ground up using a **fully structural approach**. The design avoids high-level behavioral constructs and instead relies on explicit hardware modeling, where control signals and datapaths are defined at a low level.

The processor is capable of executing real programs loaded into memory and supports a diverse instruction set including:
- arithmetic and logic operations  
- branching and control flow  
- stack manipulation  
- basic input/output operations  

The system is integrated as a **System-on-Chip (SoC)**, combining CPU, memory, and I/O components under a single clock domain.

---

## 🏗️ Architecture

The processor follows a classical structure based on two main subsystems:

- **Datapath** – responsible for computations and data transfers  
- **Control Unit** – orchestrates execution by generating control signals  

The design uses a **modular hierarchy**, allowing each component to be developed and tested independently before full integration.

### Key Characteristics

- 16-bit architecture  
- unified memory (instructions + data)  
- fixed instruction width  
- accumulator-based execution model  
- centralized control logic implemented as an FSM  

---

## 🧩 Core Components

- **ALU (Arithmetic Logic Unit)**  
  Handles arithmetic and logical operations, including multi-cycle operations such as multiplication and division.

- **Control Unit**  
  Implements a finite state machine responsible for instruction decoding and control signal generation.

- **Registers**  
  Include general-purpose registers, accumulator, program counter, stack pointer, and status flags.

- **Memory**  
  Stores both instructions and data in a unified address space.

- **I/O Subsystem**  
  Uses handshake-based communication for interaction with external inputs and outputs.

- **SoC Layer**  
  Integrates all modules into a single functional system.

---

## 🧪 Verification & Testing

Each module is validated using dedicated **testbenches**, ensuring correctness before system integration.

Verification methods include:
- simulation-based testing  
- waveform inspection  
- signal-level debugging  

This ensures correctness at both component level and full system level.

---

## ⚙️ Instruction Set

The processor supports multiple instruction categories:

- memory operations (load/store)  
- arithmetic and logic operations  
- branching and control flow  
- stack operations  
- input/output instructions  

These allow execution of non-trivial programs directly on the simulated hardware.

---

## 🛠️ Technologies

- Verilog (structural design)  
- Icarus Verilog (simulation)  
- GTKWave (waveform analysis)  

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

- Fully structural implementation – no behavioral shortcuts, all control signals explicitly defined  
- Modular architecture – each component can be tested independently  
- Dedicated control logic (FSM) – precise control over execution flow  
- System-level integration – CPU, memory, and I/O combined into a working SoC  

---

## 🎯 Project Goals

- Understand processor design at hardware level  
- Build a system using structural HDL techniques  
- Explore control signal generation and FSM design  
- Practice modular and scalable hardware architecture  

---

## ⚠️ Notes

- This project focuses on simulation and architecture, not FPGA synthesis  
- Designed primarily for educational purposes  

---

## 👤 Author

**Mihnea Remețan**  
• Systems  
• Embedded Systems  
• Low-level & Computer Architecture
