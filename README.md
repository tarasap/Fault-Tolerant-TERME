# Fault-Tolerant-TERME

A fault-tolerant RISC-V processor based on the TERME core, using selective hardware redundancy for fault detection, fault masking, and recovery at the RTL level.

## Overview

**Fault-Tolerant-TERME** is a fault-tolerant implementation of the TERME RISC-V processor that explores selective hardware redundancy as an alternative to duplicating or triplicating the complete processor.

The design combines:

* **Dual Modular Redundancy (DMR)** for fault detection in the front-end execution path
* **Triple Modular Redundancy (TMR)** for fault masking at the write-back boundary
* **Reset Point (RP) based recovery** for detected faults
* **SECDED ECC** for protection of the architectural register file
* RTL-level fault injection and simulation-based verification

The architecture follows the general protection philosophy of the Hardisc safety-oriented RISC-V processor, while adapting the approach to the substantially shallower TERME pipeline. The protected design duplicates logic where disagreement can be detected before architectural state is affected, and triplicates logic where a corrupted result must be masked before reaching architectural state.

## Key Features

| Feature                  | Implementation                                            |
| ------------------------ | --------------------------------------------------------- |
| Processor                | TERME RISC-V                                              |
| Fault detection          | Dual Modular Redundancy (DMR)                             |
| Fault masking            | Triple Modular Redundancy (TMR)                           |
| Recovery                 | Reset Point based pipeline recovery                       |
| Register-file protection | Hamming SECDED                                            |
| Fault injection          | RTL simulation using hierarchical force/release           |
| Verification             | Embedded software stress tests + targeted fault injection |
| Implementation level     | Synthesizable RTL                                         |

## Architecture

The protected processor is organized around a selective-redundancy approach.

### DMR Front End

Two independent front-end execution paths operate on the same instruction stream:



```mermaid
flowchart TD
  IM[Instruction Memory]
  ILD[Instruction Load / Decode]

  subgraph FE [Front-end]
    direction TB
    FE0[FE0]
    FE1[FE1]
  end

  COMP[FE Comparator]
  MISMATCH[mismatch detected]

  IM --> ILD
  ILD --> FE0
  ILD --> FE1
  FE0 --> COMP
  FE1 --> COMP
  COMP --> MISMATCH
```

The two paths independently perform decode, operand processing, ALU operations, branch resolution, and program-counter calculations. Their outputs are continuously compared to detect disagreement.

A mismatch causes the current execution to be flushed and execution to restart from a protected Reset Point.

## TMR Write-Back Protection

After the detection boundary, the design uses three backend instances. The majority voter performs bitwise two-out-of-three voting on the relevant backend results.

Consequently, a single faulty backend result can be masked without corrupting the value committed to architectural state.

## Reset Point Recovery

Detected front-end faults are recovered using a dedicated **Reset Point Register**.

The register stores the address of the next known-good instruction. When a fault is detected:

1. The current pipeline activity is flushed.
2. The faulting execution path is prevented from committing.
3. Both front-end paths redirect their program counters to the stored Reset Point.
4. Execution resumes from the previously verified instruction boundary.

This avoids the need to protect the program counter through every internal pipeline stage.

## Register File Protection

The architectural register file is protected independently using an extended Hamming **SECDED** code.

The current design uses a **39-bit codeword for 32-bit architectural data**, consisting of the data bits, Hamming parity bits, and an overall parity bit.

The protection flow is:

```mermaid
flowchart TD
  WR[Register Write]
  ECCENC[ECC Encode]
  ECCPRO[ECC-protected Register File]
  ECCDEC[ECC Decode]
  ECCCOR[ECC Correct]
  DATA[Corrected data]

  WR --> ECCENC
  ECCENC --> ECCPRO
  ECCPRO --> ECCDEC
  ECCDEC --> ECCCOR
  ECCCOR --> DATA
```
Single-bit errors can be corrected transparently, while multi-bit error conditions can be detected as uncorrectable depending on the observed syndrome and parity information.

## Fault-Tolerance Mechanisms

The project separates fault tolerance into three main functions:

### 1. Detection

DMR compares redundant execution paths and detects disagreements before corrupted execution can reach architectural state.

### 2. Masking

TMR and majority voting prevent a single faulty backend computation from propagating to the register file or data-memory interface.

### 3. Recovery

Detected DMR faults trigger a pipeline flush and restart from a protected Reset Point.

### 4. Register-File Protection

SECDED ECC independently protects stored architectural state.





## Project Structure

The repository is currently focused on the RTL implementation.

```text
Fault-Tolerant-TERME/
├── rtl/
│   ├── ...
│   ├── Pipeline/
│   ├── Pipe_Manager/
│   ├── TERME_Protected
│   └── ...
├── README.md
└── ...
```

The directory structure will be expanded as simulation files, test programs, scripts, and documentation are added.

## Simulation

> Simulation instructions will be added here.

The intended verification flow is:

```text
RTL
 │
 ▼
Compile
 │
 ▼
Run testbench
 │
 ├── Functional stress tests
 │
 └── Fault injection
        │
        ▼
   Check detection,
   recovery and masking
```

## Status

**Current status:** RTL implementation and simulation-based validation.

The repository is being developed as a research-oriented hardware project for studying fault-tolerant RISC-V processor architectures.
