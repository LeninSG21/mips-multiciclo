
module MIPS (
        input clk, rst
        input [7:0] sw_addr,
        output [3:0] curr_state,
        output [31:0] out_data,
        output [31:0] pc
    );

    wire PCEn, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegWrite, RegDst, ALUSrcA, zero;
    wire [1:0] PCSource, ALUSrcB;
    wire [2:0] ALUSel;
    wire [5:0] opcode, func;
    
    datapath DP(.curr_pc(pc), .*);

    control_unit CU(.*);

endmodule