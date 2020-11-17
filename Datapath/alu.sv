//ALU module
module alu(
 	input [31:0] A,B,  // ALU 32-bit Inputs                 
    input [2:0] sel,// ALU Selector
    output reg [31:0] out, // ALU 32-bit Output
  	output reg zero  //zero flag
	);
  
  assign zero = out == 0;
  
  always @(*) //Error pasado, alu solo cambia al cambiar el selector
    begin
      
      case(sel)
        3'b000  : out = A & B;
        3'b001  : out = A | B;
        3'b010  : out = A + B;
        3'b110  : out = A - B;
        3'b111  : out = A < B;
        default : out = 'x;
      endcase
    end

endmodule