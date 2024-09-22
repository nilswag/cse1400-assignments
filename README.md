# CSE 1400 Assignments

Welcome to the **CSE1400 Assignments** repository. This is a private repository containing solutions to the programming assignments for the CSE1400 course.

> **Note**: This repository is private and intended solely for personal use. Sharing solutions or copying code from others is a violation of the academic integrity policy.

## Table of Contents
- [Overview](#overview)
- [Assignments](#assignments)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Building and Running](#building-and-running)
- [License](#license)

## Overview

This repository contains a collection of assignments that focus on the following topics in assembly language programming:

- Basic assembly syntax and instructions
- Working with registers and memory
- Conditional branching and loops
- Arithmetic and logic operations
- Function calls and stack manipulation
- Input/Output operations in assembly
- Optimizing assembly code

## Assignments

1. **Assignment 1: Power Calculation Program**
   - Write an assembly program that calculates powers (e.g., `x^y`). The program takes two inputs: the base `x` and the exponent `y`, and calculates `x` raised to the power `y`.
   - [View the source code](src/assignment-1.s)

2. **Assignment 2: Factorial (Recursion)**
   - Implement a recursive function in assembly that calculates the factorial of a number `n`. The program should take an integer `n` as input and return `n!` (the factorial of `n`) as output.
   - [View the source code](src/assignment-2.s)

3. **Assignment 3: Memory Management - Treasure Chest**
   - Develop an assembly program that simulates decoding ancient artifacts using memory management techniques. The program should manipulate memory directly to "decode" the artifacts stored in memory.
   - [View the source code](src/assignment-3.s)

> More assignments will be added as the course progresses.

## Project Structure

- `src/`: Contains the `.s` assembly source files for each assignment.
- `bin/`: Contains the compiled binaries and the executable for the corresponding assignments.

## Getting Started

### Prerequisites

To work with the assignments in this repository, you'll need the following:

- A Unix-based system that can run assembly (Linux)
- **GCC**: The GNU Compiler Collection for compiling the code.
- **GDB**: The GNU Debugger for debugging the assembly programs.
- **Make**: A build automation tool to simplify the build process.

You can install these tools using your package manager. For example, on Ubuntu, you can run:

```bash
sudo apt-get install gcc gdb make
```

### Installation

1. Clone the repository (for collaborators only):
   ```bash
   git clone git@github.com:nilswag/CSE1400-assignments.git
   ```

2. Navigate to the project directory:
   ```bash
   cd CSE1400-assignments
   ```

### Building and Running

- To build in debug mode:
  ```bash
  make debug
  ```

- To build in release mode:
  ```bash
  make release
  ```

- To build in debug mode and run the program:
  ```bash
  make run
  ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.