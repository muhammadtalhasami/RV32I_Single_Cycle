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

## Compilation

For compilation you have too run make and for clean use make clean 
For gtkwave run this 
```
gtkwave temp/coremain.vcd
```

There is a flowing Test programs giving below with its dump code 
so simply you have to copy paste that dump code on instru.mem file in test bench folder name(tb)

### Test cases

#### Program 1
```
top:
addi x2,x0,10
add  x2,x2,x2
jal x1,jump
addi x3,x2,30
lui x4,1
auipc x5,0x1000
bne x2,x3,label
jump:
add x6,x3,x2
jalr x0,x1,0x0
label:
sw x6,0x4(x2)
lw x7,0x4(x2)
jal x1,top
```
#### Dump code 1
```
00A00113
00210133
014000EF
01E10193
00001237
01000297
00311663
00218333
00008067
00612223
00412383
FD5FF0EF
```

#### Program 2
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

#### Dump code 2
```
00000293
00500313
00530433
00128293
06502223
00628463
FF5FF0EF
06402383
```


#### Program 3
```
addi x5 x0 3
LOOP:
addi x5 x5 1
addi x6 x0 7
sw x6 100(x5)
lw x7 100(x5)
bne x5 x7 LOOP
```

#### Dump code 3
```
00300293
00128293
00700313
0662A223
0642A383
FE7298E3
```

#### Program 4
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


#### Dump code 4
```
00000293
00100393
00A00313
00000E13
006E0A63
00728EB3
007002B3
01D003B3
FF1FF0EF
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

#### Dump code 
```
00000093
00100113
00400513
02800313
00000193
00418213
1011A023
10222023
00800713
00800293
00800693
00400793
00400493
00208433
02628063
00800633
10C2A023
1004A583
00858433
00428293
00448493
FE5FF3EF
00618863
1001A803
00418193
FF5FF3EF
```

## Contribution Guidelines

Contributions to improve the RV32I fetch pipeline microprocessor are welcome! If you'd like to contribute, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: git checkout -b feature-name.
3. Make your changes and commit them with a descriptive message: git commit -m "Description of your changes".
4. Push your changes to your fork: git push origin feature-name.
5. Submit a pull request to the main repository's master branch.

Please ensure that your code follows the project's coding style and conventions. Also, include tests for any new functionality or fixes you implement.
