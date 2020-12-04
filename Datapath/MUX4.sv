module MUX4 (
        input logic [31:0] A, B, C, D,
        input logic [1:0] SEL,
        output logic [31:0] OUT
    );
    
    always @(SEL) begin
        case(SEL)
            2'b00: OUT = A;
            2'b01: OUT = B;
            2'b10: OUT = C;
            2'b11: OUT = D;
            default: OUT = 'x;
        endcase
    end

    // assign OUT = (SEL == 0) ? A:
    //             (SEL == 1) ? B:
    //             (SEL == 2) ? C: D;

endmodule