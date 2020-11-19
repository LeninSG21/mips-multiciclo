// Create Date:  11/19/2020, 11:06:16
// Project Name: MIPS

`timescale 1ns/1ps

module MIPS_tb;

    //Creación de regs y wires
	reg  clk;
	reg  rst;


    //Instanciar el top
    MIPS UUT(.*);

initial
  begin
    $dumpfile("MIPS_tb.vcd");
    $dumpvars (1, MIPS_tb);

	clk = 0;
	rst = 1;
 
    // Cargamos las instrucciones
    UUT.DP.RAM.mem_space[0]  = 32'h00000000;
    UUT.DP.RAM.mem_space[1]  = 32'h20190200;
    UUT.DP.RAM.mem_space[2]  = 32'h00008020;
    UUT.DP.RAM.mem_space[3]  = 32'h20110001;
    UUT.DP.RAM.mem_space[4]  = 32'h8F37000F;
    UUT.DP.RAM.mem_space[5]  = 32'h20160001;
    UUT.DP.RAM.mem_space[6]  = 32'h00007820;
    UUT.DP.RAM.mem_space[7]  = 32'h01F7402A;
    UUT.DP.RAM.mem_space[8]  = 32'h10080007;
    UUT.DP.RAM.mem_space[9]  = 32'h02119020;
    UUT.DP.RAM.mem_space[10] = 32'hAF310001;
    UUT.DP.RAM.mem_space[11] = 32'hAF320002;
    UUT.DP.RAM.mem_space[12] = 32'h8F300001;
    UUT.DP.RAM.mem_space[13] = 32'h8F310002;
    UUT.DP.RAM.mem_space[14] = 32'h01F67820;
    UUT.DP.RAM.mem_space[15] = 32'h08000007;
    UUT.DP.RAM.mem_space[16] = 32'h02308022;
    UUT.DP.RAM.mem_space[17] = 32'hAF300000;
    UUT.DP.RAM.mem_space[18] = 32'h1000FFFF;
    UUT.DP.RAM.mem_space[19] = 32'h02309024;
    UUT.DP.RAM.mem_space[20] = 32'h02309025;
    UUT.DP.RAM.mem_space[21] = 32'h02D29006;

    //Cargamos dato para fibonacci
    UUT.DP.RAM.mem_space[512+15] = 5;

    #3
    rst = 0;

   end
 always forever #0.5 clk = ~clk;
endmodule
    