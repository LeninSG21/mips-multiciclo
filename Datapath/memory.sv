module memory(
    input [31:0] Address, w_data,
    input clk, we, re,
	input [7:0] sw_addr,
    output reg [31:0] mem_data,
	output reg [31:0] out_data
);

    reg [31:0] mem_space [1023:0];

	  always @ (posedge clk)
		  begin
				if(we)
					 mem_space[Address] <= w_data;
				//else if(re)
				//	 mem_data <= mem_space[Address];
		  end
		
		assign mem_data = re ? mem_space[Address] : 'Z;
		
		assign out_data = mem_space[sw_addr];

endmodule