
module MIPS (
        input clk, rst, 
        input[6:0] sw_addr,
        output [3:0] state,
        output [31:0] pc, data
    );

    wire PCEn, IorD, MemRead, MemWrite, MemtoReg, IRWrite, RegWrite, RegDst, ALUSrcA, zero;
    wire [1:0] PCSource, ALUSrcB;
    wire [2:0] ALUSel;
    wire [5:0] opcode, func;
    // wire [3:0] curr_state;
    // wire [31:0] curr_pc, out_data;
    
    // assign state = 1 ? curr_state : 'x;

    // assign state = curr_state;
    // assign pc = curr_pc;
    // assign data = out_data;

    datapath DP(.pc(pc), .out_data(data), .*);

    control_unit CU(.curr_state(state), .*);

endmodule