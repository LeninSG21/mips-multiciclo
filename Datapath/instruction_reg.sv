module instruction_reg (
        input clk, IRWrite,
        input [31:0] dataIn,
        output [5:0] opcode, 
        output [4:0] rs_addr, rt_addr,
        output [15:0] instruction
    );
    
    reg [31:0] data;

    always @(posedge clk) begin
        if (IRWrite)
            data <= dataIn;
    end

    assign opcode = data[31:26];
    assign 

endmodule