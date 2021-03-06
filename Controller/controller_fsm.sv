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
	ERROR		 = 4'bXXXX
} fsm_state;

module controller_fsm (
        input rst, clk,
        input [5:0] opcode,
        output reg PCWriteCond, PCWrite,
        IorD, MemRead, MemWrite, MemtoReg,
        IRWrite, RegWrite, RegDst, ALUSrcA,
        output reg [1:0] PCSource, ALUSrcB, ALUOp 
    );
    
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter R = 6'b0;
    parameter JMP = 6'b000010;
    parameter ADDI = 6'b001000;

    fsm_state state, nxtstate;
    
    // FSM STATE REGISTER, SEQUENTIAL LOGIC
	always @(posedge clk)
        state <= (rst) ? INIT : nxtstate;

    // FSM COMBINATORIAL LOGIC;   STATE TRANSITION LOGIC
    always @(state) begin
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
            EXEC: nxtstate = RCOMP;
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
                    IorD = 0;
                    ALUSrcB = 2'b01;
                    ALUOp = 2'b00;
                    PCSource = 2'b00;
                end
	    DECODE:
                begin
                    ALUSrcA = 0;
                    ALUSrcB = 2'b11;
                    ALUOp = 2'b00;
                end
	    MADDR:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;
                end
	    MEMLW:
                begin
                    IorD = 1;
                end
	    MEMR:
                begin
                    RegDst = 0;
                    MemtoReg = 1;
                end
	    MEMSW:
                begin
                    IorD = 1;
                end
	    EXEC:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b10;
                end
	    RCOMP:
                begin
                    RegDst = 1;
                    MemtoReg = 0;
                end
	    BRANCH:
                begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b01;
                    PCSource = 2'b01;
                end
	    JUMP:
                begin
                    PCSource = 2'b10;
                end
        IMM:    begin
                    RegDst = 0;
                    MemtoReg = 0;
                end
        default:
                begin
                    PCWriteCond = 'x;
                    PCWrite = 'x;
                    IorD = 'x;
                    MemWrite = 'x;
                    MemtoReg = 'x;
                    IRWrite = 'x;
                    RegWrite ='x;
                    RegDst = 'x;
                    ALUSrcA = 'x;
                    PCSource = 'x;
                    ALUSrcB = 'x;
                    ALUOp = 'x;
                end
     endcase
    end

endmodule