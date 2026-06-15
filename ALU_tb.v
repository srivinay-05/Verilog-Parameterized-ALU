`timescale 1ns/1ps

module ALU_tb;

parameter WIDTH = 8;
parameter N     = 4;

reg  [WIDTH-1:0] A;
reg  [WIDTH-1:0] B;
reg  [N-1:0]     SEL;

wire [WIDTH-1:0] Y;
wire CF;
wire OF;
wire SF;
wire ZF;
wire DIV_F;

// DUT
ALU #(WIDTH,N) dut (
    .A(A),
    .B(B),
    .SEL(SEL),
    .Y(Y),
    .CF(CF),
    .OF(OF),
    .SF(SF),
    .ZF(ZF),
    .DIV_F(DIV_F)
);

initial begin

    $dumpfile("alu.vcd");
    $dumpvars(0, ALU_tb);

    $display("TIME\tSEL\tA\tB\tY\tCF OF SF ZF DIV_F");
    $monitor("%0t\t%b\t%d\t%d\t%d\t%b  %b  %b  %b   %b",
             $time, SEL, A, B, Y, CF, OF, SF, ZF, DIV_F);

    //==================================
    // ADD
    //==================================
    A=20; B=10; SEL=4'b0000; #10;

    // SUB
    A=20; B=5; SEL=4'b0001; #10;

    // MUL
    A=15; B=10; SEL=4'b0010; #10;

    // DIV
    A=100; B=5; SEL=4'b0011; #10;

    // AND
    A=8'b11001100;
    B=8'b10101010;
    SEL=4'b0100; #10;

    // OR
    SEL=4'b0101; #10;

    // XOR
    SEL=4'b0110; #10;

    // NOT
    A=8'b11001100;
    SEL=4'b0111; #10;

    // INC
    A=25;
    SEL=4'b1000; #10;

    // DEC
    A=25;
    SEL=4'b1001; #10;

    // LEFT SHIFT
    A=8'b10010110;
    SEL=4'b1010; #10;

    // RIGHT SHIFT
    A=8'b10010110;
    SEL=4'b1011; #10;

    // ARITHMETIC RIGHT SHIFT
    A=8'b10010110;
    SEL=4'b1100; #10;

    // MODULO
    A=25;
    B=7;
    SEL=4'b1101; #10;

    // COMPARE EQUAL (TRUE)
    A=50;
    B=50;
    SEL=4'b1110; #10;

    // COMPARE EQUAL (FALSE)
    A=50;
    B=20;
    SEL=4'b1110; #10;

    // NOP
    A=99;
    SEL=4'b1111; #10;

    //==================================
    // SPECIAL CASES
    //==================================

    // ADD OVERFLOW
    A=8'd127;
    B=8'd1;
    SEL=4'b0000;
    #10;

    // DIVIDE BY ZERO
    A=8'd100;
    B=8'd0;
    SEL=4'b0011;
    #10;

    // MOD BY ZERO
    A=8'd100;
    B=8'd0;
    SEL=4'b1101;
    #10;

    // ZERO FLAG TEST
    A=8'd10;
    B=8'd10;
    SEL=4'b0001;
    #10;

    $finish;

end

endmodule