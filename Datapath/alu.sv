//ALU module
module alu(
 	input [31:0] A,B,  // ALU 32-bit Inputs                 
    input [2:0] sel,// ALU Selector
    output reg [31:0] out, // ALU 32-bit Output
  	output reg zero  //zero flag
	);
  parameter AND =  3'b000;
  parameter OR  =  3'b001;
  parameter ADD =  3'b010;
  parameter SUB =  3'b110;
  parameter SLT =  3'b111;
  parameter SRLV = 3'b011;

  assign zero = out == 0;
  
  always @(*) //Error pasado, alu solo cambia al cambiar el selector
    begin
      
      case(sel)
        AND   : out = A & B;
        OR    : out = A | B;
        ADD   : out = A + B;
        SUB   : out = A -B;
        SLT   : out = A < B;
        SRLV  : out = B >> A;
        default : out = 'x;
      endcase
    end

endmodule