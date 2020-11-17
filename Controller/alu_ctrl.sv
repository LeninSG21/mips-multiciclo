typedef enum logic [2:0] { 
    AND = 3'b000, 
    OR  = 3'b001, 
    ADD = 3'b010, 
    SUB = 3'b110, 
    SLT = 3'b111
} ALUOp;

module alu_ctrl (
        input [1:0] ALUOp,
        input [5:0] func,
        output reg[2:0] ALUSel
    );
    
    always @(ALUOp or func) begin
        case(ALUOp)
            2'b00: ALUSel = ADD;
            2'b01: ALUSel = SUB;
            2'b10: begin
                case(func)
                    6'h20   : ALUSel = ADD;
                    6'h22   : ALUSel = SUB;
                    6'h24   : ALUSel = AND;
                    6'h25   : ALUSel = OR;
                    6'h2A   : ALUSel = SLT;
                    default : ALUSel = 'X;
                endcase
            end 
            default: ALUSel = 'X;
        endcase
    end

endmodule