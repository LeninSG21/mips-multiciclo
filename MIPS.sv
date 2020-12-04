module MIPS (
        input clk, rst, debug,
        input[6:0] sw_addr,
        input [31:0] debug_inst,
        output [3:0] state,
        output [31:0] pc, data
    );

    wire PCEn, IorD, MemRead, MemWrite,MemtoReg;
    wire IRWrite, RegWrite, RegDst, ALUSrcA, zero;
    wire [1:0] PCSource, ALUSrcB;
    wire [2:0] ALUSel;
    wire [5:0] opcode, func;

    datapath DP(.pc(pc), .out_data(data), .*);

    control_unit CU(.curr_state(state), .*);

endmodule