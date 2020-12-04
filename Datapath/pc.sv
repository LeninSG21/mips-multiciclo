// Program Counter block
module pc(
  input clk, rst, pc_en,
  input [31:0] next_inst,
  output reg [31:0] curr_inst
);
  
  always @ (posedge clk) begin
    if(rst)
      curr_inst <= 32'b0;
    else if(pc_en)
      curr_inst <= next_inst;
    end
    
endmodule