
module MIPS (
        input clk, rst
    );

    wire PCEn, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegWrite, RegDst, ALUSrcA, zero;
    wire [1:0] PCSource, ALUSrcB;
    wire [2:0] ALUSel;
    wire [5:0] opcode, func;
    
    datapath DP(.*);

    control_unit CU(.*);

endmodule