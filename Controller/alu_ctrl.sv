module alu_ctrl (
        input [1:0] ALUOp,
        input [5:0] func,
        output reg[2:0] ALUSel
    );

    parameter AND  = 3'b000; 
    parameter OR   = 3'b001; 
    parameter ADD  = 3'b010; 
    parameter SUB  = 3'b110; 
    parameter SLT  = 3'b111;
    parameter SRLV = 3'b011;
    
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
                    6'h06   : ALUSel = SRLV;
                    6'h08   : ALUSel = ADD; //JR
                    default : ALUSel = 'X;
                endcase
            end 
            default: ALUSel = 'X;
        endcase
    end

endmodule