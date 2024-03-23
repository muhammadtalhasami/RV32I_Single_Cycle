# RV32I Fetch Pipeline Microprocessor
<img src="https://github.com/muhammadtalhasami/RV32I_Single_Cycle/assets/141629485/019febde-0848-4ea4-9289-8e0daf7f9e41" alt="RV32I Fetch Pipeline Microprocessor Image">

This repository contains an implementation of a RV32I fetch pipeline microprocessor. The RV32I is a 32-bit RISC-V instruction set architecture, with the 'I' extension indicating the base integer instructions.

## Overview

The RV32I fetch pipeline microprocessor is designed to efficiently fetch and execute RV32I instructions. It consists of several stages including instruction fetch, decode, execute, memory access, and write back. Each stage is optimized for performance and minimal latency.

## Features

- RV32I instruction set support
- Pipelined architecture for improved throughput
- Efficient instruction fetch mechanism
- Modular design for easy expansion and customization

## Getting Started

To get started with the RV32I fetch pipeline microprocessor, follow these steps:

1. Clone this repository to your local machine:

```bash
git clone https://github.com/muhammadtalhasami/RV32I_Single_Cycle
```

### Test cases 

#### Program 1
```
addi x5 x0 0
addi x6 x0 5
add x8 x6 x5
LOOP:
addi x5 x5 1
sw x5 100(x0)
beq x5 x6 ANS
jal LOOP
ANS: lw x7 100(x0)

```
#### Program 2
```
addi x5 x0 3
LOOP:
addi x5 x5 1
addi x6 x0 7
sw x6 100(x5)
lw x7 100(x5)
bne x5 x7 LOOP

```
#### Program 3
```
addi x5 x0 0
addi x7 x0 1
addi x6 x0 10
addi x28 x0 0
LOOP: beq x28 x6 END
add x29 x5 x7
add x5 x0 x7
add x7 x0 x29
jal LOOP
END:
```
#### Fibonacci Series:
```
addi x1,x0,0
addi x2,x0,1
addi x10,x0,4
addi x6,x0,40
addi x3,x0,0
addi x4,x3,4
sw x1,0x100(x3)
sw x2,0x100(x4)
addi x14,x0,8
addi x5,x0,8
addi x13,x0,8
addi x15,x0,4
addi x9,x0,4
add x8,x1,x2
up:
beq x5,x6,end
add x12,x0,x8
sw x12,0x100(x5)
lw x11,0x100(x9)
add x8,x11,x8
addi x5,x5,4
addi x9,x9,4
jal x7,up
end:
beq x3,x6,break
lw x16,0x100(x3)
addi x3,x3,4
jal x7,end
break:
```

## Contribution Guidelines

Contributions to improve the RV32I fetch pipeline microprocessor are welcome! If you'd like to contribute, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: git checkout -b feature-name.
3. Make your changes and commit them with a descriptive message: git commit -m "Description of your changes".
4. Push your changes to your fork: git push origin feature-name.
5. Submit a pull request to the main repository's master branch.

Please ensure that your code follows the project's coding style and conventions. Also, include tests for any new functionality or fixes you implement.
