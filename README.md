# APB Master Controller using Verilog HDL

## Overview

This project implements an **Advanced Peripheral Bus (APB) Master Controller** in Verilog HDL. The controller is designed as a Finite State Machine (FSM) that performs APB write transactions by following the APB protocol phases:

- IDLE
- SETUP
- ACCESS

The design was simulated and verified using Verilator and GTKWave, and synthesized using Yosys.

---

## Features

- APB Master Controller
- Finite State Machine (FSM)
- APB Write Transaction
- APB State Transitions
- RTL Synthesis
- Functional Simulation
- Waveform Verification

---

## Project Structure

```
APB-Protocol-Verilog/
│
├── apb_master.v      # APB Master RTL
├── apb_slave.v       # Testbench
├── output.pdf        # RTL schematic generated using Yosys
├── README.md
└── .gitignore
```

---

## Tools Used

- Verilog HDL
- Yosys
- Verilator
- GTKWave
- Graphviz
- Ubuntu (WSL)

---

## APB Protocol State Machine

```
          +-------+
          | IDLE  |
          +-------+
              |
              | transfer = 1
              v
          +--------+
          | SETUP  |
          +--------+
              |
              v
         +---------+
         | ACCESS  |
         +---------+
          |      |
     PREADY=0   PREADY=1
          |      |
          |      +----------------+
          |                       |
          +----> ACCESS           |
                                  |
                         transfer=1
                                  |
                              SETUP
                                  |
                             transfer=0
                                  |
                                IDLE
```

---

## Simulation

Simulation was performed using Verilator.

Example:

```bash
verilator --binary --trace apb_master.v apb_slave.v
./obj_dir/Vapb_master
```

---

## RTL Synthesis

RTL synthesis was performed using Yosys.

Example:

```yosys
read_verilog apb_master.v
hierarchy -top apb_master
proc
opt
show
```

---

## Output

- RTL Schematic generated using Graphviz
- Simulation waveform viewed using GTKWave

---

## Future Improvements

- APB Read Transactions
- Multiple APB Slaves
- AHB to APB Bridge
- APB3/APB4 Support
- Complete Bus Functional Verification

---

## Author

**Anushka Shinde**

Electronics & Communication Engineering Student

Interested in RTL Design, Digital Design, Embedded Systems and VLSI.
