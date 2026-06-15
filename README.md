# Verilog-Parameterized-ALU
RTL implementation of a configurable ALU in Verilog with Carry, Overflow, Zero, Sign, and Divide-by-Zero flag support.

## Features
- Parameterized Width
- Arithmetic Operations
- Logical Operations
- Zero Flag
- Carry Flag
- Overflow Flag
- Sign Flag
- Divide-by-Zero Flag

## Tools Used
- Verilog HDL
- Icarus Verilog
- GTKWave

## Parameters
| Parameter | Default | Description |
|-----------|---------|-------------|
| WIDTH | 8 | Width of A, B, Y |
| N | 4 | Width of SEL |

## Ports
| Port | Direction | Description |
|------|-----------|-------------|
| A, B | input | Operands |
| SEL | input | Operation select code |
| Y | output | Result |
| CF | output | Carry / Borrow flag |
| OF | output | Overflow flag |
| SF | output | Sign flag |
| ZF | output | Zero flag |
| DIV_F | output | Divide-by-zero flag |

## Opcode Table
| SEL | Operation |
|-----|-----------|
| 0000 | ADD |
| 0001 | SUB |
| 0010 | MUL |
| 0011 | DIV |
| 0100 | AND |
| 0101 | OR |
| 0110 | INCREMENT |
| 0111 | LEFT SHIFT |
| 1000 | RIGHT SHIFT |

## Verification
Testbench created to verify all operations and flag conditions.

## Future Improvements
- Pipelined ALU
- Integration with Datapath
- Processor Design
