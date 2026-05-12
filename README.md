# 🧠 Processor Project (Structural Verilog)

A modular processor architecture implemented entirely in **structural Verilog**, designed to demonstrate clear separation between datapath and control logic, as well as scalable hardware design principles.

---

## 🚀 Overview

This project implements a complete processor system using a **hierarchical and modular approach**, where each hardware component is designed, tested, and validated independently before full integration.

The processor includes:
- Arithmetic Logic Unit (ALU)
- Control Unit (CU)
- Register File
- Memory modules
- Input/Output components
- System-on-Chip (SoC) integration layer

The design emphasizes **clean architecture**, **testability**, and **hardware-level correctness** through simulation.

---

## 🏗️ Architecture

The processor is built around two main components:

- **Datapath** – responsible for data movement and computation  
- **Control Unit** – generates control signals based on instruction decoding  

Each module is implemented structurally and interconnected to form the full system.

---

## 🧩 Key Components

- **ALU** – performs arithmetic and logical operations  
- **Control Unit** – instruction decoding and control signal generation  
- **Registers** – intermediate data storage  
- **Memory** – instruction and/or data storage  
- **I/O Modules** – interaction with external environment  
- **SoC Layer** – top-level integration of all components  

---

## 🧪 Verification & Testing

Each module is verified using **dedicated testbenches**.

Validation is done through:
- Simulation
- Waveform analysis
- Signal-level debugging

This ensures correctness both at:
- component level
- full system level

---

## 🎯 Goals

- Demonstrate a **structural hardware design approach**
- Build a **modular and scalable processor**
- Enable **independent testing of components**
- Practice **low-level system design and architecture**

---

## 🛠️ Technologies

- Verilog (structural)
- Hardware simulation tools (e.g. ModelSim / Vivado / etc.)
- Waveform analysis tools

---

## 📂 Project Structure
/alu
/control_unit
/registers
/memory
/io
/soc
/testbenches

---

## ▶️ How to Run

1. Open the project in your preferred HDL simulator  
2. Run the testbenches for individual modules  
3. Run full system simulation  
4. Inspect waveforms to validate behavior  

---

## 📌 Notes

This project focuses on **architecture and hardware design**, not on synthesis for a specific FPGA.

More detailed explanations can be found in the accompanying documentation.

---

- Systems & Embedded
- Low-level & Computer Architecture
