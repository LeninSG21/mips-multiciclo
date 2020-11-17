`include "controller_fsm.sv"
`include "alu_ctrl.sv"
module control_unit (
        input rst, clk, zero,
        input [5:0] opcode, func, 
        output IorD, MemRead, MemWrite, MemtoReg,
        IRWrite, RegWrite, RegDst, ALUSrcA,
        output reg PCEn,
        output [1:0] PCSource, ALUSrcB,
        output [2:0] ALUSel
    );
    
    wire PCWriteCond, PCWrite, ALUOp;

    assign PCEn = (PCWriteCond & zero) | PCWrite;

    controller_fsm FSM(.*);
    alu_ctrl ALU_CTRL(.*);

endmodule