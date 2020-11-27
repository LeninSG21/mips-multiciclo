
module MIPS (
        input clk, rst, 
        output [3:0] state
    );

    wire PCEn, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegWrite, RegDst, ALUSrcA, zero;
    wire [1:0] PCSource, ALUSrcB;
    wire [2:0] ALUSel;
    wire [5:0] opcode, func;
    wire [3:0] curr_state;
    
    // assign state = 1 ? curr_state : 'x;

    datapath DP(.*);

    control_unit CU(.*);

endmodule