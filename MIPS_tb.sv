// Create Date:  11/19/2020, 11:06:16
// Project Name: MIPS

`timescale 1ns/1ps

module MIPS_tb;

    //Creación de regs y wires
	reg  clk;
	reg  rst;
  reg [6:0] sw_addr;
  wire [3:0] state;
  wire [31:0] pc, data;


    //Instanciar el top
    MIPS UUT(.debug(0), .debug_inst(0), .*);

initial
  begin
    $dumpfile("MIPS_tb.vcd");
    $dumpvars (1, MIPS_tb);

	clk = 0;
	rst = 1;
  sw_addr = 66;
 
    // Cargamos las instrucciones
    UUT.DP.RAM.mem_space[0]  = 32'h8C08003F;
    UUT.DP.RAM.mem_space[1]  = 32'h20090001;
    UUT.DP.RAM.mem_space[2]  = 32'h2018000A;
    UUT.DP.RAM.mem_space[3]  = 32'h200C003F;
    UUT.DP.RAM.mem_space[4]  = 32'h11100009;
    UUT.DP.RAM.mem_space[5]  = 32'h01305824;
    UUT.DP.RAM.mem_space[6]  = 32'h112B0002;
    UUT.DP.RAM.mem_space[7]  = 32'h02308822;
    UUT.DP.RAM.mem_space[8]  = 32'h03000008;
    UUT.DP.RAM.mem_space[9]  = 32'h02308820;
    UUT.DP.RAM.mem_space[10] = 32'h020C6824;
    UUT.DP.RAM.mem_space[11] = 32'hADB10040;
    UUT.DP.RAM.mem_space[12] = 32'h22100001;
    UUT.DP.RAM.mem_space[13] = 32'h08000004;
    UUT.DP.RAM.mem_space[14] = 32'h0220A02A;
    UUT.DP.RAM.mem_space[15] = 32'h200C01FF;
    UUT.DP.RAM.mem_space[16] = 32'h0191A82A;
    UUT.DP.RAM.mem_space[17] = 32'h0295B025;
    UUT.DP.RAM.mem_space[18] = 32'h01896024;
    UUT.DP.RAM.mem_space[19] = 32'h12C00001;
    UUT.DP.RAM.mem_space[20] = 32'h200C0004;
    UUT.DP.RAM.mem_space[21] = 32'h01884006;
    UUT.DP.RAM.mem_space[22] = 32'hAC08003F;


    //límite
    UUT.DP.RAM.mem_space[63] = 1023;


    #3
    rst = 0;

   end
 always forever #0.5 clk = ~clk;
endmodule
    