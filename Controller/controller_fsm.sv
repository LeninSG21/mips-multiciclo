//STATE ENCODING
typedef enum reg [3:0]
{
	INIT         = 4'b1111,
    FETCH		 = 4'b0000,
	DECODE		 = 4'b0001,
	MADDR	     = 4'b0010,
	MEMLW		 = 4'b0011,
	MEMR		 = 4'b0100,
	MEMSW		 = 4'b0101,
	EXEC         = 4'b0110,
	RCOMP        = 4'b0111,
	BRANCH       = 4'b1000,
	JUMP         = 4'b1001,
    IMM          = 4'b1010,
    JR           = 4'b1011,
	ERROR		 = 4'bXXXX
} fsm_state;

module controller_fsm (
        input rst, clk,
        input [5:0] opcode,func,
        output reg PCWriteCond, PCWrite,
        IorD, MemRead, MemWrite, MemtoReg,
        IRWrite, RegWrite, RegDst, ALUSrcA,
        output reg [1:0] PCSource, ALUSrcB, ALUOp,
        output [3:0] curr_state
    );
    
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter R = 6'b0;
    parameter JMP = 6'b000010;
    parameter ADDI = 6'b001000;

    fsm_state state, nxtstate;

    assign curr_state = state;

    // FSM STATE REGISTER, SEQUENTIAL LOGIC
	always @(posedge clk) 
        state <= (rst) ? INIT : nxtstate;
    // FSM COMBINATORIAL LOGIC;   STATE TRANSITION LOGIC
    always @(state or opcode or func) begin
        case(state)
            INIT: nxtstate = FETCH;
            FETCH : nxtstate = DECODE;
            DECODE: begin
                case(opcode)
                    LW  : nxtstate = MADDR;
                    SW  : nxtstate = MADDR;
                    ADDI: nxtstate = MADDR;
                    R   : nxtstate = EXEC;
                    BEQ : nxtstate = BRANCH;
                    JMP : nxtstate = JUMP;
                    default: nxtstate = ERROR;
                endcase
                end
            MADDR: begin
                    case(opcode)
                        LW : nxtstate = MEMLW;
                        SW : nxtstate = MEMSW;
                        ADDI: nxtstate = IMM;
                        default : nxtstate = ERROR; 
                    endcase
                end
            MEMLW: nxtstate = MEMR;
            MEMR: nxtstate =  FETCH;
            MEMSW: nxtstate =   FETCH;
            EXEC: begin
                case(func)
                    6'd8 : nxtstate = JR;
                    default : nxtstate = RCOMP;
                endcase 
            end
            RCOMP: nxtstate = FETCH;
            BRANCH:  nxtstate = FETCH;
            JUMP  : nxtstate = FETCH;
            IMM   : nxtstate = FETCH;
            default: nxtstate = INIT;
        endcase
    
    end

    always @(state) begin
        MemRead = (state == FETCH) | (state == MEMLW);
        IRWrite = (state == FETCH);
        PCWrite = (state == FETCH) | (state == JUMP);
        MemWrite = (state == MEMSW);
        RegWrite = (state == MEMR) | (state == RCOMP) | (state == IMM);
        PCWriteCond = (state == BRANCH);
    end

    //OUTPUT LOGIC
    always @(state)
    begin
    case(state)
        FETCH: 
                begin
                    ALUSrcA = 0;
                    ALUSrcB = 2'b01;
                    ALUOp = 2'b00;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h0;
                end
	    DECODE:
                begin
                    ALUSrcA = 0;
                    ALUSrcB = 2'b11;
                    ALUOp = 2'b00;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h1;
                end
	    MADDR:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h2;
                end
	    MEMLW:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                    IorD = 1;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h3;
                end
	    MEMR:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                    IorD = 1;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 1;
                    //curr_state = 4'h4;
                end
	    MEMSW:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                    IorD = 1;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h5;
                end
	    EXEC:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b10;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h6;
                end
	    RCOMP:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b10;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 1;
                    MemtoReg = 0;
                    //curr_state = 4'h7;
                end
	    BRANCH:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b01;
                    IorD = 0;
                    PCSource = 2'b01;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h8;
                end
	    JUMP:
                begin
                    ALUSrcA = 0;
                    ALUSrcB = 2'b11;
                    ALUOp = 2'b00;
                    IorD = 0;
                    PCSource = 2'b10;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'h9;
                end
        IMM:    begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'hA;
                end
        JR  : begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b10;
                    IorD = 0;
                    PCSource = 2'b00;
                    RegDst = 0;
                    MemtoReg = 0;
                    //curr_state = 4'hB;
                end
        default:
                begin
                    ALUSrcA  ='x;
                    ALUSrcB  ='x;
                    ALUOp    ='x;
                    IorD     ='x;
                    PCSource ='x;
                    RegDst   ='x;
                    MemtoReg ='x;
                    //curr_state = 4'hF;
                end
     endcase
    end

endmodule