module datapath (
        input clk, rst, PCEn,
        input IorD, MemRead, MemWrite, MemtoReg,
        IRWrite, RegWrite, RegDst, ALUSrcA,
        input [1:0] PCSource, ALUSrcB,
        input [2:0] ALUSel,
        output [5:0] opcode,func,
		  output zero,
          output [31:0] curr_pc
    );
    

	wire [31:0] alu_res, alu_out, alu_inA, alu_inB;
wire [4:0] write_register;
    wire [31:0] write_data, rf_A, rf_B;

    wire [31:0] next_pc;
    wire [25:0] jmp_offset;

    wire [31:0] inst_32b;

    /******** MEMORY *************/
    wire [4:0] rs_addr, rt_addr;
    wire [15:0] instruction;
    wire [31:0] mem_data, data, mem_addr;

    assign func = instruction[5:0];

    assign mem_addr = IorD ? alu_out : curr_pc;

    memory RAM(.clk(clk), .we(MemWrite), .re(MemRead),.Address(mem_addr), .w_data(rf_B),  .mem_data(mem_data));

    instruction_reg IR(.clk(clk), .dataIn(mem_data), .IRWrite(IRWrite),
        .opcode(opcode), .rs_addr(rs_addr), .rt_addr(rt_addr), .instruction(instruction));
    data_reg DR(.clk(clk), .dataIn(mem_data), .dataOut(data));

    /************* REGISTER FILE ***************/
    

    //MUXES
    assign write_data = MemtoReg ? data : alu_out;
    assign write_register = RegDst ? instruction[15:11] : rt_addr;
    
    rf RF(.clk(clk), .rst(rst), .we(RegWrite), .rs_addr(rs_addr), .rt_addr(rt_addr), 
    .rd_addr(write_register), .rd_data(write_data), .rs_data(rf_A), .rt_data(rf_B));


    /************** ALU **************************/

    

    assign alu_inA = ALUSrcA ? rf_A : curr_pc;
	 
    assign alu_inB = (ALUSrcB == 0) ? rf_B :
                    (ALUSrcB == 1) ? 32'b1 : inst_32b;

    alu ALU(.A(alu_inA), .B(alu_inB),  .sel(ALUSel), .out(alu_res), .zero(zero));

    data_reg ALUOut(.clk(clk), .dataIn(alu_res), .dataOut(alu_out));


    /***************** PC *********************/


    assign jmp_offset = {rs_addr, rt_addr, instruction};

    assign next_pc = (PCSource == 0) ? alu_res :
                      (PCSource == 1) ? alu_out : {curr_pc[31:26] , jmp_offset};

    pc PC(.clk(clk), .rst(rst), .pc_en(PCEn), .next_inst(next_pc), .curr_inst(curr_pc));

    /***************** SIGN EXTEND ***************/


    sign_extend SE32(.signal_in(instruction), .signal_out(inst_32b));

endmodule