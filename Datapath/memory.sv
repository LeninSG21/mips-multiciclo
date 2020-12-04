module memory(
    input [31:0] Address, w_data,
	input [6:0] sw_addr, //debug address
    input clk, we, re,
    output reg  [31:0] mem_data, out_data
);

    reg [31:0] mem_space [128:0];

	  always @ (posedge clk)
		  begin
				if(we) //synchronous write
					mem_space[Address] <= w_data;
		  end
		
		//combinational read with a tri-state buffer
		assign mem_data = re ? mem_space[Address] : 'Z;
		assign out_data = mem_space[sw_addr]; //debug read port

endmodule