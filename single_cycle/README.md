## RV32I Single Cycle Processor Implementation on verilog


<img src="https://github.com/muhammadtalhasami/rv32I_single_cycle_logisim/blob/main/single%20cycle%20logisim.jpeg">

This project implements a single-cycle processor based on the RV32I instruction set architecture using Verilog HDL. The processor supports 32-bit RISC-V instructions and executes them in a single clock cycle.

Single Cycle Processor
Features

    RV32I Instruction Set: Full support for the RV32I instruction set architecture, including arithmetic, logical, control transfer, and memory access instructions.
    Single Cycle Execution: Each instruction is executed in a single clock cycle, simplifying the design and providing deterministic performance.
    Modular Design: The processor is designed with modularity in mind, facilitating easy expansion and modification for future enhancements or customizations.
    Documentation: Comprehensive documentation is provided to explain the design choices, implementation details, and usage instructions.



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


## Getting Started

To simulate the RV32I single-cycle processor on your local machine, follow these steps:

Clone the Repository: Clone this GitHub repository to your local machine using the following command:



    git clone git@github.com:muhammadtalhasami/RV32I_Single_Cycle.git


## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request. Please follow the contribution guidelines when contributing to this project.

