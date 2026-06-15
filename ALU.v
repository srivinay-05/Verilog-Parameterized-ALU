module ALU #(parameter WIDTH = 8, N = 4)
(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [N-1:0]     SEL,

    output reg [WIDTH-1:0] Y,

    output reg CF,
    output reg OF,
    output reg SF,
    output reg ZF,
    output reg DIV_F
);

reg [2*WIDTH-1:0] MUL_RESULT;

always @(*) begin

    Y          = {WIDTH{1'b0}};
    CF         = 1'b0;
    OF         = 1'b0;
    SF         = 1'b0;
    ZF         = 1'b0;
    DIV_F      = 1'b0;
    MUL_RESULT = {(2*WIDTH){1'b0}};

    case (SEL)

        // ADD
        4'b0000:
        begin
            {CF,Y} = A + B;
            OF = (~(A[WIDTH-1]^B[WIDTH-1])) &
                 (Y[WIDTH-1]^A[WIDTH-1]);
        end

        // SUB
        4'b0001:
        begin
            Y = A - B;
            CF = (A < B);

            OF = (A[WIDTH-1]^B[WIDTH-1]) &
                 (Y[WIDTH-1]^A[WIDTH-1]);
        end

        // MUL
        4'b0010:
        begin
            MUL_RESULT = A * B;
            Y = MUL_RESULT[WIDTH-1:0];
            OF = |MUL_RESULT[2*WIDTH-1:WIDTH];
        end

        // DIV
        4'b0011:
        begin
            if(B == 0)
            begin
                DIV_F = 1'b1;
                Y = 0;
            end
            else
                Y = A / B;
        end

        // AND
        4'b0100: Y = A & B;

        // OR
        4'b0101: Y = A | B;

        // XOR
        4'b0110: Y = A ^ B;

        // NOT
        4'b0111: Y = ~A;

        // INC
        4'b1000:
        begin
            {CF,Y} = A + 1'b1;
            OF = (A == {1'b0,{(WIDTH-1){1'b1}}});
        end

        // DEC
        4'b1001:
        begin
            Y = A - 1'b1;
            OF = (A == {1'b1,{(WIDTH-1){1'b0}}});
        end

        // LEFT SHIFT
        4'b1010:
        begin
            CF = A[WIDTH-1];
            Y  = A << 1;
        end

        // RIGHT SHIFT
        4'b1011:
        begin
            CF = A[0];
            Y  = A >> 1;
        end

        // ARITHMETIC RIGHT SHIFT
        4'b1100:
        begin
            CF = A[0];
            Y  = $signed(A) >>> 1;
        end

        // MODULO
        4'b1101:
        begin
            if(B == 0)
            begin
                DIV_F = 1'b1;
                Y = 0;
            end
            else
                Y = A % B;
        end

        // COMPARE EQUAL
        4'b1110:
        begin
            Y = (A == B);
        end

        // NOP
        4'b1111:
        begin
            Y = A;
        end

    endcase

    SF = Y[WIDTH-1];
    ZF = (Y == 0);

end

endmodule