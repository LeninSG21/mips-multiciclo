`timescale 1ns/1ps

module FSM_tb;
  
  parameter LW = 6'b100011;
  parameter SW = 6'b101011;
  parameter BEQ = 6'b000100;
  parameter R = 6'b0;
  parameter JMP = 6'b000010;
  parameter ADDI = 6'b001000;
  
  reg rst, clk;
  reg [5:0] opcode;
  wire PCWriteCond, PCWrite,
        IorD, MemRead, MemWrite, MemtoReg,
        IRWrite, RegWrite, RegDst, ALUSrcA;
  wire [1:0] PCSource, ALUSrcB, ALUOp;
  
  controller_fsm UUT(.*);
  
  initial begin
    $dumpfile("controller_fsm.vcd");
    $dumpvars(0, FSM_tb);
    
    
    clk = 0;
    rst = 1;
    opcode = R;
    
    #1
    rst = 0;
    
    #4
    opcode = LW;
    
    #6
    opcode = SW;
    
    #4
    opcode = ADDI;
    
    #4
    opcode = BEQ;
    
    #4
    opcode = JMP;
    
    #6
    rst = 1;
    
    #3
    $finish;
    
  end
  
  always forever #0.5 clk = ~clk;
endmodule